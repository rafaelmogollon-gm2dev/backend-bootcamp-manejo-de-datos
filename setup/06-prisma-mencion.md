# Setup 6 — Prisma (mención comparativa, no hands-on completo)

## Qué es y para qué lo mencionamos

Prisma es otro ORM para Node.js, con un enfoque distinto a Sequelize: define el esquema en un archivo declarativo (`schema.prisma`) en vez de código imperativo, genera un cliente con tipado automático, y tiene una interfaz visual (Prisma Studio) para ver los datos. Lo mostramos como comparación de DX (developer experience), no lo implementamos a fondo — eso queda para que lo exploren por su cuenta si les interesa.

## Paso a paso (demo rápida, no todos necesitan instalarlo)

1. En una carpeta de prueba aparte (no en el proyecto principal, para no mezclar con Sequelize):
   ```bash
   mkdir prisma-demo && cd prisma-demo
   npm init -y
   npm install prisma@6 --save-dev
   npm install @prisma/client@6
   npx prisma init
   ```
   **Importante — pineá la versión `@6` como arriba, no instales `prisma` a secas.** Verificado: al momento de escribir esto, `npm install prisma --save-dev` sin versión resuelve a un release candidate (`8.0.0-rc.13`) que hace fallar la instalación completa con un error críptico de npm (`Cannot read properties of null (reading 'edgesOut')`), sin ninguna pista de que el problema es la versión. Si en el futuro Prisma 8 ya está estable, probá sin pinear; si falla así, este es el motivo.
2. Esto crea `prisma/schema.prisma`, un `.env`, y (desde Prisma 6.something en adelante) un `prisma.config.ts` que centraliza la configuración — ya no alcanza con tener `DATABASE_URL` en `.env`, Prisma lee la conexión a través de ese archivo de config.
3. Completá `.env`:
   ```
   DATABASE_URL="postgresql://tu_usuario_de_mac@localhost:5432/postgres"
   ```
4. Reemplazá el contenido de `prisma/schema.prisma` por (el que genera `init` por defecto puede traer un `generator client` distinto, orientado a otro flujo — usá este para que coincida con lo que sigue):
   ```prisma
   generator client {
     provider = "prisma-client-js"
   }

   datasource db {
     provider = "postgresql"
     url      = env("DATABASE_URL")
   }

   model Item {
     id          Int     @id @default(autoincrement())
     nombre      String
     descripcion String?
   }
   ```
5. Generá la migración y el cliente:
   ```bash
   npx prisma migrate dev --name init
   ```
6. Abrí Prisma Studio para ver los datos visualmente:
   ```bash
   npx prisma studio
   ```
   Esto abre una interfaz web en `http://localhost:5555` donde podés ver y editar filas sin SQL ni cliente externo.

## Cómo verificar que funcionó

Si `npx prisma studio` abre el navegador y ves la tabla `Item` (vacía o con datos), Prisma está funcionando correctamente contra tu Postgres local.

## Errores comunes en Mac

### "Cannot read properties of null (reading 'edgesOut')" al instalar (verificado — pasa en la práctica)
Es un bug del resolver de npm (`arborist`) al instalar la versión "latest" de `prisma`, que en ciertos momentos resuelve a un release candidate inestable. Solución: instalar una versión mayor fija y estable, por ejemplo `npm install prisma@6 --save-dev` (ver paso 1 arriba).

### "Can't reach database server"
Revisá que `DATABASE_URL` en `.env` (o en `prisma.config.ts`, según la versión) tenga el usuario correcto (`whoami`) y que Postgres.app esté corriendo.

### "Environment variable not found: DATABASE_URL"
Prisma necesita el archivo `.env` en la raíz del proyecto donde corrés los comandos `npx prisma`, no en una subcarpeta. Si tenés `prisma.config.ts`, confirmá que ese archivo también apunte a la variable correcta.

### "Drift detected" / "We need to reset the schema" al correr `migrate dev`
Pasa si la base de datos que usás ya tenía tablas de otro ejercicio (por ejemplo, si reutilizás la misma base `postgres` de las clases anteriores). Prisma detecta que el estado real no coincide con el historial de migraciones que él conoce. Para esta demo aislada, lo más simple es usar una base nueva y vacía (`createdb prisma_demo` y apuntar `DATABASE_URL` ahí) en vez de la `postgres` que ya tiene tablas de Sequelize/SQL puro.

### Puerto 5555 ocupado (Prisma Studio)
```bash
npx prisma studio --port 5556
```

## Nota para la clase

Esta demo es para que vean la diferencia de enfoque (declarativo + tipado vs. Sequelize imperativo), no para que todos lo instalen en simultáneo. Alcanza con que el profesor lo muestre en pantalla y quien quiera problarlo después de clase, lo haga por su cuenta con el [Quickstart oficial](https://www.prisma.io/docs/getting-started) o el tutorial interactivo in-browser (sin instalar nada).
