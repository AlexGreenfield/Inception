## sshd_config
- Port 2222
- PermitRootLogin no
## Host commands
 - Connection `ssh localhost -p 2222`

## VM commands
 - Restart `sudo rc-service sshd restart`

## Common commands
- Check listening ports `netstat -tuln | grep 2222`

 
 