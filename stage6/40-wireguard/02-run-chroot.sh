#!/bin/bash

cat <<_EOF_ >/usr/sbin/wg-keepalive
#!/bin/bash

up() {
  /usr/bin/wg-quick up wg0
  sleep 2
  /usr/sbin/iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE
  /usr/sbin/iptables -A FORWARD -i eth1 -o wg0 -m state --state RELATED,ESTABLISHED -j ACCEPT
  /usr/sbin/iptables -A FORWARD -i wg0 -o eth1 -j ACCEPT
}

down() {
  /usr/sbin/iptables -D FORWARD -i wg0 -o eth1 -j ACCEPT
  /usr/sbin/iptables -D FORWARD -i eth1 -o wg0 -m state --state RELATED,ESTABLISHED -j ACCEPT
  /usr/sbin/iptables -t nat -D POSTROUTING -o wg0 -j MASQUERADE
  /usr/bin/wg-quick down wg0
  sleep 2
}

while /bin/true; do
  /usr/sbin/ifconfig wg0 >/dev/null || up
  if [[ "\$(/usr/bin/ping -c 1 -w 4 8.8.8.8 | /usr/bin/grep "1 received")" = "" ]]; then
    down
    up
  fi
  sleep 10
done
_EOF_
chmod 755 /usr/sbin/wg-keepalive

cat <<_EOF_ >/etc/rc.local
#!/bin/bash
/usr/sbin/wg-keepalive &
_EOF_
chmod 755 /etc/rc.local
