# Telus Digital Academy — Clase 1 (Data Handling)

Este archivo NO se sube a Telus — es la fuente de donde copiás el contenido para cargar los 2 resources de esta clase en la plataforma. Cada resource tiene su **Title** y sus **Notes** (Markdown) marcados abajo.

## Class day

- **Date:** la fecha real en que dictás la Clase 1
- **Teacher:** Rafael Mogollon
- **Detail:** `Introducción a Bases de Datos y Modelado`

---

## RESOURCE 1

**Title:**
```
MATERIAL 1: Introducción a Bases de Datos y Modelado
```

> Numeración propia del submodule "Data Handling" — arranca en 1, independiente de la numeración de "Backend Introduction".

**Notes (Markdown):**

```markdown
# Introducción a Bases de Datos y Modelado

## Por qué esto importa

Hasta ahora, la API que construiste en la Semana 1 guarda todo en un array de JavaScript. Funciona mientras el servidor esté corriendo, pero apenas lo reiniciás — o si el proceso se cae — todos los datos desaparecen. Eso no es un detalle menor: ninguna aplicación real puede depender de que el servidor nunca se apague.

Una base de datos resuelve exactamente ese problema: es un sistema diseñado para guardar información de forma persistente, en disco, independiente del ciclo de vida de tu aplicación. Vas a poder apagar y prender tu API mil veces y los datos van a seguir ahí.

Esta clase es la puerta de entrada a esa idea, y a algo igual de importante: antes de escribir código, conviene pensar la estructura de los datos.

---

## 1. Repaso + por qué persistencia real (Portada)

- Repaso relámpago: qué construiste en la Semana 1 (API Express con CRUD en memoria).
- El problema: si reiniciás el servidor, ¿qué pasa con los datos?
- Una base de datos relacional resuelve exactamente ese problema.

---

## 2. Qué es una base de datos relacional

Una base de datos relacional organiza la información en **tablas**. Cada tabla representa un tipo de entidad (por ejemplo, `autores` o `libros`), y cada fila de esa tabla es una instancia concreta de esa entidad (un autor específico, un libro específico). Las columnas definen qué atributos tiene cada entidad, y cada columna tiene un tipo de dato asociado (texto, número, fecha, etc.).

Lo que hace "relacional" a este modelo es que las tablas se conectan entre sí mediante **relaciones**: un libro pertenece a un autor, un pedido tiene varios productos, etc. Esas conexiones se expresan con claves.

### Clave primaria (Primary Key)

Cada fila de una tabla necesita un identificador único e inequívoco — la clave primaria. Es lo que te permite decir "este libro, y no otro" sin ambigüedad, incluso si dos libros tienen el mismo título. Generalmente es un número autoincremental (`id`).

### Clave foránea (Foreign Key) y relaciones

Una clave foránea es una columna que referencia la clave primaria de otra tabla. Por ejemplo, la tabla `libros` puede tener una columna `autor_id` que apunta al `id` de un autor en la tabla `autores`. Esa es la base de una relación **1 a N**: un autor puede tener muchos libros, pero cada libro tiene un único autor.

Más adelante en el bootcamp vas a ver también relaciones **N a N** (por ejemplo, un libro puede tener varios géneros, y un género puede aplicar a varios libros), que se modelan con una tabla intermedia.

---

## 3. SQL vs. NoSQL

No todas las bases de datos son relacionales. Las bases de datos NoSQL (como MongoDB) guardan la información como documentos flexibles, sin una estructura de tablas fija ni relaciones explícitas mediante claves. Cada enfoque tiene sus casos de uso.

Video comparativo SQL vs. NoSQL — buscar "SQL vs NoSQL databases" para comparaciones cortas en video
Documentación oficial de MongoDB (conceptos básicos): https://www.mongodb.com/docs/

**Pregunta abierta para investigar en clase:** ¿cuándo elegirías SQL sobre NoSQL, o viceversa? Pensá en tu propio proyecto de React: ¿cómo modelarías tus datos en cada enfoque?

---

## 4. Explorar una base de datos ya armada

Antes de crear tu propia base de datos, vas a explorar una ya cargada ("Biblioteca": autores → libros → préstamos) con un cliente visual (TablePlus o pgAdmin), sin escribir SQL todavía:

- Vas a identificar la clave primaria (`id`) y la clave foránea (`autor_id`) directamente en los datos reales.
- Vas a ver una relación 1 a N funcionando, antes de la teoría formal.
- Vas a explorar por tu cuenta: cambiar valores, agregar una fila desde la interfaz visual, y compartir qué encontraste.

---

## 5. Modelado ER: pensar antes de codear

Antes de escribir una sola línea de SQL, se recomienda diagramar el modelo de datos. Para esto usamos **dbdiagram.io**, una herramienta web con sintaxis simple tipo código que además exporta directo a SQL (`CREATE TABLE`) — lo vamos a usar en la próxima clase.

Documentación / referencia: https://dbdiagram.io
Alternativa manual (sin exportación a SQL): https://draw.io

---

## 6. Normalización

Si vas a modelar un sistema con autores y libros, una opción ingenua sería tener una sola tabla con el título del libro y el nombre completo del autor repetido en cada fila. El problema: si ese autor cambia de nombre, o hay un error de tipeo, hay que corregirlo en decenas de filas.

La normalización es el proceso de organizar los datos en tablas separadas para que cada dato viva en un único lugar, y las relaciones entre esas tablas se expresen mediante claves. Existen niveles formales de normalización (1FN, 2FN, 3FN).

Documentación oficial de PostgreSQL: https://www.postgresql.org/docs/
postgresqltutorial.com: https://www.postgresqltutorial.com
Database Design Course (freeCodeCamp) — modelado, normalización y ER: https://www.youtube.com/watch?v=ztHopE5Wnpc

**Pregunta abierta para investigar en clase:** ¿por qué separar los datos en varias tablas en vez de tener una sola tabla gigante? Investigá 1FN, 2FN y 3FN y explicalo con tus propias palabras.

---

## 7. Herramientas de esta clase

- **PostgreSQL**: el motor de base de datos relacional que vamos a usar durante todo el bootcamp.
- **TablePlus o pgAdmin**: un cliente visual para explorar tablas y datos sin escribir SQL.
- **dbdiagram.io**: para diagramar entidades y relaciones antes de escribir código.
- Alternativa cloud si la instalación local falla: Supabase.

(La guía de instalación paso a paso de cada herramienta, con troubleshooting específico de Mac, está en el repo de la clase.)

---

## 8. Para llevarte de esta clase

- Una base de datos relacional es sinónimo de persistencia real, no de memoria volátil.
- Antes de escribir SQL, conviene pensar el modelo: entidades, atributos, relaciones.
- El diagrama de tu propio proyecto queda como base para la próxima clase, donde vamos a crear las tablas reales con SQL.
```

---

## RESOURCE 2

**Title:**
```
Guía de Ejercicios 1: Modelado de tu propio dominio
```

> Numeración propia del submodule "Data Handling" — arranca en 1.

**Notes (Markdown):**

```markdown
# Ejercicio: Modelado ER de tu propio dominio

**Objetivo:** Diseñar en dbdiagram.io el modelo de datos (entidades, atributos, relaciones) de tu propio proyecto de React, antes de escribir una sola línea de SQL.

## Pasos

### 1. Elegir el dominio
- Usá el mismo dominio de tu proyecto de React (personajes, hechizos, naves, planetas, o el que hayas elegido).
- No importa si terminaste el frontend o no — solo necesitás tener claro qué entidades maneja tu dominio.

### 2. Explorar el ejemplo guiado (opcional, antes de arrancar)
- Cargá la mini base de datos "Biblioteca" (autores → libros → préstamos) y explorala con TablePlus/pgAdmin.
- Identificá dónde está la clave primaria y dónde la clave foránea antes de diseñar la tuya.

### 3. Modelar en dbdiagram.io
- Entrá a [dbdiagram.io](https://dbdiagram.io) y creá un diagrama nuevo.
- Definí al menos 2 tablas relacionadas entre sí (ej. personajes y casas/facciones, o naves y planetas).
- Cada tabla necesita su clave primaria (`id`).
- Al menos una clave foránea tiene que marcar la relación entre tus tablas.

### 4. Si te sobra tiempo
- Agregá una tercera tabla con una relación N a N (por ejemplo, personajes y hechizos, si un personaje puede tener varios hechizos y un hechizo puede pertenecer a varios personajes).
- Pensá cómo modelarías esa relación con una tabla intermedia (no hace falta implementarla todavía, solo identificarla en el diagrama).

## Entregable (enviar por Slack en #canal)
- Link público al diagrama de dbdiagram.io.

## Criterios de evaluación
- Al menos 2 tablas relacionadas entre sí, cada una con su clave primaria.
- Al menos una clave foránea correctamente marcada.
- El alumno puede explicar verbalmente por qué eligió esas entidades y esa relación (se valida en la puesta en común de la clase, no solo por el diagrama en sí).
```
