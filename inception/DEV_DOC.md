# Developer Documentation
## Setup environnement from scratch
As stated in the User Documentation, there are some credentials that Docker Compose access at running time. Those credentials stablish the Wordpress Admin, User and the SQL tables. These file aren't provided in the repository and must be created by the user. In other words, you have to set up a .env file and some .txt files to fill this information. Here's the folder structure.

```shell
.
├── DEV_DOC.md
├── Makefile
├── README.md
├── secrets # You will have to create these four files
│   ├── db_password.txt
│   ├── db_root_password.txt
│   ├── wp_admin_password.txt
│   └── wp_user_password.txt
├── srcs
│   ├── docker-compose.yml
│   └── .env # You will have to create this file
│   └── requirements
│       ├── mariadb
│       ├── nginx
│       └── wordpress
└── USER_DOC.md
```

Those are the files and variables that his Docker Compose makes use of:
- srcs/.env
	- SQL_DATABASE= 
	- SQL_USER=
	- WP_URL=
	- WP_TITLE=
	- WP_ADMIN=
	- WP_ADMIN_EMAIL=
	- WP_USER=
	- WP_USER_EMAIL=
- /secrets/
	- db_password.txt
	- db_root_password.txt
	- wp_admin_password.txt
	- wp_user_password.txt

## Build and launch the project
There's a Makefile to gracefully start and stop this project. You only have to move to the root of this repository and use make. Here is the list of commands: 

```Makefile
all : setup
	sudo docker compose -f $(DOCKERCOMPOSE_PATH) up --build

setup:
	@sudo mkdir -p $(VOLUMES_PATH)/mariadb
	@sudo mkdir -p $(VOLUMES_PATH)/wordpress
	@sudo chown -R 777 $(VOLUMES_PATH)/mariadb
	@sudo chown -R 777 $(VOLUMES_PATH)/wordpress

stop:
	sudo docker compose -f $(DOCKERCOMPOSE_PATH) stop

down:
	sudo docker compose -f $(DOCKERCOMPOSE_PATH) down

up:
	sudo docker compose -f $(DOCKERCOMPOSE_PATH) up

list-volumes:
	sudo docker volume ls
	@echo "--- MariaDB Path ---"
	sudo docker volume inspect srcs_mariadb | grep Mountpoint
	@echo "--- WordPress Path ---"
	sudo docker volume inspect srcs_wordpress | grep Mountpoint

clean:
	sudo docker compose -f $(DOCKERCOMPOSE_PATH) down -v

fclean: clean
	@sudo rm -rf $(VOLUMES_PATH)
	sudo docker system prune -af

docker-restart:
	@sudo systemctl restart docker
```

## Manage the containers and volumes
Once your Docker Compose is up and running, there are different commands to check services, network and volumes status:

- Check network: `docker network ls`
- Check containers: `docker compose ps`
- Check volumes list: `docker volume ls`
- Check a specific volume: `docker volume inspect <volume name>`

## Identify where the project data is stored and how it persist

The `docker-compose.yml` specifies that all the data is Bind Mounted from the host:

```YAML
volumes:
  wordpress:
    driver: local
    driver_opts:
      type: 'none'
      o: 'bind'
      device: '/home/acastrov/data/wordpress'
  mariadb:
    driver: local
    driver_opts:
      type: 'none'
      o: 'bind'
      device: '/home/acastrov/data/mariadb'
```
As you can see, the volumes are bind mounted to this path: /home/login/data/. Make sure to change "acastrov" with your own login when cloning this repo! As it is a bind mount, Docker can keep track os this storage location, but it can't manage it via the CLI whatsoever. Only the host can manipulate it using the started filesystem operations.

To do so, the Makefile first creates this directories, and only a `make fclean` can remove it. This also avoid accidents like use a `docker compose down -v` that could wipe all your data. You can also run `make list-volumes` to check the mount location.