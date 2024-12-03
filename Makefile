COMPOSE_FILE = ./srcs/docker-compose.yml
 
all: start

start:
		@mkdir -p /home/kali/data/wordpress
		@mkdir -p /home/kali/data/mariadb
		docker compose -f $(COMPOSE_FILE) up -d

down:
		docker compose -f $(COMPOSE_FILE) down
.SILENT:

clean: down
		docker compose -f $(COMPOSE_FILE) rm

fclean: clean
		docker compose -f $(COMPOSE_FILE) down -v --rmi all

prune: fclean
		docker system prune -af

re: prune start
