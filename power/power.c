 Skip to content

    Explore
    Gist
    Blog
    Help

    Giuseppe Giugiu19

    2
    0
    0

public SpeedGroup/Build_SpeedMod_kk

Build_SpeedMod_kk / msm7x27a-common / power / power.c
Giuseppe Giugiu19 4 days ago
add msm7x27a-common

1 contributor
file 231 lines (191 sloc) 6.684 kb
1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 	

/*
* Copyright (C) 2012 The Android Open Source Project
* Copyright (c) 2012 The CyanogenMod Project
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define LOG_TAG "CM PowerHAL"
#include <utils/Log.h>

#include <hardware/hardware.h>
#include <hardware/power.h>

#define SCALING_GOVERNOR_PATH "/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"
#define BOOSTPULSE_ONDEMAND "/sys/devices/system/cpu/cpufreq/ondemand/boostpulse"
#define BOOSTPULSE_INTERACTIVE "/sys/devices/system/cpu/cpufreq/interactive/boostpulse"

struct cm_power_module {
    struct power_module base;
    pthread_mutex_t lock;
    int boostpulse_fd;
    int boostpulse_warned;
};

static char governor[20];

static int sysfs_read(char *path, char *s, int num_bytes)
{
    char buf[80];
    int count;
    int ret = 0;
    int fd = open(path, O_RDONLY);

    if (fd < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error opening %s: %s\n", path, buf);

        return -1;
    }

    if ((count = read(fd, s, num_bytes - 1)) < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error writing to %s: %s\n", path, buf);

        ret = -1;
    } else {
        s[count] = '\0';
    }

    close(fd);

    return ret;
}

static void sysfs_write(char *path, char *s)
{
    char buf[80];
    int len;
    int fd = open(path, O_WRONLY);

    if (fd < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error opening %s: %s\n", path, buf);
        return;
    }

    len = write(fd, s, strlen(s));
    if (len < 0) {
        strerror_r(errno, buf, sizeof(buf));
        ALOGE("Error writing to %s: %s\n", path, buf);
    }

    close(fd);
}

static int get_scaling_governor() {
    if (sysfs_read(SCALING_GOVERNOR_PATH, governor,
                sizeof(governor)) == -1) {
        return -1;
    } else {
        // Strip newline at the end.
        int len = strlen(governor);

        len--;

        while (len >= 0 && (governor[len] == '\n' || governor[len] == '\r'))
            governor[len--] = '\0';
    }

    return 0;
}

static void cm_power_set_interactive(struct power_module *module, int on)
{
    return;
}


static void configure_governor()
{
    if (strncmp(governor, "ondemand", 8) == 0) {
        sysfs_write("/sys/devices/system/cpu/cpufreq/ondemand/sampling_rate", "50000");
        sysfs_write("/sys/devices/system/cpu/cpufreq/ondemand/up_threshold", "90");
        sysfs_write("/sys/devices/system/cpu/cpufreq/ondemand/io_is_busy", "0");
        sysfs_write("/sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor", "4");
        sysfs_write("/sys/devices/system/cpu/cpufreq/ondemand/down_differential", "10");

    } else if (strncmp(governor, "interactive", 11) == 0) {
        sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/timer_rate", "30000");
        sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/min_sample_time", "90000");
        sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/io_is_busy", "0");
        sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/hispeed_freq", "1008000");
        sysfs_write("/sys/devices/system/cpu/cpufreq/interactive/above_hispeed_delay", "30000");
    }
}

static int boostpulse_open(struct cm_power_module *cm)
{
    char buf[80];

    pthread_mutex_lock(&cm->lock);

    if (cm->boostpulse_fd < 0) {
        if (get_scaling_governor() < 0) {
            ALOGE("Can't read scaling governor.");
            cm->boostpulse_warned = 1;
        } else {
            if (strncmp(governor, "ondemand", 8) == 0)
                cm->boostpulse_fd = open(BOOSTPULSE_ONDEMAND, O_WRONLY);
            else if (strncmp(governor, "interactive", 11) == 0)
                cm->boostpulse_fd = open(BOOSTPULSE_INTERACTIVE, O_WRONLY);

            if (cm->boostpulse_fd < 0 && !cm->boostpulse_warned) {
                strerror_r(errno, buf, sizeof(buf));
                ALOGV("Error opening boostpulse: %s\n", buf);
                cm->boostpulse_warned = 1;
            } else if (cm->boostpulse_fd > 0) {
                configure_governor();
                ALOGD("Opened %s boostpulse interface", governor);
            }
        }
    }

    pthread_mutex_unlock(&cm->lock);
    return cm->boostpulse_fd;
}

static void cm_power_hint(struct power_module *module, power_hint_t hint,
                            void *data)
{
    struct cm_power_module *cm = (struct cm_power_module *) module;
    char buf[80];
    int len;
    int duration = 1;

    switch (hint) {
    case POWER_HINT_INTERACTION:
    case POWER_HINT_CPU_BOOST:
        if (boostpulse_open(cm) >= 0) {
            if (data != NULL)
                duration = (int) data;

            snprintf(buf, sizeof(buf), "%d", duration);
            len = write(cm->boostpulse_fd, buf, strlen(buf));

            if (len < 0) {
                strerror_r(errno, buf, sizeof(buf));
ALOGE("Error writing to boostpulse: %s\n", buf);

                pthread_mutex_lock(&cm->lock);
                close(cm->boostpulse_fd);
                cm->boostpulse_fd = -1;
                cm->boostpulse_warned = 0;
                pthread_mutex_unlock(&cm->lock);
            }
        }
        break;

    case POWER_HINT_VSYNC:
        break;

    default:
        break;
    }
}

static void cm_power_init(struct power_module *module)
{
    get_scaling_governor();
    configure_governor();
}

static struct hw_module_methods_t power_module_methods = {
    .open = NULL,
};

struct cm_power_module HAL_MODULE_INFO_SYM = {
    base: {
        common: {
            tag: HARDWARE_MODULE_TAG,
            module_api_version: POWER_MODULE_API_VERSION_0_2,
            hal_api_version: HARDWARE_HAL_API_VERSION,
            id: POWER_HARDWARE_MODULE_ID,
            name: "CM Power HAL",
            author: "The CyanogenMod Project",
            methods: &power_module_methods,
        },
       init: cm_power_init,
       setInteractive: cm_power_set_interactive,
       powerHint: cm_power_hint,
    },

    lock: PTHREAD_MUTEX_INITIALIZER,
    boostpulse_fd: -1,
    boostpulse_warned: 0,
};

    Status
    API
    Training
    Shop
    Blog
    About

    © 2014 GitHub, Inc.
    Terms
    Privacy
    Security
    Contact


