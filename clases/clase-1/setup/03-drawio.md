# Setup 3 — draw.io / diagrams.net (modelado ER) + entrega vía GitHub

## Qué es y para qué lo instalamos

draw.io (también conocido como diagrams.net) es una herramienta web para diagramar entidades y relaciones (ER) arrastrando cajas y conectándolas manualmente. Nos sirve para **pensar el modelo de datos antes de escribir SQL** — tablas, columnas, claves primarias/foráneas y relaciones.

No requiere instalación: es 100% web (también existe una app de escritorio opcional, no la necesitamos).

**Nota de verificación:** no se probó la interfaz web en vivo (requiere navegador). La mecánica básica (arrastrar formas, conectar con flechas, exportar imagen) es estable en la documentación pública de diagrams.net.

## Paso a paso: crear el diagrama

1. Entrá a [app.diagrams.net](https://app.diagrams.net).
2. Elegí dónde guardar tu diagrama — podés usar "Device" (se guarda localmente en tu navegador/descarga) sin necesidad de crear cuenta.
3. En el panel izquierdo vas a encontrar formas básicas. Para representar una tabla, la forma más simple es un rectángulo con el nombre de la tabla arriba y sus columnas listadas debajo (podés usar doble click para editar el texto dentro de una forma).
4. Dibujá una tabla por entidad de tu dominio (por ejemplo, `autores`, `libros`).
5. Para marcar una relación (clave foránea), conectá dos tablas con una flecha desde la columna que referencia hacia la tabla referenciada.
6. Repetí para todas tus tablas y relaciones.

## Cómo exportar la imagen del diagrama

Una vez terminado el diagrama:

1. Andá a **File → Export as → PNG** (o SVG, si preferís un formato vectorial).
2. Guardá el archivo con un nombre descriptivo, por ejemplo `diagrama-er.png`.
3. Esta imagen es la que vas a subir a tu repo como parte del entregable.

## Entregar el diagrama vía GitHub (mismo flujo que Backend Introduction)

1. Creá un repo nuevo en GitHub (público o privado) llamado, por ejemplo, `ejercicio-modelado-tu-nombre`. Inicializalo con un `README.md`.
2. Verificá en **Settings → General → Default branch** que la rama por defecto sea `main`.
3. Protegé la rama `main`: **Settings → Branches → Add branch ruleset** (o "Add classic branch protection rule"), aplicada a `main`, con:
   - Require a pull request before merging
   - Require approvals (mínimo 1)
   - Block force pushes
   - Restrict deletions
4. Cloná el repo localmente, creá una rama nueva (ej. `feature/diagrama-er`), agregá tu imagen exportada (`diagrama-er.png`) a la raíz del repo o a una carpeta `ejercicio-1/`.
5. Hacé commit y push de tu rama, y abrí un Pull Request hacia `main`.
6. Mergeá el PR (pedí review si corresponde).

**Verificar que funcionó:** el PR mergeado debe mostrar la imagen del diagrama visible en el diff de GitHub (los `.png`/`.svg` se previsualizan directo en la interfaz de GitHub).

## Errores comunes

### No encuentro la opción de exportar
Está en el menú superior **File → Export as**. Si estás en la versión de escritorio, el menú puede llamarse distinto según el sistema operativo, pero la opción "Export as" siempre existe.

### La imagen exportada se ve borrosa o muy chica
Al exportar, diagrams.net te permite elegir un "Zoom" o escala antes de exportar — subilo (por ejemplo a 200%) para que la imagen tenga mejor resolución.

### GitHub no me deja proteger la rama main
Necesitás que el repo sea tuyo (no de una organización con permisos restringidos) o tener rol de administrador sobre el repo. Si el repo es de una organización del bootcamp, puede que la protección de ramas ya venga configurada o requiera permisos que no tenés — consultá con tu docente.

## Alternativa

Si preferís una herramienta con sintaxis tipo código en vez de arrastrar cajas manualmente, existe [dbdiagram.io](https://dbdiagram.io) — tiene la ventaja de exportar directo a SQL, pero para el objetivo de esta clase (pensar el modelo antes de escribir código) usamos draw.io porque el foco está en el diagrama en sí, no en generar SQL automáticamente.
