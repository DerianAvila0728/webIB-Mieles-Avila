<script>
    let filtroEstado = 'todos';
    let filtroNivel = 'todos';
    let busqueda = '';

    // Datos simulados de rutinas y planes de bienestar
    let rutinas = [
        { id: 301, titulo: 'Rutina de hipertrofia y dieta alta en proteína', cliente: 'Mateo Vera', iniciales: 'MV', estado: 'en progreso', nivel: 'intermedio', actualizacion: 'hace 30 min' },
        { id: 302, titulo: 'Plan de cardio y déficit calórico', cliente: 'Lucía Pérez', iniciales: 'LP', estado: 'pendiente', nivel: 'principiante', actualizacion: 'hace 2 h' },
        { id: 303, titulo: 'Entrenamiento de fuerza y nutrición limpia', cliente: 'Juan Morales', iniciales: 'JM', estado: 'completado', nivel: 'avanzado', actualizacion: 'ayer' }
    ];

    // Filtrado reactivo en Svelte
    $: rutinasFiltradas = rutinas.filter(r => {
        const matchEstado = filtroEstado === 'todos' || r.estado === filtroEstado;
        const matchNivel = filtroNivel === 'todos' || r.nivel === filtroNivel;
        const matchBusqueda = r.titulo.toLowerCase().includes(busqueda.toLowerCase()) || r.cliente.toLowerCase().includes(busqueda.toLowerCase());
        return matchEstado && matchNivel && matchBusqueda;
    });

    function resetearFiltros() {
        filtroEstado = 'todos';
        filtroNivel = 'todos';
        busqueda = '';
    }
</script>

<!-- STREAMING_CHUNK:Estructura semántica de la cabecera -->
<header class="sticky top-0 z-50 backdrop-blur-xl bg-[#090d16]/80 border-b border-gray-800">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 h-20 flex items-center justify-between">
        <div class="flex items-center space-x-3">
            <div class="w-12 h-12 rounded-xl bg-gradient-to-tr from-emerald-600 to-teal-400 flex items-center justify-center shadow-lg shadow-emerald-900/40">
                <span class="text-white font-black text-xl">⚡</span>
            </div>
            <div>
                <span class="text-xl font-extrabold tracking-wider bg-gradient-to-r from-white via-gray-200 to-emerald-400 bg-clip-text text-transparent">GYM & WELLNESS</span>
                <span class="block text-xs text-emerald-400 font-semibold uppercase tracking-widest">PRO TRAINER HUB</span>
            </div>
        </div>
        
        <nav class="hidden md:flex items-center space-x-8 text-sm font-medium" aria-label="Navegación principal">
            <a href="#dashboard" class="text-emerald-400 hover:text-emerald-300 transition-colors flex items-center gap-2">Dashboard</a>
            <a href="#ejercicios" class="text-gray-400 hover:text-emerald-300 transition-colors flex items-center gap-2">Ejercicios</a>
            <a href="#clientes" class="text-gray-400 hover:text-emerald-300 transition-colors flex items-center gap-2">Atletas</a>
            <a href="#nutricion" class="text-gray-400 hover:text-emerald-300 transition-colors flex items-center gap-2">Nutrición</a>
        </nav>

        <div class="flex items-center space-x-4">
            <button class="px-5 py-2.5 rounded-xl bg-gradient-to-r from-emerald-500 to-teal-600 hover:from-emerald-400 hover:to-teal-500 text-white font-semibold text-sm shadow-lg shadow-emerald-600/30 transition-all transform hover:-translate-y-0.5 active:translate-y-0 flex items-center gap-2">
                + Nueva Rutina
            </button>
        </div>
    </div>
</header>

<!-- STREAMING_CHUNK:Contenido principal de la aplicación -->
<main class="flex-grow max-w-7xl w-full mx-auto px-4 sm:px-6 lg:px-8 py-8 space-y-8">
    
    <!-- Banner de Bienvenida y Estadísticas Rápidas -->
    <section aria-labelledby="titulo-vista" class="space-y-6">
        <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-4 bg-gradient-to-r from-gray-900 via-gray-900 to-[#0c1816] p-8 rounded-3xl border border-gray-800 shadow-2xl relative overflow-hidden">
            <div class="absolute -right-10 -bottom-10 w-64 h-64 bg-emerald-500/10 rounded-full blur-3xl pointer-events-none"></div>
            <div class="relative z-10 space-y-2">
                <div class="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-emerald-500/10 border border-emerald-500/20 text-emerald-400 text-xs font-semibold">
                    <span class="w-2 h-2 rounded-full bg-emerald-400 animate-pulse"></span> Sistema Activo en Vivo
                </div>
                <h1 id="titulo-vista" class="text-3xl sm:text-4xl font-extrabold tracking-tight text-white">Panel de Control & Atletas</h1>
                <p class="text-gray-400 text-sm sm:text-base">Entrenador a cargo: <span class="text-white font-semibold">Carlos Mendoza</span> | Rendimiento óptimo</p>
            </div>
            <div class="grid grid-cols-3 gap-4 relative z-10">
                <div class="bg-gray-800/60 backdrop-blur border border-gray-700/60 p-4 rounded-2xl text-center">
                    <span class="block text-2xl sm:text-3xl font-extrabold text-emerald-400">12</span>
                    <span class="text-xs text-gray-400 font-medium uppercase tracking-wider">Activos</span>
                </div>
                <div class="bg-gray-800/60 backdrop-blur border border-gray-700/60 p-4 rounded-2xl text-center">
                    <span class="block text-2xl sm:text-3xl font-extrabold text-amber-400">3</span>
                    <span class="text-xs text-gray-400 font-medium uppercase tracking-wider">Pendientes</span>
                </div>
                <div class="bg-gray-800/60 backdrop-blur border border-gray-700/60 p-4 rounded-2xl text-center">
                    <span class="block text-2xl sm:text-3xl font-extrabold text-teal-400">95%</span>
                    <span class="text-xs text-gray-400 font-medium uppercase tracking-wider">Éxito</span>
                </div>
            </div>
        </div>
    </section>

    <!-- Barra de Filtros Interactiva -->
    <section aria-labelledby="titulo-filtros" class="bg-gray-900/80 backdrop-blur border border-gray-800 p-6 rounded-3xl shadow-xl space-y-4">
        <div class="flex items-center justify-between">
            <h2 id="titulo-filtros" class="text-lg font-bold text-white flex items-center gap-2">
                Filtros Avanzados de Entrenamiento
            </h2>
            <button on:click={resetearFiltros} class="text-xs text-emerald-400 hover:text-emerald-300 font-semibold transition-colors">Limpiar filtros</button>
        </div>
        
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            <div>
                <label for="filtro-estado" class="block text-xs font-semibold text-gray-400 uppercase tracking-wider mb-2">Estado de Rutina</label>
                <select id="filtro-estado" bind:value={filtroEstado} class="w-full bg-gray-950 border border-gray-800 rounded-xl px-4 py-3 text-sm text-gray-200 focus:outline-none focus:border-emerald-500 transition-colors cursor-pointer">
                    <option value="todos">Todos los estados</option>
                    <option value="pendiente">Pendiente</option>
                    <option value="en progreso">En progreso</option>
                    <option value="completado">Completado</option>
                </select>
            </div>

            <div>
                <label for="filtro-nivel" class="block text-xs font-semibold text-gray-400 uppercase tracking-wider mb-2">Nivel de Exigencia</label>
                <select id="filtro-nivel" bind:value={filtroNivel} class="w-full bg-gray-950 border border-gray-800 rounded-xl px-4 py-3 text-sm text-gray-200 focus:outline-none focus:border-emerald-500 transition-colors cursor-pointer">
                    <option value="todos">Todos los niveles</option>
                    <option value="principiante">Principiante</option>
                    <option value="intermedio">Intermedio</option>
                    <option value="avanzado">Avanzado</option>
                </select>
            </div>

            <div>
                <label for="filtro-buscar" class="block text-xs font-semibold text-gray-400 uppercase tracking-wider mb-2">Búsqueda Rápida</label>
                <input id="filtro-buscar" type="text" bind:value={busqueda} placeholder="Buscar por cliente o rutina..." class="w-full bg-gray-950 border border-gray-800 rounded-xl px-4 py-3 text-sm text-gray-200 focus:outline-none focus:border-emerald-500 transition-colors placeholder:text-gray-600">
            </div>
        </div>
    </section>

    <!-- Listado con Tabla Semántica Profesional -->
    <section aria-labelledby="titulo-listado" class="bg-gray-900/80 backdrop-blur border border-gray-800 rounded-3xl shadow-2xl overflow-hidden">
        <div class="p-6 border-b border-gray-800 flex items-center justify-between flex-wrap gap-4">
            <div>
                <h2 id="titulo-listado" class="text-xl font-bold text-white flex items-center gap-2">
                    Listado de Rutinas & Nutrición
                </h2>
                <p class="text-xs text-gray-400 mt-1">Control diario de entrenamientos y dietas personalizadas</p>
            </div>
            <div class="text-xs text-gray-400 bg-gray-950 px-3 py-1.5 rounded-xl border border-gray-800 font-medium">
                Mostrando <span class="text-emerald-400 font-bold">{rutinasFiltradas.length}</span> registros
            </div>
        </div>

        <div class="overflow-x-auto">
            <table class="w-full text-left border-collapse">
                <caption>Listado detallado de planes de gimnasio asignados a clientes</caption>
                <thead>
                    <tr class="bg-gray-950/60 text-gray-400 uppercase text-xs tracking-wider border-b border-gray-800">
                        <th scope="col" class="py-4 px-6 font-semibold">N° ID</th>
                        <th scope="col" class="py-4 px-6 font-semibold">Rutina / Plan Nutricional</th>
                        <th scope="col" class="py-4 px-6 font-semibold">Cliente</th>
                        <th scope="col" class="py-4 px-6 font-semibold">Estado</th>
                        <th scope="col" class="py-4 px-6 font-semibold">Nivel</th>
                        <th scope="col" class="py-4 px-6 font-semibold">Última Actualización</th>
                        <th scope="col" class="py-4 px-6 font-semibold text-right">Acción</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-800/60 text-sm">
                    {#each rutinasFiltradas as rutina}
                        <tr class="hover:bg-gray-800/40 transition-colors group">
                            <td class="py-4 px-6 font-mono font-bold text-emerald-400">#{rutina.id}</td>
                            <td class="py-4 px-6">
                                <div class="font-semibold text-white group-hover:text-emerald-400 transition-colors">{rutina.titulo}</div>
                                <div class="text-xs text-gray-500">Enfoque: Rendimiento & Nutrición</div>
                            </td>
                            <td class="py-4 px-6">
                                <div class="flex items-center gap-3">
                                    <div class="w-8 h-8 rounded-full bg-emerald-500/20 text-emerald-400 flex items-center justify-center font-bold text-xs">{rutina.iniciales}</div>
                                    <span class="font-medium text-gray-300">{rutina.cliente}</span>
                                </div>
                            </td>
                            <td class="py-4 px-6">
                                <span class="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-semibold 
                                    {rutina.estado === 'completado' ? 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/20' : 
                                      rutina.estado === 'en progreso' ? 'bg-sky-500/10 text-sky-400 border border-sky-500/20' : 
                                      'bg-amber-500/10 text-amber-400 border border-amber-500/20'}">
                                    <span class="w-1.5 h-1.5 rounded-full {rutina.estado === 'completado' ? 'bg-emerald-400' : rutina.estado === 'en progreso' ? 'bg-sky-400' : 'bg-amber-400'}"></span> 
                                    {rutina.estado}
                                </span>
                            </td>
                            <td class="py-4 px-6">
                                <span class="px-2.5 py-1 rounded-lg text-xs font-semibold bg-gray-800 text-gray-300 border border-gray-700">{rutina.nivel}</span>
                            </td>
                            <td class="py-4 px-6 text-gray-400 text-xs font-mono">{rutina.actualizacion}</td>
                            <td class="py-4 px-6 text-right">
                                <button class="px-3 py-1.5 rounded-xl bg-gray-800 hover:bg-emerald-600 hover:text-white text-gray-300 font-semibold text-xs transition-all border border-gray-700 shadow-sm ml-auto flex items-center gap-1.5">
                                    Ver Detalle
                                </button>
                            </td>
                        </tr>
                    {:else}
                        <tr>
                            <td colspan="7" class="py-8 text-center text-gray-500 text-sm">No se encontraron rutinas que coincidan con los filtros.</td>
                        </tr>
                    {/each}
                </tbody>
            </table>
        </div>
    </section>
</main>

<!-- STREAMING_CHUNK:Pie de página semántico -->
<footer class="mt-auto border-t border-gray-800 bg-gray-950 py-6 text-center text-xs text-gray-500">
    <div class="max-w-7xl mx-auto px-4 flex flex-col sm:flex-row items-center justify-between gap-4">
        <p>Gym & Wellness Pro - Proyecto Docente 2026-2 | Desarrollado con Estándares Semánticos</p>
        <p>Última sincronización del sistema: <time datetime="2026-09-18T15:20">hoy, 15:20</time></p>
    </div>
</footer>

<!-- STREAMING_CHUNK:Estilos CSS integrados y personalizados -->
<style>
    /* Estilos base para la plataforma de fitness */
    :global(body) {
        background-color: #090d16;
        color: #f3f4f6;
        font-family: 'Outfit', system-ui, -apple-system, sans-serif;
    }

    /* Scrollbar elegante */
    ::-webkit-scrollbar {
        width: 8px;
        height: 8px;
    }
    ::-webkit-scrollbar-track {
        background: #090d16;
    }
    ::-webkit-scrollbar-thumb {
        background: #1f2937;
        border-radius: 4px;
    }
    ::-webkit-scrollbar-thumb:hover {
        background: #22c55e;
    }
</style>
