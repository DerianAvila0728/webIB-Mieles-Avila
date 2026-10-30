<script lang="ts">
  import { onMount } from 'svelte';
  import { supabase } from './lib/supabase';

  let rutina = '';
  let clienteNombre = '';
  let planesDisponibles: any[] = [];
  let planSeleccionadoId: number = 1;
  let estadoSeleccionado = 'Pendiente';
  let mensaje = '';
  let errorMsg = '';

  onMount(async () => {
    const { data, error } = await supabase.from('planes').select('*');
    if (!error && data) {
      planesDisponibles = data;
      if (data.length > 0) {
        planSeleccionadoId = data[0].id;
      }
    }
  });

  async function registrarSuscripcionCompleta(event: Event) {
    event.preventDefault();
    mensaje = '';
    errorMsg = '';

    try {
      // 1. Crear el usuario en la tabla 'usuarios'
      const { data: usuarioData, error: userError } = await supabase
        .from('usuarios')
        .insert([{ nombre: clienteNombre, rol: 'cliente' }])
        .select()
        .single();

      if (userError) throw new Error('Error al registrar usuario: ' + userError.message);

      const planElegido = planesDisponibles.find(p => p.id === Number(planSeleccionadoId));
      const diasPlan = planElegido ? planElegido.dias : 30;
      const precioPlan = planElegido ? planElegido.precio : 29.99;

      const fechaFin = new Date(Date.now() + diasPlan * 24 * 60 * 60 * 1000).toISOString().split('T')[0];

      // 2. Crear la suscripción vinculada al usuario y plan
      const { data: suscripcionData, error: suscripcionError } = await supabase
        .from('suscripciones')
        .insert([
          {
            usuario_id: usuarioData.id,
            plan_id: Number(planSeleccionadoId),
            estado: estadoSeleccionado,
            fin: fechaFin
          }
        ])
        .select()
        .single();

      if (suscripcionError) throw new Error('Error al registrar suscripción: ' + suscripcionError.message);

      // 3. Registrar automáticamente el pago asociado
      const { error: pagoError } = await supabase
        .from('pagos')
        .insert([
          {
            suscripcion_id: suscripcionData.id,
            monto: precioPlan,
            foto_url: rutina ? `${rutina.toLowerCase().replace(/\s+/g, '_')}.jpg` : 'comprobante_registro.jpg'
          }
        ]);

      if (pagoError) throw new Error('Error al registrar el pago inicial: ' + pagoError.message);

      // 4. Registrar automáticamente la asistencia inicial
      const { error: asistenciaError } = await supabase
        .from('asistencias')
        .insert([
          {
            suscripcion_id: suscripcionData.id,
            ingreso: new Date().toISOString(),
            nota: rutina ? `Registro inicial: ${rutina}` : 'Apertura de membresía'
          }
        ]);

      if (asistenciaError) throw new Error('Error al registrar la asistencia inicial: ' + asistenciaError.message);

      mensaje = '¡Suscripción, pago y asistencia registrados con éxito!';
      rutina = '';
      clienteNombre = '';

      setTimeout(() => {
        window.location.reload();
      }, 1000);

    } catch (err: any) {
      errorMsg = err.message || 'Ocurrió un error inesperado.';
    }
  }
</script>

<section class="form-card" aria-labelledby="titulo-nuevo">
    <h2 id="titulo-nuevo">Nuevo plan o rutina</h2>

    {#if mensaje}
        <p style="color: #2ecc71; font-weight: bold; margin-bottom: 1rem;">{mensaje}</p>
    {/if}
    {#if errorMsg}
        <p style="color: #e74c3c; font-weight: bold; margin-bottom: 1rem;">{errorMsg}</p>
    {/if}

    <form on:submit={registrarSuscripcionCompleta} class="main-form">
        <div class="form-group">
            <label for="rutina">
                Rutina / Plan <span aria-hidden="true">*</span>
            </label>
            <input
                type="text"
                id="rutina"
                bind:value={rutina}
                required
                autocomplete="off"
                placeholder="Ej. Rutina de Piernas"
            />
            <p class="field-help">Campo obligatorio.</p>
        </div>

        <div class="form-group">
            <label for="cliente">
                Cliente <span aria-hidden="true">*</span>
            </label>
            <input
                type="text"
                id="cliente"
                bind:value={clienteNombre}
                required
                autocomplete="name"
                placeholder="Ej. Neyser"
            />
        </div>

        <div class="form-group">
            <label for="plan">Seleccionar Plan</label>
            <select id="plan" bind:value={planSeleccionadoId}>
                {#each planesDisponibles as plan}
                    <option value={plan.id}>Plan #{plan.id} - ${plan.precio} ({plan.dias} días)</option>
                {:else}
                    <option value="1">Cargando planes...</option>
                {/each}
            </select>
        </div>

        <div class="form-group">
            <label for="estado">Estado</label>
            <select id="estado" bind:value={estadoSeleccionado}>
                <option value="Pendiente">Pendiente</option>
                <option value="Activa">Activa</option>
                <option value="Vencida">Vencida</option>
            </select>
        </div>

        <button type="submit" class="btn-submit">
            Registrar plan
        </button>
    </form>
</section>

<style>
  .form-card {
    background: #1e1e1e;
    padding: 1.5rem;
    border-radius: 8px;
    color: #fff;
    margin-bottom: 1rem;
  }
  .form-group {
    margin-bottom: 1rem;
  }
  .form-group label {
    display: block;
    margin-bottom: 0.5rem;
    font-weight: bold;
  }
  .form-group input, .form-group select {
    width: 100%;
    padding: 0.5rem;
    background: #2a2a2a;
    border: 1px solid #444;
    color: #fff;
    border-radius: 4px;
  }
  .field-help {
    font-size: 0.85rem;
    color: #aaa;
    margin-top: 0.25rem;
  }
  .btn-submit {
    background-color: #8b5cf6;
    color: white;
    padding: 0.75rem 1.5rem;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-weight: bold;
  }
  .btn-submit:hover {
    background-color: #7c3aed;
  }
</style>