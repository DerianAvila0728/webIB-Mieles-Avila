<script lang="ts">
  import { onMount } from 'svelte';
  import { supabase } from './lib/supabase';
  import type { Suscripcion, Pago, Asistencia } from './tipos';

  let suscripciones: Suscripcion[] = [];
  let suscripcionSeleccionada: Suscripcion | null = null;
  let pagos: Pago[] = [];
  let asistencias: Asistencia[] = [];
  let errorRed = '';

  // Cargar el listado al iniciar la vista desde Supabase
  onMount(async () => {
    const { data, error } = await supabase.from('suscripciones').select('*');
    if (error) {
      errorRed = 'Sin red o error al cargar datos';
    } else {
      suscripciones = data as Suscripcion[];
      // Seleccionar automáticamente la primera suscripción si existe
      if (suscripciones.length > 0) {
        verDetalle(suscripciones[0]);
      }
    }
  });

  // Cargar los datos relacionados para el detalle
  async function verDetalle(suscripcion: Suscripcion) {
    suscripcionSeleccionada = suscripcion;
    
    // Peticiones a las tablas relacionadas
    const { data: dataPagos } = await supabase
      .from('pagos')
      .select('*')
      .eq('suscripcion_id', suscripcion.id);
      
    const { data: dataAsistencias } = await supabase
      .from('asistencias')
      .select('*')
      .eq('suscripcion_id', suscripcion.id);

    pagos = (dataPagos as Pago[]) || [];
    asistencias = (dataAsistencias as Asistencia[]) || [];
  }
</script>

<main>
  <h1>GYM & WELLNESS PRO</h1>

  {#if errorRed}
    <p style="color: red; font-weight: bold;">{errorRed}</p>
  {/if}

  <div class="contenedor">
    <!-- VISTA LISTADO -->
    <section class="listado">
      <h2>Listado de Suscripciones</h2>
      <ul>
        {#each suscripciones as s}
          <!-- svelte-ignore a11y-click-events-have-key-events -->
          <!-- svelte-ignore a11y-no-noninteractive-element-interactions -->
          <li on:click={() => verDetalle(s)} style="cursor: pointer; margin-bottom: 10px; border: 1px solid #ccc; padding: 10px;">
            <strong>Suscripción #{s.id}</strong> <br>
            Estado: {s.estado}
          </li>
        {:else}
          <p>Cargando suscripciones o sin registros...</p>
        {/each}
      </ul>
    </section>

    <!-- VISTA DETALLE -->
    <section class="detalle">
      {#if suscripcionSeleccionada}
        <h2>Detalle Suscripción #{suscripcionSeleccionada.id}</h2>
        <p><strong>Estado:</strong> {suscripcionSeleccionada.estado}</p>
        <p><strong>Vence el:</strong> {suscripcionSeleccionada.fin}</p>

        <h3>Pagos Relacionados</h3>
        <ul>
          {#each pagos as p}
            <li>Monto: ${p.monto}</li>
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
  .contenedor {
    display: flex;
    gap: 2rem;
    padding: 1rem;
  }
  .listado, .detalle {
    flex: 1;
  }
</style>