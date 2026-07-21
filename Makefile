NAME = isda-base-docker

COMPOSE = docker compose
COMPOSE_FILE = docker-compose.yml

.PHONY: all up down clean fclean re setup

all: setup

setup:
	@if [ ! -f servers.json ]; then \
		echo "Creating servers.json..."; \
		echo '{\n  "Servers": {\n    "1": {\n      "Name": "PostgreSQL DB",\n      "Group": "Servers",\n      "Host": "db",\n      "Port": 5432,\n      "MaintenanceDB": "isda",\n      "Username": "postgres",\n      "Password": "postgrespassword",\n      "SSLMode": "prefer",\n      "SavePassword": true\n    }\n  }\n}' > servers.json; \
	fi
	$(COMPOSE) -f $(COMPOSE_FILE) up -d --build

up:
	$(COMPOSE) -f $(COMPOSE_FILE) up -d --build

down:
	$(COMPOSE) -f $(COMPOSE_FILE) down

clean:
	$(COMPOSE) -f $(COMPOSE_FILE) down --rmi local

fclean:
	$(COMPOSE) -f $(COMPOSE_FILE) down -v --rmi all --remove-orphans

re: fclean setup
