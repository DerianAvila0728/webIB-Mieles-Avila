<section aria-labelledby="titulo-nuevo">
  <h2 id="titulo-nuevo">Nuevo plan o rutina</h2>
  
  <form action="#" method="post">
    <label for="rutina">Rutina / Plan</label>
    <input type="text" id="rutina" name="rutina" required>

    <label for="cliente">Cliente</label>
    <input type="text" id="cliente" name="cliente" required>

    <label for="estado">Estado</label>
    <select id="estado" name="estado">
      <option>Pendiente</option>
      <option>En progreso</option>
      <option>Completado</option>
    </select>

    <label for="nivel">Nivel</label>
    <select id="nivel" name="nivel">
      <option>Principiante</option>
      <option>Intermedio</option>
      <option>Avanzado</option>
    </select>

    <button type="submit">Registrar plan</button>
  </form>
</section>