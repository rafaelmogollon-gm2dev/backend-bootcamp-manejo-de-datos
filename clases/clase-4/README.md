# Clase 4 — Construcción & ORM: Sequelize

## Por qué esto importa

En la Clase 3 escribiste a mano cada query SQL que tu API necesita: `SELECT`, `INSERT`, `UPDATE`, `DELETE`, todos con sus placeholders parametrizados. Funciona, pero a medida que tu API crece, ese código se vuelve repetitivo — cada endpoint nuevo implica escribir de nuevo la misma lógica de conexión, manejo de errores y mapeo de resultados.

Un **ORM** (Object-Relational Mapper) resuelve ese problema: te permite representar tus tablas como clases de JavaScript, y trabajar con filas como si fueran objetos, sin escribir SQL a mano para las operaciones más comunes. En esta clase vamos a usar **Sequelize**, uno de los ORMs más usados en el ecosistema Node.js.

Haber visto `pg` puro en la Clase 3 no fue un paso descartable: entender qué hace un ORM "por debajo" es exactamente lo que te va a permitir depurarlo cuando algo no funcione como esperás — y en esta clase vas a ver un ejemplo concreto de eso.

## Conceptos clave

### Qué es el mapeo objeto-relacional

Un ORM traduce entre dos mundos: el de las tablas relacionales (filas, columnas, claves) y el de la programación orientada a objetos (clases, instancias, propiedades). Un **modelo** en Sequelize es una clase que representa una tabla; cada instancia de esa clase representa una fila.

### Ventajas y trade-offs

Usar un ORM tiene ventajas reales: migraciones versionadas (cambios al esquema quedan registrados y son reproducibles), menos SQL repetitivo, y validaciones declarativas a nivel de modelo. Pero también tiene un costo: es una capa de abstracción más entre vos y la base de datos, y algunas queries complejas pueden terminar siendo más difíciles de expresar que en SQL puro. No es una herramienta mágica — es una herramienta con compromisos, como cualquier otra.

### Relaciones en Sequelize: `hasMany` y `belongsTo`

Así como en SQL declarás una clave foránea con `REFERENCES`, en Sequelize declarás relaciones entre modelos con métodos como `hasMany` (un modelo tiene muchas instancias de otro) y `belongsTo` (un modelo pertenece a una instancia de otro). Por ejemplo, si una categoría tiene muchos items:

```js
Categoria.hasMany(Item, { as: 'items' });
Item.belongsTo(Categoria, { as: 'categoria' });
```

Con esa relación definida, podés pedirle a Sequelize que traiga los datos relacionados en una sola consulta usando `include` — el equivalente, desde el ORM, a un `JOIN` en SQL puro.

### Una trampa real: el alias de las asociaciones

Si no especificás el parámetro `as` en `hasMany`/`belongsTo`, Sequelize intenta generar un alias automáticamente pluralizando o singularizando el nombre del modelo. Con palabras en inglés generalmente funciona bien, pero con palabras en español el algoritmo puede fallar de forma silenciosa: por ejemplo, `Categoria` puede terminar generando el alias `Categorium`, que no es lo que esperás.

El problema es que esto **no produce un error** — la consulta con `include` simplemente devuelve el dato relacionado como `undefined`, sin ninguna pista de por qué. La solución es simple pero hay que conocerla: especificá siempre `as` a mano en tus asociaciones, y usá ese mismo string al hacer el `include` (por ejemplo, `include: 'categoria'`).

## Actividad de indagación

Vas a leer las secciones "Model Basics" y "Associations" de la documentación oficial de Sequelize, y anotar un ejemplo de `hasMany`/`belongsTo` con tus propias entidades. Material de apoyo en [recursos/referencias.md](recursos/referencias.md).

## Ejercicio práctico: migrá tu API a Sequelize

Partiendo de la API que trabajaste en Clase 3 (con `pg` puro):

1. Generá los modelos correspondientes a tus tablas ya existentes (o creá las migraciones si no las tenías).
2. Definí las relaciones entre tus modelos (`hasMany`/`belongsTo` según tu dominio, con `as` explícito).
3. Reescribí las rutas CRUD usando los métodos de Sequelize (`findAll`, `create`, `update`, `destroy`) en vez de queries manuales.
4. Agregá al menos una ruta que use `include` para traer datos relacionados.
5. Si te sobra tiempo: agregá validaciones básicas a nivel de modelo (`allowNull: false`, `validate: { notEmpty: true }`) y probá qué pasa al mandar un dato inválido.

## Herramientas de esta clase

- Instalación y configuración de Sequelize: [setup/01-sequelize.md](setup/01-sequelize.md).

## Para llevarte de esta clase

- Ves la diferencia directa entre escribir SQL a mano (Clase 3) y usar un ORM para lo mismo.
- Tus modelos ya tienen relaciones definidas, no solo tablas sueltas.
- Sabés evitar la trampa del alias silencioso en asociaciones — algo que te va a ahorrar tiempo de debugging en cualquier proyecto real con Sequelize.
