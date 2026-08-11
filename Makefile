NAME = isda-base-docker

COMPOSE = docker compose
COMPOSE_FILE = docker-compose.yml

.PHONY: all up down clean fclean re setup init-exam-db exam grade exam-status exam-reset grade-all

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

init-exam-db:
	@echo "Initializing database 'isda-mock-exam'..."
	@docker exec -i postgres_db psql -U postgres -c "DROP DATABASE IF EXISTS \"isda-mock-exam\";" || true
	@docker exec -i postgres_db psql -U postgres -c "CREATE DATABASE \"isda-mock-exam\";"
	@docker exec -i postgres_db psql -U postgres -d "isda-mock-exam" -f /dev/stdin < mock-exam/init_db.sql
	@echo "Database 'isda-mock-exam' successfully initialized!"

exam:
	@python3 mock-exam/exam.py --start

grade:
	@python3 mock-exam/exam.py --submit

exam-status:
	@python3 mock-exam/exam.py --status

exam-reset:
	@python3 mock-exam/exam.py --reset

grade-all:
	@python3 mock-exam/grade.py


