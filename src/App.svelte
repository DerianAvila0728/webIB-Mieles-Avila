```svelte
<script lang="ts">
    import Formulario from './Formulario.svelte';
</script>

<a class="skip-link" href="#contenido-principal">
    Saltar al contenido principal
</a>

<header class="site-header">
    <div class="header-inner">
        <h1>GYM &amp; WELLNESS PRO</h1>

        <nav aria-label="Navegación principal">
            <ul class="nav-list">
                <li>
                    <a href="#ejercicios">Ejercicios</a>
                </li>

                <li>
                    <a href="#resumen">Comidas</a>
                </li>

                <li>
                    <a href="#nuevo">Nueva rutina</a>
                </li>
            </ul>
        </nav>
    </div>
</header>

<main id="contenido-principal" class="container">

    <section
        aria-labelledby="titulo-vista"
        class="intro"
    >
        <h2 id="titulo-vista">
            Planes y rutinas asignadas
        </h2>

        <p class="subtitle">
            Entrenador: Carlos Mendoza - 3 usuarios activos
        </p>
    </section>


    <section
        aria-labelledby="titulo-filtros"
        class="filter-card"
    >
        <h2 id="titulo-filtros">
            Filtros de búsqueda
        </h2>

        <form
            class="filter-row"
            aria-label="Filtros de planes"
        >

            <div class="filter-group">
                <label for="filtro-estado">
                    Estado
                </label>

                <select
                    id="filtro-estado"
                    name="estado"
                >
                    <option value="todos">Todos</option>
                    <option value="pendiente">Pendiente</option>
                    <option value="progreso">En progreso</option>
                    <option value="completado">Completado</option>
                </select>
            </div>


            <div class="filter-group">
                <label for="filtro-nivel">
                    Nivel
                </label>

                <select
                    id="filtro-nivel"
                    name="nivel"
                >
                    <option value="todos">Todos</option>
                    <option value="principiante">Principiante</option>
                    <option value="intermedio">Intermedio</option>
                    <option value="avanzado">Avanzado</option>
                </select>
            </div>


            <div class="filter-group search">
                <label for="filtro-buscar">
                    Buscar por asunto o cliente
                </label>

                <input
                    id="filtro-buscar"
                    name="buscar"
                    type="search"
                    placeholder="Asunto o cliente..."
                    autocomplete="off"
                />
            </div>


            <button
                type="submit"
                class="btn-filter"
            >
                Aplicar filtros
            </button>

        </form>
    </section>


    <section
        id="resumen"
        aria-labelledby="titulo-resumen"
        class="summary-card"
    >
        <h2 id="titulo-resumen">
            Resumen
        </h2>

        <ul
            class="badges"
            aria-label="Resumen de planes por estado"
        >
            <li class="badge pending">
                <span aria-hidden="true">1</span>
                <span>Pendiente: 1 plan</span>
            </li>

            <li class="badge progress">
                <span aria-hidden="true">1</span>
                <span>En progreso: 1 plan</span>
            </li>

            <li class="badge success">
                <span aria-hidden="true">1</span>
                <span>Completado: 1 plan</span>
            </li>
        </ul>
    </section>


    <section
        id="ejercicios"
        aria-labelledby="titulo-listado"
        class="table-card"
    >
        <h2 id="titulo-listado">
            Listado de planes
        </h2>

        <p id="descripcion-tabla" class="sr-only">
            Tabla con los planes asignados, sus clientes, estado,
            nivel y enlaces para consultar cada detalle.
        </p>

        <div
            class="tabla-scroll"
            tabindex="0"
            aria-label="Tabla desplazable de planes"
            aria-describedby="descripcion-tabla"
        >
            <table>

                <caption>
                    Listado de rutinas de ejercicios y nutrición asignadas
                </caption>

                <thead>
                    <tr>
                        <th scope="col">N.º ID</th>
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

                        <td>
                            Rutina de hipertrofia y dieta alta en proteína
                        </td>

                        <td>
                            Mateo Vera
                        </td>

                        <td>
                            <span
                                class="status status-progress"
                                aria-label="Estado: En progreso"
                            >
                                En progreso
                            </span>
                        </td>

                        <td>
                            Intermedio
                        </td>

                        <td>
                            <a
                                class="table-link"
                                href="#ver-301"
                                aria-label="Ver detalle del plan 301 de Mateo Vera"
                            >
                                Ver detalle
                            </a>
                        </td>
                    </tr>


                    <tr>
                        <th scope="row">302</th>

                        <td>
                            Plan de cardio y déficit calórico
                        </td>

                        <td>
                            Lucía Pérez
                        </td>

                        <td>
                            <span
                                class="status status-pending"
                                aria-label="Estado: Pendiente"
                            >
                                Pendiente
                            </span>
                        </td>

                        <td>
                            Principiante
                        </td>

                        <td>
                            <a
                                class="table-link"
                                href="#ver-302"
                                aria-label="Ver detalle del plan 302 de Lucía Pérez"
                            >
                                Ver detalle
                            </a>
                        </td>
                    </tr>


                    <tr>
                        <th scope="row">303</th>

                        <td>
                            Entrenamiento de fuerza y nutrición limpia
                        </td>

                        <td>
                            Juan Morales
                        </td>

                        <td>
                            <span
                                class="status status-success"
                                aria-label="Estado: Completado"
                            >
                                Completado
                            </span>
                        </td>

                        <td>
                            Avanzado
                        </td>

                        <td>
                            <a
                                class="table-link"
                                href="#ver-303"
                                aria-label="Ver detalle del plan 303 de Juan Morales"
                            >
                                Ver detalle
                            </a>
                        </td>
                    </tr>

                </tbody>
            </table>
        </div>
    </section>


    <section
        id="nuevo"
        aria-labelledby="titulo-nuevo-plan"
    >
        <h2 id="titulo-nuevo-plan" class="sr-only">
            Crear nuevo plan
        </h2>

        <Formulario />
    </section>

</main>


<footer class="site-footer">
    <p>
        Bienestar Humano y Gym Pro -
        Última sincronización:
        <time datetime="2026-09-18T15:20">
            hoy, 15:20
        </time>
    </p>
</footer>

