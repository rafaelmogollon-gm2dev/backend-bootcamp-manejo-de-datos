# Introducción a Bases de Datos y Modelado

## Por qué esto importa

Ya conocés una forma de persistir datos del lado del cliente: `localStorage` o `sessionStorage` en el navegador. Sirve para guardar preferencias del usuario o estado de una sesión, pero tiene un límite claro — esos datos viven solo en ese navegador, en esa máquina. No hay forma de que dos usuarios distintos, desde dos dispositivos distintos, vean la misma información compartida.

Ahí es donde entra el servidor. En la Semana 1 construiste una API que guarda datos en memoria — un array de JavaScript que vive mientras el proceso de Node está corriendo. Esto ya resuelve el problema de compartir datos entre usuarios (todos hablan con el mismo servidor), pero introduce uno nuevo: esa memoria es volátil. Apenas reiniciás el servidor, o si el proceso se cae, todos los datos desaparecen. Ninguna aplicación real puede depender de que el servidor nunca se apague.

Una base de datos resuelve exactamente ese problema: es un sistema diseñado para guardar información en disco, de forma persistente e independiente del ciclo de vida del proceso que la usa. El servidor puede reiniciarse, actualizarse, incluso migrar a otra máquina — los datos siguen estando ahí.

Esta clase es la puerta de entrada a esa idea, y a algo igual de importante: antes de escribir código, conviene pensar la estructura de los datos.

---

## 1. Repaso + por qué persistencia real (Portada)

- Tres niveles de persistencia que ya conocés o estás por conocer: `localStorage`/`sessionStorage` en el cliente, memoria en el servidor (Semana 1), y ahora base de datos.
- El problema concreto de la memoria en el servidor: si reiniciás el servidor, ¿qué pasa con los datos?
- Una base de datos relacional resuelve exactamente ese problema, agregando además la capacidad de modelar relaciones entre distintos tipos de datos.

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

Bases de datos SQL vs. NoSQL: ¿Cuál es la diferencia? (IBM): https://www.ibm.com/think/topics/sql-vs-nosql
Documentación oficial de MongoDB (conceptos básicos): https://www.mongodb.com/docs/

Con estas dos referencias como punto de partida, buscá material adicional si te sirve — es una buena oportunidad para practicar cómo evaluar la calidad de una fuente técnica en inglés o español.

**Pregunta abierta para investigar en clase:** ¿cuándo elegirías SQL sobre NoSQL, o viceversa? Pensá en tu propio proyecto de React: ¿cómo modelarías tus datos en cada enfoque?

---

## 4. Explorar una base de datos ya armada

Antes de crear tu propia base de datos, vas a explorar una ya armada ("Biblioteca": autores → libros → préstamos) con un cliente visual (TablePlus o pgAdmin), sin escribir SQL todavía.

El bloque de código de abajo es el SQL que "instala" esos datos de ejemplo — no hace falta que entiendas la sintaxis todavía, solo copialo tal cual está y ejecutalo. En la próxima clase vamos a ver en detalle qué es cada instrucción (`CREATE TABLE`, `INSERT`) y vas a escribir las tuyas propias.

Para tenerla en tu propia máquina, con Postgres corriendo (ver sección 7.1), abrí la Terminal, pegá el siguiente contenido en un archivo llamado `seed.sql` (podés crearlo con cualquier editor de texto), y corré:

```bash
psql postgres -f seed.sql
```

Contenido de `seed.sql`:

```sql
DROP TABLE IF EXISTS prestamos;
DROP TABLE IF EXISTS libros;
DROP TABLE IF EXISTS autores;

CREATE TABLE autores (
  id SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  nacionalidad VARCHAR(50)
);

CREATE TABLE libros (
  id SERIAL PRIMARY KEY,
  titulo VARCHAR(150) NOT NULL,
  autor_id INTEGER REFERENCES autores(id),
  anio INTEGER,
  disponible BOOLEAN DEFAULT true
);

CREATE TABLE prestamos (
  id SERIAL PRIMARY KEY,
  libro_id INTEGER REFERENCES libros(id),
  nombre_lector VARCHAR(100) NOT NULL,
  fecha_prestamo DATE DEFAULT CURRENT_DATE,
  fecha_devolucion DATE
);

INSERT INTO autores (nombre, nacionalidad) VALUES
  ('Gabriel García Márquez', 'Colombiana'),
  ('Jorge Luis Borges', 'Argentina'),
  ('Isabel Allende', 'Chilena'),
  ('J.K. Rowling', 'Británica');

INSERT INTO libros (titulo, autor_id, anio, disponible) VALUES
  ('Cien años de soledad', 1, 1967, true),
  ('El amor en los tiempos del cólera', 1, 1985, true),
  ('Ficciones', 2, 1944, false),
  ('El Aleph', 2, 1949, true),
  ('La casa de los espíritus', 3, 1982, true),
  ('Harry Potter y la piedra filosofal', 4, 1997, false);

INSERT INTO prestamos (libro_id, nombre_lector, fecha_prestamo, fecha_devolucion) VALUES
  (3, 'Mati', '2026-08-15', NULL),
  (6, 'Joaquín', '2026-08-20', NULL);
```

Con las 3 tablas ya cargadas, abrí TablePlus/pgAdmin y navegá:

- Vas a identificar la clave primaria (`id`) y la clave foránea (`autor_id`) directamente en los datos reales.
- Vas a ver una relación 1 a N funcionando, antes de la teoría formal.
- Explorá por tu cuenta: cambiá valores, agregá una fila desde la interfaz visual, y anotá qué encontraste.

---

## 5. Modelado ER: pensar antes de codear

Antes de escribir una sola línea de SQL, se recomienda diagramar el modelo de datos. Para esto usamos **draw.io (diagrams.net)**, una herramienta web donde dibujás cada tabla como una caja y conectás las relaciones con flechas.

A diferencia de otras herramientas de modelado, draw.io no exporta el diagrama a SQL automáticamente — eso es intencional: en la próxima clase vas a escribir el `CREATE TABLE` de tus tablas completamente a mano, usando tu diagrama como guía.

Documentación / acceso: https://app.diagrams.net

---

## 6. Normalización

Si vas a modelar un sistema con autores y libros, una opción ingenua sería tener una sola tabla con el título del libro y el nombre completo del autor repetido en cada fila. El problema: si ese autor cambia de nombre, o hay un error de tipeo, hay que corregirlo en decenas de filas.

La normalización es el proceso de organizar los datos en tablas separadas para que cada dato viva en un único lugar, y las relaciones entre esas tablas se expresen mediante claves. Existen niveles formales de normalización (1FN, 2FN, 3FN).

Documentación oficial de PostgreSQL: https://www.postgresql.org/docs/
postgresqltutorial.com: https://www.postgresqltutorial.com
Database Design Course (freeCodeCamp) — modelado, normalización y ER: https://www.youtube.com/watch?v=ztHopE5Wnpc

**Pregunta abierta para investigar en clase:** ¿por qué separar los datos en varias tablas en vez de tener una sola tabla gigante? Investigá 1FN, 2FN y 3FN y explicalo con tus propias palabras.

---

## 7. Herramientas de esta clase — instalación paso a paso

### 7.1 PostgreSQL (con Postgres.app)

PostgreSQL es el motor de base de datos relacional que vamos a usar en todo el bootcamp. Postgres.app es la forma más simple de tenerlo corriendo en una Mac: es una aplicación normal, sin terminal ni gestores de paquetes.

1. Entrá a https://postgresapp.com y descargá el instalador.
2. Abrí el `.dmg` descargado y arrastrá el ícono de Postgres.app a la carpeta `Aplicaciones`.
3. Abrí Postgres.app desde `Aplicaciones` (o Spotlight, `cmd+espacio` y escribí "Postgres").
   - Si Mac bloquea la apertura ("no se puede abrir porque no se pudo verificar el desarrollador"): andá a `Preferencias del Sistema → Privacidad y Seguridad`, bajá hasta el mensaje sobre Postgres.app y hacé click en "Abrir de todas formas".
4. En la ventana que aparece vas a ver una lista de versiones de PostgreSQL para elegir (14, 15, 16, 17, etc.) — **elegí la 16** y hacé click en "Initialize". Esto crea un servidor Postgres nuevo con esa versión y lo deja corriendo (vas a ver un elefante 🐘 en la barra de menú, arriba a la derecha).
   - Si Postgres.app no te ofrece elegir versión y directamente inicializa una, no hay problema: cualquier versión 15+ funciona igual.
5. Sumá las herramientas de línea de comandos (`psql`, `createdb`, etc.) a tu PATH:
   - Abrí la Terminal y ejecutá:
     ```bash
     sudo mkdir -p /etc/paths.d && echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp
     ```
   - Cerrá la Terminal y abrila de nuevo (esto recarga el PATH).

**Verificar que funcionó:** en una Terminal nueva, ejecutá `psql --version` (debería mostrar `psql (PostgreSQL) 16.x`), y después `psql postgres`. Si ves un prompt como `postgres=#`, estás adentro (para salir, escribí `\q` y Enter).

**Datos de conexión por defecto:** host `localhost`, puerto `5432`, usuario tu usuario de Mac (`whoami` en la Terminal si no lo recordás), contraseña vacía, base de datos `postgres`.

**Errores comunes:**
- *"psql: command not found"*: el PATH no se actualizó. Cerrá todas las Terminales y abrí una nueva.
- *Puerto 5432 ocupado*: puede haber otro Postgres corriendo. Con `lsof -i :5432` ves qué proceso es; si no es Postgres.app, matalo con `kill <PID>`.
- *"connection refused"*: el servidor no está corriendo. Abrí Postgres.app y verificá que el elefante de la barra de menú esté activo.
- *"role no existe"*: volvé a hacer click en "Initialize" desde la app, o creá el rol manualmente con `createuser -s $(whoami)`.

### 7.2 Cliente visual: TablePlus o pgAdmin

Un cliente visual permite ver tablas, datos y relaciones sin escribir SQL a mano todo el tiempo. Elegí **una** de las dos opciones.

**Opción A — TablePlus (recomendado, más liviano):**
1. Entrá a https://tableplus.com y descargá la versión para Mac. Abrí el `.dmg` y arrastrá TablePlus a `Aplicaciones`.
2. Abrilo, y al abrir por primera vez, click en "Create a new connection" → elegí **PostgreSQL**.
3. Completá: Host `localhost`, Port `5432`, User tu usuario de Mac, Password vacío, Database `postgres`.
4. Click en "Test" (debería aparecer un tilde verde) y luego "Connect".
   - Si la app no abre por Gatekeeper: `xattr -cr /Applications/TablePlus.app` en la Terminal.

**Opción B — pgAdmin 4 (100% gratis, sin límites):**
1. Entrá a https://www.pgadmin.org/download/pgadmin-4-macos/ y descargá el instalador. Arrastralo a `Aplicaciones`.
2. Abrilo — la primera vez pide configurar una contraseña maestra (solo para la app, no es la de Postgres).
3. Click derecho en "Servers" → "Register" → "Server...". En General, poné un nombre; en Connection: host `localhost`, port `5432`, maintenance database `postgres`, username tu usuario de Mac, password vacío.
4. Guardar.

**Verificar que funcionó:** deberías ver la base de datos `postgres` con sus esquemas en el árbol de la izquierda.

### 7.3 draw.io / diagrams.net (modelado ER) + entrega vía GitHub

Herramienta 100% web para diagramar entidades y relaciones dibujando cajas y conectándolas con flechas.

1. Entrá a https://app.diagrams.net.
2. Elegí "Device" para guardar el diagrama localmente en tu navegador/descarga (no hace falta cuenta).
3. Dibujá una tabla por entidad de tu dominio: un rectángulo con el nombre de la tabla arriba y sus columnas listadas debajo (doble click sobre una forma para editar su texto).
4. Conectá las tablas relacionadas con una flecha, desde la columna que referencia (clave foránea) hacia la tabla referenciada.
5. Repetí para todas tus tablas y relaciones.

**Exportar la imagen:** una vez terminado, andá a File → Export as → PNG (o SVG). Guardá el archivo, por ejemplo, como `diagrama-er.png`.

**Entregar vía GitHub (mismo flujo que Backend Introduction):**
1. Creá un repo nuevo en GitHub (ej. `ejercicio-modelado-tu-nombre`), inicializado con un `README.md`.
2. Verificá que la rama por defecto sea `main` (Settings → General → Default branch).
3. Protegé `main` (Settings → Branches → Add branch ruleset): Require a pull request before merging, Require approvals (mínimo 1), Block force pushes, Restrict deletions.
4. Cloná el repo, creá una rama (ej. `feature/diagrama-er`), agregá tu imagen exportada.
5. Commit, push, y abrí un Pull Request hacia `main`.
6. Mergeá el PR (con review si corresponde).

**Verificar que funcionó:** el PR mergeado muestra la imagen del diagrama visible directo en el diff de GitHub.

Alternativa con sintaxis tipo código, que sí exporta directo a SQL (no la usamos en esta clase a propósito, para que en la próxima escribas el CREATE TABLE a mano): https://dbdiagram.io

### 7.4 Alternativa cloud si la instalación local falla: Supabase

Si Postgres.app da problemas (permisos, puertos ocupados), Supabase ofrece un PostgreSQL real gestionado en la nube, gratis, sin instalar nada.

1. Entrá a https://supabase.com → "Start your project" → creá una cuenta (podés usar GitHub).
2. Click en "New project". Completá: nombre del proyecto, una contraseña fuerte para la base (guardala), región más cercana, plan Free.
3. Click en "Create new project" (tarda 1-2 minutos).
4. Andá a Project Settings → Database y copiá la Connection string ("URI").

**Verificar que funcionó:** `psql "postgresql://postgres:TU-PASSWORD@db.xxxxxxxxxxxx.supabase.co:5432/postgres"` desde la Terminal, o pegá esos datos en TablePlus/pgAdmin como conexión nueva.

**Nota:** Supabase pausa proyectos free inactivos después de un tiempo — si dice que el proyecto se "pausó", entrá al dashboard y click en "Restore project".

---

## 8. Para llevarte de esta clase

- Una base de datos relacional es sinónimo de persistencia real, no de memoria volátil.
- Antes de escribir SQL, conviene pensar el modelo: entidades, atributos, relaciones.
- El diagrama de tu propio proyecto queda como base para la próxima clase, donde vamos a crear las tablas reales con SQL.
