# Clase 2 — SQL y Relaciones

## Por qué esto importa

En la Clase 1 diseñaste el modelo de tu dominio en un diagrama, sin escribir código. Ahora ese diagrama se convierte en realidad: vas a crear las tablas de verdad en PostgreSQL y a manipular datos con SQL, el lenguaje que usa (con variantes) prácticamente cualquier base de datos relacional del mercado.

SQL no es solo "la forma de hablarle a la base de datos" — es también la herramienta que te va a permitir razonar sobre relaciones entre datos de un modo que ningún array en memoria puede igualar. Un JOIN bien escrito reemplaza decenas de líneas de lógica manual para cruzar información.

## Conceptos clave

### Tipos de datos en PostgreSQL

Cada columna de una tabla tiene un tipo de dato que restringe qué se puede guardar ahí. Los más comunes que vas a usar:

- `VARCHAR(n)` vs. `TEXT`: ambos guardan texto, pero `VARCHAR` impone un límite de caracteres y `TEXT` no.
- `INTEGER` vs. `SERIAL`: `INTEGER` es un número entero cualquiera; `SERIAL` es un entero que se autoincrementa automáticamente — ideal para claves primarias.
- `BOOLEAN`: verdadero o falso.
- `DATE` / `TIMESTAMP`: fechas, con o sin hora.

Elegir el tipo correcto no es un detalle cosmético: define qué operaciones podés hacer sobre esa columna (no podés comparar fechas si las guardaste como texto) y cuánto espacio ocupa cada fila.

### De diagrama a SQL: `CREATE TABLE`

El `CREATE TABLE` es la sentencia que traduce tu diagrama ER en una tabla real. Como en Clase 1 diagramaste con draw.io (que no genera SQL automáticamente), acá vas a escribir cada `CREATE TABLE` desde cero: cada tabla que dibujaste se convierte en columnas con su nombre y tipo de dato, y cada clave foránea que marcaste con una flecha se declara con `REFERENCES` apuntando a la tabla que referencia.

### Las cuatro operaciones básicas (CRUD)

- `INSERT`: agrega una fila nueva.
- `SELECT`: consulta datos existentes, con filtros (`WHERE`), orden (`ORDER BY`) y límites (`LIMIT`).
- `UPDATE`: modifica una o más filas existentes.
- `DELETE`: elimina una o más filas.

Estas cuatro operaciones son la base de cualquier sistema que maneje datos persistentes — es literalmente lo que hace tu API cuando alguien crea, lee, actualiza o borra un recurso.

### JOINs: cruzar información entre tablas

Cuando separaste tus datos en varias tablas (normalización, Clase 1), perdiste la posibilidad de ver todo junto en una sola consulta simple. Los JOINs recuperan esa capacidad:

- **INNER JOIN**: devuelve solo las filas que tienen coincidencia en ambas tablas. Si un autor no tiene libros cargados, no aparece en el resultado.
- **LEFT JOIN**: devuelve todas las filas de la tabla izquierda, tengan o no coincidencia en la derecha. Un autor sin libros sí aparece, con valores nulos en las columnas del libro.

Elegir entre uno y otro depende de la pregunta que quieras responder: "¿qué libros tiene cada autor?" (INNER) vs. "¿qué autores tengo, y cuáles no tienen libros todavía?" (LEFT).

### Relaciones 1 a N y N a N

Ya viste en Clase 1 que un autor puede tener muchos libros (1 a N). Existe también la relación N a N: un libro puede pertenecer a varios géneros, y un género puede aplicar a varios libros. Este tipo de relación se modela con una **tabla intermedia** que solo contiene las claves foráneas de ambas tablas relacionadas.

## Actividad de indagación

Vas a resolver ejercicios interactivos de JOIN en SQLBolt y tomar nota de al menos un caso donde INNER y LEFT JOIN te hayan dado resultados distintos. Material de apoyo en [recursos/referencias.md](recursos/referencias.md).

## Ejercicio práctico: creá y consultá las tablas de tu propio dominio

A partir del diagrama ER que armaste en Clase 1:

1. Escribí el `CREATE TABLE` de tus tablas a partir de tu diagrama de draw.io — no hay export automático, así que esta vez lo escribís completamente vos.
2. Poblá cada tabla con al menos 5 filas de datos de prueba.
3. Escribí un `SELECT` con `WHERE` y `ORDER BY`, un `INNER JOIN` entre dos de tus tablas relacionadas, y un `UPDATE` y un `DELETE` sobre alguna fila de prueba.
4. Si te sobra tiempo: agregá un `LEFT JOIN` y compará el resultado contra el `INNER JOIN` sobre tus propios datos.

Podés usar [ejercicios/biblioteca](../clase-1/ejercicios/biblioteca/) (de Clase 1) como referencia mientras escribís tus propias queries.

## Para llevarte de esta clase

- Ya sabés escribir SQL real para las 4 operaciones básicas (CRUD).
- Entendés la diferencia entre INNER y LEFT JOIN con un caso concreto, no solo la definición.
- Tu propio dominio ya existe como tablas reales en Postgres — base para la Clase 3, donde vamos a conectar esto desde Node.
