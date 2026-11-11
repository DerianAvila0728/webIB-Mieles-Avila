Decisión 1: La tabla en pantalla estrecha

Elegimos la mecánica 1: la tabla se desplaza dentro de su propio espacio utilizando un contenedor con desbordamiento horizontal (overflow-x: auto).
Para el rol de entrenador de gimnasio, porque en un teléfono móvil necesita consultar todas las columnas de métricas e indicadores de los atletas sin perder información clave.
Lo que se pierde es la vista simultánea de toda la tabla completa en pantallas pequeñas, obligando a realizar desplazamiento horizontal.

Decisión 2: Los filtros y la estructura semántica

Elegimos organizar los filtros de búsqueda en una fila horizontal clara con elementos semánticos de formulario y etiquetas asociadas.
La consecuencia es que el entrenador puede ubicar y filtrar rápidamente los planes de sus atletas por estado o nivel con una interfaz limpia y accesible.
Lo que se pierde es el espacio vertical compacto, priorizando la claridad visual y la usabilidad frente a pantallas saturadas.

## Semana 10: dónde vive cada cosa

| Dato | Clase | Dónde vive | Por qué ahí | Qué arriesga |
|---|---|---|---|---|
| Suscripciones | Negocio | Supabase (BD) | Es la fuente de verdad del negocio, compartida por todos los usuarios. | Requiere conexión a internet. |
| El token | Sesión | localStorage | Permite que el usuario siga logueado al recargar o cerrar la pestaña. | Vulnerable a ataques XSS si se inyectan scripts. |
| El filtro | Interfaz | localStorage | Permite mantener la preferencia de vista del usuario si recarga la página. | Es específico del dispositivo, no se comparte mediante URL. |
| El borrador | Interfaz | sessionStorage | Mantiene el formulario vivo ante recargas accidentales, pero se limpia al cerrar. | Si el usuario cierra el navegador por completo, pierde lo escrito. |

### La copia vieja (Reto de diseño)
**El problema:** Si un usuario (A) deja la pestaña abierta y otro usuario (B) cambia el estado de una suscripción, el usuario A está viendo una "copia vieja". Si el usuario A presiona un botón, podría sobreescribir el cambio del usuario B.

**Solución elegida:** Modificar la petición PATCH añadiendo un filtro PostgREST por el estado actual (`&estado=eq.${estadoAnterior}`). 
* **Por qué:** Asegura directamente en la base de datos que el registro solo se actualice si el estado coincide con lo que el usuario A está viendo. Si el usuario B ya lo cambió, la petición devuelve `[]` (cero filas afectadas). 
* **Descartada:** Hacer peticiones `GET` cada 5 segundos (Polling) o recargar toda la lista antes de enviar. Se descartó porque sobrecarga la base de datos innecesariamente y aún existe una fracción de segundo donde el error puede ocurrir.
* **Qué pasa ahora en la pantalla de la persona A:** Supabase rechaza el cambio devolviendo `[]`. El frontend detecta esto, lanza un aviso ("No se pudo cambiar. Es posible que otro usuario...") y ejecuta la función `cargarListado()` automáticamente para que la pantalla del usuario A quede actualizada con el estado real.

