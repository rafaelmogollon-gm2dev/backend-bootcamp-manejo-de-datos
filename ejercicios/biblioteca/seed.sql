-- Mini base de datos "Biblioteca" — usada en Clases 1 y 2
-- Correr con: psql postgres -f seed.sql

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
