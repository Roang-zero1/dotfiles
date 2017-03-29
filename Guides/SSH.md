# SSH

## SSH Aliases

In the `~/.ssh/config` file you can add aliases that then can be used in the ssh connection commands.

```
Host alias
Hostname <<hostname>>
User <<username>>
```

## Open Port Forwarding in Background

Open a port forwarding connection in background (with control possibility)

Preparation in `~/.ssh/config`:
```
Host alias-proxy
Hostname <<hostname>>
ControlPath ~/.ssh/alias-proxy.ctl
```

Using the alias:
```bash
# Port forward the mysql port
ssh -f -N -T -M -L 3306:localhost:3306 alias-proxy

# Checking the connection
ssh -T -O check alias-proxy

# Closing the connection
ssh -T -O exit alias-proxy
```
