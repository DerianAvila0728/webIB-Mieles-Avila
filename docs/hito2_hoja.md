# Hoja del Hito 2 - GYM & WELLNESS PRO

## 1. Tablas

| Tabla | Columnas | Relación |
| :--- | :--- | :--- |
| `usuarios` | id, nombre, rol | Un usuario tiene muchas suscripciones |
| `planes` | id, precio, dias | Un plan tiene muchas suscripciones |
| `suscripciones` | id, usuario_id, plan_id, estado, fin | Una suscripción tiene muchos pagos y asistencias |
| `pagos` | id, suscripcion_id, monto, foto_url | Cada pago pertenece a una suscripción |
| `asistencias` | id, suscripcion_id, ingreso, nota | Cada asistencia pertenece a una suscripción |

## 2. Vista x consulta

| Vista | Qué pide | A qué tabla | Con qué filtro u orden | Qué puede fallar | ¿Funciona ya? |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Listado de suscripciones** | Leer | `suscripciones` | Todas las suscripciones | Sin red: mensaje en texto | Sí |
| **Detalle de suscripción** | Leer | `suscripciones`, `pagos` y `asistencias` | La suscripción seleccionada por ID | Sin red: mensaje en texto | Sí |
| **Nueva suscripción** | Crear | `suscripciones` | Solo estado válido y campos obligatorios | Sin sesión: lo rechaza el servicio | Sí |
| **Panel del Administrador** | Leer y cambiar el estado | `suscripciones` | Filtrado por estado o cliente | No es administrador: no autoriza cambios | Plan |

## 3. Matriz rol x tabla x operación

| Tabla / Operación | Sin sesión | Cliente | Cajero / Admin | ¿Política escrita? |
| :--- | :--- | :--- | :--- | :--- |
| `suscripciones` leer | Sí | Sí | Sí | Sí |
| `pagos` leer | Sí | Sí | Sí | Sí |
| `asistencias` leer | Sí | Sí | Sí | Sí |
| `suscripciones` crear | No | Sí | Sí | Sí |
| `suscripciones` cambiar el estado | No | No | Sí | Diseño |
| `pagos` crear | No | Sí | Sí | Diseño |

## 4. Usuario de ejemplo

* **Correo:** `derian@gym.com`
* **Contraseña:** `PowerFit123!`

## 5. Recuadro de cumplimiento

- [x] Las tablas existen en Supabase y tienen datos.
- [x] Los tipos de `src/tipos.ts` tienen las mismas columnas.
- [x] El listado y el detalle cargan desde Supabase.
- [x] El formulario valida antes de enviar.
- [x] Sin sesión no se puede crear; con sesión, sí.
- [x] Hay una captura de respaldo de cada demostración.