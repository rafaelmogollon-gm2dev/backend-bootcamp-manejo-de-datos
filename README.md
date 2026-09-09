# Backend Bootcamp — Manejo de Datos

Material de las 5 clases de "Manejo de Datos" (Semana 2 del bootcamp de backend): introducción a bases de datos, modelado, SQL, relaciones, e interacción desde Node.js con y sin ORM.

## Estructura del repo

- `setup/` — guías paso a paso para instalar cada herramienta (Postgres, TablePlus/pgAdmin, Sequelize, Prisma)
- `clases/` — contenido de cada clase (temario, ejercicios, indagación)
- `recursos/` — banco de referencias: documentación oficial, tutoriales, videos
- `ejercicios/biblioteca/` — dominio guiado común usado en las clases 1 y 2
- `starter-api/` — API Express mínima (CRUD en memoria) usada como base garantizada por si algún alumno no llega con su proyecto de la Semana 1 funcionando

## Clases

1. [Introducción a Bases de Datos y Modelado](clases/clase-1-introduccion-modelado/README.md)
2. [SQL y Relaciones](clases/clase-2-sql-relaciones/README.md)
3. [Interacciones con la Base de Datos desde Node](clases/clase-3-interacciones-node/README.md)
4. [Construcción & ORM — Sequelize](clases/clase-4-orm-sequelize-1/README.md)
5. [Construcción & ORM — Consolidación + Prisma](clases/clase-5-orm-sequelize-2-prisma/README.md)

## Setup (instalar antes de cada clase)

0. [Alternativa cloud: Supabase](setup/00-supabase-alternativa-cloud.md) — plan B si falla la instalación local
1. [PostgreSQL con Postgres.app](setup/01-postgres.md)
2. [Cliente visual: TablePlus o pgAdmin](setup/02-tableplus-pgadmin.md)
3. [Conectar Node.js a PostgreSQL (driver pg)](setup/03-node-pg.md)
4. [dbdiagram.io (modelado ER)](setup/04-dbdiagram.md)
5. [Sequelize](setup/05-sequelize.md)
6. [Prisma (mención comparativa)](setup/06-prisma-mencion.md)
