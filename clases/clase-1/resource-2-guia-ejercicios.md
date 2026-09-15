# Guía de Ejercicios — Clase 1: Introducción a Bases de Datos y Modelado

Esta guía tiene 3 bloques. Podés resolverlos en el orden que quieras, pero te recomendamos seguir el mismo orden del MATERIAL (primero las preguntas de SQL vs. NoSQL, después Normalización, y por último el modelado de tu propio dominio).

Todos los entregables van al mismo repo de GitHub: podés subirlos en un solo Pull Request al final, o en varios PRs a medida que termines cada bloque — como te resulte más cómodo.

---

## Bloque 1: SQL vs. NoSQL

### Ejercicio 1: Comparar bases de datos relacionales y no relacionales

**Objetivo:** Investigar y explicar con tus propias palabras qué diferencia a una base de datos SQL de una NoSQL, y en qué casos elegirías cada una.

**Requerimientos:**
- Leé el material de la sección 3 del MATERIAL de esta clase, y las referencias que ahí se mencionan (documentación de IBM y de MongoDB).
- Creá un archivo llamado **respuestas-sql-nosql.md** en tu repo, y respondé ahí las preguntas de abajo.

**Preguntas:**
1. ¿Cuál es la diferencia principal entre una base de datos relacional (SQL) y una no relacional (NoSQL)?
2. Nombrá al menos dos motores de base de datos relacionales, y dos no relacionales (de categorías distintas: documentos, clave-valor, o columnar).
3. Tomemos el ejemplo de biblioteca (authors, books, loans) que ya usaste en el MATERIAL. En una base relacional, esos datos viven en 3 tablas separadas, conectadas por claves foráneas. Si tuvieras que modelar ese mismo ejemplo como base de datos de documentos (tipo MongoDB), una opción posible sería tener un solo documento por libro, con los datos del autor "adentro" del documento (en vez de en otra tabla aparte). Con esa idea como referencia: elegí 2 o 3 entidades de tu propio proyecto (por ejemplo, personajes y su casa/facción) y describí brevemente cómo se verían como documentos, en vez de como tablas separadas.
4. ¿En qué situación elegirías una base no relacional en vez de una relacional? Dame un ejemplo concreto (no tiene que ser de tu proyecto).

---

## Bloque 2: Normalización

### Ejercicio 2: Por qué separamos los datos en varias tablas

**Objetivo:** Entender el problema que resuelve la normalización, y poder explicarlo con un ejemplo propio.

**Requerimientos:**
- Leé el material de la sección 8 del MATERIAL de esta clase, y las referencias que ahí se mencionan.
- Creá un archivo llamado **respuestas-normalizacion.md** en tu repo, y respondé ahí las preguntas de abajo.

**Preguntas:**
1. ¿Qué problema concreto tiene una tabla única que repite datos de un mismo autor en cada fila de libro (en vez de separar autores y libros en dos tablas)?
2. ¿Qué es la normalización, con tus propias palabras?
3. La normalización tiene niveles formales llamados 1FN, 2FN y 3FN, cada uno más estricto que el anterior. Investigá qué es la 1FN (Primera Forma Normal). Explicá con tus propias palabras qué regla exige.
4. **Entidad** es el nombre que le damos a cada "cosa" distinta que modelamos como su propia tabla (por ejemplo, en el ejemplo de biblioteca, "autor" es una entidad y "libro" es otra entidad). Pensá en el dominio de tu propio proyecto de React: nombrá 2 entidades distintas que tenga tu dominio, y para cada una, un dato que le pertenece SOLO a esa entidad (por ejemplo: la nacionalidad le pertenece al autor, no al libro).

---

## Bloque 3: Modelado Entidad-Relación (ER) de tu propio dominio

### Ejercicio 3: Diseñar el modelo de datos de tu proyecto

**Objetivo:** Diseñar en draw.io el modelo de datos (entidades, atributos, relaciones) de tu propio proyecto de React, antes de escribir una sola línea de SQL, y entregarlo mediante un Pull Request.

**Requerimientos:**
- Tener draw.io accesible (app.diagrams.net, no hace falta cuenta).
- Tener un repo de GitHub con la rama principal protegida (mismo flujo que Backend Introduction — podés reutilizar ese repo, o crear uno nuevo con la misma configuración de rama protegida).

**Pasos:**

1. **Elegir el dominio.** Usá el mismo dominio de tu proyecto de React (personajes, hechizos, naves, planetas, o el que hayas elegido). Podés pensar en el proyecto que trabajaste en los módulos anteriores como el proyecto de React — solo necesitás tener claro qué entidades maneja ese dominio.

2. **Explorar el ejemplo guiado (opcional, antes de arrancar).** Si todavía no lo hiciste, cargá la mini base de datos de biblioteca (authors → books → loans) — el SQL para crearla está en el MATERIAL de esta clase, sección 6 — y explorala con pgAdmin. Identificá dónde está la clave primaria y dónde la clave foránea antes de diseñar la tuya.

3. **Modelar en draw.io.** Entrá a app.diagrams.net y creá un diagrama nuevo (guardado en "Device", sin necesidad de cuenta). Definí al menos 2 tablas relacionadas entre sí (ej. personajes y casas/facciones, o naves y planetas) — cada tabla como un rectángulo con sus columnas listadas. Cada tabla necesita su clave primaria (columna **id**). Al menos una clave foránea tiene que marcar la relación entre tus tablas (una flecha entre la columna que referencia y la tabla referenciada).

4. **Si te sobra tiempo.** Agregá una tercera tabla con una relación N a N (por ejemplo, personajes y hechizos, si un personaje puede tener varios hechizos y un hechizo puede pertenecer a varios personajes). Pensá cómo modelarías esa relación con una tabla intermedia (no hace falta implementarla todavía, solo identificarla en el diagrama).

5. **Exportar y entregar vía GitHub.** Exportá el diagrama como imagen (File → Export as → PNG o SVG), llamalo **diagrama-er.png** (o .svg). Subilo a tu repo (junto con los archivos de respuestas de los Bloques 1 y 2, si querés juntarlo todo en un mismo PR) y abrí un Pull Request hacia la rama principal. Mergeá el PR (con review si corresponde).

**Entregable (enviar por Slack en #canal):**
- Link al Pull Request (o Pull Requests) mergeado, con los 3 archivos visibles: **respuestas-sql-nosql.md**, **respuestas-normalizacion.md**, y **diagrama-er.png** (o .svg).

**Criterios de evaluación:**
- Bloque 1 y 2: las respuestas muestran que investigaste y entendiste los conceptos (no hace falta que sean perfectas, sí que reflejen comprensión propia).
- Bloque 3: al menos 2 tablas relacionadas entre sí, cada una con su clave primaria; al menos una clave foránea correctamente marcada; un PR mergeado con la rama principal protegida y la imagen del diagrama visible en el repo.
