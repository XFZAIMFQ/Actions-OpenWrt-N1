#!/bin/bash
cd openwrt
# wireless
rm -rf files/etc/config/wireless
rm -rf files/etc/modules.d/wireless_enable
#Add amlogic管理
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/lean/luci-app-amlogic

#Add luci-app-passwall
#git clone -b luci https://github.com/xiaorouji/openwrt-passwall.git package/lean/luci-app-passwall

#Add luci-app-smartdns
#git clone -b lede https://github.com/pymumu/luci-app-smartdns.git package/lean/luci-app-smartdns

#Add luci-app-adguardhome
#git clone https://github.com/rufengsuixing/luci-app-adguardhome.git package/lean/luci-app-adguardhome

# Add luci-app-openclash
git clone https://github.com/vernesong/OpenClash.git package-temp 
mv -f package-temp/luci-app-openclash package/lean/
rm -rf package-temp
