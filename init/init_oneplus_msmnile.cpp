/*
   Copyright (c) 2015, The Linux Foundation. All rights reserved.
   Copyright (C) 2019 The OmniRom Project.
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.
   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

 #include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/stat.h>
 #include <sys/types.h>

 #include <android-base/file.h>
 #include <android-base/logging.h>
 #include <android-base/properties.h>
 #include <android-base/strings.h>

 #define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
 #include <sys/_system_properties.h>

 #include "vendor_init.h"
 #include "property_service.h"

namespace android {
namespace init {

using android::base::GetProperty;
using android::base::ReadFileToString;
using android::init::property_set;

void property_override(const std::string& name, const std::string& value)
{
    size_t valuelen = value.size();

    prop_info* pi = (prop_info*) __system_property_find(name.c_str());
    if (pi != nullptr) {
        __system_property_update(pi, value.c_str(), valuelen);
    }
    else {
        int rc = __system_property_add(name.c_str(), name.size(), value.c_str(), valuelen);
        if (rc < 0) {
            LOG(ERROR) << "property_set(\"" << name << "\", \"" << value << "\") failed: "
                       << "__system_property_add failed";
        }
    }
}

void vendor_load_properties()
{
    std::string name;
    LOG(INFO) << "Starting custom init";

    name = android::base::GetProperty("ro.product.vendor.name", "");
    LOG(INFO) << name;
    if (name == "OnePlus7Pro_EEA") {
        property_set("ro.build.fingerprint", "OnePlus/OnePlus7Pro_EEA/OnePlus7Pro:9/PKQ1.190110.001/1907281556:user/release-keys");
        property_set("ro.bootimage.build.fingerprint", "OnePlus/OnePlus7Pro/OnePlus7Pro:9/PKQ1.190110.001/1907281556:user/release-keys");
        property_set("ro.build.description", "OnePlus7Pro-user 9 PKQ1.190110.001 1907281556 release-keys");
        property_set("ro.build.model", "GM1913");
        property_set("ro.display.series", "OnePlus 7 Pro");
    }
    if (name == "OnePlus7Pro") {
        property_set("ro.build.fingerprint", "OnePlus/OnePlus7Pro/OnePlus7Pro:9/PKQ1.190110.001/1907281556:user/release-keys");
        property_set("ro.bootimage.build.fingerprint", "OnePlus/OnePlus7Pro/OnePlus7Pro:9/PKQ1.190110.001/1907281556:user/release-keys");
        property_set("ro.build.description", "OnePlus7Pro-user 9 PKQ1.190110.001 1907281556 release-keys");
        property_set("ro.build.model", "GM1917");
        property_set("ro.display.series", "OnePlus 7 Pro");
    }
    if (name == "OnePlus7_EEA") {
        property_set("ro.build.fingerprint", "OnePlus/OnePlus7_EEA/OnePlus7:9/PKQ1.190110.001/1907280700:user/release-keys");
        property_set("ro.bootimage.build.fingerprint", "OnePlus/OnePlus7/OnePlus7:9/PKQ1.190110.001/1907280700:user/release-keys");
        property_set("ro.build.description", "OnePlus7-user 9 PKQ1.190110.001 1907280700 release-keys");
        property_set("ro.build.model", "GM1903");
        property_set("ro.display.series", "OnePlus 7");
    }
    if (name == "OnePlus7") {
        property_set("ro.build.fingerprint", "OnePlus/OnePlus7/OnePlus7:9/PKQ1.190110.001/1907280700:user/release-keys");
        property_set("ro.bootimage.build.fingerprint", "OnePlus/OnePlus7/OnePlus7:9/PKQ1.190110.001/1907280700:user/release-keys");
        property_set("ro.build.description", "OnePlus7-user 9 PKQ1.190110.001 1907280700 release-keys");
        property_set("ro.build.model", "GM1901");
        property_set("ro.display.series", "OnePlus 7");
    }
    /*Check for kgsl node and disable HW composition*/
    if (access("/dev/kgsl-3d0", F_OK) < 0) {
        property_set("persist.sys.force_sw_gles", "1");
    } else {
        property_set("persist.sys.force_sw_gles", "0");
    }
}

}
}
