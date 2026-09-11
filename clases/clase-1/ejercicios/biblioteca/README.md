# Dominio guiado: Biblioteca

Mini base de datos común usada en las Clases 1 y 2. Modela autores, libros y préstamos — suficiente para practicar claves foráneas, relaciones 1 a N y JOINs sin ambigüedad de diseño.

## Modelo (ER)

- **autores** (`id`, `nombre`, `nacionalidad`)
- **libros** (`id`, `titulo`, `autor_id → autores.id`, `anio`, `disponible`)
- **prestamos** (`id`, `libro_id → libros.id`, `nombre_lector`, `fecha_prestamo`, `fecha_devolucion`)

Relaciones: un autor tiene muchos libros (1 a N), un libro tiene muchos préstamos a lo largo del tiempo (1 a N).

## Cómo cargarla

Con Postgres.app corriendo:

```bash
psql postgres -f seed.sql
```

Esto borra (si existían) y vuelve a crear las 3 tablas, con datos de prueba ya cargados.

## Verificar que cargó bien

```bash
psql postgres -c "SELECT titulo, nombre FROM libros JOIN autores ON libros.autor_id = autores.id;"
```

Deberías ver 6 filas con título de libro + nombre de autor.

## Uso en clase

- **Clase 1:** explorar la estructura ya cargada con TablePlus/pgAdmin (sin escribir SQL todavía) y compararla contra el diagrama ER en draw.io.
- **Clase 2:** escribir SELECT/INSERT/UPDATE/DELETE y JOINs directamente sobre estos datos ya existentes.
