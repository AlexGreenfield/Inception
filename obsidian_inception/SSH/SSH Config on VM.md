## sshd_config
- Port 4343
- PermitRootLogin no

## ssh_config
- Port 4343

## Host commands
 - Connection `ssh localhost -p 4343`

## VM commands
 - Restart `sudo rc-service sshd restart`

## Common commands
- Check listening ports `netstat -tuln | grep 4242`

 
 