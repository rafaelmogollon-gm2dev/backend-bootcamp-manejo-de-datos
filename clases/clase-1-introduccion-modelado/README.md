# Clase 1 — Introducción a Bases de Datos y Modelado

**Duración total:** 4hs (bloques cortos, no exposición corrida)

## Objetivo de la clase

Que entiendan por qué necesitamos persistencia real (más allá de la memoria/JSON de la Semana 1), qué es una base de datos relacional, y que practiquen pensar el modelo de datos (entidades, atributos, relaciones) **antes** de escribir una sola línea de SQL.

## Antes de la clase (avisar por Slack/canal del bootcamp)

- Instalar Postgres.app: [setup/01-postgres.md](../../setup/01-postgres.md)
- Instalar TablePlus o pgAdmin: [setup/02-tableplus-pgadmin.md](../../setup/02-tableplus-pgadmin.md)
- Si algo falla, alternativa cloud: [setup/00-supabase-alternativa-cloud.md](../../setup/00-supabase-alternativa-cloud.md)
- Al arrancar la clase: preguntar quién no pudo instalar y resolver 1:1 mientras el resto avanza con el material de indagación.

## Bloque 1 (~25 min) — Repaso + por qué persistencia real

- Repaso relámpago: qué construyeron en la Semana 1 (API Express con CRUD en memoria).
- El problema: si reiniciás el servidor, ¿qué pasa con los datos? (que ellos mismos lo digan)
- Qué es una base de datos: tablas, columnas, filas, tipos de datos.
- Claves primarias: por qué necesitamos un identificador único por fila.
- Mención breve SQL vs NoSQL (relacional = tablas con estructura fija y relaciones explícitas; documentos = estructura flexible, sin JOINs).

## Pregunta abierta 1 (~15 min investigan, ~10 min puesta en común)

**Consigna:** "Busquen la diferencia entre una base de datos SQL y una NoSQL. ¿Cuándo elegirían una sobre la otra? Piensen en el proyecto de React que entregaron: ¿cómo modelarían sus datos en cada una?"

**Material:**
- Video comparativo SQL vs NoSQL (ver [recursos/banco-de-referencias.md](../../recursos/banco-de-referencias.md))
- Documentación de MongoDB (conceptos básicos)

## Bloque 2 (~20 min) — Explorar una base de datos ya armada

- Cargar la mini-DB "Biblioteca" (ver [ejercicios/biblioteca/README.md](../../ejercicios/biblioteca/README.md)):
  ```bash
  psql postgres -f ejercicios/biblioteca/seed.sql
  ```
- Abrir TablePlus/pgAdmin y navegar juntos: tablas `autores`, `libros`, `prestamos`.
- Señalar en vivo: ahí está la clave primaria (`id`), ahí está la clave foránea (`autor_id`), así se ve una relación 1 a N sin explicarla todavía en profundidad — solo que la vean con datos reales antes de la teoría formal.

## Bloque 3 (~20 min) — Modelado ER: pensar antes de codear

- Presentar dbdiagram.io ([setup/04-dbdiagram.md](../../setup/04-dbdiagram.md)).
- Recrear en vivo el diagrama de "Biblioteca" a partir de lo que vieron en TablePlus (ida y vuelta entre "esto es lo que ya existe" y "así se diagrama").
- Concepto de normalización: por qué separamos autores de libros en vez de repetir el nombre del autor en cada fila de libro (mencionar 1FN/2FN/3FN sin exhaustividad).

## Pregunta abierta 2 (~15 min investigan, ~10 min puesta en común)

**Consigna:** "Investiguen qué es la normalización (1FN, 2FN, 3FN). Con sus propias palabras: ¿por qué separar los datos en varias tablas en vez de tener una sola tabla gigante?"

**Material:**
- Sección de normalización en el Database Design Course de freeCodeCamp
- postgresqltutorial.com

## Ejercicio práctico (~45 min)

**Consigna:** modelar en dbdiagram.io el dominio de su propio proyecto de React (Harry Potter, Star Wars, Pokémon, o el que hayan elegido) — **no importa si terminaron el frontend o no**, solo necesitan tener claro qué entidades manejan.

Mínimo esperado:
- Al menos 2 tablas relacionadas entre sí (ej. personajes y casas/facciones, o naves y planetas).
- Cada tabla con su clave primaria.
- Al menos una clave foránea marcando la relación.

**Cierre:** 2-3 voluntarios comparten su diagrama y explican las decisiones (qué entidades eligieron, por qué esa relación).

## Qué llevarse de esta clase

- Una base de datos relacional es sinónimo de persistencia real, no de memoria volátil.
- Antes de escribir SQL, conviene pensar el modelo: entidades, atributos, relaciones.
- El diagrama de su propio proyecto queda como base para las clases siguientes (Clase 2 en adelante van a crear tablas reales a partir de esto).
