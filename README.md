# Minimal PostgreSQL & pgAdmin Docker Setup

This repository contains a minimal Docker Compose configuration for PostgreSQL and pgAdmin 4, ideal for database and information systems courses.

## Quick Start (Using Makefile)

- **`make setup`**: Ensures `servers.json` exists for automatic pgAdmin database connection and starts all containers.
- **`make` / `make up`**: Build and start containers in detached mode.
- **`make down`**: Stop containers.
- **`make clean`**: Stop containers and remove locally built images.
- **`make fclean`**: Stop containers, remove all volumes (database data reset), images, and orphan containers.
- **`make re`**: Reset everything (`fclean`) and rerun `setup`.

---

## Automatic Database Initialization ([init.sql](file:///Users/jikaewsi/Documents/code_and_scripts/isda-base-docker/init.sql))

When the container starts up for the first time, PostgreSQL will automatically execute [init.sql](file:///Users/jikaewsi/Documents/code_and_scripts/isda-base-docker/init.sql) inside the `isda` database.

The tables created are:
- `ADMINISTRATION`
- `ADMIN_PR_VP`
- `ELECTION`
- `PRESIDENT`
- `PRES_HOBBY`
- `PRES_MARRIAGE`
- `STATE`

---

## Automatic pgAdmin Connection (`servers.json`)

pgAdmin automatically connects to the PostgreSQL database on startup using [servers.json](file:///Users/jikaewsi/Documents/code_and_scripts/isda-base-docker/servers.json):

```json
{
  "Servers": {
    "1": {
      "Name": "PostgreSQL DB",
      "Group": "Servers",
      "Host": "db",
      "Port": 5432,
      "MaintenanceDB": "isda",
      "Username": "postgres",
      "Password": "postgrespassword",
      "SSLMode": "prefer",
      "SavePassword": true
    }
  }
}
```

### Accessing pgAdmin
- **URL**: [http://localhost:5050](http://localhost:5050)
- **Email**: `admin@admin.com`
- **Password**: `admin`

Upon logging into pgAdmin, the **PostgreSQL DB** server (connected to database `isda`) will already be listed in the left sidebar tree, ready for use!

---

## Direct Database Connection (from Host Machine)
If you want to connect using DBeaver, TablePlus, or your application running locally on your computer outside Docker:

- **Host**: `localhost`
- **Port**: `5432`
- **Database**: `isda`
- **Username**: `postgres`
- **Password**: `postgrespassword`
