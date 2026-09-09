# Setup 6 — Prisma (mención comparativa, no hands-on completo)

## Qué es y para qué lo mencionamos

Prisma es otro ORM para Node.js, con un enfoque distinto a Sequelize: define el esquema en un archivo declarativo (`schema.prisma`) en vez de código imperativo, genera un cliente con tipado automático, y tiene una interfaz visual (Prisma Studio) para ver los datos. Lo mostramos como comparación de DX (developer experience), no lo implementamos a fondo — eso queda para que lo exploren por su cuenta si les interesa.

## Paso a paso (demo rápida, no todos necesitan instalarlo)

1. En una carpeta de prueba aparte (no en el proyecto principal, para no mezclar con Sequelize):
   ```bash
   mkdir prisma-demo && cd prisma-demo
   npm init -y
   npm install prisma --save-dev
   npm install @prisma/client
   npx prisma init
   ```
2. Esto crea `prisma/schema.prisma` y un `.env` con `DATABASE_URL`.
3. Completá `.env`:
   ```
   DATABASE_URL="postgresql://tu_usuario_de_mac@localhost:5432/postgres"
   ```
4. Definí un modelo simple en `prisma/schema.prisma`:
   ```prisma
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

### "Can't reach database server"
Revisá que `DATABASE_URL` en `.env` tenga el usuario correcto (`whoami`) y que Postgres.app esté corriendo.

### "Environment variable not found: DATABASE_URL"
Prisma necesita el archivo `.env` en la raíz del proyecto donde corrés los comandos `npx prisma`, no en una subcarpeta.

### Puerto 5555 ocupado (Prisma Studio)
```bash
npx prisma studio --port 5556
```

## Nota para la clase

Esta demo es para que vean la diferencia de enfoque (declarativo + tipado vs. Sequelize imperativo), no para que todos lo instalen en simultáneo. Alcanza con que el profesor lo muestre en pantalla y quien quiera problarlo después de clase, lo haga por su cuenta con el [Quickstart oficial](https://www.prisma.io/docs/getting-started) o el tutorial interactivo in-browser (sin instalar nada).
