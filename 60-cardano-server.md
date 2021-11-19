## Disable the lid from triggering system sleep
If using a laptop for a server, closing the lid on the laptop normally suspends OS. To prevent this:

`sudo vi /etc/systemd/logind.conf`

Then modify the 

```
HandleLidSwitch=ignore
HandleLidSwitchDocked=ignore
```

And then `sudo systemctl restart systemd-logind`

