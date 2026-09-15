-- Mini base de datos de biblioteca — usada en Clases 1 y 2
-- Correr con: psql postgres -f seed.sql

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
