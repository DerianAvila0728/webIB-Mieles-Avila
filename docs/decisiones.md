## El listado principal usa table con scope para accesibilidad
**Elegido:** Una etiqueta `<table>` con `<caption>`, `<thead>`, `<tbody>` y atributos `scope="col"` en los encabezados de columna.
**Descartado:** Una lista desordenada (`<ul>`) o un bloque de contenedores genéricos (`div`) con estilos visuales de tabla.
**Consecuencia que evita:** Permite que las tecnologías de asistencia y lectores de pantalla anuncien de qué columna proviene cada celda de datos al navegar (por ejemplo, anunciando "Estado, En progreso" en lugar de leer únicamente el texto suelto).

## El pie de página utiliza footer y time
**Elegido:** Una etiqueta semántica `<footer>` para el cierre de la página y una etiqueta `<time datetime="2026-09-18T15:20">` para la sincronización.
**Descartado:** Un contenedor genérico `<div class="footer">` con texto plano.
**Consecuencia que evita:** El uso de `footer` anuncia la región de pie de página permitiendo a los usuarios saltar directamente a ella mediante atajos de teclado o lectores de pantalla; además, el elemento `time` preserva una fecha legible por máquinas.