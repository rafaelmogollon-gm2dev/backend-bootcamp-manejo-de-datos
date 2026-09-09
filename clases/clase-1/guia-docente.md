# Guía docente — Clase 1

**Duración total:** 4hs (bloques cortos, no exposición corrida)

## Antes de la clase (avisar por Slack/canal del bootcamp)

- Instalar Postgres.app: [setup/01-postgres.md](setup/01-postgres.md)
- Instalar TablePlus o pgAdmin: [setup/02-tableplus-pgadmin.md](setup/02-tableplus-pgadmin.md)
- Si algo falla, alternativa cloud: [setup/00-supabase-alternativa-cloud.md](setup/00-supabase-alternativa-cloud.md)
- Al arrancar la clase: preguntar quién no pudo instalar y resolver 1:1 mientras el resto avanza con el material de indagación.

## Bloque 1 (~25 min) — Repaso + por qué persistencia real

- Repaso relámpago: qué construyeron en la Semana 1 (API Express con CRUD en memoria).
- El problema: si reiniciás el servidor, ¿qué pasa con los datos? (que ellos mismos lo digan)
- Qué es una base de datos: tablas, columnas, filas, tipos de datos.
- Claves primarias: por qué necesitamos un identificador único por fila.
- Mención breve SQL vs NoSQL (relacional = tablas con estructura fija y relaciones explícitas; documentos = estructura flexible, sin JOINs).

## Pregunta abierta 1 (~15 min investigan, ~10 min puesta en común)

**Consigna:** "Busquen la diferencia entre una base de datos SQL y una NoSQL. ¿Cuándo elegirían una sobre la otra? Piensen en el proyecto de React que entregaron: ¿cómo modelarían sus datos en cada una?"

**Material:** ver [recursos/referencias.md](recursos/referencias.md)

## Bloque 2 (~30 min) — Explorar una base de datos ya armada

- Cargar la mini-DB "Biblioteca" (ver [ejercicios/biblioteca/README.md](ejercicios/biblioteca/README.md)):
  ```bash
  psql postgres -f ejercicios/biblioteca/seed.sql
  ```
- Abrir TablePlus/pgAdmin y navegar juntos: tablas `autores`, `libros`, `prestamos`.
- Señalar en vivo: ahí está la clave primaria (`id`), ahí está la clave foránea (`autor_id`), así se ve una relación 1 a N sin explicarla todavía en profundidad — solo que la vean con datos reales antes de la teoría formal.
- Que cada alumno explore por su cuenta 5-10 minutos: cambiar valores, agregar una fila manualmente desde la interfaz visual (sin SQL), y contar qué encontraron.

## Bloque 3 (~20 min) — Modelado ER: pensar antes de codear

- Presentar dbdiagram.io ([setup/03-dbdiagram.md](setup/03-dbdiagram.md)).
- Recrear en vivo el diagrama de "Biblioteca" a partir de lo que vieron en TablePlus (ida y vuelta entre "esto es lo que ya existe" y "así se diagrama").
- Concepto de normalización: por qué separamos autores de libros en vez de repetir el nombre del autor en cada fila de libro (mencionar 1FN/2FN/3FN sin exhaustividad).

## Pregunta abierta 2 (~15 min investigan, ~10 min puesta en común)

**Consigna:** "Investiguen qué es la normalización (1FN, 2FN, 3FN). Con sus propias palabras: ¿por qué separar los datos en varias tablas en vez de tener una sola tabla gigante?"

**Material:** ver [recursos/referencias.md](recursos/referencias.md)

## Bloque 4 (~15 min) — Buffer de dudas y troubleshooting de setup

- Espacio abierto para resolver instalaciones que no terminaron de andar (Postgres.app, TablePlus/pgAdmin) antes de que se meta de lleno en el ejercicio.

## Ejercicio práctico (~1h40)

**Consigna:** modelar en dbdiagram.io el dominio de su propio proyecto de React (Harry Potter, Star Wars, Pokémon, o el que hayan elegido) — **no importa si terminaron el frontend o no**, solo necesitan tener claro qué entidades manejan.

Mínimo esperado:
- Al menos 2 tablas relacionadas entre sí (ej. personajes y casas/facciones, o naves y planetas).
- Cada tabla con su clave primaria.
- Al menos una clave foránea marcando la relación.
- Si termina antes de tiempo: agregar una tercera tabla (ej. relación N a N, como personajes y hechizos que pueden compartirse entre varios personajes) y pensar cómo se modelaría esa relación con una tabla intermedia.

**Cierre:** 2-3 voluntarios comparten su diagrama y explican las decisiones (qué entidades eligieron, por qué esa relación).

## Notas de facilitación

- El objetivo pedagógico central: que salgan pensando en modelos antes que en código. No apurar el Bloque 3 aunque el grupo venga con ganas de "ya escribir algo".
- Si la mayoría no llegó con Postgres.app instalado, usar el Bloque 4 completo (y robar 5-10 min del ejercicio) antes de avanzar — sin base de datos funcionando, el resto de la semana se cae.
- La presentación (`presentacion.pptx`) sigue esta misma estructura de bloques, con la consigna de cada pregunta abierta y del ejercicio como slide propia para que quede a la vista del grupo mientras trabajan.
