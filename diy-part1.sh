#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo "src-git kenzo https://github.com/kenzok8/openwrt-packages" >> ./feeds.conf.default
#echo "src-git small https://github.com/kenzok8/small" >> ./feeds.conf.default
#echo "src-git OpenClash https://github.com/vernesong/OpenClash.git" >> ./feeds.conf.default

#添加额外软件包
#git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
#git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
#git clone https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
#git clone https://github.com/sirpdboy/luci-app-poweroffdevice.git package/luci-app-poweroffdevice

# 预置openclash内核
mkdir -p files/etc/openclash/core
#master分支内核
# dev内核
CLASH_DEV_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz"
# premium内核
CLASH_TUN_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/premium/clash-linux-arm64-2023.08.17-13-gdcc8d87.gz"
# Meta内核版本
CLASH_META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz"
wget -qO- $CLASH_DEV_URL | tar  xOz > files/etc/openclash/core/clash
wget -qO- $CLASH_TUN_URL | gunzip -c > files/etc/openclash/core/clash_tun
wget -qO- $CLASH_META_URL | tar xOz > files/etc/openclash/core/clash_meta
# 给内核权限
chmod +x files/etc/openclash/core/clash*
GEOIP_URL="https://testingcf.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geoip.dat"
GEOSITE_URL="https://testingcf.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geosite.dat"
wget -qO- $GEOIP_URL > files/etc/openclash/GeoIP.dat
wget -qO- $GEOSITE_URL > files/etc/openclash/GeoSite.dat
# Country.mmdb
#COUNTRY_LITE_URL=https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/lite/Country.mmdb
COUNTRY_LITE_URL=https://testingcf.jsdelivr.net/gh/alecthw/mmdb_china_ip_list@release/lite/Country.mmdb
# COUNTRY_FULL_URL=https://raw.githubusercontent.com/alecthw/mmdb_china_ip_list/release/Country.mmdb
wget -qO- $COUNTRY_LITE_URL > files/etc/openclash/Country.mmdb
# wget -qO- $COUNTRY_FULL_URL > files/etc/openclash/Country.mmdb
#下载使用master版本openclash
wget -qO- https://github.com/vernesong/OpenClash/archive/master.zip > temp.zip
unzip -q temp.zip
cp -r OpenClash-master/luci-app-openclash package/
rm -rf OpenClash-master
rm -rf temp.zip
#alist更新
wget -qO- https://github.com/sbwml/luci-app-alist/archive/master.zip > alist.zip
unzip -q alist.zip
rm -rf feeds/luci/applications/luci-app-alist
cp -r luci-app-alist-master/luci-app-alist package/
rm -rf alist.zip
rm -rf luci-app-alist-master
