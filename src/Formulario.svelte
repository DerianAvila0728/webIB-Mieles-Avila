<script lang="ts">
  import { onMount } from 'svelte';
  import { supabase } from './lib/supabase';

  // FASE 2: Estado para la sesión
  let usuarioAutenticado = false;
  let emailLogin = '';
  let passwordLogin = '';
  let mensajeSesion = '';

  // Variables del formulario
  let rutina = '';
  let clienteNombre = '';
  let planesDisponibles: any[] = [];
  let planSeleccionadoId: number = 1;
  let estadoSeleccionado = 'Pendiente';
  let mensaje = '';
  let errorMsg = '';

  // FASE 4: Clave para el sessionStorage
  const CLAVE_BORRADOR = 'gym.borrador';

  onMount(async () => {
    // 1. Verificar si hay sesión activa
    const { data: { session } } = await supabase.auth.getSession();
    usuarioAutenticado = !!session;

    // 2. Cargar planes disponibles
    const { data, error } = await supabase.from('planes').select('*');
    if (!error && data) {
      planesDisponibles = data;
      if (data.length > 0) {
        planSeleccionadoId = data[0].id;
      }
    }

    // FASE 4: Recuperar el borrador al cargar la página
    const borradorGuardado = sessionStorage.getItem(CLAVE_BORRADOR);
    if (borradorGuardado) {
      try {
        const datos = JSON.parse(borradorGuardado);
        rutina = datos.rutina || '';
        clienteNombre = datos.clienteNombre || '';
      } catch (e) {
        console.error("Error al leer borrador", e);
      }
    }
  });

  // FASE 4: Guardar el borrador en tiempo real
  function guardarBorrador() {
    const datos = {
      rutina,
      clienteNombre
    };
    sessionStorage.setItem(CLAVE_BORRADOR, JSON.stringify(datos));
  }

  // FASE 2: Función de inicio de sesión
  async function iniciarSesion(event: Event) {
    event.preventDefault();
    mensajeSesion = 'Iniciando sesión...';
    
    const { error } = await supabase.auth.signInWithPassword({
      email: emailLogin,
      password: passwordLogin,
    });

    if (error) {
      mensajeSesion = 'Error: correo o contraseña incorrectos.';
    } else {
      mensajeSesion = '';
      usuarioAutenticado = true;
      window.location.reload(); 
    }
  }

  // NUEVO: Registrarse directamente desde la página
  async function registrarse(event: Event) {
    event.preventDefault();
    mensajeSesion = 'Registrando nuevo usuario...';

    const { error } = await supabase.auth.signUp({
      email: emailLogin,
      password: passwordLogin,
    });

    if (error) {
      mensajeSesion = 'Error al registrarse: ' + error.message;
    } else {
      mensajeSesion = '¡Registro exitoso! Ya puedes hacer clic en Entrar.';
    }
  }

  // FASE 2: Función de cierre de sesión
  async function cerrarSesion() {
    await supabase.auth.signOut();
    usuarioAutenticado = false;
    window.location.reload();
  }

  async function registrarSuscripcionCompleta(event: Event) {
    event.preventDefault();
    mensaje = '';
    errorMsg = '';

    try {
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

      // FASE 4: Limpiar el borrador cuando el registro es exitoso
      sessionStorage.removeItem(CLAVE_BORRADOR);

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

<section class="form-card">
  <!-- GESTIÓN DE SESIÓN Y REGISTRO -->
  {#if !usuarioAutenticado}
    <h2>Autenticación (Iniciar Sesión / Registrarse)</h2>
    {#if mensajeSesion}
      <p style="color: #f39c12; font-weight: bold; margin-bottom: 10px;">{mensajeSesion}</p>
    {/if}
    <form class="main-form" style="margin-bottom: 2rem; padding-bottom: 1rem; border-bottom: 1px solid #444;">
      <div class="form-group">
        <label for="email">Correo Electrónico</label>
        <input type="email" id="email" bind:value={emailLogin} required autocomplete="username" />
      </div>
      <div class="form-group">
        <label for="password">Contraseña</label>
        <input type="password" id="password" bind:value={passwordLogin} required autocomplete="current-password" />
      </div>
      
      <div style="display: flex; gap: 10px; margin-top: 10px;">
        <button type="submit" on:click={iniciarSesion} class="btn-submit">Entrar</button>
        <button type="button" on:click={registrarse} style="background: #2563eb; color: white; padding: 0.75rem 1.5rem; border: none; border-radius: 4px; cursor: pointer; font-weight: bold;">Registrarse</button>
      </div>
    </form>
  {:else}
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; padding-bottom: 1rem; border-bottom: 1px solid #444;">
      <span style="color: #2ecc71; font-weight: bold;">✅ Sesión iniciada</span>
      <button on:click={cerrarSesion} style="background: #e74c3c; color: white; border: none; padding: 5px 10px; border-radius: 4px; cursor: pointer;">Cerrar sesión</button>
    </div>
  {/if}

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
              on:input={guardarBorrador}
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
              on:input={guardarBorrador}
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

      <button type="submit" class="btn-submit" disabled={!usuarioAutenticado} style={!usuarioAutenticado ? 'opacity: 0.5; cursor: not-allowed;' : ''}>
          Registrar plan
      </button>
      {#if !usuarioAutenticado}
        <p class="field-help" style="color: #e74c3c;">Debe iniciar sesión para registrar datos.</p>
      {/if}
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