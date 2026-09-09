# Setup 1 — PostgreSQL con Postgres.app

## Qué es y para qué lo instalamos

PostgreSQL es el motor de base de datos relacional que vamos a usar en todas las clases de Manejo de Datos. Postgres.app es la forma más simple de tener Postgres corriendo en una Mac: es una aplicación normal, sin terminal ni gestores de paquetes.

**Versión verificada para este bootcamp: PostgreSQL 16.** Todo el material (queries, Sequelize, Prisma) fue probado contra esta versión real de PostgreSQL. Postgres.app suele ofrecer instalar varias versiones mayores en simultáneo — elegí 16 si te da a elegir.

**Nota de verificación:** el motor PostgreSQL 16 en sí y todos los comandos (`psql`, `createuser`, etc.) fueron probados de punta a punta. Los pasos específicos de la app Postgres.app (el instalador `.dmg`, el diálogo de "Initialize", los mensajes de Gatekeeper) no se probaron en una Mac real — siguen la documentación pública de postgresapp.com.

## Paso a paso

1. Entrá a [postgresapp.com](https://postgresapp.com) y descargá la versión más reciente del instalador (Postgres.app en sí se actualiza seguido, pero eso es independiente de qué versión de PostgreSQL vas a correr adentro — eso se elige en el paso 4).
2. Abrí el `.dmg` descargado y arrastrá el ícono de Postgres.app a la carpeta `Aplicaciones`.
3. Abrí Postgres.app desde `Aplicaciones` (o Spotlight, `cmd+espacio` y escribí "Postgres").
   - **Si Mac bloquea la apertura** ("no se puede abrir porque no se pudo verificar el desarrollador"): andá a `Preferencias del Sistema → Privacidad y Seguridad`, bajá hasta el mensaje sobre Postgres.app y hacé click en "Abrir de todas formas".
4. En la ventana que aparece vas a ver una lista de versiones de PostgreSQL para elegir (14, 15, 16, 17, etc.) — **elegí la 16** y hacé click en **"Initialize"**. Esto crea un servidor Postgres nuevo con esa versión y lo deja corriendo (vas a ver un elefante 🐘 en la barra de menú, arriba a la derecha).
   - Si Postgres.app no te ofrece elegir versión y directamente inicializa una (versiones nuevas a veces simplifican esto), no hay problema: cualquier versión 15+ es compatible con todo lo que vamos a hacer. Los pasos exactos de instalación y los mensajes de error solo fueron verificados con la 16.
5. Postgres.app agrega automáticamente sus herramientas de línea de comandos (`psql`, `createdb`, etc.) pero necesitás sumarlas a tu PATH:
   - Abrí la Terminal.
   - Ejecutá:
     ```bash
     sudo mkdir -p /etc/paths.d && echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp
     ```
   - Cerrá la Terminal y abrila de nuevo (esto recarga el PATH).

## Cómo verificar que funcionó

En una Terminal nueva, ejecutá:

```bash
psql --version
```

Debería mostrar `psql (PostgreSQL) 16.x`. Si te muestra una versión distinta (14, 15, 17), no es un error — el material va a funcionar igual — pero si algo del contenido de las clases no se comporta exactamente como está documentado, la primera sospecha debería ser esa diferencia de versión.

Después probá conectarte a la base de datos por defecto:

```bash
psql postgres
```

Si ves un prompt como `postgres=#`, estás adentro. Para salir, escribí `\q` y Enter.

## Datos de conexión por defecto

Postgres.app crea un usuario con tu nombre de usuario de Mac (sin contraseña) y el servidor escucha en el puerto **5432**.

- Host: `localhost`
- Puerto: `5432`
- Usuario: tu usuario de Mac (podés verlo con el comando `whoami`)
- Contraseña: (vacía)
- Base de datos por defecto: `postgres`

## Errores comunes en Mac

### "psql: command not found"
El PATH no se actualizó. Cerrá **todas** las ventanas de Terminal y abrí una nueva. Si persiste, verificá que el archivo `/etc/paths.d/postgresapp` se haya creado (`cat /etc/paths.d/postgresapp`).

### Puerto 5432 ocupado / "could not bind IPv4 address"
Puede haber otro Postgres corriendo (por ejemplo, uno instalado antes con Homebrew). Para ver qué está usando el puerto:

```bash
lsof -i :5432
```

Si aparece un proceso que no es Postgres.app, matalo con `kill <PID>` (reemplazando `<PID>` por el número que te muestre `lsof`), o desinstalá el Postgres viejo (`brew uninstall postgresql` si lo instalaste con Homebrew).

### "connection refused" al conectarte con psql o TablePlus
El servidor no está corriendo. Abrí Postgres.app y verificá que el elefante de la barra de menú esté verde/activo. Si no, hacé click en el servidor listado y luego en "Start".

### "role \"tu_usuario\" does not exist"
Esto pasa si intentás conectarte con un usuario que Postgres.app no creó automáticamente. Volvé a hacer click en "Initialize" desde la app, o creá el rol manualmente:

```bash
createuser -s $(whoami)
```

### Apple Silicon (M1/M2/M3) vs Intel
Postgres.app detecta automáticamente la arquitectura de tu Mac — no hay pasos distintos, pero si descargaste el `.dmg` en una Mac y lo copiaste a otra con arquitectura distinta, puede fallar. Descargá siempre directo desde postgresapp.com en la máquina donde lo vas a usar.

## Cómo desinstalar / empezar de cero

1. Cerrá Postgres.app (click derecho en el elefante de la barra de menú → Quit).
2. Arrastrá Postgres.app desde `Aplicaciones` a la Papelera.
3. Borrá los datos del servidor (cuidado, esto borra todas tus bases de datos locales):
   ```bash
   rm -rf ~/Library/Application\ Support/Postgres
   ```
4. Borrá la entrada de PATH si ya no vas a usar Postgres.app:
   ```bash
   sudo rm /etc/paths.d/postgresapp
   ```
