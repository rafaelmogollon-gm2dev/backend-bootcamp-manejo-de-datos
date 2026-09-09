# Clase 5 — Construcción & ORM: Consolidación + Prisma + Cierre de Semana

**Duración total:** 4hs (bloques cortos, no exposición corrida)

## Objetivo de la clase

Consolidar Sequelize con queries más avanzadas (preparando el terreno para validaciones y paginación que van a ver más adelante), mostrar Prisma como alternativa de DX, y cerrar la semana con su API completa (rutas de Semana 1 + persistencia real) funcionando end-to-end.

## Antes de la clase

- Tener su API con Sequelize de Clase 4 funcionando.
- Opcional: curiosear el [Quickstart de Prisma](https://www.prisma.io/docs/getting-started) antes de clase.

## Bloque 1 (~25 min) — Queries avanzadas en Sequelize

- `where` con operadores (`Op.gt`, `Op.like`, `Op.in`).
- `order` y `limit`/`offset` para paginación básica.
- `include` anidado (traer libros de un autor, y de cada libro sus préstamos, por ejemplo).
- Mencionar que esto es exactamente lo que van a necesitar para "API con validaciones y paginación" más adelante en el bootcamp (no lo van a dar ellos desde cero, ya van a tener la base).

## Bloque 2 (~20 min) — Prisma: demo comparativa

- Mostrar en pantalla (no todos instalan en simultáneo) el flujo de Prisma: `schema.prisma` declarativo, `prisma migrate dev`, `prisma studio`.
- Comparar el mismo modelo definido en Sequelize (Clase 4) vs. Prisma: mismo resultado, sintaxis distinta.
- Mencionar tipado automático con TypeScript como ventaja de Prisma (conecta con lo que van a ver en Semana 4).

## Pregunta abierta (~15 min investigan, ~10 min puesta en común)

**Consigna:** "Prueben el tutorial interactivo de Prisma (sin instalar nada, es in-browser). ¿Qué les resultó más intuitivo comparado con Sequelize? ¿Qué extrañaron?"

**Material:**
- [Prisma Quickstart](https://www.prisma.io/docs/getting-started)

## Bloque 3 (~15 min) — Cierre de la semana

- Checklist grupal: ¿qué tiene ahora su API que no tenía en la Semana 1?
  - Persistencia real (no memoria)
  - Relaciones entre entidades
  - Queries con filtros, orden y paginación básica
- Qué van a necesitar la semana que viene (Santi L — Mejores Prácticas y Testing): autenticación, middlewares, validaciones, testing — todo eso se construye **sobre** lo que armaron esta semana.

## Ejercicio final (~1h15)

**Consigna:** su API completa (rutas de la Semana 1 + persistencia de esta semana) corriendo end-to-end:

1. Confirmar que todas las rutas CRUD de su dominio funcionan contra Postgres vía Sequelize.
2. Agregar al menos una ruta con filtro + paginación (ej. `GET /libros?autor=Borges&limit=5`).
3. Preparar una demo corta (3-5 min) para mostrar a un compañero: qué modelaron, qué relaciones tienen, una ruta con `include`.

**Cierre:** demos cruzadas en pares — cada uno le muestra su API a un compañero distinto, no al profesor. Esto los obliga a explicar sus propias decisiones de modelado en voz alta.

## Qué llevarse de la semana completa

- Pasaron de "pensar en memoria" a "pensar en modelos, relaciones y persistencia real".
- Sabés escribir SQL a mano, usar un driver crudo (`pg`), y usar un ORM (Sequelize) — entendés qué hace cada capa y por qué existe.
- Tu API está lista para que la semana que viene le sumen auth, validaciones y testing sobre una base sólida.
