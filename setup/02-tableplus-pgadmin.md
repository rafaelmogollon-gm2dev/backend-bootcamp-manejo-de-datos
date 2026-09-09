# Setup 2 — Cliente visual: TablePlus o pgAdmin

## Qué es y para qué lo instalamos

Un cliente visual nos permite ver tablas, datos y relaciones sin escribir SQL a mano todo el tiempo. Elegí **una** de las dos opciones (no hace falta instalar ambas). TablePlus es más liviano y rápido; pgAdmin es 100% gratis sin límites y es la herramienta "oficial" del ecosistema Postgres.

---

## Opción A — TablePlus (recomendado)

### Paso a paso

1. Entrá a [tableplus.com](https://tableplus.com) y descargá la versión para Mac.
2. Abrí el `.dmg` y arrastrá TablePlus a `Aplicaciones`.
3. Abrí TablePlus desde `Aplicaciones`.
   - **Si Mac bloquea la apertura:** `Preferencias del Sistema → Privacidad y Seguridad` → "Abrir de todas formas".
4. Al abrir por primera vez, click en **"Create a new connection"**.
5. Elegí **PostgreSQL** de la lista de motores.
6. Completá los datos (los mismos del setup de Postgres.app):
   - Name: `Local Postgres` (o el nombre que quieras)
   - Host: `localhost`
   - Port: `5432`
   - User: tu usuario de Mac (`whoami` en la Terminal si no lo recordás)
   - Password: dejalo vacío
   - Database: `postgres`
7. Click en **"Test"** — debería aparecer un tilde verde. Si es así, click en **"Connect"**.

### Nota sobre la versión gratis

TablePlus en su versión gratis limita la cantidad de pestañas/conexiones simultáneas abiertas (no la cantidad de bases de datos guardadas). Para el uso de este bootcamp alcanza sin problema.

---

## Opción B — pgAdmin 4

### Paso a paso

1. Entrá a [pgadmin.org/download](https://www.pgadmin.org/download/pgadmin-4-macos/) y descargá el instalador para Mac.
2. Abrí el `.dmg` y arrastrá pgAdmin 4 a `Aplicaciones`.
3. Abrí pgAdmin 4. La primera vez te va a pedir configurar una **contraseña maestra** (es solo para la app, no es la de Postgres) — guardala en un lugar que recuerdes.
4. En el panel izquierdo, click derecho en **"Servers" → "Register" → "Server..."**.
5. Pestaña **General**: en "Name" poné `Local Postgres`.
6. Pestaña **Connection**:
   - Host name/address: `localhost`
   - Port: `5432`
   - Maintenance database: `postgres`
   - Username: tu usuario de Mac
   - Password: dejalo vacío y tildá "Save password" si te lo permite (si Postgres.app no tiene contraseña configurada, puede pedirte que la dejes en blanco y confirmes igual)
7. Click en **Save**.

---

## Cómo verificar que funcionó (ambas opciones)

Deberías poder ver, en el árbol de la izquierda, la base de datos `postgres` con sus esquemas (`public`, etc.). Si podés expandir "Tables" (va a estar vacío porque todavía no creamos ninguna), la conexión funciona.

## Errores comunes en Mac

### "Connection refused" o "could not connect to server"
Postgres.app no está corriendo. Abrilo y verificá que el servidor esté iniciado (ver [setup/01-postgres.md](01-postgres.md)).

### "password authentication failed"
Dejaste algo escrito en el campo contraseña cuando debía estar vacío, o tu usuario de Postgres tiene contraseña configurada y no la estás poniendo. Probá dejar el campo completamente vacío, o revisá con `psql postgres` desde la Terminal si te pide contraseña.

### La app no abre / "TablePlus/pgAdmin4 está dañado y no se puede abrir"
Esto pasa por la cuarentena de Gatekeeper en descargas de internet. Solución:
```bash
xattr -cr /Applications/TablePlus.app
```
(reemplazá la ruta por `pgAdmin\ 4.app` si es esa la que falla).

### pgAdmin pide contraseña maestra y no la recuerdo
No hay forma de recuperarla — hay que reinstalar pgAdmin desde cero:
```bash
rm -rf ~/Library/Preferences/org.pgadmin.pgadmin4.plist
```
y volver a abrir la app para configurar una nueva.

## Cómo desinstalar

**TablePlus:** arrastrá `TablePlus.app` desde `Aplicaciones` a la Papelera. Opcionalmente borrá preferencias:
```bash
rm -rf ~/Library/Application\ Support/com.tableplus.TablePlus
```

**pgAdmin:** arrastrá `pgAdmin 4.app` a la Papelera. Opcionalmente:
```bash
rm -rf ~/Library/Preferences/org.pgadmin.pgadmin4.plist
```
