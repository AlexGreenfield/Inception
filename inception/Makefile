DOCKERCOMPOSE_PATH = ./srcs/docker-compose.yml
# Change for login
VOLUMES_PATH = /home/alejandro/data

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

re: fclean all

.PHONY: all setup stop down list-volumes clean fclean re docker-restart