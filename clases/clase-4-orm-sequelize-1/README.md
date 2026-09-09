# Clase 4 — Construcción & ORM: Sequelize

**Duración total:** 4hs (bloques cortos, no exposición corrida)

## Objetivo de la clase

Que entiendan qué problema resuelve un ORM (comparado con lo que escribieron a mano en Clase 3) y migren su API a Sequelize, incluyendo relaciones entre modelos.

## Antes de la clase

- Setup de Sequelize: [setup/05-sequelize.md](../../setup/05-sequelize.md)
- Tener su API de Clase 3 (con `pg` puro) funcionando como punto de partida.

## Bloque 1 (~20 min) — Qué problema resuelve un ORM

- Repaso: mostrar de nuevo una query escrita a mano en Clase 3, contar líneas y pasos.
- Qué es el mapeo objeto-relacional: modelos como clases, filas como instancias.
- Ventajas: migraciones versionadas, menos SQL repetitivo, validaciones declarativas.
- Contras/trade-offs a mencionar: una capa de abstracción más, queries complejas a veces más difíciles de expresar que en SQL puro.

## Bloque 2 (~25 min) — Instalación y primer modelo

- Instalar Sequelize en vivo (o repasar si ya lo instalaron antes de clase).
- Generar el modelo de "Biblioteca" (`Autor`, `Libro`) con `sequelize-cli model:generate`.
- Correr la migración y verificar en TablePlus que las tablas se crearon.

## Pregunta abierta (~15 min investigan, ~10 min puesta en común)

**Consigna:** "Lean la sección 'Model Basics' y 'Associations' de la documentación oficial de Sequelize. ¿Cómo se define una relación `hasMany`/`belongsTo`? Anoten un ejemplo con sus propias entidades."

**Material:**
- [Documentación de Sequelize](https://sequelize.org) — "Model Basics" y "Associations"

## Bloque 3 (~25 min) — Relaciones en Sequelize

- Definir juntos `Autor.hasMany(Libro)` y `Libro.belongsTo(Autor)`.
- Query con `include` para traer libros junto con su autor (equivalente al JOIN de Clase 2, pero desde el ORM).
- Comparar el código de esta query contra el SQL puro de Clase 2/3 — mismo resultado, menos código.

## Ejercicio práctico (~1h)

**Consigna:** migrar su API (la que trabajaron en Clase 3 con `pg` puro) a Sequelize:

1. Generar los modelos correspondientes a sus tablas ya existentes (o crear las migraciones si no las tenían).
2. Definir las relaciones entre sus modelos (`hasMany`/`belongsTo` según su dominio).
3. Reescribir las rutas CRUD para usar los métodos de Sequelize (`findAll`, `create`, `update`, `destroy`) en vez de queries manuales.
4. Agregar al menos una ruta que use `include` para traer datos relacionados.

**Cierre:** cada alumno muestra su ruta con `include` funcionando (Postman o curl).

## Qué llevarse de esta clase

- Ven la diferencia directa entre escribir SQL a mano (Clase 3) y usar un ORM para lo mismo.
- Sus modelos ya tienen relaciones definidas, no solo tablas sueltas.
- Quedan preparados para la Clase 5, donde vamos a consolidar con queries más avanzadas y comparar con Prisma.
