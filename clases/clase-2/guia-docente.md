# Guía docente — Clase 2

**Duración total:** 4hs (bloques cortos, no exposición corrida)

## Antes de la clase

- Tener cargada la mini-DB "Biblioteca" (si no la cargaron en Clase 1): `psql postgres -f ../clase-1/ejercicios/biblioteca/seed.sql`
- Traer el diagrama ER de su propio dominio (hecho en Clase 1 en dbdiagram.io)

## Bloque 1 (~35 min) — Repaso + tipos de datos + sentencias básicas

- Repaso rápido del modelo de "Biblioteca" (autores → libros → préstamos).
- Tipos de datos en Postgres: `VARCHAR` vs `TEXT`, `INTEGER` vs `SERIAL`, `BOOLEAN`, `DATE`/`TIMESTAMP` — necesario antes de que escriban su propio `CREATE TABLE` en el ejercicio de hoy.
- CREATE TABLE: cómo se traduce un diagrama ER a SQL real (mostrar el export de dbdiagram.io y compararlo con `seed.sql`).
- INSERT, SELECT, UPDATE, DELETE — sintaxis básica, con ejemplos en vivo sobre "Biblioteca" (que ya tienen cargada, así que arrancan viendo resultados reales al toque).

## Bloque 2 (~25 min) — Relaciones y JOINs

- Tipos de relaciones: 1 a N (autor → libros) y N a N (mencionar con ejemplo: libros y géneros, si un libro puede tener varios géneros y un género varios libros — no está en el seed, es para ilustrar el concepto).
- INNER JOIN: traer libros con el nombre de su autor.
- LEFT JOIN: traer todos los autores, tengan o no libros cargados (agregar un autor sin libros para probarlo en vivo).
- Diferencia práctica entre INNER y LEFT con el mismo query, mostrando cómo cambia el resultado.

## Pregunta abierta (~15 min investigan, ~10 min puesta en común)

**Consigna:** "Resuelvan los ejercicios de JOIN en SQLBolt (lecciones de INNER JOIN y LEFT JOIN) y tomen nota de al menos un caso donde INNER y LEFT JOIN les hayan dado resultados distintos."

**Material:** ver [recursos/referencias.md](recursos/referencias.md)

## Bloque 3 (~25 min) — Condiciones, orden, límites

- WHERE con distintos operadores (`=`, `>`, `LIKE`, `IN`).
- ORDER BY y LIMIT.
- GROUP BY básico (ej. cantidad de libros por autor) — sin profundizar demasiado, solo que lo conozcan.

## Bloque 4 (~10 min) — Buffer de dudas

- Espacio para resolver errores de sintaxis SQL antes de pasar al ejercicio largo.

## Ejercicio práctico (~2h)

**Consigna:** a partir del diagrama ER que armaron en Clase 1 (su propio dominio: personajes, hechizos, naves, etc.):

1. Escribir el `CREATE TABLE` de sus tablas (pueden usar el export de dbdiagram.io como punto de partida, pero tienen que entender cada línea).
2. Poblar cada tabla con al menos 5 filas de datos de prueba.
3. Escribir:
   - Un SELECT con WHERE y ORDER BY.
   - Un INNER JOIN entre dos de sus tablas relacionadas.
   - Un UPDATE y un DELETE sobre alguna fila de prueba.
4. Si termina antes de tiempo: agregar un LEFT JOIN y comparar el resultado contra el INNER JOIN sobre sus propios datos.

**Cierre:** cada alumno corre su INNER JOIN en vivo y cuenta qué relación modeló.

## Notas de facilitación

- Este es el bloque de más carga de contenido nuevo (tipos de datos + CREATE TABLE + CRUD completo) — no acelerar el Bloque 1 aunque parezca "básico", es la base de todo lo que viene.
- Si algún alumno no trae el diagrama de Clase 1, dale la opción de modelar en el momento con 2 tablas simples — no debería frenar el ejercicio del resto.
- La presentación (`presentacion.pptx`) sigue esta misma estructura de bloques.
