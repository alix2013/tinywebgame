#! /bin/sh
P="tinywebgame"

ARCH=$(uname -m | sed -e 's/x86_64/amd64/' -e 's/aarch64/arm64/')
PROG="${P}-$(uname -s | tr '[:upper:]' '[:lower:]')-${ARCH}"

curl -k -L -o /tmp/cf https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-`uname -m | sed 's/x86_64/amd64/;s/aarch64/arm64/;s/armv7l/arm/'`
chmod a+x /tmp/cf

if [ -n "$CF_TOKEN" ]; then
    #echo "CF is set: $CF_TOKEN"
    su - web -c "nohup /tmp/cf tunnel run --token $CF_TOKEN >> /tmp/cf.log 2>&1 &"
fi

su - web -c "cd /home/web/tinywebgame; ./$PROG"


