# Setup 0 — Alternativa cloud: Supabase (por si la instalación local falla)

## Qué es y para qué lo instalamos

Supabase ofrece una base de datos PostgreSQL real, gestionada en la nube, con plan gratuito. Es el **plan B** si la instalación local de Postgres.app da problemas en tu Mac (permisos, puertos ocupados, etc.) — en 2 minutos tenés un Postgres funcionando sin instalar nada.

No reemplaza el setup local: para las clases en vivo usamos Postgres.app, pero si algo no arranca el día de la clase, esta es la alternativa para no quedarte sin poder practicar.

**Nota de verificación:** no se probó la creación real de un proyecto en la plataforma de Supabase (requiere cuenta propia) — los pasos siguen la interfaz pública documentada por Supabase al momento de escribir esto. Lo que sí está verificado es que el resto del material (SQL, `pg`, Sequelize, Prisma) funciona igual contra cualquier Postgres real, sea local o en Supabase, porque todos hablan el mismo protocolo — así que si Supabase cambia algún botón de su UI, el resto de las clases no se ve afectado.

## Paso a paso

1. Entrá a [supabase.com](https://supabase.com) y hacé click en **"Start your project"**.
2. Creá una cuenta (podés usar GitHub para no tener que definir otra contraseña).
3. Click en **"New project"**.
4. Completá:
   - Name: el nombre que quieras (ej. `bootcamp-manejo-datos`)
   - Database Password: generá una password fuerte y **guardala** (la vas a necesitar para conectarte)
   - Region: elegí la más cercana (ej. `South America (São Paulo)`)
   - Plan: Free
5. Click en **"Create new project"**. Tarda 1-2 minutos en aprovisionarse.
6. Una vez listo, andá a **Project Settings → Database**.
7. Ahí vas a ver la **Connection string** — copiá la que dice "URI" (formato `postgresql://postgres:[TU-PASSWORD]@...`).

## Cómo verificar que funcionó

Con la connection string, conectate desde la Terminal:

```bash
psql "postgresql://postgres:TU-PASSWORD@db.xxxxxxxxxxxx.supabase.co:5432/postgres"
```

O pegá esos mismos datos (host, puerto, usuario, password, database) en TablePlus/pgAdmin como una conexión nueva, igual que hiciste con la local.

Si ves el prompt `postgres=#` o la conexión conecta en TablePlus, funciona.

## Errores comunes

### "connection timed out"
Puede ser tu red (algunas redes corporativas/wifi de universidad bloquean el puerto 5432 saliente). Probá desde otra red o usá el modo "Connection pooling" de Supabase (puerto 6543), que usa un puerto distinto y suele evitar bloqueos.

### Olvidaste la contraseña de la base
Andá a **Project Settings → Database → Reset database password**. Genera una nueva; vas a tener que actualizar la connection string donde la estés usando.

### El proyecto se "pausó"
El plan free de Supabase pausa proyectos inactivos después de un tiempo sin uso. Entrá al dashboard y hacé click en "Restore project" — tarda un par de minutos en reactivarse.

## Nota

Guardá la connection string en un lugar seguro, nunca la subas a un repo público. Cuando lleguemos a la clase de conexión desde Node, vamos a guardarla en un archivo `.env` que **no** se commitea (ver [setup/03-node-pg.md](03-node-pg.md)).
