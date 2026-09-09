const express = require('express');
const app = express();
const PORT = 3000;

app.use(express.json());

let categorias = [
  { id: 1, nombre: 'Electrónica' },
  { id: 2, nombre: 'Hogar' },
];
let nextCategoriaId = 3;

let items = [
  { id: 1, nombre: 'Item de ejemplo', descripcion: 'Descripción de ejemplo', categoriaId: 1 },
];
let nextItemId = 2;

// --- Categorías ---

app.get('/categorias', (req, res) => {
  res.json(categorias);
});

app.post('/categorias', (req, res) => {
  const { nombre } = req.body;
  if (!nombre) return res.status(400).json({ error: 'nombre es requerido' });

  const nuevaCategoria = { id: nextCategoriaId++, nombre };
  categorias.push(nuevaCategoria);
  res.status(201).json(nuevaCategoria);
});

// --- Items (relacionados a una categoría) ---

app.get('/items', (req, res) => {
  res.json(items);
});

app.get('/items/:id', (req, res) => {
  const item = items.find((i) => i.id === Number(req.params.id));
  if (!item) return res.status(404).json({ error: 'Item no encontrado' });
  res.json(item);
});

app.post('/items', (req, res) => {
  const { nombre, descripcion, categoriaId } = req.body;
  if (!nombre) return res.status(400).json({ error: 'nombre es requerido' });

  const nuevoItem = { id: nextItemId++, nombre, descripcion, categoriaId };
  items.push(nuevoItem);
  res.status(201).json(nuevoItem);
});

app.put('/items/:id', (req, res) => {
  const item = items.find((i) => i.id === Number(req.params.id));
  if (!item) return res.status(404).json({ error: 'Item no encontrado' });

  const { nombre, descripcion, categoriaId } = req.body;
  if (nombre !== undefined) item.nombre = nombre;
  if (descripcion !== undefined) item.descripcion = descripcion;
  if (categoriaId !== undefined) item.categoriaId = categoriaId;
  res.json(item);
});

app.delete('/items/:id', (req, res) => {
  const index = items.findIndex((i) => i.id === Number(req.params.id));
  if (index === -1) return res.status(404).json({ error: 'Item no encontrado' });

  items.splice(index, 1);
  res.status(204).send();
});

app.listen(PORT, () => {
  console.log(`starter-api corriendo en http://localhost:${PORT}`);
});
