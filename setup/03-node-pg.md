# Setup 4 — Conectar Node.js a PostgreSQL (driver `pg`)

## Qué es y para qué lo instalamos

`pg` (node-postgres) es el driver que le permite a una app Node.js hablar directamente con PostgreSQL, sin pasar por un ORM. Lo usamos en la Clase 3 para entender qué hace un ORM "por debajo" antes de usar uno.

## Paso a paso

1. Parado en la carpeta de tu proyecto (tu API de la Semana 1, o `starter-api/`), instalá las dependencias:
   ```bash
   npm install pg dotenv
   ```
2. Creá un archivo `.env` en la raíz del proyecto con los datos de conexión:
   ```
   DB_HOST=localhost
   DB_PORT=5432
   DB_USER=tu_usuario_de_mac
   DB_PASSWORD=
   DB_NAME=postgres
   ```
   (reemplazá `tu_usuario_de_mac` por el resultado de `whoami` en la Terminal)
3. Agregá `.env` a tu `.gitignore` para no subir credenciales al repo:
   ```
   echo ".env" >> .gitignore
   ```
4. Creá un archivo `db.js` con el pool de conexiones:
   ```js
   require('dotenv').config();
   const { Pool } = require('pg');

   const pool = new Pool({
     host: process.env.DB_HOST,
     port: process.env.DB_PORT,
     user: process.env.DB_USER,
     password: process.env.DB_PASSWORD,
     database: process.env.DB_NAME,
   });

   module.exports = pool;
   ```

## Cómo verificar que funcionó

Creá un archivo de prueba `test-conexion.js`:

```js
const pool = require('./db');

pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('Error de conexión:', err);
  } else {
    console.log('Conexión OK, hora del servidor:', res.rows[0]);
  }
  pool.end();
});
```

Corrélo con:

```bash
node test-conexion.js
```

Si ves `Conexión OK, hora del servidor: ...`, está todo bien.

## Errores comunes en Mac

### "ECONNREFUSED 127.0.0.1:5432"
Postgres.app no está corriendo, o el puerto en tu `.env` no coincide con el real. Verificá con `psql postgres` desde la Terminal que la conexión directa funcione primero.

### "password authentication failed for user"
Tu `.env` tiene un `DB_USER` que no coincide con tu usuario real de Mac, o pusiste una contraseña donde Postgres.app no tiene ninguna configurada. Verificá con `whoami` y dejá `DB_PASSWORD` vacío si nunca configuraste una.

### "database \"postgres\" does not exist" o similar
Poco común con Postgres.app (crea `postgres` por defecto), pero si pasa, creá la base con:
```bash
createdb postgres
```

### El módulo `dotenv` no carga las variables
Asegurate de que `require('dotenv').config()` esté en la primera línea de tu archivo de entrada (`index.js` o `db.js`), antes de leer cualquier `process.env`.

### Conectando contra Supabase en vez de local
Si usás la alternativa cloud, reemplazá las variables del `.env` por los datos de tu connection string de Supabase (host, puerto —ojo que Supabase puede usar 5432 o 6543 según el modo—, usuario, password, database). Ver [setup/00-supabase-alternativa-cloud.md](00-supabase-alternativa-cloud.md).

## Cómo "desinstalar" / limpiar

No hay nada que desinstalar del sistema — simplemente borrá `node_modules`, `.env` y los archivos de prueba si querés empezar de cero:

```bash
rm -rf node_modules .env test-conexion.js
```
