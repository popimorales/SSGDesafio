document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");
    const fechaInicioInput = form.querySelector("input[name='fecha_inicio']");
    const fechaFinInput = form.querySelector("input[name='fecha_fin']");
    const agenteSelect = form.querySelector("select[name='agente_id']");
    const campaniaSelect = form.querySelector("select[name='campania_id']");

    const hoy = new Date();
    const haceUnMes = new Date();
    haceUnMes.setMonth(hoy.getMonth() - 1);

    const formatoFecha = (d) => d.toISOString().slice(0, 10);
    fechaInicioInput.value = formatoFecha(haceUnMes);
    fechaFinInput.value = formatoFecha(hoy);

    const ctxDistribucion = document.getElementById("chartDistribucion")?.getContext("2d");
    let chartDistribucion;

    // --- Cargar dashboard ---
    async function cargarDashboard(fechaInicio, fechaFin, agenteId = "", campaniaId = "") {
        const formData = new FormData();
        formData.append("fecha_inicio", fechaInicio);
        formData.append("fecha_fin", fechaFin);
        formData.append("agente_id", agenteId);
        formData.append("campania_id", campaniaId);

        try {
            const response = await fetch("/reporte", { method: "POST", body: formData });
            const data = await response.json();
            if (!data.error) {
                document.getElementById("res-pb").textContent = parseFloat(data.penetracion_bruta).toFixed(2) + "%";
                document.getElementById("res-cn").textContent = parseFloat(data.contactabilidad).toFixed(2) + "%";
                document.getElementById("res-pn").textContent = parseFloat(data.penetracion_neta).toFixed(2) + "%";
            }

            actualizarSnapshots();
            actualizarDistribucion(formData);
            cargarAgentesActivos();

        } catch (err) {
            console.error("Error al cargar dashboard:", err);
        }
    }

    cargarDashboard(formatoFecha(haceUnMes), formatoFecha(hoy));

    form.addEventListener("submit", (e) => {
        e.preventDefault();
        cargarDashboard(fechaInicioInput.value, fechaFinInput.value, agenteSelect.value, campaniaSelect.value);
    });

    // --- Cargar selects ---
    async function cargarAgentes() {
        try {
            const res = await fetch("/usuarios");
            const usuarios = await res.json();
            agenteSelect.innerHTML = "<option value=''>Todos</option>";
            usuarios.forEach(u => {
                const opt = document.createElement("option");
                opt.value = u.id;
                opt.textContent = `${u.nombre} ${u.apellido}`;
                agenteSelect.appendChild(opt);
            });
        } catch (err) { console.error(err); }
    }
    cargarAgentes();

    async function cargarCampanias() {
        try {
            const res = await fetch("/campanias");
            const campanias = await res.json();
            campaniaSelect.innerHTML = "<option value=''>Todas</option>";
            campanias.forEach(c => {
                const opt = document.createElement("option");
                opt.value = c.id;
                opt.textContent = c.nombre;
                campaniaSelect.appendChild(opt);
            });
        } catch (err) { console.error(err); }
    }
    cargarCampanias();

    // --- Guardar snapshot ---
    const btnGuardar = document.getElementById("guardarSnapshot");
    btnGuardar.addEventListener("click", async () => {
        const payload = new FormData();
        payload.append("fecha_inicio", fechaInicioInput.value);
        payload.append("fecha_fin", fechaFinInput.value);
        payload.append("id_broker", agenteSelect.value);      // <- coincide con Python
        payload.append("id_campaign", campaniaSelect.value);  // <- coincide con Python
        payload.append("contactabilidad", parseFloat(document.getElementById("res-cn").textContent));
        payload.append("penetracion_bruta", parseFloat(document.getElementById("res-pb").textContent));
        payload.append("penetracion_neta", parseFloat(document.getElementById("res-pn").textContent));

        try {
            const res = await fetch("/guardar_snapshot", { method: "POST", body: payload });
            const data = await res.json();
            if (data.error) {
                console.error("Error guardando snapshot:", data.error);
                var modalError = new bootstrap.Modal(document.getElementById('modal-error'));
                modalError.show();
                return;
            }
            var modalGuardado = new bootstrap.Modal(document.getElementById('modal-guardado'));
            modalGuardado.show();
            actualizarSnapshots();
        } catch (err) {
            var modalError = new bootstrap.Modal(document.getElementById('modal-error'));
            modalError.show();
        }
    });

    // --- Actualizar snapshots ---
    async function actualizarSnapshots() {
        try {
            const res = await fetch("/listar_snapshots");
            const snapshots = await res.json();
            const tbody = document.querySelector("#snapshots tbody");
            tbody.innerHTML = "";

            snapshots.forEach(s => {
                const tr = document.createElement("tr");
                tr.innerHTML = `
                    <td>${s.fecha_creacion}</td>
                    <td>${s.fec_intervalo}</td>
                    <td>${s.nom_agente}</td>
                    <td>${s.nom_campania}</td>
                    <td>${parseFloat(s.contactabilidad).toFixed(2)}%</td>
                    <td>${parseFloat(s.penetracion_bruta).toFixed(2)}%</td>
                    <td>${parseFloat(s.penetracion_neta).toFixed(2)}%</td>
                `;
                tbody.appendChild(tr);
            });
        } catch (err) { console.error(err); }
    }

    // --- Actualizar gráfico ---
    async function actualizarDistribucion(formData) {
        try {
            const res = await fetch("/distribucion", { method: "POST", body: formData });
            const distribucion = await res.json();
            if (!distribucion) return;

            const labels = distribucion.map(d => d.resultado);
            const dataValues = distribucion.map(d => d.total);
            const colors = ["#4e79a7","#f28e2b","#e15759","#76b7b2","#59a14f","#edc948","#b07aa1","#ff9da7"];

            if (chartDistribucion) chartDistribucion.destroy();

            chartDistribucion = new Chart(ctxDistribucion, {
                type: "bar",
                data: { labels, datasets:[{ label: "Cantidad de gestiones", data: dataValues, backgroundColor: colors.slice(0, labels.length) }] },
                options: {
                    responsive:true,
                    plugins: { legend:{display:false}, tooltip:{mode:'index', intersect:false} },
                    scales: { y:{beginAtZero:true, title:{display:true,text:'Cantidad'}}, x:{title:{display:true,text:'Resultado'}} }
                }
            });
        } catch (err) { console.error(err); }
    }

    // --- Agentes activos ---
    async function cargarAgentesActivos() {
        try {
            // Cantidad
            const resCant = await fetch("/cantAct");
            const cant = await resCant.json();
            document.getElementById("cant-activos").textContent = cant.cant;

            // Tabla
            const resAgentes = await fetch("/agentesAct");
            const agentes = await resAgentes.json();
            const tbody = document.getElementById("lista-agentes");
            tbody.innerHTML = "";
            agentes.forEach(a => {
                const tr = document.createElement("tr");
                tr.innerHTML = `<td>${a.nombre}</td><td>${a.estado}</td>`;
                tbody.appendChild(tr);
            });
        } catch (err) { console.error("Error cargando agentes activos:", err); }
    }

    // --- Inicializar ---
    actualizarSnapshots();
    cargarAgentesActivos();
});
