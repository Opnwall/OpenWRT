# OpenWRT 云编译

基于 [VIKINGYFY/OpenWRT-CI](https://github.com/VIKINGYFY/OpenWRT-CI) 的 GitHub Actions 编译配置，使用 [VIKINGYFY/immortalwrt](https://github.com/VIKINGYFY/immortalwrt) 源码，仅构建下列设备。

[下载固件](https://github.com/Opnwall/OpenWRT/releases) · [查看编译任务](https://github.com/Opnwall/OpenWRT/actions)

## 支持设备

| 设备 | 设备标识 | 编译配置 | 源码分支 |
| --- | --- | --- | --- |
| x86_64 | x86 / 64 | `X86` | `owrt` |
| NanoPi R4SE | `friendlyarm_nanopi-r4se` | `ROCKCHIP` | `owrt` |
| NanoPi R6S | `friendlyarm_nanopi-r6s` | `ROCKCHIP` | `owrt` |
| QNAP 301W（带 Wi-Fi） | `qnap_301w` | `IPQ807X-WIFI-YES` | `main` |
| 京东无线宝太乙（有线） | `jdcloud_re-cs-07` | `IPQ60XX-WIFI-NO` | `main` |
| 京东无线宝 AX1800 PRO（亚瑟） | `jdcloud_re-ss-01` | `IPQ60XX-WIFI-YES` | `main` |
| GL.iNet GL-AX1800 | `glinet_gl-ax1800` | `IPQ60XX-WIFI-YES` | `main` |
| NN6000 v2 | `link_nn6000-v2` | `IPQ60XX-WIFI-YES` | `main` |

太乙使用有线配置；QNAP 301W、AX1800 PRO、GL-AX1800 和 NN6000 v2 保留无线支持。下载时请按设备标识选择对应固件。

## 默认设置

| 项目 | 默认值 |
| --- | --- |
| 登录地址 | `192.168.10.1` |
| 用户名 | `root` |
| root 密码 | 空，直接登录 |
| 主机名 | `OWRT` |
| Wi-Fi 名称 | `OWRT`（适用于无线设备） |
| Wi-Fi 密码 | `12345678`（适用于无线设备） |
| LuCI 主题 | Argon |
| 登录壁纸 | 从 Bing 在线获取，需联网 |

上述设置适用于首次启动或恢复出厂设置。保留配置升级时，沿用现有配置。

## 内置插件

| 插件 | 软件包 |
| --- | --- |
| SSR Plus+（包含 SSR 客户端） | `luci-app-ssr-plus` |
| iStore 应用商店 | `luci-app-store` |
| EasyTier | `luci-app-easytier` |
| UPnP | `luci-app-upnp` |
| MosDNS | `luci-app-mosdns` |
| Lucky | `luci-app-lucky` |
| Argon 主题及设置 | `luci-theme-argon`、`luci-app-argon-config` |

插件依赖由 `make defconfig` 自动补齐。配置生成后会检查设备列表和必需软件包；若上游变动导致设备或插件缺失，任务会报错停止。

## 编译方式

### 自动编译

每天北京时间 **05:21** 运行 `Auto-Clean`，该工作流完成后触发 `OWRT-ALL` 和 `QCA-ALL`。固件发布到本仓库的 [Releases](https://github.com/Opnwall/OpenWRT/releases)。

`Auto-Clean` 按当前配置清理历史 Release、标签和工作流记录。实际编译完成时间取决于 GitHub Actions 排队、源码下载及构建耗时。

### 手动编译

1. 打开仓库的 [Actions](https://github.com/Opnwall/OpenWRT/actions)。
2. 选择工作流，点击 **Run workflow**：

   | 工作流 | 编译范围 |
   | --- | --- |
   | `OWRT-ALL` | x86_64、NanoPi R4SE、NanoPi R6S |
   | `QCA-ALL` | 表中全部高通设备 |
   | `WRT-TEST` | 选择一个编译配置 |

3. `TEST` 为 `true` 时只生成并发布配置文件；需要编译固件时设为 `false`。`WRT-TEST` 的 `TEST` 默认开启。
4. `PACKAGE` 可追加配置项，多项使用字面量 `\n` 分隔，例如 `CONFIG_PACKAGE_htop=y\nCONFIG_PACKAGE_iperf3=y`。必需插件仍受配置校验约束。

`WRT-TEST` 的源码分支留空时，高通配置自动使用 `main`，X86 和 ROCKCHIP 使用 `owrt`。修改源码来源或分支前，请确认对应源码支持所选设备和软件包。

## 仓库目录

| 路径 | 用途 |
| --- | --- |
| `.github/workflows/` | 自动编译、手动编译、清理和缓存工作流 |
| `Config/` | 平台、设备与公共软件包配置 |
| `Scripts/Packages.sh` | 引入插件和主题源码 |
| `Scripts/Handles.sh` | 软件包适配及主题调整 |
| `Scripts/Settings.sh` | 默认网络、主题、壁纸和登录设置 |
| `Scripts/Validate.sh` | 检查最终配置中的设备和必需插件 |

## 上游项目

- [OpenWRT-CI](https://github.com/VIKINGYFY/OpenWRT-CI)：原始云编译框架。
- [VIKINGYFY/immortalwrt](https://github.com/VIKINGYFY/immortalwrt)：当前默认固件源码。
- [ImmortalWrt](https://github.com/immortalwrt/immortalwrt)：上游固件项目。
- [OWRT-Tools](https://github.com/VIKINGYFY/OWRT-Tools)：本地编译工具。

本仓库沿用 [MIT 许可证](LICENSE)；固件源码及各软件包遵循各自的许可证。
