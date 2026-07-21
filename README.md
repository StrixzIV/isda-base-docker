# Minimal PostgreSQL & pgAdmin Docker Setup

This repository contains a minimal Docker Compose configuration for PostgreSQL and pgAdmin 4, ideal for database and information systems courses.

## Quick Start (Using Makefile)

- **`make` / `make up`**: Build and start containers in detached mode.
- **`make down`**: Stop containers.
- **`make clean`**: Stop containers and remove locally built images.
- **`make fclean`**: Stop containers, remove all volumes (database data reset), images, and orphan containers.
- **`make re`**: Reset everything (`fclean`) and restart (`up`).

---

## Direct Docker Commands

```bash
docker compose up -d
```

### Access pgAdmin
- **URL**: [http://localhost:5050](http://localhost:5050)
- **Email**: `admin@admin.com`
- **Password**: `admin`

### Connect pgAdmin to PostgreSQL
Once logged into pgAdmin, click **Add New Server** and enter the following settings:

#### General Tab
- **Name**: `PostgreSQL DB` (or any name you prefer)

#### Connection Tab
- **Host name / address**: `db`
- **Port**: `5432`
- **Maintenance database**: `main_db`
- **Username**: `postgres`
- **Password**: `postgrespassword`
- Check **Save password?** for convenience.

---

## Direct Database Connection (from Host Machine)
If you want to connect using DBeaver, TablePlus, or your application running locally on your computer outside Docker:

- **Host**: `localhost`
- **Port**: `5432`
- **Database**: `main_db`
- **Username**: `postgres`
- **Password**: `postgrespassword`
