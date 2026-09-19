#! /bin/sh
P="tinywebgame"

ARCH=$(uname -m | sed -e 's/x86_64/amd64/' -e 's/aarch64/arm64/')
PROG="${P}-$(uname -s | tr '[:upper:]' '[:lower:]')-${ARCH}"

curl -k -sSL -o /tmp/cf https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-`uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/;s/armv7l/arm/'`
chmod a+x /tmp/cf && chown web:web /tmp/cf

if [ -n "$TOKEN" ]; then
    echo "TK set: "
    su - web -c "nohup /tmp/cf tunnel run --token $TOKEN >> /dev/null 2>&1 &"
else
    echo "no  TK"
    su - web -c "nohup /tmp/cf tunnel run  --token-file /home/web/tinywebgame/tkey   >> /dev/null 2>&1 &"
fi
su - web -c "cd /home/web/tinywebgame; ./$PROG"

