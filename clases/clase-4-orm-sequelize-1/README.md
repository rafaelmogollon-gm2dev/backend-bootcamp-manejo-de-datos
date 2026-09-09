# Clase 4 — Construcción & ORM: Sequelize

**Duración total:** 4hs (bloques cortos, no exposición corrida)

## Objetivo de la clase

Que entiendan qué problema resuelve un ORM (comparado con lo que escribieron a mano en Clase 3) y migren su API a Sequelize, incluyendo relaciones entre modelos.

## Antes de la clase

- Setup de Sequelize: [setup/05-sequelize.md](../../setup/05-sequelize.md)
- Tener su API de Clase 3 (con `pg` puro, sobre su propio dominio o `starter-api`) funcionando como punto de partida — **seguimos sobre el mismo dominio que ya traen, no volvemos a "Biblioteca"**.

## Bloque 1 (~25 min) — Qué problema resuelve un ORM

- Repaso: mostrar de nuevo una query escrita a mano en Clase 3, contar líneas y pasos.
- Qué es el mapeo objeto-relacional: modelos como clases, filas como instancias.
- Ventajas: migraciones versionadas, menos SQL repetitivo, validaciones declarativas.
- Contras/trade-offs a mencionar: una capa de abstracción más, queries complejas a veces más difíciles de expresar que en SQL puro.

## Bloque 2 (~30 min) — Instalación y primer modelo

- Instalar Sequelize en vivo (o repasar si ya lo instalaron antes de clase).
- Generar el modelo correspondiente a **su propio dominio** (el que ya vienen usando desde Clase 3: `starter-api` con `Categoria`/`Item`, o el propio de cada alumno) con `sequelize-cli model:generate`.
  - Ejemplo con `starter-api`: `Categoria` (`nombre`) e `Item` (`nombre`, `descripcion`, `categoriaId`).
- Correr la migración y verificar en TablePlus que las tablas se crearon.
- **Nota:** si tu tabla ya existía de Clase 3 (creada con `CREATE TABLE` a mano), usá `tableName` en el modelo para apuntar a ella en vez de que Sequelize cree una tabla nueva por convención de nombres.

## Pregunta abierta (~15 min investigan, ~10 min puesta en común)

**Consigna:** "Lean la sección 'Model Basics' y 'Associations' de la documentación oficial de Sequelize. ¿Cómo se define una relación `hasMany`/`belongsTo`? Anoten un ejemplo con sus propias entidades."

**Material:**
- [Documentación de Sequelize](https://sequelize.org) — "Model Basics" y "Associations"

## Bloque 3 (~30 min) — Relaciones en Sequelize

- Definir juntos la relación de a uno con el ejemplo de `starter-api`: `Categoria.hasMany(Item, { as: 'items' })` y `Item.belongsTo(Categoria, { as: 'categoria' })`.
- **Importante — mostrar esto en vivo, es una trampa común:** si no ponés `as` explícito, Sequelize intenta pluralizar/singularizar el nombre del modelo automáticamente para armar el alias, y con palabras en español eso puede salir mal (por ejemplo, `Categoria` → alias `Categorium`, que no existe en ningún lado). El síntoma es que el `include` no tira error, pero el dato relacionado aparece como `undefined`/`null` silenciosamente. La regla general: **siempre poné `as` a mano** en `hasMany`/`belongsTo`, y usá ese mismo string en el `include` (`include: 'items'` en vez de `include: Item`).
- Query con `include: 'categoria'` para traer items junto con su categoría (equivalente al JOIN de Clase 2, pero desde el ORM).
- Comparar el código de esta query contra el SQL puro de Clase 2/3 — mismo resultado, menos código.
- Cada alumno adapta esto a su propia relación (si su dominio tiene otra, ej. personajes↔casas), prestando atención al alias si su entidad también está en español.

## Bloque 4 (~15 min) — Buffer de dudas y troubleshooting

- Espacio abierto para resolver errores de conexión, migraciones que no corrieron, o modelos mal generados antes de pasar al ejercicio largo.

## Ejercicio práctico (~1h55)

**Consigna:** migrar su API (la que trabajaron en Clase 3 con `pg` puro) a Sequelize:

1. Generar los modelos correspondientes a sus tablas ya existentes (o crear las migraciones si no las tenían).
2. Definir las relaciones entre sus modelos (`hasMany`/`belongsTo` según su dominio).
3. Reescribir las rutas CRUD para usar los métodos de Sequelize (`findAll`, `create`, `update`, `destroy`) en vez de queries manuales.
4. Agregar al menos una ruta que use `include` para traer datos relacionados.
5. Si termina antes de tiempo: agregar validaciones básicas a nivel de modelo (`allowNull: false`, `validate: { notEmpty: true }`) y probar qué pasa al mandar un dato inválido.

**Cierre:** cada alumno muestra su ruta con `include` funcionando (Postman o curl).

## Qué llevarse de esta clase

- Ven la diferencia directa entre escribir SQL a mano (Clase 3) y usar un ORM para lo mismo.
- Sus modelos ya tienen relaciones definidas, no solo tablas sueltas.
- Quedan preparados para la Clase 5, donde vamos a consolidar con queries más avanzadas y comparar con Prisma.
