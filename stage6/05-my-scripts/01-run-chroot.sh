#!/bin/bash

cat <<_EOF_ >/usr/local/bin/myip
#!/bin/bash
curl https://api.myip.com 2>/dev/null | jq -r .ip
_EOF_
chmod 755 /usr/local/bin/myip

