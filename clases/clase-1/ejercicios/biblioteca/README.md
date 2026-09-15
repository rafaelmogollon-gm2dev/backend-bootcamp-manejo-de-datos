# Dominio guiado: biblioteca

Mini base de datos común usada en las Clases 1 y 2. Modela autores, libros y préstamos (con nombres de tablas/columnas en inglés) — suficiente para practicar claves foráneas, relaciones 1 a N y JOINs sin ambigüedad de diseño.

## Modelo (ER)

- **authors** (`id`, `name`, `nationality`)
- **books** (`id`, `title`, `author_id → authors.id`, `year`, `available`)
- **loans** (`id`, `book_id → books.id`, `reader_name`, `loan_date`, `return_date`)

Relaciones: un autor tiene muchos libros (1 a N), un libro tiene muchos préstamos a lo largo del tiempo (1 a N).

## Cómo cargarla

Con Postgres.app corriendo:

```bash
psql postgres -f seed.sql
```

Esto borra (si existían) y vuelve a crear las 3 tablas, con datos de prueba ya cargados.

## Verificar que cargó bien

```bash
psql postgres -c "SELECT title, name FROM books JOIN authors ON books.author_id = authors.id;"
```

Deberías ver 6 filas con título de libro + nombre de autor.

## Uso en clase

- **Clase 1:** explorar la estructura ya cargada con pgAdmin (sin escribir SQL todavía) y compararla contra el diagrama ER en draw.io.
- **Clase 2:** escribir SELECT/INSERT/UPDATE/DELETE y JOINs directamente sobre estos datos ya existentes.
