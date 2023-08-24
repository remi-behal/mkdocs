# New ISP. New Router
So, you've changed internet service provider (ISP) because your 12 month contract is up, and they won't give you the same deal!

Serve's them right because a new ISP is quite easy to resetup, at least in my country.

## router config
### Get your settings off your old router!
Don't unplug your old router just yet! Go in to your ports and make a note of what you've setup, do the same in your static IP reservations.

### Setup and start your new router
You've changed internet service provider (ISP) and they've activated and sent you a new router.
Your old internet and router should spontaneously stop working.
That means it's time to plug in the new router, go ahead and do that.

Once it's online and you have access to the internet (or before your new internet is online, if impatient) log in to your router as administrator.

### Static IP
You need a static IP address for your server in your local LAN, otherwise it's very difficult to get many services running! Yes your server should have a local domain name but many docker containers have difficulty picking this up.

So, login to your router as admin.
Navigate to the relevant section. It's named something different on every router, unfortunately.
But it will be something like. Networking -> DHCP reservation
Create a static IP for your server, the same address as before your new router...I hope you made note of it!!

First of all open ports to your server.
These should be 80, and 443. You might only need 443. These ports are your http and https ports.

Go to [you get signal open port checker](https://www.yougetsignal.com/tools/open-ports/) on another PC or device on your home network, and check that these ports are open.
They should be open, as long as there's not something going on with the ISP, or your config. For example your firewall could be blocking it.
For them to appear open you need a service on your router listening to those ports, such as a web server

## Restart your cloudflare container
Check in on your cloudflare ddns container. I had a look at the logs and saw that it hadn't picked up my new IP yet. 
I also saw this on my cloudflare dashboard that my DNS record A entry was still the old IP address for my root domain.

The cloudflare ddns container does update every so often, but I am impatient so I force restarted it in portainer.

Wait a minute and you should see the new IP address in the logs and in your cloudflare DNS records.

## Back to router config
Now it's time to setup other open ports. For example your VPN port. I found that for some reason I needed to do port 80 and 443 before the VPN would work.
So do that and test. You might need to restart the VPN container (wireguard)

Wireguard might also regenerate a new config, so you may have to scan the qr code again and set up a new tunnel in the wireguard app on android.