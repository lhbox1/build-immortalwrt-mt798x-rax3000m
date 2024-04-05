#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.15.1/g' package/base-files/files/bin/config_generate

#修改默认主机名
sed -i "s/hostname='.*'/hostname='RAX3000M'/g" ./package/base-files/files/bin/config_generate

#修改wifi名称（mtwifi-cfg）
#sed -i 's/ImmortalWrt-2.4G/RAX3000M/g' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
#sed -i 's/ImmortalWrt-5G/RAX3000M_5G/g' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh

#修改闪存为256M版本(这是针对原厂128闪存来的，但又要编译256M固件来的）
#sed -i 's/<0x580000 0x7200000>/<0x580000 0xee00000>/g' target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7981-cmcc-rax3000m.dts
#sed -i 's/116736k/240128k/g' target/linux/mediatek/image/mt7981.mk

#修改默认时区
#sed -i "s/timezone='.*'/timezone='CST-8'/g" ./package/base-files/files/bin/config_generate
#sed -i "/timezone='.*'/a\\\t\t\set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate

##添加软件包
git clone https://github.com/lhbox1/luci-app-adguardhome package/luci-app-adguardhome
git clone https://github.com/shuishihan/luci-app-easymesh.git package/luci-app-easymesh
#删除冲突插件
rm -rf $(find ./feeds/luci/ -type d -regex ".*\(alist\|openclash\|easymesh\).*")
#rm -rf ./package/istore
#rm -rf ./feeds/kenzo/luci-app-quickstart
#rm -rf ./feeds/kenzo/luci-app-store
#rm -rf ./feeds/kenzo/luci-lib-taskd
