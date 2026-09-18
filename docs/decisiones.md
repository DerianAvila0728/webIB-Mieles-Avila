## El pie usa footer y la hora usa time
**Elegido:** <footer> con párrafos y la marca de tiempo dentro de <time datetime="2026-09-11T09:40">.
**Descartado:** Un <div class="footer"> con texto corrido.
**Consecuencia que evita:** footer se anuncia como región de pie de página y permite saltar directamente a ella desde un lector de pantalla; un div genérico no aporta esa semántica.

## El listado principal usa table con scope
**Elegido:** Una etiqueta <table> con <caption>, <thead>, <tbody> y atributos `scope="col"` en los encabezados.
**Descartado:** Una lista anidada o un bloque de contenedores genéricos con estilos simulados de tabla.
**Consecuencia que evita:** Permite que las tecnologías de asistencia anuncien de qué columna proviene cada celda de datos al navegar (por ejemplo, "Estado, Abierto" en lugar de leer solo "Abierto").