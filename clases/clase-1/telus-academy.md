# Telus Digital Academy — Clase 1 (Data Handling)

Este archivo NO se sube a Telus — es la fuente de donde copiás el contenido para cargar los 2 resources de esta clase en la plataforma. Cada resource tiene su **Title** y sus **Notes** (Markdown) marcados abajo.

Nota sobre formato: Telus no soporta bloques de código (` ``` `) ni backticks inline — el contenido usa negrita y texto plano en su lugar. Los nombres de tablas y columnas del ejemplo van en inglés (convención estándar de la industria), aunque el resto del texto esté en español.

## Class day

- **Date:** la fecha real en que dictás la Clase 1
- **Teacher:** Rafael Mogollon
- **Detail:** Introducción a Bases de Datos y Modelado

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

## Introducción

Ya conocés una forma de persistir datos del lado del cliente: **localStorage** o **sessionStorage** en el navegador. Sirve para guardar preferencias del usuario o estado de una sesión, pero tiene un límite claro — esos datos viven solo en ese navegador, en esa máquina. No hay forma de que dos usuarios distintos, desde dos dispositivos distintos, vean la misma información compartida.

Ahí es donde entra el servidor. En la Semana 1 construiste una API que guarda datos en memoria — un array de JavaScript que vive mientras el proceso de Node está corriendo. Esto ya resuelve el problema de compartir datos entre usuarios (todos hablan con el mismo servidor), pero introduce uno nuevo: esa memoria es volátil. Apenas reiniciás el servidor, o si el proceso se cae, todos los datos desaparecen. Ninguna aplicación real puede depender de que el servidor nunca se apague.

Una base de datos resuelve exactamente ese problema: es un sistema diseñado para guardar información en disco, de forma persistente e independiente del ciclo de vida del proceso que la usa. El servidor puede reiniciarse, actualizarse, incluso migrar a otra máquina — los datos siguen estando ahí.

Tres niveles de persistencia, entonces:
- **localStorage**/**sessionStorage** en el cliente — solo para ese navegador.
- Memoria en el servidor (lo que ya usaste en la Semana 1) — compartida entre usuarios, pero volátil.
- Base de datos — compartida y persistente.

Esta clase es la puerta de entrada a esa idea, y a algo igual de importante: antes de escribir código, conviene pensar la estructura de los datos.

---

## 1. Antes de empezar: instalar las herramientas

Para poder seguir el resto de este material y hacer los ejercicios, necesitás tener instaladas dos cosas: el motor de base de datos (PostgreSQL) y pgAdmin, el cliente visual para verlo.

### 1.1 PostgreSQL (con Postgres.app)

PostgreSQL es el motor de base de datos relacional que vamos a usar en todo el bootcamp. **No viene instalado por defecto en macOS** — hay que instalarlo. Postgres.app es la forma más simple de tenerlo corriendo en una Mac: es una aplicación normal, sin terminal ni gestores de paquetes.

1. Entrá a postgresapp.com y descargá el instalador.
2. Abrí el archivo **.dmg** descargado y arrastrá el ícono de Postgres.app a la carpeta **Aplicaciones**.
3. Abrí Postgres.app desde **Aplicaciones** (o Spotlight, cmd+espacio y escribí "Postgres").
   - Si Mac bloquea la apertura ("no se puede abrir porque no se pudo verificar el desarrollador"): andá a Preferencias del Sistema → Privacidad y Seguridad, bajá hasta el mensaje sobre Postgres.app y hacé click en "Abrir de todas formas".
4. En la ventana que aparece vas a ver una lista de versiones de PostgreSQL para elegir (14, 15, 16, 17, etc.) — **elegí la 16** y hacé click en "Initialize". Esto crea un servidor Postgres nuevo con esa versión y lo deja corriendo (vas a ver un elefante 🐘 en la barra de menú, arriba a la derecha).
   - Si Postgres.app no te ofrece elegir versión y directamente inicializa una, no hay problema: cualquier versión 15+ funciona igual.

**psql** es la herramienta de línea de comandos para hablarle a Postgres desde la Terminal. **Tampoco viene instalada por defecto** — Postgres.app la instala, pero hay que agregarla al PATH de tu Mac para poder usarla desde cualquier carpeta. No hace falta instalar Homebrew para esto, alcanza con:

1. Abrí la Terminal.
2. Ejecutá este comando (podés copiarlo y pegarlo tal cual):

**sudo mkdir -p /etc/paths.d && echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp**

3. Cerrá la Terminal y abrila de nuevo (esto recarga el PATH).

**Verificar que funcionó:** en una Terminal nueva, ejecutá:

**psql --version**

Debería mostrar algo como "psql (PostgreSQL) 16.x". Después ejecutá:

**psql postgres**

Si ves un prompt como "postgres=#", estás adentro (para salir, escribí el comando **\q** y Enter).

**Datos de conexión por defecto:** host **localhost**, puerto **5432**, usuario tu usuario de Mac (ejecutá el comando **whoami** en la Terminal si no lo recordás), contraseña vacía, base de datos **postgres**.

**Aclaración importante:** al hacer "Initialize", Postgres.app crea automáticamente dos bases de datos distintas — una con el mismo nombre que tu usuario de Mac (por ejemplo, si tu usuario es "rafael", existe una base llamada "rafael"), y otra llamada literalmente **postgres**, que es una base de mantenimiento estándar en cualquier instalación de PostgreSQL. En todo este material vamos a usar específicamente la base **postgres** (no la que lleva tu nombre de usuario), porque así el material funciona igual para cualquier alumno, sin importar cómo se llame su Mac.

**Errores comunes:**
- *"psql: command not found"*: el PATH no se actualizó. Cerrá todas las Terminales y abrí una nueva.
- *Puerto 5432 ocupado*: puede haber otro Postgres corriendo. Podés ver qué proceso es ejecutando en la Terminal el comando **lsof -i :5432**. Si no es Postgres.app, cerralo con el comando **kill** seguido del número de proceso que te mostró.
- *"connection refused"*: el servidor no está corriendo. Abrí Postgres.app y verificá que el elefante de la barra de menú esté activo.
- *"role no existe"*: volvé a hacer click en "Initialize" desde la app, o creá el rol manualmente ejecutando en la Terminal el comando **createuser -s $(whoami)**.

### 1.2 pgAdmin 4 (cliente visual)

pgAdmin permite ver tablas, datos y relaciones sin escribir SQL a mano todo el tiempo. Es 100% gratis y sin límites.

1. Entrá a pgadmin.org/download/pgadmin-4-macos y descargá el instalador. Arrastralo a **Aplicaciones**.
2. Abrilo — la primera vez pide configurar una contraseña maestra (solo para la app, no es la de Postgres).
3. Click derecho en "Servers" → "Register" → "Server...". En General, poné un nombre; en Connection: host **localhost**, port **5432**, maintenance database **postgres**, username tu usuario de Mac, password vacío.
4. Guardar.

**Verificar que funcionó:** deberías ver la base de datos **postgres** con sus esquemas en el árbol de la izquierda.

**Alternativa cloud, si la instalación local falla:** Supabase (supabase.com) ofrece un PostgreSQL real gestionado en la nube, gratis, sin instalar nada. Creá una cuenta, un proyecto nuevo, y en Project Settings → Database vas a encontrar la connection string para usar en pgAdmin o desde psql. Los proyectos free se pausan después de un tiempo sin uso — si eso pasa, entrá al dashboard y click en "Restore project".

---

## 2. Qué es una base de datos relacional

Una base de datos relacional organiza la información en **tablas**. Cada tabla representa un tipo de entidad (por ejemplo, **authors** o **books**), y cada fila de esa tabla es una instancia concreta de esa entidad (un autor específico, un libro específico). Las columnas definen qué atributos tiene cada entidad, y cada columna tiene un tipo de dato asociado (texto, número, fecha, etc.).

Los nombres de tablas y columnas los vamos a escribir en inglés — es la convención más habitual en la industria, incluso en equipos que hablan español.

Lo que hace "relacional" a este modelo es que las tablas se conectan entre sí mediante **relaciones**: un libro pertenece a un autor, un pedido tiene varios productos, etc. Esas conexiones se expresan con claves.

### Clave primaria (Primary Key)

Cada fila de una tabla necesita un identificador único e inequívoco — la clave primaria. Es lo que te permite decir "este libro, y no otro" sin ambigüedad, incluso si dos libros tienen el mismo título. Generalmente es un número autoincremental (columna **id**).

### Clave foránea (Foreign Key) y relaciones

Una clave foránea es una columna que referencia la clave primaria de otra tabla. Por ejemplo, la tabla **books** puede tener una columna **author_id** que apunta al **id** de un autor en la tabla **authors**. Esa es la base de una relación **1 a N**: un autor puede tener muchos libros, pero cada libro tiene un único autor.

Más adelante en el bootcamp vas a ver también relaciones **N a N** (por ejemplo, un libro puede tener varios géneros, y un género puede aplicar a varios libros), que se modelan con una tabla intermedia.

---

## 3. Bases de datos relacionales vs. no relacionales (SQL vs. NoSQL)

No todas las bases de datos organizan la información en tablas. Existen dos grandes categorías:

**Relacionales (SQL):** organizan los datos en tablas con estructura fija (columnas y tipos definidos de antemano) y relaciones explícitas mediante claves. Ejemplos: **PostgreSQL** (la que usamos en este bootcamp), **MySQL**, **SQL Server**, **SQLite**.

**No relacionales (NoSQL):** agrupan varias familias distintas, sin una estructura de tablas fija:
- **Documentos** (ej. **MongoDB**): cada registro es un documento tipo JSON, con estructura flexible.
- **Clave-valor** (ej. **Redis**): pares simples de clave y valor, muy rápidos, usados típicamente para caché.
- **Columnares** (ej. **Cassandra**): pensadas para grandes volúmenes de escritura y lectura distribuida.

Cada categoría tiene sus casos de uso: una base relacional es una buena base por defecto cuando los datos tienen una estructura clara y relaciones entre entidades (como en la mayoría de las aplicaciones de negocio); una no relacional puede convenir cuando la estructura de los datos cambia mucho, o cuando se necesita muchísima velocidad de lectura/escritura simple.

Documentación de referencia:
- Bases de datos SQL vs. NoSQL: ¿Cuál es la diferencia? (IBM): www.ibm.com/think/topics/sql-vs-nosql
- Documentación oficial de MongoDB (conceptos básicos): www.mongodb.com/docs

---

## 4. CRUD: las cuatro operaciones básicas

Cualquier sistema que maneje datos persistentes necesita poder hacer cuatro cosas con ellos — a esto se lo conoce como **CRUD**:

- **Create** (Crear): agregar un dato nuevo. En SQL, la instrucción es **INSERT**.
- **Read** (Leer): consultar datos existentes. En SQL, la instrucción es **SELECT**.
- **Update** (Actualizar): modificar un dato existente. En SQL, la instrucción es **UPDATE**.
- **Delete** (Eliminar): borrar un dato existente. En SQL, la instrucción es **DELETE**.

Es el mismo concepto que ya usaste en la Semana 1 con tu API en memoria (crear, leer, actualizar y borrar recursos) — la diferencia es que ahora, en vez de operar sobre un array de JavaScript, estas cuatro operaciones se ejecutan contra una base de datos real, con sentencias SQL. Vas a escribir cada una de ellas en detalle en la próxima clase; por ahora alcanza con reconocer el concepto y los cuatro verbos.

---

## 5. Tipos de datos y constraints

Cada columna de una tabla tiene un **tipo de dato**, que define qué se puede guardar ahí. Vas a ver estos con más profundidad en la próxima clase, pero como ya aparecen en el script que vamos a cargar en la siguiente sección, conviene reconocerlos ahora:

- **INTEGER**: un número entero.
- **SERIAL**: un número entero que se autoincrementa solo — es el tipo típico de una clave primaria como **id**, para no tener que asignar el número a mano en cada fila nueva.
- **VARCHAR(n)**: texto, con un límite de **n** caracteres (por ejemplo, **VARCHAR(100)** admite hasta 100 caracteres).
- **BOOLEAN**: verdadero o falso.
- **DATE**: una fecha (sin hora).

Además del tipo de dato, una columna puede tener **constraints**: reglas que la base de datos aplica automáticamente para proteger la integridad de los datos, sin que tu código tenga que verificarlas a mano.

- **NOT NULL**: esa columna no puede quedar vacía. Si intentás guardar una fila sin ese dato, la base de datos rechaza la operación.
- **DEFAULT**: si no especificás un valor para esa columna, se usa automáticamente el valor por defecto indicado (por ejemplo, que una fecha se complete sola con la fecha de hoy).
- **UNIQUE**: no puede haber dos filas con el mismo valor en esa columna (por ejemplo, para asegurar que no se repita un email).

Vas a ver estos mismos elementos — **NOT NULL** y **DEFAULT** — en el script SQL de la próxima sección.

---

## 6. Explorar una base de datos ya armada

Para practicar todo lo anterior con datos reales (sin escribir SQL todavía), vamos a usar una mini base de datos ya armada, con el dominio de una biblioteca, con tres tablas: **authors**, **books** y **loans**.

### Paso 1: crear la base de datos

Postgres.app ya crea automáticamente una base de datos llamada **postgres** por defecto (además de otra con el nombre de tu usuario de Mac, que no vamos a usar) — vamos a trabajar sobre esa base **postgres**, no hace falta crear una nueva. Si en algún momento quisieras crear una base de datos separada para otro proyecto, el comando en la Terminal sería **createdb nombre_de_tu_base** (no lo necesitás para este ejercicio, pero es bueno saber que existe).

### Paso 2: crear el archivo con el script SQL

Abrí cualquier editor de texto y creá un archivo llamado **seed.sql**, con este contenido:

DROP TABLE IF EXISTS loans;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;

CREATE TABLE authors (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  nationality VARCHAR(50)
);

CREATE TABLE books (
  id SERIAL PRIMARY KEY,
  title VARCHAR(150) NOT NULL,
  author_id INTEGER REFERENCES authors(id),
  year INTEGER,
  available BOOLEAN DEFAULT true
);

CREATE TABLE loans (
  id SERIAL PRIMARY KEY,
  book_id INTEGER REFERENCES books(id),
  reader_name VARCHAR(100) NOT NULL,
  loan_date DATE DEFAULT CURRENT_DATE,
  return_date DATE
);

INSERT INTO authors (name, nationality) VALUES
  ('Gabriel García Márquez', 'Colombian'),
  ('Jorge Luis Borges', 'Argentine'),
  ('Isabel Allende', 'Chilean'),
  ('J.K. Rowling', 'British');

INSERT INTO books (title, author_id, year, available) VALUES
  ('Cien años de soledad', 1, 1967, true),
  ('El amor en los tiempos del cólera', 1, 1985, true),
  ('Ficciones', 2, 1944, false),
  ('El Aleph', 2, 1949, true),
  ('La casa de los espíritus', 3, 1982, true),
  ('Harry Potter y la piedra filosofal', 4, 1997, false);

INSERT INTO loans (book_id, reader_name, loan_date, return_date) VALUES
  (3, 'Mati', '2026-08-15', NULL),
  (6, 'Joaquín', '2026-08-20', NULL);

No hace falta que entiendas todavía la sintaxis de cada instrucción — con lo que viste en la sección de CRUD alcanza para reconocer que hay **CREATE TABLE** (crea las tablas) e **INSERT** (agrega filas). En la próxima clase vas a escribir instrucciones como estas por tu cuenta.

### Paso 3: cargar el script en Postgres

Con Postgres corriendo (Postgres.app abierto), abrí la Terminal en la carpeta donde guardaste **seed.sql** y ejecutá:

**psql postgres -f seed.sql**

Esto crea las 3 tablas dentro de la base de datos **postgres**, y las llena con los datos de ejemplo.

### Paso 4: explorar los datos con pgAdmin

Abrí pgAdmin (ya conectado a **postgres**, ver sección 1.2) y en el árbol de la izquierda navegá así: tu servidor → **postgres** (la base de datos) → **Schemas** → **public** → **Tables**. Ahí vas a encontrar las tablas **authors**, **books** y **loans**.

Para ver las filas de una tabla: hacé click derecho sobre ella → **View/Edit Data** → **All Rows**. Se abre una grilla con todas las columnas y filas de esa tabla, similar a una planilla de cálculo.

Repitiendo esto para cada tabla, vas a poder ver:

- La clave primaria (columna **id**) de cada tabla.
- La clave foránea (columna **author_id** en **books**, columna **book_id** en **loans**) conectando una tabla con otra.
- Los datos reales cargados por el script.

Explorá por tu cuenta 5-10 minutos: cambiá algún valor directamente en esa grilla, agregá una fila nueva (hay un botón "+" o una fila vacía al final de la grilla para eso), sin escribir SQL, y prestá atención a qué pasa.

---

## 7. Modelado Entidad-Relación (ER)

Antes de crear las tablas de un sistema nuevo, conviene diagramar el modelo de datos: qué entidades existen, qué atributos tiene cada una, y cómo se relacionan entre sí. A esto se lo llama **modelado Entidad-Relación (ER)**.

Por ejemplo, el modelo de biblioteca que acabás de explorar se diagrama así:

TABLE: authors                    TABLE: books
-----------------                 -----------------------
id (PK)          <----------      author_id (FK)
name                               id (PK)
nationality                        title
                                   year
                                   available

La flecha indica que **author_id** en la tabla **books** es una clave foránea que apunta al **id** (clave primaria) de la tabla **authors**. Cada tabla es una entidad, cada flecha marca una relación.

En la próxima clase vas a hacer este mismo ejercicio con tu propio dominio, usando una herramienta de diagramado (los detalles están en la Guía de Ejercicios de esta clase).

---

## 8. Normalización

Si vas a modelar un sistema con autores y libros, una opción ingenua sería tener una sola tabla con el título del libro y el nombre completo del autor repetido en cada fila. El problema: si ese autor cambia de nombre, o hay un error de tipeo, hay que corregirlo en decenas de filas.

La normalización es el proceso de organizar los datos en tablas separadas para que cada dato viva en un único lugar, y las relaciones entre esas tablas se expresen mediante claves. Existen niveles formales de normalización (1FN, 2FN, 3FN) — el modelo de biblioteca que viste ya está normalizado: los datos del autor viven solo en la tabla **authors**, no repetidos en cada libro.

Documentación de referencia:
- Documentación oficial de PostgreSQL: www.postgresql.org/docs
- postgresqltutorial.com
- Normalización en SQL (DataCamp) — modelado, normalización y ER: www.datacamp.com/es/tutorial/normalization-in-sql

---

## 9. Para llevarte de esta clase

- Una base de datos relacional es sinónimo de persistencia real, no de memoria volátil.
- CRUD (Create, Read, Update, Delete) es el conjunto de operaciones básicas sobre cualquier dato persistente.
- Antes de escribir SQL, conviene pensar el modelo: entidades, atributos, relaciones.
- Vas a aplicar todo esto en los ejercicios de esta clase, y en la próxima vas a escribir SQL real para crear tus propias tablas.
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

**Objetivo:** Diseñar en draw.io el modelo de datos (entidades, atributos, relaciones) de tu propio proyecto de React, antes de escribir una sola línea de SQL, y entregarlo mediante un Pull Request.

## Pasos

### 1. Elegir el dominio
- Usá el mismo dominio de tu proyecto de React (personajes, hechizos, naves, planetas, o el que hayas elegido).
- No importa si terminaste el frontend o no — solo necesitás tener claro qué entidades maneja tu dominio.

### 2. Explorar el ejemplo guiado (opcional, antes de arrancar)
- Cargá la mini base de datos de biblioteca (authors → books → loans) — el SQL para crearla está en el MATERIAL de esta clase, sección 6 — y explorala con pgAdmin.
- Identificá dónde está la clave primaria y dónde la clave foránea antes de diseñar la tuya.

### 3. Modelar en draw.io
- Entrá a [app.diagrams.net](https://app.diagrams.net) y creá un diagrama nuevo (guardado en "Device", sin necesidad de cuenta).
- Definí al menos 2 tablas relacionadas entre sí (ej. personajes y casas/facciones, o naves y planetas) — cada tabla como un rectángulo con sus columnas listadas.
- Cada tabla necesita su clave primaria (columna **id**).
- Al menos una clave foránea tiene que marcar la relación entre tus tablas (una flecha entre la columna que referencia y la tabla referenciada).

### 4. Si te sobra tiempo
- Agregá una tercera tabla con una relación N a N (por ejemplo, personajes y hechizos, si un personaje puede tener varios hechizos y un hechizo puede pertenecer a varios personajes).
- Pensá cómo modelarías esa relación con una tabla intermedia (no hace falta implementarla todavía, solo identificarla en el diagrama).

### 5. Exportar y entregar vía GitHub
- Exportá el diagrama como imagen (File → Export as → PNG o SVG).
- Creá un repo en GitHub (o reutilizá el de Backend Introduction si aplica).
- Protegé la rama principal **main** activando estas reglas:
  - Require pull request before merging
  - Require approvals
  - Block force pushes
  - Restrict deletions
- Subí tu imagen exportada en una rama nueva, y abrí un Pull Request hacia la rama **main**.
- Mergeá el PR (con review si corresponde).

## Entregable (enviar por Slack en #canal)
- Link al Pull Request mergeado, con la imagen del diagrama visible en el diff.

## Criterios de evaluación
- Al menos 2 tablas relacionadas entre sí, cada una con su clave primaria.
- Al menos una clave foránea correctamente marcada.
- Un PR mergeado, con la rama principal protegida y la imagen del diagrama visible en el repo.
- El alumno puede explicar verbalmente por qué eligió esas entidades y esa relación (se valida en la puesta en común de la clase, no solo por el diagrama en sí).
```
