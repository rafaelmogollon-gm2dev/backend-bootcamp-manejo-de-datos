# Setup 3 — dbdiagram.io (modelado ER)

## Qué es y para qué lo instalamos

dbdiagram.io es una herramienta web para diagramar entidades y relaciones (ER) escribiendo una sintaxis simple tipo código, en vez de arrastrar cajas manualmente. Nos sirve para **pensar el modelo de datos antes de escribir SQL** — tablas, columnas, claves primarias/foráneas y relaciones.

No requiere instalación: es 100% web.

**Nota de verificación:** no se probó la interfaz web en vivo (requiere navegador). La sintaxis documentada abajo (`Table`, `ref:`) es estable y pública en la documentación oficial de dbdiagram.io — si la interfaz cambió de aspecto, la sintaxis para definir tablas y relaciones no debería haber cambiado.

## Paso a paso

1. Entrá a [dbdiagram.io](https://dbdiagram.io).
2. Click en **"Go to App"** (podés usarlo sin cuenta para probar; para guardar diagramas necesitás crear una cuenta gratuita con GitHub o Google).
3. Click en **"Create new Diagram"**.
4. A la izquierda vas a escribir la definición de tus tablas, por ejemplo:

   ```
   Table autores {
     id int [pk, increment]
     nombre varchar
     nacionalidad varchar
   }

   Table libros {
     id int [pk, increment]
     titulo varchar
     autor_id int [ref: > autores.id]
     anio int
   }
   ```

5. A la derecha se va a dibujar automáticamente el diagrama con las tablas y la relación (una línea conectando `libros.autor_id` con `autores.id`).

## Cómo verificar que funcionó

Si al escribir la sintaxis de arriba ves dos cajas conectadas por una línea a la derecha, ya está funcionando. No hay "instalación" que pueda fallar al ser 100% web, pero sí puede fallar la sintaxis — dbdiagram.io marca en rojo la línea con el error.

## Exportar a SQL

Una vez armado el diagrama, podés ir a **Export → PostgreSQL** para que te genere automáticamente el `CREATE TABLE` correspondiente. Esto es muy útil para la Clase 2, donde pasamos del diagrama al SQL real.

## Errores comunes

### El diagrama no se actualiza al escribir
A veces el editor tarda un segundo en re-renderizar, o hay un error de sintaxis más arriba en el archivo que bloquea el parseo de todo lo siguiente. Revisá si hay alguna línea marcada en rojo antes de la que estás editando.

### No puedo guardar el diagrama
Necesitás estar logueado (GitHub o Google). Si no querés crear cuenta, podés simplemente copiar el código de la sintaxis a un archivo de texto local antes de cerrar la pestaña — al volver a pegarlo se reconstruye el diagrama.

### El export a SQL no incluye algo que esperaba
dbdiagram.io no soporta el 100% de las features avanzadas de Postgres (por ejemplo, ciertos constraints o triggers) — para el nivel de esta semana no debería ser un problema, pero si el SQL exportado no compila, revisá manualmente los `CREATE TABLE` generados antes de correrlos.

## Alternativa

Si preferís una herramienta más visual/manual (arrastrar cajas en vez de escribir sintaxis), podés usar [draw.io](https://draw.io) — es gratis y sin límites, pero no exporta a SQL directamente.
