# starter-api

API Express mínima con CRUD en memoria (rutas `/items`). Es la base garantizada de las clases de Manejo de Datos, por si algún alumno no llega con su API de la Semana 1 funcionando.

## Cómo usarla

```bash
cd starter-api
npm install
npm run dev
```

Corre en `http://localhost:3000`.

## Rutas

- `GET /items` — lista todos los items
- `GET /items/:id` — trae un item por id
- `POST /items` — crea un item (body: `{ "nombre": "...", "descripcion": "..." }`)
- `PUT /items/:id` — actualiza un item
- `DELETE /items/:id` — elimina un item

## Cuándo se usa

- **Escenario por defecto en Clase 3:** reemplazamos el array `items` en memoria por queries reales a PostgreSQL, ruta por ruta.
- **Si tenés tu propia API de la Semana 1 funcionando:** usá la tuya en lugar de esta — la consigna es la misma (reemplazar memoria por base de datos real), solo cambia el nombre de las entidades.
