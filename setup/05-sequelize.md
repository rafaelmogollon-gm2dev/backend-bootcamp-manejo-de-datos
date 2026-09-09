# Setup 5 — Sequelize

## Qué es y para qué lo instalamos

Sequelize es un ORM (Object-Relational Mapper) para Node.js: nos permite definir modelos como clases/objetos JavaScript en vez de escribir SQL a mano, y maneja migraciones, relaciones y validaciones básicas por nosotros.

## Paso a paso

1. Parado en la carpeta de tu proyecto, instalá Sequelize y el CLI:
   ```bash
   npm install sequelize pg pg-hstore
   npm install --save-dev sequelize-cli
   ```
   (`pg` ya lo tenías de la Clase 3; `pg-hstore` es una dependencia que Sequelize necesita para Postgres)

2. Inicializá la estructura de Sequelize:
   ```bash
   npx sequelize-cli init
   ```
   Esto crea las carpetas `config/`, `models/`, `migrations/`, `seeders/`.

3. Editá `config/config.json` (o convertilo a usar variables de entorno) con tus datos de conexión:
   ```json
   {
     "development": {
       "username": "tu_usuario_de_mac",
       "password": null,
       "database": "postgres",
       "host": "localhost",
       "port": 5432,
       "dialect": "postgres"
     }
   }
   ```

4. Generá tu primer modelo (ejemplo con las entidades de `starter-api`, `Categoria` e `Item`):
   ```bash
   npx sequelize-cli model:generate --name Categoria --attributes nombre:string
   npx sequelize-cli model:generate --name Item --attributes nombre:string,descripcion:string,categoriaId:integer
   ```
   Esto crea los modelos en `models/` y las migraciones correspondientes en `migrations/`. Si tu dominio es otro (el de tu propio proyecto), usá tus propias entidades en lugar de estas.

5. Corré la migración para crear la tabla:
   ```bash
   npx sequelize-cli db:migrate
   ```

## Cómo verificar que funcionó

```bash
npx sequelize-cli db:migrate:status
```

Debería mostrar tu migración marcada como `up`. También podés verificar en TablePlus/pgAdmin que la tabla `Items` se haya creado.

## Errores comunes en Mac

### "SequelizeConnectionError: password authentication failed"
Mismo problema que con `pg` puro: revisá `username` en `config.json` contra el resultado de `whoami`, y que `password` sea `null` si Postgres.app no tiene contraseña configurada.

### "Please install pg package manually"
Falta instalar el driver de Postgres (Sequelize no lo trae por defecto, es agnóstico de motor):
```bash
npm install pg pg-hstore
```

### "SequelizeMigrationError" al correr `db:migrate` dos veces
Sequelize ya aplicó esa migración antes. Si necesitás resetear todo en desarrollo:
```bash
npx sequelize-cli db:migrate:undo:all
npx sequelize-cli db:migrate
```

### El modelo generado no tiene el campo que esperaba
Revisá el archivo de migración en `migrations/` — a veces hay que editarlo a mano para ajustar tipos, `allowNull`, o agregar `references` para claves foráneas (por ejemplo, `autor_id` referenciando `Autores`).

### Conflicto de nombres entre tabla y modelo
Sequelize por convención pluraliza el nombre del modelo para la tabla (`Item` → `Items`). Si tu tabla ya existía con otro nombre (de la Clase 3), especificá `tableName` en el modelo para que apunte a la tabla correcta en vez de crear una nueva.

## Cómo desinstalar / empezar de cero

```bash
rm -rf config migrations models seeders .sequelizerc
npm uninstall sequelize sequelize-cli pg-hstore
```

(Esto no borra las tablas ya creadas en Postgres — para eso hay que hacer `db:migrate:undo:all` antes de borrar las migraciones, o borrar las tablas manualmente desde TablePlus/pgAdmin.)
