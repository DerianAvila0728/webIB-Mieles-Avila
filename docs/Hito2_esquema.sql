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

CREATE POLICY "Permitir leer asistencias" ON asistencias FOR SELECT USING (true);
CREATE POLICY "Permitir leer planes" ON planes FOR SELECT USING (true);
CREATE POLICY "Permitir leer usuarios" ON usuarios FOR SELECT USING (true);

-- Insertar una suscripción para el usuario 1 (Derian el cajero)
INSERT INTO suscripciones (usuario_id, plan_id, estado, fin) VALUES (1, 2, 'Activa', '2026-12-30');

-- Pagos y asistencias para esta nueva suscripción de Derian (ID 2)
INSERT INTO pagos (suscripcion_id, monto, foto_url) VALUES (2, 49.99, 'pago_derian.jpg');
INSERT INTO asistencias (suscripcion_id, ingreso, nota) VALUES (2, '2026-10-30 09:00:00', 'Control de apertura');

-- 1. Suscripción en estado Pendiente
INSERT INTO suscripciones (usuario_id, plan_id, estado, fin) VALUES (2, 2, 'Pendiente', '2026-12-31');
INSERT INTO pagos (suscripcion_id, monto, foto_url) VALUES (3, 49.99, 'comprobante_pendiente.jpg');

-- 2. Suscripción en estado Vencida
INSERT INTO suscripciones (usuario_id, plan_id, estado, fin) VALUES (1, 1, 'Vencida', '2026-09-30');
INSERT INTO pagos (suscripcion_id, monto, foto_url) VALUES (4, 29.99, 'comprobante_vencido.jpg');
INSERT INTO asistencias (suscripcion_id, ingreso, nota) VALUES (4, '2026-09-15 08:00:00', 'Entrenamiento antiguo');