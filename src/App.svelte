<script lang="ts">
  import { onMount } from 'svelte';
  import { supabase } from './lib/supabase';
  import type { Suscripcion, Pago, Asistencia, Usuario, Plan } from './tipos';
  import Formulario from './Formulario.svelte';

  let suscripciones: Suscripcion[] = [];
  let suscripcionSeleccionada: Suscripcion | null = null;
  let usuarioAsociado: Usuario | null = null;
  let planAsociado: Plan | null = null;
  let pagos: Pago[] = [];
  let asistencias: Asistencia[] = [];
  
  let errorRed = '';
  let mensajeAviso = ''; 

  // FASE 3: Variables para el filtro
  let filtroEstado = 'Todos';
  const CLAVE_FILTRO = 'gym.filtro';

  // Reactividad: Filtra la lista automáticamente cuando cambia el filtro o los datos
  $: suscripcionesFiltradas = filtroEstado === 'Todos' 
    ? suscripciones 
    : suscripciones.filter(s => s.estado === filtroEstado);

  onMount(async () => {
    // Verificamos sesión (Fase 2)
    const { data: { session }, error: errorSesion } = await supabase.auth.getSession();
    
    if (errorSesion || !session) {
      errorRed = 'Su sesión venció o no hay sesión. Inicie sesión otra vez.';
      await supabase.auth.signOut();
      return; 
    }

    // FASE 3: Recuperar el filtro guardado al recargar
    const filtroGuardado = localStorage.getItem(CLAVE_FILTRO);
    if (filtroGuardado && ['Todos', 'Activa', 'Pendiente', 'Vencida'].includes(filtroGuardado)) {
      filtroEstado = filtroGuardado;
    }

    await cargarListado();
  });

  // FASE 3: Función para guardar el filtro cuando el usuario lo cambie
  function manejarCambioFiltro(event: Event) {
    const select = event.target as HTMLSelectElement;
    filtroEstado = select.value;
    localStorage.setItem(CLAVE_FILTRO, filtroEstado);
  }

  // Extraemos la carga de datos a una función para poder reutilizarla
  async function cargarListado() {
    const { data, error } = await supabase.from('suscripciones').select('*');
    if (error) {
      if (error.code === '401' || error.message.includes('JWT')) {
        errorRed = 'Su sesión venció. Inicie sesión otra vez.';
        await supabase.auth.signOut();
      } else {
        errorRed = 'Sin red o error al cargar datos';
      }
    } else {
      suscripciones = data as Suscripcion[];
      if (suscripciones.length > 0 && !suscripcionSeleccionada) {
        verDetalle(suscripciones[0]);
      }
    }
  }

  async function verDetalle(suscripcion: Suscripcion) {
    suscripcionSeleccionada = suscripcion;
    
    const { data: dataUsuario } = await supabase.from('usuarios').select('*').eq('id', suscripcion.usuario_id).single();
    const { data: dataPlan } = await supabase.from('planes').select('*').eq('id', suscripcion.plan_id).single();
    const { data: dataPagos } = await supabase.from('pagos').select('*').eq('suscripcion_id', suscripcion.id);
    const { data: dataAsistencias } = await supabase.from('asistencias').select('*').eq('suscripcion_id', suscripcion.id);

    usuarioAsociado = (dataUsuario as Usuario) || null;
    planAsociado = (dataPlan as Plan) || null;
    pagos = (dataPagos as Pago[]) || [];
    asistencias = (dataAsistencias as Asistencia[]) || [];
  }
  
  // FASE 1 y FASE 5 (Reto de Copia Vieja)
  async function cambiarEstadoSuscripcion(id: number, nuevoEstado: string) {
    mensajeAviso = `Guardando estado ${nuevoEstado}...`;
    
    const suscripcion = suscripciones.find((s) => s.id === id);
    if (!suscripcion) return;

    if (suscripcion.estado === nuevoEstado) {
       mensajeAviso = `La suscripción ya está en estado ${nuevoEstado}.`;
       return;
    }

    try {
      // FASE 5: Se añade "&estado=eq." + suscripcion.estado para asegurar que nadie más lo haya cambiado
      const url = `https://aqiwzhspancaxhvxlkuj.supabase.co/rest/v1/suscripciones?id=eq.${id}&estado=eq.${suscripcion.estado}`;
      
      const respuesta = await fetch(url, {
        method: "PATCH",
        headers: {
          "apikey": "sb_publishable_6EcKknEhJsI9YB3beA1Xxw_WxK1Ec90",
          "Content-Type": "application/json",
          "Prefer": "return representation"
        },
        body: JSON.stringify({ estado: nuevoEstado }),
      });

      if (!respuesta.ok) {
        mensajeAviso = `Error: la suscripción no cambió (respondió ${respuesta.status}).`;
        return;
      }

      const filas = await respuesta.json();

      // FASE 5: Si vuelve vacío, o no hay permisos, o el estado ya había sido cambiado por otro usuario
      if (filas.length === 0) {
        mensajeAviso = "No se pudo cambiar. Es posible que otro usuario ya haya modificado esta suscripción. Actualizando listado...";
        // Actualizamos la pantalla para reflejar el cambio del otro usuario
        await cargarListado(); 
        
        // Actualizamos el detalle actual
        const actualizada = suscripciones.find((s) => s.id === id);
        if (actualizada && suscripcionSeleccionada?.id === id) {
           suscripcionSeleccionada = { ...actualizada };
        }
        return;
      }

      // Éxito: actualizamos la copia visual
      const indice = suscripciones.findIndex((s) => s.id === id);
      if (indice !== -1) {
        suscripciones[indice].estado = filas[0].estado;
        suscripciones = [...suscripciones]; 
        
        if (suscripcionSeleccionada?.id === id) {
           suscripcionSeleccionada = { ...suscripcionSeleccionada, estado: filas[0].estado };
        }
      }
      
      mensajeAviso = `Suscripción #${id} pasó a "${nuevoEstado}".`;

    } catch (error) {
      console.error(error);
      mensajeAviso = "Error: no hubo respuesta. La suscripción no cambió.";
    }
  }
</script>

<main>
  <h1>GYM & WELLNESS PRO</h1>

  {#if errorRed}
    <p style="color: red; font-weight: bold; padding: 10px; background: #ffe6e6; border-radius: 5px;">{errorRed}</p>
  {/if}

  <section class="seccion-formulario">
    <Formulario />
  </section>

  <div class="contenedor">
    <!-- VISTA LISTADO -->
    <section class="listado">
      <div style="display: flex; justify-content: space-between; align-items: center;">
        <h2>Listado de Suscripciones</h2>
        
        <!-- FASE 3: Selector de filtro -->
        <div>
          <label for="filtro-estado">Filtrar: </label>
          <select id="filtro-estado" bind:value={filtroEstado} on:change={manejarCambioFiltro} style="padding: 5px;">
            <option value="Todos">Todos</option>
            <option value="Activa">Activa</option>
            <option value="Pendiente">Pendiente</option>
            <option value="Vencida">Vencida</option>
          </select>
        </div>
      </div>
      
      <ul>
        {#each suscripcionesFiltradas as s}
          <!-- svelte-ignore a11y-click-events-have-key-events -->
          <!-- svelte-ignore a11y-no-noninteractive-element-interactions -->
          <li on:click={() => verDetalle(s)} style="cursor: pointer; margin-bottom: 10px; border: 1px solid #ccc; padding: 10px; {suscripcionSeleccionada?.id === s.id ? 'border-color: #8b5cf6; background: #2a2a2a;' : ''}">
            <strong>Suscripción #{s.id}</strong> <br>
            Estado: <span style="color: {s.estado === 'Activa' ? '#2ecc71' : s.estado === 'Pendiente' ? '#f39c12' : '#e74c3c'}; font-weight: bold;">{s.estado}</span>
          </li>
        {:else}
          <p style="color: #aaa; margin-top: 10px;">
            {suscripciones.length === 0 ? 'Cargando suscripciones o sin registros...' : 'Ninguna suscripción coincide con el filtro.'}
          </p>
        {/each}
      </ul>
    </section>

    <!-- VISTA DETALLE -->
    <section class="detalle">
      {#if suscripcionSeleccionada}
        <h2>Detalle Suscripción #{suscripcionSeleccionada.id}</h2>
        
        {#if usuarioAsociado}
          <p><strong>Cliente:</strong> {usuarioAsociado.nombre} ({usuarioAsociado.rol})</p>
        {/if}

        {#if planAsociado}
          <p><strong>Plan Contratado:</strong> ${planAsociado.precio} ({planAsociado.dias} días)</p>
        {/if}

        <p>
          <strong>Estado:</strong> 
          <span style="color: {suscripcionSeleccionada.estado === 'Activa' ? '#2ecc71' : suscripcionSeleccionada.estado === 'Pendiente' ? '#f39c12' : '#e74c3c'}; font-weight: bold;">
            {suscripcionSeleccionada.estado}
          </span>
        </p>

        <!-- FASE 1: Botones y avisos -->
        {#if mensajeAviso}
          <p role="status" style="background: #333; color: white; padding: 8px; border-left: 4px solid #f39c12; margin: 10px 0;">
            {mensajeAviso}
          </p>
        {/if}

        <div style="margin: 15px 0; display: flex; gap: 10px;">
          {#if suscripcionSeleccionada.estado !== 'Activa'}
            <button on:click={() => cambiarEstadoSuscripcion(suscripcionSeleccionada.id, 'Activa')}>Pasar a Activa</button>
          {/if}
          {#if suscripcionSeleccionada.estado !== 'Pendiente'}
            <button on:click={() => cambiarEstadoSuscripcion(suscripcionSeleccionada.id, 'Pendiente')}>Pasar a Pendiente</button>
          {/if}
          {#if suscripcionSeleccionada.estado !== 'Vencida'}
            <button on:click={() => cambiarEstadoSuscripcion(suscripcionSeleccionada.id, 'Vencida')}>Pasar a Vencida</button>
          {/if}
        </div>
        
        <p><strong>Vence el:</strong> {suscripcionSeleccionada.fin}</p>

        <h3>Pagos Relacionados</h3>
        <ul>
          {#each pagos as p}
            <li>
              Monto: ${p.monto} <br>
              {#if p.foto_url}
                <small>Comprobante: {p.foto_url}</small>
              {/if}
            </li>
          {:else}
            <li>No hay pagos registrados.</li>
          {/each}
        </ul>

        <h3>Asistencias</h3>
        <ul>
          {#each asistencias as a}
            <li>Ingreso: {a.ingreso} - Nota: {a.nota}</li>
          {:else}
            <li>No hay asistencias registradas.</li>
          {/each}
        </ul>
      {:else}
        <p>Haz clic en una suscripción para ver su detalle.</p>
      {/if}
    </section>
  </div>
</main>

<style>
  .seccion-formulario {
    margin: 1rem 0;
    padding: 1rem;
    border: 1px solid #444;
    border-radius: 8px;
    background-color: #1a1a1a;
  }
  .contenedor {
    display: flex;
    gap: 2rem;
    padding: 1rem 0;
  }
  .listado, .detalle {
    flex: 1;
  }
  button {
    padding: 8px 12px;
    cursor: pointer;
    border: none;
    border-radius: 4px;
    background-color: #4CAF50;
    color: white;
    font-weight: bold;
  }
  button:hover {
    background-color: #45a049;
  }
</style>