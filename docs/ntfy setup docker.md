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

## Usage
See [Guide on using uptime-kuma push](https://www.leewoodhouse.com/2022/09/14/how-to-setup-push-notifications-in-uptime-kuma-to-monitor-systems-on-a-private-network/) on how to to setup uptime-kuma.

You also need to setup ntfy notifications in uptime-kuma, see [docs.ntfy.sh/examples/#uptime-kuma](https://docs.ntfy.sh/examples/#uptime-kuma)

Following that, add this to your docker-compose file docker images(Example below is prowlarr, but can be any container). I integrated in to my healthchecks also!
``` yaml
services:
    autoheal:   #you need this container to call the healthcheck command below. you only need to create this container once!
        image: willfarrell/autoheal:latest
        environment:
        - AUTOHEAL_CONTAINER_LABEL=all
        volumes:
        - /var/run/docker.sock:/var/run/docker.sock
        restart : always

    prowlarr:
        image: lscr.io/linuxserver/prowlarr:latest
        container_name: prowlarr
        ports:
        - 9696:9696
        healthcheck:
            test: ["CMD", "curl", "<link generated by uptime-kuma>"]
            interval: 60s
            timeout: 10s
            retries: 3
            start_period: 60s
        restart: always  
```

If your container doesn't have curl, use this instead. It's for a sh enabled system instead of bash, it's the equivalent or simlar to curl.
``` yaml
test: ["CMD-SHELL", "wget --no-verbose --tries=1 --spider <link generated by uptime-kuma> || exit 1"]
```

## Limitations
The only limitation I've encountered is that I haven't figured out how to detect the down status of my entire server (if ntfy or uptime-kuma stops running, then how can I be notified on my phone). 

I've found a decent alternative to this in Cloudflare - Notifications - Passive Origin Monitoring. This monitors your Origin server/site every 5 minutes and emails you if it's down. see [Cloudflare Notifications Documention](https://developers.cloudflare.com/fundamentals/notifications/)
