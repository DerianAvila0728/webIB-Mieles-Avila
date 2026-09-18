<<<<<<< HEAD
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
        <tr>
          <th scope="row">1031</th>
          <td>Solicitud de un usuario adicional</td>
          <td>Clínica San Rafael</td>
          <td>Abierto</td>
          <td>Baja</td>
          <td>ayer</td>
          <td><a href="#ver-1031">Ver</a></td>
        </tr>
        <tr>
          <th scope="row">1027</th>
          <td>Lentitud al cargar el inventario</td>
          <td>Comercial Vélez</td>
          <td>En progreso</td>
          <td>Alta</td>
          <td>hace 3 días</td>
          <td><a href="#ver-1027">Ver</a></td>
        </tr>
        <tr>
          <th scope="row">1019</th>
          <td>Cambio de RUC en la cuenta</td>
          <td>Panadería Doña Luz</td>
          <td>Resuelto</td>
          <td>Baja</td>
          <td>hace 5 días</td>
          <td><a href="#ver-1019">Ver</a></td>
        </tr>
      </tbody>
    </table>
  </section>
</main>

<footer>
  <p>Mesa de Ayuda Proyecto docente 2026-2 - Última sincronización: <time datetime="2026-09-11T09:40">hoy, 09:40</time></p>
</footer>
```[cite: 1]
=======
<script>
  import svelteLogo from './assets/svelte.svg'
  import viteLogo from './assets/vite.svg'
  import heroImg from './assets/hero.png'
  import Counter from './lib/Counter.svelte'
</script>

<section id="center">
  <div class="hero">
    <img src={heroImg} class="base" width="170" height="179" alt="" />
    <img src={svelteLogo} class="framework" alt="Svelte logo" />
    <img src={viteLogo} class="vite" alt="Vite logo" />
  </div>
  <div>
    <h1>Get started</h1>
    <p>Edit <code>src/App.svelte</code> and save to test <code>HMR</code></p>
  </div>
  <Counter />
</section>

<div class="ticks"></div>

<section id="next-steps">
  <div id="docs">
    <svg class="icon" role="presentation" aria-hidden="true">
      <use href="/icons.svg#documentation-icon"></use>
    </svg>
    <h2>Documentation</h2>
    <p>Your questions, answered</p>
    <ul>
      <li>
        <a href="https://vite.dev/" target="_blank" rel="noreferrer">
          <img class="logo" src={viteLogo} alt="" />
          Explore Vite
        </a>
      </li>
      <li>
        <a href="https://svelte.dev/" target="_blank" rel="noreferrer">
          <img class="button-icon" src={svelteLogo} alt="" />
          Learn more
        </a>
      </li>
    </ul>
  </div>
  <div id="social">
    <svg class="icon" role="presentation" aria-hidden="true">
      <use href="/icons.svg#social-icon"></use>
    </svg>
    <h2>Connect with us</h2>
    <p>Join the Vite community</p>
    <ul>
      <li>
        <a href="https://github.com/vitejs/vite" target="_blank" rel="noreferrer">
          <svg class="button-icon" role="presentation" aria-hidden="true">
            <use href="/icons.svg#github-icon"></use>
          </svg>
          GitHub
        </a>
      </li>
      <li>
        <a href="https://chat.vite.dev/" target="_blank" rel="noreferrer">
          <svg class="button-icon" role="presentation" aria-hidden="true">
            <use href="/icons.svg#discord-icon"></use>
          </svg>
          Discord
        </a>
      </li>
      <li>
        <a href="https://x.com/vite_js" target="_blank" rel="noreferrer">
          <svg class="button-icon" role="presentation" aria-hidden="true">
            <use href="/icons.svg#x-icon"></use>
          </svg>
          X.com
        </a>
      </li>
      <li>
        <a href="https://bsky.app/profile/vite.dev" target="_blank" rel="noreferrer">
          <svg class="button-icon" role="presentation" aria-hidden="true">
            <use href="/icons.svg#bluesky-icon"></use>
          </svg>
          Bluesky
        </a>
      </li>
    </ul>
  </div>
</section>

<div class="ticks"></div>
<section id="spacer"></section>
>>>>>>> 5ab136aa7e530512d7acb571c574adc54bb1b84c
