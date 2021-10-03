#!/bin/bash

mkdir "${ROOTFS_DIR}"/etc/wireguard
chmod 700 "${ROOTFS_DIR}"/etc/wireguard
cp /etc/wireguard/wg0.conf "${ROOTFS_DIR}"/etc/wireguard/wg0.conf
chmod 600 "${ROOTFS_DIR}"/etc/wireguard/wg0.conf

cat <<_EOF_ >"${ROOTFS_DIR}"/etc/network/if-up.d/wg0nat
#!/bin/bash
[ "\$IFACE" = "wg0" ] || exit 0
iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE
iptables -A FORWARD -i eth1 -o wg0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wg0 -o eth1 -j ACCEPT
_EOF_
chmod 755 "${ROOTFS_DIR}"/etc/network/if-up.d/wg0nat

cat <<_EOF_ >"${ROOTFS_DIR}"/etc/network/if-down.d/wg0nat
#!/bin/bash
[ "\$IFACE" = "wg0" ] || exit 0
iptables -D FORWARD -i wg0 -o eth1 -j ACCEPT
iptables -D FORWARD -i eth1 -o wg0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -D POSTROUTING -o wg0 -j MASQUERADE
_EOF_
chmod 755 "${ROOTFS_DIR}"/etc/network/if-down.d/wg0nat
