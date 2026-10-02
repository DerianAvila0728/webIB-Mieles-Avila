<section class="form-card" aria-labelledby="titulo-nuevo">
    <h2 id="titulo-nuevo">Nuevo plan o rutina</h2>

    <form action="#" method="post" class="main-form">

        <div class="form-group">
            <label for="rutina">
                Rutina / Plan
                <span aria-hidden="true">*</span>
            </label>

            <input
                type="text"
                id="rutina"
                name="rutina"
                required
                autocomplete="off"
                aria-describedby="rutina-ayuda"
            />

            <p id="rutina-ayuda" class="field-help">
                Campo obligatorio.
            </p>
        </div>


        <div class="form-group">
            <label for="cliente">
                Cliente
                <span aria-hidden="true">*</span>
            </label>

            <input
                type="text"
                id="cliente"
                name="cliente"
                required
                autocomplete="name"
            />
        </div>


        <div class="form-group">
            <label for="estado">
                Estado
            </label>

            <select id="estado" name="estado">
                <option value="pendiente">Pendiente</option>
                <option value="progreso">En progreso</option>
                <option value="completado">Completado</option>
            </select>
        </div>


        <div class="form-group">
            <label for="nivel">
                Nivel
            </label>

            <select id="nivel" name="nivel">
                <option value="principiante">Principiante</option>
                <option value="intermedio">Intermedio</option>
                <option value="avanzado">Avanzado</option>
            </select>
        </div>


        <button type="submit" class="btn-submit">
            Registrar plan
        </button>

    </form>
</section>