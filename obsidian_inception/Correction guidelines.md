## Setup
1. Download repo
2. Add secrets and .env to repo
3. Open VM
4. Send repo to VM via SCP ` % scp -r inception  acastrov@localhost:/home/acastrov`
5. Connect to VM via VSCODE SSH
6. Do Make and go grab a snack and a drink, this is gonna take a while
## Mariadb
- If change 50-server.conf file, is nececesary to do a docker prune all and mount a new images, as the configuration will be burnt into the image and it will ignore the change in docker compose and the script
-  Check the part about login into database