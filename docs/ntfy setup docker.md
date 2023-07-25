# How to Setup Ntfy and Uptime-Kuma in Docker
## What is Ntfy
Ntfy is an extremely useful notification service. You can either use their default ntfy.sh server to send notifications, or host your own server. I attempted to host my own, but unfortunately I couldn't get it to work, I'm not sure why, couldn't login to my server when using the app.

Regardless, the ntfy.sh server suits my needs.

Nfy allows you to send many different types of notifications to subscribers of topics.
I am using it for push notifications to my phone, using the ntfy android app. It allows me to know if my docker containers have stopped running.
I've combined it with uptime-kuma as a down detector of sorts.
You can use it for other tasks too, such as disk space nofitfier, which I plan on doing.

For full ntfy documentation, see [docs.ntfy.sh](https://docs.ntfy.sh/)

## Docker compose uptime-kuma
``` yaml
services:
    uptime-kuma:
        image: louislam/uptime-kuma:latest
        container_name: uptime-kuma
        environment:
            - PUID=999 #your user id
            - PGID=999 #your group id
            - TZ=Europe/Dublin
        volumes:
            - /srv/<your disk>/configs/uptimekuma/app/data:/app/data
            - /var/run/docker.sock:/var/run/docker.sock
        ports:
            - 3001:3001  # <Host Port>:<Container Port>
        restart: always  
```

## Limitations
The only limitation I've encountered is that I haven't figured out how to detect the down status of my entire server (if ntfy or uptime-kuma stops running, then how can I be notified on my phone). 

I've found a decent alternative to this in Cloudflare - Notifications - Passive Origin Monitoring. This monitors your Origin server/site every 5 minutes and emails you if it's down. see [Cloudflare Notifications Documention](https://developers.cloudflare.com/fundamentals/notifications/)
