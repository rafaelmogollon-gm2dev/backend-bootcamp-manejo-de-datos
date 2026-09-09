# Guía docente — Clase 3

**Duración total:** 4hs (bloques cortos, no exposición corrida)

## Antes de la clase

- Setup de conexión Node + Postgres: [setup/01-node-pg.md](setup/01-node-pg.md)
- Preguntar al grupo: "¿quiénes tienen su API de la Semana 1 corriendo ahora mismo?"
  - **Mayoría sí:** cada uno trabaja sobre su propia API durante el ejercicio.
  - **Mayoría no / dudas:** todos trabajan sobre [starter-api/](starter-api/README.md), la propia queda como desafío opcional después de clase.

## Bloque 1 (~20 min) — Repaso de la API existente + el problema de la memoria

- Repasar en vivo la estructura de `starter-api` (o de un voluntario que tenga la suya): rutas, dónde vive el array en memoria.
- Preguntar: "si reinician el servidor ahora, ¿qué pasa con los items que crearon?" — que lo prueben ellos mismos.
- Introducir el driver `pg`: qué es, por qué existe antes de un ORM.

## Bloque 2 (~25 min) — Pool de conexiones y primera query

- Explicar qué es un pool de conexiones (por qué no abrir una conexión nueva por cada request).
- Variables de entorno con `dotenv` — por qué las credenciales no van hardcodeadas ni al repo.
- Escribir juntos la primera query real: `GET /items` reemplazando el array por `SELECT * FROM items`.

## Pregunta abierta (~15 min investigan, ~10 min puesta en común)

**Consigna:** "Lean la sección de la documentación de node-postgres sobre queries parametrizadas (`$1`, `$2`, etc.) y la página de OWASP sobre SQL Injection. ¿Por qué no alcanza con concatenar strings para armar una query?"

**Material:** ver [recursos/referencias.md](recursos/referencias.md)

## Bloque 3 (~30 min) — CRUD completo con queries parametrizadas

- Migrar juntos las rutas restantes (`POST`, `PUT`, `DELETE`) usando placeholders (`$1`, `$2`) en vez de concatenar strings.
- Mostrar en vivo un ejemplo de query vulnerable (concatenada) vs. parametrizada, con un input "malicioso" simple para que vean la diferencia de comportamiento.

## Bloque 4 (~15 min) — Buffer de dudas y troubleshooting

- Espacio abierto para resolver errores de conexión (`.env`, pool, puerto) antes de pasar al ejercicio largo.

## Ejercicio práctico (~2h05)

**Consigna:**

1. Crear las tablas de su propio dominio en Postgres (si no lo hicieron en Clase 2, usar el `CREATE TABLE` que ya tienen).
2. Migrar su API (o `starter-api`) para que las rutas CRUD trabajen contra esas tablas reales, usando `pg` y queries parametrizadas.
3. Probar cada ruta con Postman o `curl`, confirmando que los datos persisten aunque reinicien el servidor.
4. Si termina antes de tiempo: agregar manejo de errores básico (por ejemplo, devolver 400 si falta un campo obligatorio antes de mandar la query a Postgres).

**Cierre:** cada alumno reinicia su servidor en vivo y hace un GET para demostrar que los datos siguen ahí.

## Notas de facilitación

- La demo del input "malicioso" en el Bloque 3 es el momento más memorable de la clase — no te la saltees aunque vayas justo de tiempo, es lo que hace tangible por qué importan las queries parametrizadas.
- `starter-api` (en esta carpeta) ya tiene dos entidades relacionadas (`categorias`/`items`) para que el ejercicio no quede limitado a una sola tabla, incluso para quien no traiga su propia API.
- La presentación (`presentacion.pptx`) sigue esta misma estructura de bloques.
