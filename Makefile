NAME = isda-base-docker

COMPOSE = docker compose
COMPOSE_FILE = docker-compose.yml

.PHONY: all up down clean fclean re

all: up

up:
	$(COMPOSE) -f $(COMPOSE_FILE) up -d --build

down:
	$(COMPOSE) -f $(COMPOSE_FILE) down

clean:
	$(COMPOSE) -f $(COMPOSE_FILE) down --rmi local

fclean:
	$(COMPOSE) -f $(COMPOSE_FILE) down -v --rmi all --remove-orphans

re: fclean all
