# Common Tree for OnePlus devices with a Qualcomm 855 chipset

Currently these devices are supported:

> codename   Devicename        Target area     projectname     baseband (rf)
> --------------------------------------------------------------------------
> GM1903     OnePlus 7         Europe (EEA)    18857           4
> GM1907     OnePlus 7         Global/US       18857           5
>
> GM1913     OnePlus 7 Pro     Europe (-EEA)   18821           4
> GM1917     OnePlus 7 Pro     Global/US       18821           5
>
> _unsupported as of writing:_
>
> GM1900     OnePlus 7         China           18857           1
> GM1901     OnePlus 7         India           18857           3
>
> GM1910     OnePlus 7 Pro     China           18821           1
> GM1911     OnePlus 7 Pro     India           18821           3
> GM1915     OnePlus 7 Pro     T-Mobile        18831           -
> GM1920     OnePlus 7 Pro NR  Europe (5G)     18827           3

<kbd>projectname = android projectname defined by the vendor system props "ro.boot.project_name" or "ro.vendor.boot.project_name"
baseband = defined baseband by the vendor system prop "ro.boot.rf_version"</kbd>

Copyright 2019 - The AICP Project.
