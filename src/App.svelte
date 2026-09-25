<script lang="ts">
    import Formulario from './Formulario.svelte';
</script>

<header>
    <h1>GYM & WELLNESS PRO</h1>
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

    <!-- Filtros ordenados estrictamente en horizontal en PC y vertical en móvil -->
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
        <div class="tabla-scroll">
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
        </div>
    </section>

    <!-- Aquí se muestra el componente Formulario requerido en la semana 4 -->
    <Formulario />
</main>

<footer>
    <p>Bienestar Humano y Gym Pro - Última sincronización: <time datetime="2026-09-18T15:20">hoy, 15:20</time></p>
</footer>

<style>
    /* Estilos estructurales limpios sin colores añadidos */
    header {
        display: flex;
        flex-direction: column;
        gap: 10px;
        align-items: center;
        padding: 10px;
    }

    header h1 {
        margin: 0;
        font-size: 1.2rem;
    }

    nav {
        display: flex;
        gap: 15px;
    }

    .container {
        margin: 10px auto;
        padding: 0 10px;
    }

    section {
        margin-bottom: 15px;
        padding: 10px;
    }

    .subtitle {
        margin-bottom: 0;
    }

    /* Filtros: Vertical en móvil, Horizontal en PC */
    .filter-row {
        display: flex;
        flex-direction: column;
        gap: 10px;
        margin-top: 10px;
    }

    .filter-group {
        display: flex;
        flex-direction: column;
        gap: 5px;
        width: 100%;
    }

    label {
        font-weight: bold;
        font-size: 0.9rem;
    }

    select, input, .btn-filter {
        padding: 8px;
        font-size: 1rem;
        width: 100%;
        box-sizing: border-box;
    }

    /* Badges */
    .badges {
        display: flex;
        flex-wrap: wrap;
        gap: 10px;
        margin: 0;
    }

    .badge {
        padding: 4px 8px;
    }

    /* Tabla con scroll horizontal para móviles */
    .tabla-scroll {
        width: 100%;
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
        margin-top: 10px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        white-space: nowrap;
    }

    th, td {
        border: 1px solid #ccc;
        padding: 8px;
        text-align: left;
    }

    footer {
        text-align: center;
        padding: 10px;
    }

    /* Diseño para Escritorio (PC) */
    @media (min-width: 768px) {
        header {
            flex-direction: row;
            justify-content: space-between;
            padding: 15px 20px;
        }

        .filter-row {
            flex-direction: row;
            align-items: flex-end;
            gap: 15px;
        }

        .filter-group {
            flex: 1;
        }

        .filter-group.search {
            flex: 2;
        }

        .btn-filter {
            width: auto;
        }
    }
</style>