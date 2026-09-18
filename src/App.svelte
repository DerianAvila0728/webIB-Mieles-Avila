<header>
  <p>Mesa de Ayuda</p>
  <nav aria-label="Navegación principal">
    <a href="#tickets">Tickets</a>
    <a href="#clientes">Clientes</a>
    <a href="#reportes">Reportes</a>
  </nav>
  <a href="#nuevo">Nuevo ticket</a>
</header>

<main>
  <section aria-labelledby="titulo-vista">
    <h1 id="titulo-vista">Bandeja de tickets</h1>
    <p>Agente: Mariela Zambrano 6 tickets asignados</p>
  </section>

  <section aria-labelledby="titulo-filtros">
    <h2 id="titulo-filtros">Filtros</h2>
    <div>
      <label for="filtro-estado">Estado:</label>
      <select id="filtro-estado">
        <option>Todos</option>
        <option>Abierto</option>
        <option>En progreso</option>
        <option>En espera</option>
        <option>Resuelto</option>
        <option>Cerrado</option>
      </select>
    </div>
    <div>
      <label for="filtro-prioridad">Prioridad:</label>
      <select id="filtro-prioridad">
        <option>Todas</option>
        <option>Alta</option>
        <option>Media</option>
        <option>Baja</option>
      </select>
    </div>
    <div>
      <label for="filtro-buscar">Buscar:</label>
      <input id="filtro-buscar" type="text" placeholder="Asunto o cliente" />
    </div>
    <button type="button">Aplicar filtros</button>
  </section>

  <section aria-labelledby="titulo-resumen">
    <h2 id="titulo-resumen">Resumen</h2>
    <p>Abiertos: 2. En progreso: 2. En espera: 1. Resueltos: 1</p>
  </section>

  <section aria-labelledby="titulo-listado">
    <h2 id="titulo-listado">Listado de tickets</h2>
    <table>
      <caption>Listado de tickets asignados al agente</caption>
      <thead>
        <tr>
          <th scope="col">N°</th>
          <th scope="col">Asunto</th>
          <th scope="col">Cliente</th>
          <th scope="col">Estado</th>
          <th scope="col">Prioridad</th>
          <th scope="col">Última actualización</th>
          <th scope="col">Acción</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th scope="row">1041</th>
          <td>No puedo iniciar sesión en el portal</td>
          <td>Comercial Vélez</td>
          <td>Abierto</td>
          <td>Alta</td>
          <td>hace 20 min</td>
          <td><a href="#ver-1041">Ver</a></td>
        </tr>
        <tr>
          <th scope="row">1038</th>
          <td>La factura electrónica no llega al correo</td>
          <td>Ferretería El Progreso</td>
          <td>En progreso</td>
          <td>Media</td>
          <td>hace 2 h</td>
          <td><a href="#ver-1038">Ver</a></td>
        </tr>
        <tr>
          <th scope="row">1035</th>
          <td>Error al exportar el reporte mensual</td>
          <td>Distribuidora Manabí</td>
          <td>En espera</td>
          <td>Media</td>
          <td>ayer</td>
          <td><a href="#ver-1035">Ver</a></td>
        </tr>
      </tbody>
    </table>
  </section>
</main>

<footer>
  <p>Mesa de Ayuda Proyecto docente 2026-2 - Última sincronización: <time datetime="2026-09-11T09:40">hoy, 09:40</time></p>
</footer>