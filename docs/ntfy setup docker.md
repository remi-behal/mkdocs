# How to Setup Ntfy and Uptime-Kuma in Docker
## What is Ntfy
Ntfy is an extremely useful notification service. You can either use their default ntfy.sh server to send notifications, or host your own server. I attempted to host my own, but unfortunately I couldn't get it to work, I'm not sure why, couldn't login to my server when using the app.

Regardless, the ntfy.sh server suits my needs.

Nfy allows you to send many different types of notifications to subscribers of topics.
I am using it for push notifications to my phone, using the ntfy android app. It allows me to know if my docker containers have stopped running.
I've combined it with uptime-kuma as a down detector of sorts.
You can use it for other tasks too, such as disk space nofitfier, which I plan on doing.

For full ntfy documentation, see [docs.ntfy.sh](https://docs.ntfy.sh/)

## Docker compose
``` yaml
services:
    ntfy:
        image: binwiederhier/ntfy
        container_name: ntfy
        command:
        - serve
        environment:
        - TZ=Europe/Dublin
        user: 9999:999 #adapt to your own PUID:PGID
        volumes:
        - /srv/dev-disk/configs/ntfy/var/cache/ntfy:/var/cache/ntfy
        - /srv/dev-disk/configs/ntfy/var/lib/ntfy:/var/lib/ntfy
        - /srv/dev-disk/configs/ntfy/etc/ntfy:/etc/ntfy
        ports:
        - 8880:80
        healthcheck: # optional: remember to adapt the host:port to your environment
            test: ["CMD-SHELL", "wget -q --tries=1 http://<your-host-or-localhost-or-ip-address>:8880/v1/health -O - | grep -Eo '\"healthy\"\\s*:\\s*true' || exit 1"]
            interval: 60s
            timeout: 10s
            retries: 3
            start_period: 40s
        restart: unless-stopped
```

## Limitations
The only limitation I've encountered is that I haven't figured out how to detect the down status of my entire server (if ntfy or uptime-kuma stops running, then how can I be notified on my phone). 

I've found a decent alternative to this in Cloudflare - Notifications - Passive Origin Monitoring. This monitors your Origin server/site every 5 minutes and emails you if it's down. see [Cloudflare Notifications Documention](https://developers.cloudflare.com/fundamentals/notifications/)
