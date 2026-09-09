# starter-api

API Express mínima con CRUD en memoria (rutas `/items` y `/categorias`). Es la base garantizada de las clases de Manejo de Datos, por si algún alumno no llega con su API de la Semana 1 funcionando.

Tiene dos entidades relacionadas (una categoría tiene muchos items) para poder practicar no solo CRUD simple, sino también relaciones cuando lleguemos a Sequelize (Clases 4 y 5).

## Cómo usarla

```bash
cd starter-api
npm install
npm run dev
```

Corre en `http://localhost:3000`.

## Rutas

- `GET /categorias` — lista todas las categorías
- `POST /categorias` — crea una categoría (body: `{ "nombre": "..." }`)
- `GET /items` — lista todos los items
- `GET /items/:id` — trae un item por id
- `POST /items` — crea un item (body: `{ "nombre": "...", "descripcion": "...", "categoriaId": 1 }`)
- `PUT /items/:id` — actualiza un item
- `DELETE /items/:id` — elimina un item

## Modelo

- **categorias** (`id`, `nombre`)
- **items** (`id`, `nombre`, `descripcion`, `categoriaId → categorias.id`)

Relación: una categoría tiene muchos items (1 a N) — mismo patrón que autor→libros en la mini-DB Biblioteca de las Clases 1-2.

## Cuándo se usa

- **Clase 3 (por defecto si el grupo no llega con su API de Semana 1):** reemplazamos los arrays en memoria por queries reales a PostgreSQL, ruta por ruta.
- **Clases 4-5:** migramos a Sequelize, definimos `Categoria.hasMany(Item)` / `Item.belongsTo(Categoria)`.
- **Si tenés tu propia API de la Semana 1 funcionando:** usá la tuya en lugar de esta en todas las clases — la consigna es la misma (persistencia real + relaciones), solo cambia el nombre de las entidades. Este starter queda como tu "dominio" por defecto si el tuyo no está listo.
