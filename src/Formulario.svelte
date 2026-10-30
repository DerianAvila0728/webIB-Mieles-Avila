<script lang="ts">
  import { supabase } from './lib/supabase';

  let rutina = '';
  let clienteNombre = '';
  let estadoSeleccionado = 'Pendiente';
  let nivelSeleccionado = 'Intermedio';
  let mensaje = '';
  let errorMsg = '';

  async function registrarSuscripcion(event: Event) {
    event.preventDefault();
    mensaje = '';
    errorMsg = '';

    try {
      // 1. Primero insertamos o buscamos al usuario ingresado en el formulario
      const { data: usuarioData, error: userError } = await supabase
        .from('usuarios')
        .insert([{ nombre: clienteNombre, rol: 'cliente' }])
        .select()
        .single();

      if (userError) {
        throw new Error('Error al registrar el usuario: ' + userError.message);
      }

      // 2. Insertamos la suscripción vinculada a ese nuevo usuario
      const { error: suscripcionError } = await supabase
        .from('suscripciones')
        .insert([
          {
            usuario_id: usuarioData.id,
            plan_id: 1, // Plan por defecto (puedes ajustarlo si prefieres otro)
            estado: estadoSeleccionado,
            fin: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0]
          }
        ]);

      if (suscripcionError) {
        throw new Error('Error al registrar la suscripción: ' + suscripcionError.message);
      }

      mensaje = '¡Suscripción y cliente registrados con éxito!';
      rutina = '';
      clienteNombre = '';
      
      // Recargar la página para ver el cambio reflejado en el listado
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

    <form on:submit={registrarSuscripcion} class="main-form">
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
                placeholder="Ej. Pecho, Pierna..."
            />
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
                placeholder="Ej. Juanito"
            />
        </div>

        <div class="form-group">
            <label for="estado">Estado</label>
            <select id="estado" bind:value={estadoSeleccionado}>
                <option value="Pendiente">Pendiente</option>
                <option value="Activa">Activa</option>
                <option value="Vencida">Vencida</option>
            </select>
        </div>

        <div class="form-group">
            <label for="nivel">Nivel</label>
            <select id="nivel" bind:value={nivelSeleccionado}>
                <option value="Principiante">Principiante</option>
                <option value="Intermedio">Intermedio</option>
                <option value="Avanzado">Avanzado</option>
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