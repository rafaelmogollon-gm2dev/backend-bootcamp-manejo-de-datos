# Clase 1 — Introducción a Bases de Datos y Modelado

## Por qué esto importa

Hasta ahora, la API que construiste en la Semana 1 guarda todo en un array de JavaScript. Funciona mientras el servidor esté corriendo, pero apenas lo reiniciás — o si el proceso se cae — todos los datos desaparecen. Eso no es un detalle menor: ninguna aplicación real puede depender de que el servidor nunca se apague.

Una base de datos resuelve exactamente ese problema: es un sistema diseñado para guardar información de forma persistente, en disco, independiente del ciclo de vida de tu aplicación. Vas a poder apagar y prender tu API mil veces y los datos van a seguir ahí.

Esta clase es la puerta de entrada a esa idea, y a algo igual de importante: antes de escribir código, conviene pensar la estructura de los datos. Vamos a practicar eso con un ejercicio concreto.

## Conceptos clave

### ¿Qué es una base de datos relacional?

Una base de datos relacional organiza la información en **tablas**. Cada tabla representa un tipo de entidad (por ejemplo, `autores` o `libros`), y cada fila de esa tabla es una instancia concreta de esa entidad (un autor específico, un libro específico). Las columnas definen qué atributos tiene cada entidad, y cada columna tiene un tipo de dato asociado (texto, número, fecha, etc.).

Lo que hace "relacional" a este modelo es que las tablas se conectan entre sí mediante **relaciones**: un libro pertenece a un autor, un pedido tiene varios productos, etc. Esas conexiones se expresan con claves.

### Clave primaria (Primary Key)

Cada fila de una tabla necesita un identificador único e inequívoco — la clave primaria. Es lo que te permite decir "este libro, y no otro" sin ambigüedad, incluso si dos libros tienen el mismo título. Generalmente es un número autoincremental (`id`), aunque no es la única forma posible de definirla.

### Clave foránea (Foreign Key) y relaciones

Una clave foránea es una columna que referencia la clave primaria de otra tabla. Por ejemplo, la tabla `libros` puede tener una columna `autor_id` que apunta al `id` de un autor en la tabla `autores`. Esa es la base de una relación **1 a N**: un autor puede tener muchos libros, pero cada libro tiene un único autor.

Más adelante en el bootcamp vas a ver también relaciones **N a N** (por ejemplo, un libro puede tener varios géneros, y un género puede aplicar a varios libros), que se modelan con una tabla intermedia.

### SQL vs. NoSQL

No todas las bases de datos son relacionales. Las bases de datos NoSQL (como MongoDB) guardan la información como documentos flexibles, sin una estructura de tablas fija ni relaciones explícitas mediante claves. Cada enfoque tiene sus casos de uso — vamos a profundizar esto en la actividad de indagación de esta clase.

### Normalización

Si vas a modelar un sistema con autores y libros, una opción ingenua sería tener una sola tabla con el título del libro y el nombre completo del autor repetido en cada fila. El problema: si ese autor cambia de nombre, o hay un error de tipeo, tenés que corregirlo en decenas de filas.

La normalización es el proceso de organizar los datos en tablas separadas para que cada dato viva en un único lugar, y las relaciones entre esas tablas se expresen mediante claves. Existen niveles formales de normalización (1FN, 2FN, 3FN) que vas a investigar como parte de esta clase.

## Herramientas de esta clase

- **PostgreSQL**, el motor de base de datos relacional que vamos a usar durante todo el bootcamp — instalación en [setup/01-postgres.md](setup/01-postgres.md).
- **TablePlus o pgAdmin**, un cliente visual para explorar tablas y datos sin escribir SQL — instalación en [setup/02-tableplus-pgadmin.md](setup/02-tableplus-pgadmin.md).
- **draw.io (diagrams.net)**, para diagramar entidades y relaciones antes de escribir código, y **GitHub**, para entregar el diagrama vía Pull Request — guía en [setup/03-drawio.md](setup/03-drawio.md).
- Alternativa cloud si la instalación local falla: [setup/00-supabase-alternativa-cloud.md](setup/00-supabase-alternativa-cloud.md).

## Actividades de indagación

Durante la clase vas a investigar dos preguntas en grupo, con la guía de tu docente:

1. **SQL vs. NoSQL**: ¿cuándo elegirías una sobre la otra? ¿Cómo modelarías tu propio proyecto de React en cada enfoque?
2. **Normalización**: ¿por qué separar los datos en varias tablas en vez de tener una sola tabla gigante?

Material de apoyo en [recursos/referencias.md](recursos/referencias.md).

## Ejercicio práctico: modelá tu propio dominio

Usando [ejercicios/biblioteca](ejercicios/biblioteca/) como referencia (una mini base de datos de autores, libros y préstamos ya armada para que explores), vas a modelar en draw.io el dominio de tu propio proyecto de React (personajes, hechizos, naves, o lo que hayas elegido) — no importa si terminaste el frontend o no, solo necesitás tener claro qué entidades manejás.

**Consigna:**
- Al menos 2 tablas relacionadas entre sí.
- Cada tabla con su clave primaria.
- Al menos una clave foránea marcando la relación.
- Si te sobra tiempo: agregá una tercera tabla con una relación N a N (por ejemplo, personajes y hechizos que pueden compartirse entre varios personajes) y pensá cómo modelarías esa relación con una tabla intermedia.
- Exportá el diagrama como imagen y subilo a tu propio repo de GitHub vía Pull Request (mismo flujo que ya usaste en Backend Introduction: rama `main` protegida, PR con review).

Este diagrama, sin export automático a SQL, es la base que vas a usar en la Clase 2 para escribir el `CREATE TABLE` de tus tablas completamente a mano.

## Para llevarte de esta clase

- Una base de datos relacional es sinónimo de persistencia real, no de memoria volátil.
- Antes de escribir SQL, conviene pensar el modelo: entidades, atributos, relaciones.
- El diagrama de tu propio proyecto queda como base para las clases siguientes.
