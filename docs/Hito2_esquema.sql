-- 1. Tabla Usuario
CREATE TABLE usuarios (
  id SERIAL PRIMARY KEY,
  nombre TEXT NOT NULL,
  rol TEXT NOT NULL
);

-- 2. Tabla Plan
CREATE TABLE planes (
  id SERIAL PRIMARY KEY,
  precio DECIMAL(10,2) NOT NULL,
  dias INTEGER NOT NULL
);

-- 3. Tabla Suscripción (Entidad principal con estados)
CREATE TABLE suscripciones (
  id SERIAL PRIMARY KEY,
  usuario_id INTEGER REFERENCES usuarios(id),
  plan_id INTEGER REFERENCES planes(id),
  estado TEXT NOT NULL, -- 'Pendiente', 'Activa', 'Vencida'
  fin DATE
);

-- 4. Tabla Pago
CREATE TABLE pagos (
  id SERIAL PRIMARY KEY,
  suscripcion_id INTEGER REFERENCES suscripciones(id),
  monto DECIMAL(10,2) NOT NULL,
  foto_url TEXT
);

-- 5. Tabla Asistencia
CREATE TABLE asistencias (
  id SERIAL PRIMARY KEY,
  suscripcion_id INTEGER REFERENCES suscripciones(id),
  ingreso TIMESTAMP NOT NULL,
  nota TEXT
);

-- INSERCIÓN DE DATOS DE PRUEBA
INSERT INTO usuarios (nombre, rol) VALUES ('Derian', 'cajero'), ('Jostin', 'cliente');
INSERT INTO planes (precio, dias) VALUES (29.99, 30), (49.99, 60);

-- Una suscripción para probar el listado
INSERT INTO suscripciones (usuario_id, plan_id, estado, fin) VALUES (2, 1, 'Activa', '2026-11-29');

-- Datos relacionados para el detalle
INSERT INTO pagos (suscripcion_id, monto, foto_url) VALUES (1, 29.99, 'transferencia.jpg');
INSERT INTO asistencias (suscripcion_id, ingreso, nota) VALUES (1, '2026-10-29 10:00:00', 'Entrenamiento de pecho');




-- Activar Row Level Security (RLS) en las tablas clave
ALTER TABLE suscripciones ENABLE ROW LEVEL SECURITY;
ALTER TABLE pagos ENABLE ROW LEVEL SECURITY;

-- 1. Políticas de Leer (Cualquiera puede leer para que cargue el listado y detalle)
CREATE POLICY "Permitir leer suscripciones" ON suscripciones FOR SELECT USING (true);
CREATE POLICY "Permitir leer pagos" ON pagos FOR SELECT USING (true);

-- 2. Política de Crear (Solo usuarios autenticados pueden crear suscripciones)
CREATE POLICY "Permitir crear suscripciones con sesion" ON suscripciones FOR INSERT TO authenticated WITH CHECK (true);