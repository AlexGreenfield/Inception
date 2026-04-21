## sshd_config
- Port 2222
- PermitRootLogin no
## Host commands
 - Connection `ssh localhost -p 2222`

## VM commands
 - Restart `sudo rc-service sshd restart`

## Common commands
- Check listening ports `netstat -tuln | grep 2222`

## To connect to SSH through VSCODE
1. Ctrl+P Connect Current Window to Host
2. Select Host and type password
3. If necessary, specify the user and port `acastrov@localhost -p 2222`
4. Pick the first config file for user acastrov
5. Connect!
 