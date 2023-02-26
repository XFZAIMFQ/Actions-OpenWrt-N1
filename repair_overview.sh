#!/bin/bash
cd openwrt
cat >> package/lean/autocore/files/arm/sbin/ethinfo <<EOF
#!/bin/sh

a=\$(ls /sys/class/net/*/device/uevent | grep -v wlan | awk -F '/' '{print \$5}')
b=\$(echo "\$a" | wc -l)
rm -f /tmp/state/ethinfo

echo -n "[" > /tmp/state/ethinfo

for i in \$(seq 1 \$b)
do
	h=\$(echo '{"name":' )
	c=\$(echo "\$a" | sed -n \${i}p)
	d=\$(ethtool \$c)

	e=\$(echo "\$d" | grep "Link detected" | awk -F: '{printf \$2}' | sed 's/^[ \t]*//g')
	if [ \$e = yes ]; then
		l=1
	else
		l=0
	fi

	f=\$(echo "\$d" | grep "Speed" | awk -F: '{printf \$2}' | sed 's/^[ \t]*//g' | tr -d "Unknown!")
	[ -z "\$f" ] && f=" - "

	g=\$(echo "\$d" | grep "Duplex" | awk -F: '{printf \$2}' | sed 's/^[ \t]*//g')
	if [ "\$g" == "Full" ]; then
		x=1
	else
		x=0
	fi

	echo -n "\$h \"\$c\", \"status\": \$l, \"speed\": \"\$f\", \"duplex\": \$x}," >> /tmp/state/ethinfo
done

sed -i 's/.$//' /tmp/state/ethinfo

echo -n "]" >> /tmp/state/ethinfo

cat /tmp/state/ethinfo
EOF