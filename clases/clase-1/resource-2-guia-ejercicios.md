# Ejercicio: Modelado ER de tu propio dominio

**Objetivo:** Diseñar en draw.io el modelo de datos (entidades, atributos, relaciones) de tu propio proyecto de React, antes de escribir una sola línea de SQL, y entregarlo mediante un Pull Request.

## Pasos

### 1. Elegir el dominio
- Usá el mismo dominio de tu proyecto de React (personajes, hechizos, naves, planetas, o el que hayas elegido).
- No importa si terminaste el frontend o no — solo necesitás tener claro qué entidades maneja tu dominio.

### 2. Explorar el ejemplo guiado (opcional, antes de arrancar)
- Cargá la mini base de datos "Biblioteca" (autores → libros → préstamos) — el SQL para crearla está en el MATERIAL de esta clase, sección 4 — y explorala con TablePlus/pgAdmin.
- Identificá dónde está la clave primaria y dónde la clave foránea antes de diseñar la tuya.

### 3. Modelar en draw.io
- Entrá a [app.diagrams.net](https://app.diagrams.net) y creá un diagrama nuevo (guardado en "Device", sin necesidad de cuenta).
- Definí al menos 2 tablas relacionadas entre sí (ej. personajes y casas/facciones, o naves y planetas) — cada tabla como un rectángulo con sus columnas listadas.
- Cada tabla necesita su clave primaria (columna "id").
- Al menos una clave foránea tiene que marcar la relación entre tus tablas (una flecha entre la columna que referencia y la tabla referenciada).

### 4. Si te sobra tiempo
- Agregá una tercera tabla con una relación N a N (por ejemplo, personajes y hechizos, si un personaje puede tener varios hechizos y un hechizo puede pertenecer a varios personajes).
- Pensá cómo modelarías esa relación con una tabla intermedia (no hace falta implementarla todavía, solo identificarla en el diagrama).

### 5. Exportar y entregar vía GitHub
- Exportá el diagrama como imagen (File → Export as → PNG o SVG).
- Creá un repo en GitHub (o reutilizá el de Backend Introduction si aplica).
- Protegé la rama principal "main" activando estas reglas:
  - Require pull request before merging
  - Require approvals
  - Block force pushes
  - Restrict deletions
- Subí tu imagen exportada en una rama nueva, y abrí un Pull Request hacia la rama "main".
- Mergeá el PR (con review si corresponde).

## Entregable (enviar por Slack en #canal)
- Link al Pull Request mergeado, con la imagen del diagrama visible en el diff.

## Criterios de evaluación
- Al menos 2 tablas relacionadas entre sí, cada una con su clave primaria.
- Al menos una clave foránea correctamente marcada.
- Un PR mergeado, con la rama principal protegida y la imagen del diagrama visible en el repo.
- El alumno puede explicar verbalmente por qué eligió esas entidades y esa relación (se valida en la puesta en común de la clase, no solo por el diagrama en sí).
