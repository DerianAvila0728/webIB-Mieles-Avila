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

  // Cargar el listado al iniciar la vista desde Supabase
  onMount(async () => {
    const { data, error } = await supabase.from('suscripciones').select('*');
    if (error) {
      errorRed = 'Sin red o error al cargar datos';
    } else {
      suscripciones = data as Suscripcion[];
      if (suscripciones.length > 0) {
        verDetalle(suscripciones[0]);
      }
    }
  });

  // Cargar los datos relacionados completos para el detalle
  async function verDetalle(suscripcion: Suscripcion) {
    suscripcionSeleccionada = suscripcion;
    
    // 1. Obtener el usuario vinculado
    const { data: dataUsuario } = await supabase
      .from('usuarios')
      .select('*')
      .eq('id', suscripcion.usuario_id)
      .single();

    // 2. Obtener el plan vinculado
    const { data: dataPlan } = await supabase
      .from('planes')
      .select('*')
      .eq('id', suscripcion.plan_id)
      .single();
    
    // 3. Obtener pagos
    const { data: dataPagos } = await supabase
      .from('pagos')
      .select('*')
      .eq('suscripcion_id', suscripcion.id);
      
    // 4. Obtener asistencias
    const { data: dataAsistencias } = await supabase
      .from('asistencias')
      .select('*')
      .eq('suscripcion_id', suscripcion.id);

    usuarioAsociado = (dataUsuario as Usuario) || null;
    planAsociado = (dataPlan as Plan) || null;
    pagos = (dataPagos as Pago[]) || [];
    asistencias = (dataAsistencias as Asistencia[]) || [];
  }
</script>

<main>
  <h1>GYM & WELLNESS PRO</h1>

  {#if errorRed}
    <p style="color: red; font-weight: bold;">{errorRed}</p>
  {/if}

  <!-- SECCIÓN DEL FORMULARIO UNIFICADO -->
  <section class="seccion-formulario">
    <Formulario />
  </section>

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
            Estado: <span style="color: {s.estado === 'Activa' ? '#2ecc71' : s.estado === 'Pendiente' ? '#f39c12' : '#e74c3c'}; font-weight: bold;">{s.estado}</span>
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
</style>