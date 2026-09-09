# Clase 5 — Construcción & ORM: Consolidación + Prisma + Cierre de Semana

## Por qué esto importa

Esta es la clase de cierre de la semana de Manejo de Datos. Vas a profundizar en Sequelize con queries más realistas (filtros, orden, paginación) — el tipo de consultas que vas a necesitar en cualquier API que maneje volúmenes de datos más allá de un puñado de filas de prueba. También vas a conocer **Prisma**, otro ORM del ecosistema Node.js, para tener una referencia de comparación: no todos los ORMs se usan igual, y entender las diferencias te va a ayudar a elegir con criterio en proyectos futuros.

## Conceptos clave

### Queries avanzadas en Sequelize

Más allá del CRUD básico que viste en Clase 4, Sequelize permite expresar consultas más ricas:

- **`where` con operadores**: `Op.gt` (mayor que), `Op.like` (coincidencia parcial de texto), `Op.in` (dentro de un conjunto de valores), entre otros.
- **`order` y `limit`/`offset`**: para ordenar resultados y paginarlos — fundamental cuando una tabla tiene miles de filas y no querés traerlas todas de una vez.
- **`include` con condiciones**: podés filtrar no solo la entidad principal, sino también los datos relacionados que trae el `include`.

Este tipo de consultas es exactamente lo que vas a necesitar más adelante en el bootcamp, cuando trabajes con validaciones y paginación de forma más sistemática.

### Prisma: otro enfoque de ORM

Prisma resuelve el mismo problema que Sequelize (mapear objetos a tablas relacionales) con un enfoque distinto:

- El esquema se define de forma **declarativa** en un archivo `schema.prisma`, en vez de escribirse como código imperativo (clases).
- Genera un **cliente con tipado automático**, algo especialmente valioso si trabajás con TypeScript — el compilador te avisa en el momento si estás usando mal un campo del modelo.
- Incluye **Prisma Studio**, una interfaz visual para ver y editar datos sin escribir queries.

En esta clase vas a ver una demo comparativa con una entidad simple, para enfocarte en comparar sintaxis y flujo de trabajo, no en re-migrar todo tu dominio a otro ORM.

## Actividad de indagación

Vas a probar el tutorial interactivo de Prisma (sin instalar nada, es in-browser) y comparar la experiencia con Sequelize: ¿qué te resultó más intuitivo? ¿qué extrañaste? Material de apoyo en [recursos/referencias.md](recursos/referencias.md).

## Ejercicio final: tu API completa, de punta a punta

1. Confirmá que todas las rutas CRUD de tu dominio funcionan contra Postgres vía Sequelize.
2. Agregá al menos una ruta con filtro + paginación (por ejemplo, con `starter-api`: `GET /items?categoriaId=2&limit=5`).
3. Revisá que las queries parametrizadas y las relaciones de las clases anteriores sigan funcionando de punta a punta — un repaso integrador de toda la semana.
4. Preparen una demo corta para mostrarle a un compañero: qué modelaron, qué relaciones tienen, una ruta con `include`.
5. Si te sobra tiempo: probá el mismo modelo simple en Prisma Studio y comparás la experiencia frente a Sequelize.

## Herramientas de esta clase

- Demo de Prisma (instalación y flujo comparativo): [setup/01-prisma-mencion.md](setup/01-prisma-mencion.md).

## Para llevarte de la semana completa

- Pasaste de "pensar en memoria" a "pensar en modelos, relaciones y persistencia real".
- Sabés escribir SQL a mano, usar un driver crudo (`pg`), y usar un ORM (Sequelize) — entendés qué hace cada capa y por qué existe.
- Tu API está lista para que la semana que viene le sumen autenticación, validaciones y testing sobre una base sólida.
