# 高质量<免费>交流群

[IPQ技术讨论群](https://qm.qq.com/q/v7nMhzB4oU)

# 高质量<付费>中转站

[LiBwrt-Ai](https://api.zipimg.cn/register?aff=LR7FSZ2ZZ4D3)

# 本地编译器

https://github.com/VIKINGYFY/OWRT-Tools.git

# 自用修改版插件

https://github.com/VIKINGYFY/packages.git

# OpenWRT-CI

官方版：

https://github.com/immortalwrt/immortalwrt.git

自用版：

https://github.com/VIKINGYFY/immortalwrt.git

# U-BOOT

高通版-沉心：

https://github.com/chenxin527/uboot-qsdk12.5-build.git

高通版-小猪：

https://github.com/1980490718/u-boot-2016.git

联发科-全新版：

https://github.com/VIKINGYFY/UBOOT-CI/releases

联发科-官方版：

https://drive.wrt.moe/uboot/mediatek

# 固件简要说明

固件每天早上5点自动编译。

固件信息里的时间为编译开始的时间，方便核对上游源码提交时间。

QUALCOMMAX系列、ROCKCHIP系列、X86系列。

# 目录简要说明

workflows——自定义CI配置

Scripts——自定义脚本

Config——自定义配置

#
[![Stargazers over time](https://starchart.cc/VIKINGYFY/OpenWRT-CI.svg?variant=adaptive)](https://starchart.cc/VIKINGYFY/OpenWRT-CI)

## 当前编译配置

仅编译以下设备：

| 配置 | 设备 | 源码分支 |
| --- | --- | --- |
| X86 | x86_64 | owrt |
| ROCKCHIP | NanoPi R4SE、R6S | owrt |
| IPQ60XX-WIFI-NO | 京东无线宝太乙（RE-CS-07，有线） | main |
| IPQ60XX-WIFI-YES | 京东无线宝 AX1800 PRO（RE-SS-01）、GL-AX1800、NN6000 v2 | main |
| IPQ807X-WIFI-YES | QNAP 301W（带 Wi-Fi） | main |

默认插件：SSR Plus+（包含 SSR 客户端）、iStore、EasyTier、UPnP、MosDNS、Lucky。
默认主题：Argon，登录壁纸从 Bing 获取。
默认登录地址：`192.168.10.1`，用户名：`root`，密码为空。
这些默认值适用于首次启动或恢复出厂设置；保留配置升级时沿用现有配置。

`OWRT-ALL` 编译 X86 和 ROCKCHIP，`QCA-ALL` 编译上述高通设备。
`WRT-TEST` 可选择上述配置，默认只生成配置文件。
