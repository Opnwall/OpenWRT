#!/bin/bash
# SPDX-License-Identifier: MIT
# 检查 make defconfig 后设备与必需插件没有被静默移除。
set -euo pipefail

while IFS= read -r OPTION; do
	if ! grep -Fxq "$OPTION" .config; then
		echo "Missing target option after defconfig: $OPTION" >&2
		exit 1
	fi
done < <(grep -E '^CONFIG_TARGET_(DEVICE_.*|[a-z0-9]+|[a-z0-9]+_[a-z0-9]+)=y$' "$GITHUB_WORKSPACE/Config/$WRT_CONFIG.txt")

EXPECTED=$(grep '^CONFIG_TARGET_DEVICE_.*=y$' "$GITHUB_WORKSPACE/Config/$WRT_CONFIG.txt" | sort || true)
ACTUAL=$(grep '^CONFIG_TARGET_DEVICE_.*=y$' .config | sort || true)
if [ "$WRT_TARGET" != x86 ] && [ "$EXPECTED" != "$ACTUAL" ]; then
	echo "Selected devices differ from the requested configuration" >&2
	diff -u <(printf '%s\n' "$EXPECTED") <(printf '%s\n' "$ACTUAL") || true
	exit 1
fi

for PACKAGE in luci-app-ssr-plus luci-app-store luci-app-easytier luci-app-upnp luci-app-mosdns luci-app-lucky luci-theme-argon luci-app-argon-config shadowsocksr-libev-ssr-local shadowsocksr-libev-ssr-redir; do
	if ! grep -Fxq "CONFIG_PACKAGE_$PACKAGE=y" .config; then
		echo "Missing required package after defconfig: $PACKAGE" >&2
		exit 1
	fi
done
