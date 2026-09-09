# Clase 3 — Interacciones con la Base de Datos desde Node

## Por qué esto importa

Ya sabés escribir SQL y ya tenés tus tablas creadas en Postgres. El paso que falta es conectar eso con tu API: hasta ahora, tu servidor Express sigue leyendo y escribiendo en un array en memoria, no en la base de datos real que armaste en la Clase 2.

Esta clase reemplaza esa memoria volátil por queries reales, usando el driver `pg` — la librería que le permite a Node.js hablar directamente con PostgreSQL. Vamos a hacerlo sin un ORM todavía, a propósito: entender qué pasa "por debajo" te va a servir para valorar (y depurar) lo que un ORM como Sequelize hace por vos en la Clase 4.

## Conceptos clave

### El driver `pg` y el pool de conexiones

`pg` (node-postgres) es la librería que traduce las llamadas de tu código JavaScript en comunicación real con el servidor de PostgreSQL. En vez de abrir una conexión nueva cada vez que llega un request (algo costoso y lento), se usa un **pool de conexiones**: un conjunto de conexiones ya abiertas que se reutilizan entre requests.

### Variables de entorno

Las credenciales de tu base de datos (usuario, contraseña, host) nunca deberían estar escritas directamente en tu código ni subidas a un repositorio. Se guardan en un archivo `.env`, que se lee con la librería `dotenv` y se excluye del control de versiones con `.gitignore`. Esto separa la configuración del código, y evita que un secreto termine expuesto públicamente.

### Queries parametrizadas y SQL Injection

Cuando armás una query SQL a partir de un input del usuario, existen dos formas de hacerlo:

- **Concatenando strings** (peligroso): el input del usuario se inserta directamente en el texto de la query. Si alguien manda un input diseñado para alterar la estructura de la consulta (por ejemplo, cerrando comillas y agregando SQL propio), puede ejecutar comandos que no tenías previstos — esto se llama **SQL Injection**, uno de los ataques más comunes y más graves contra aplicaciones web.
- **Parametrizada** (correcta): el input se pasa como un valor separado (`$1`, `$2`, etc.), y la librería se encarga de tratarlo siempre como dato, nunca como código SQL ejecutable.

Esta no es una cuestión de estilo: usar queries parametrizadas es una práctica obligatoria en cualquier código que toque una base de datos con inputs externos.

## Actividad de indagación

Vas a leer la documentación de node-postgres sobre queries parametrizadas y la página de OWASP sobre SQL Injection, para entender en profundidad por qué concatenar strings no alcanza. Material de apoyo en [recursos/referencias.md](recursos/referencias.md).

## Ejercicio práctico: persistencia real en tu API

1. Creá las tablas de tu propio dominio en Postgres (si no lo hiciste en Clase 2, usá el `CREATE TABLE` que ya tenés).
2. Migrá tu API (o [starter-api](starter-api/)) para que las rutas CRUD trabajen contra esas tablas reales, usando `pg` y queries parametrizadas.
3. Probá cada ruta con Postman o `curl`, confirmando que los datos persisten aunque reinicies el servidor.
4. Si te sobra tiempo: agregá manejo de errores básico (por ejemplo, devolver un 400 si falta un campo obligatorio, antes de mandar la query a Postgres).

Si no tenés tu propia API de la Semana 1 lista, usá [starter-api](starter-api/) — una API Express mínima con dos entidades relacionadas, pensada como punto de partida garantizado para el resto de las clases de esta semana.

## Herramientas de esta clase

- Setup de conexión Node + PostgreSQL con el driver `pg`: [setup/01-node-pg.md](setup/01-node-pg.md).

## Para llevarte de esta clase

- Tu API ya no pierde datos al reiniciar — tiene persistencia real.
- Entendés que un ORM (Clase 4) es una capa de conveniencia sobre esto mismo que acabás de escribir a mano.
- Las queries parametrizadas no son opcionales — es la defensa básica contra SQL injection.
