<!-- STREAMING_CHUNK:Definición del componente principal Svelte -->
<script>
    // Lógica limpia y sencilla para la plataforma de gimnasio
</script>

<header>
    <h1>🏋️ GYM & WELLNESS PRO</h1>
    <nav aria-label="Navegación principal">
        <a href="#ejercicios">Ejercicios</a>
        <a href="#comidas">Comidas</a>
        <a href="#nuevo">+ Nueva rutina</a>
    </nav>
</header>

<main class="container">
    <section aria-labelledby="titulo-vista">
        <h2 id="titulo-vista">Planes y rutinas asignadas</h2>
        <p class="subtitle">Entrenador: Carlos Mendoza - 3 usuarios activos</p>
    </section>

    <!-- Filtros ordenados estrictamente en horizontal -->
    <section aria-labelledby="titulo-filtros" class="filter-card">
        <h3 id="titulo-filtros">Filtros de Búsqueda</h3>
        <div class="filter-row">
            <div class="filter-group">
                <label for="filtro-estado">Estado:</label>
                <select id="filtro-estado">
                    <option>Todos</option>
                    <option>Pendiente</option>
                    <option>En progreso</option>
                    <option>Completado</option>
                </select>
            </div>
            <div class="filter-group">
                <label for="filtro-nivel">Nivel:</label>
                <select id="filtro-nivel">
                    <option>Todos</option>
                    <option>Principiante</option>
                    <option>Intermedio</option>
                    <option>Avanzado</option>
                </select>
            </div>
            <div class="filter-group search">
                <label for="filtro-buscar">Buscar:</label>
                <input id="filtro-buscar" type="text" placeholder="Asunto o cliente..." />
            </div>
            <button type="button" class="btn-filter">Aplicar filtros</button>
        </div>
    </section>

    <section aria-labelledby="titulo-resumen" class="summary-card">
        <h3 id="titulo-resumen">Resumen</h3>
        <p class="badges">
            <span class="badge pending">Pendientes: 1</span>
            <span class="badge progress">En progreso: 1</span>
            <span class="badge success">Completados: 1</span>
        </p>
    </section>

    <section aria-labelledby="titulo-listado" class="table-card">
        <h3 id="titulo-listado">Listado de planes</h3>
        <table>
            <caption>Listado de rutinas de ejercicios y nutrición asignadas</caption>
            <thead>
                <tr>
                    <th scope="col">N° ID</th>
                    <th scope="col">Rutina / Plan</th>
                    <th scope="col">Cliente</th>
                    <th scope="col">Estado</th>
                    <th scope="col">Nivel</th>
                    <th scope="col">Acción</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th scope="row">301</th>
                    <td>Rutina de hipertrofia y dieta alta en proteína</td>
                    <td>Mateo Vera</td>
                    <td>En progreso</td>
                    <td>Intermedio</td>
                    <td><a href="#ver-301">Ver detalle</a></td>
                </tr>
                <tr>
                    <th scope="row">302</th>
                    <td>Plan de cardio y déficit calórico</td>
                    <td>Lucía Pérez</td>
                    <td>Pendiente</td>
                    <td>Principiante</td>
                    <td><a href="#ver-302">Ver detalle</a></td>
                </tr>
                <tr>
                    <th scope="row">303</th>
                    <td>Entrenamiento de fuerza y nutrición limpia</td>
                    <td>Juan Morales</td>
                    <td>Completado</td>
                    <td>Avanzado</td>
                    <td><a href="#ver-303">Ver detalle</a></td>
                </tr>
            </tbody>
        </table>
    </section>
</main>

<footer>
    <p>Bienestar Humano y Gym Pro - Última sincronización: <time datetime="2026-09-18T15:20">hoy, 15:20</time></p>
</footer>

<style>
    /* Estilos limpios y organizados para Svelte */
    :global(body) {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f4f6f8;
        color: #333;
    }

    header {
        background-color: #111827;
        color: #fff;
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        border-bottom: 3px solid #22c55e;
    }

    header h1 {
        margin: 0;
        font-size: 1.2rem;
        color: #4ade80;
    }

    nav a {
        color: #fff;
        text-decoration: none;
        margin-left: 20px;
        font-size: 0.9rem;
        font-weight: 600;
    }

    nav a:hover {
        color: #4ade80;
    }

    .container {
        max-width: 1000px;
        margin: 20px auto;
        padding: 0 15px;
    }

    section {
        background: #fff;
        padding: 20px;
        margin-bottom: 15px;
        border-radius: 8px;
        border: 1px solid #e5e7eb;
        box-shadow: 0 2px 4px rgba(0,0,0,0.02);
    }

    h2, h3 {
        margin-top: 0;
        color: #111827;
    }

    .subtitle {
        color: #6b7280;
        font-size: 0.95rem;
        margin-bottom: 0;
    }

    /* Filtros ordenados estrictamente en horizontal */
    .filter-row {
        display: flex;
        gap: 15px;
        align-items: flex-end;
        flex-wrap: wrap;
        margin-top: 10px;
    }

    .filter-group {
        display: flex;
        flex-direction: column;
        gap: 5px;
        flex: 1;
        min-width: 150px;
    }

    .filter-group.search {
        flex: 2;
    }

    label {
        font-size: 0.85rem;
        font-weight: bold;
        color: #374151;
    }

    select, input {
        padding: 8px 10px;
        border: 1px solid #d1d5db;
        border-radius: 6px;
        font-size: 0.9rem;
        background-color: #f9fafb;
    }

    .btn-filter {
        background-color: #0ea5e9;
        color: white;
        border: none;
        padding: 9px 16px;
        border-radius: 6px;
        font-weight: bold;
        cursor: pointer;
        height: 38px;
    }

    .btn-filter:hover {
        background-color: #0284c7;
    }

    /* Badges de resumen */
    .badges {
        display: flex;
        gap: 10px;
        margin: 0;
    }

    .badge {
        padding: 4px 10px;
        border-radius: 6px;
        font-size: 0.85rem;
        font-weight: bold;
    }

    .badge.pending { background-color: #fef3c7; color: #b45309; }
    .badge.progress { background-color: #e0f2fe; color: #0369a1; }
    .badge.success { background-color: #dcfce7; color: #15803d; }

    /* Estilos de tabla */
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    caption {
        display: none;
    }

    th, td {
        border: 1px solid #e5e7eb;
        padding: 12px;
        text-align: left;
        font-size: 0.9rem;
    }

    th {
        background-color: #f9fafb;
        color: #1f2937;
    }

    tr:hover {
        background-color: #f8fafc;
    }

    td a {
        color: #0ea5e9;
        text-decoration: none;
        font-weight: bold;
    }

    td a:hover {
        text-decoration: underline;
    }

    footer {
        text-align: center;
        padding: 20px;
        color: #6b7280;
        font-size: 0.85rem;
        background-color: #fff;
        border-top: 1px solid #e5e7eb;
        margin-top: 30px;
    }
</style>
```eof