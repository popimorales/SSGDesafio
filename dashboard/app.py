from flask import Flask, render_template, request, jsonify
import mysql.connector
from datetime import datetime
import os

app = Flask(__name__)

# --- Conexión a la DB ---
def get_connection():
    return mysql.connector.connect(
        user=os.environ.get('DB_USER', 'root'),
        password=os.environ.get('DB_PASSWORD', 'popi'),
        host=os.environ.get('DB_HOST', 'localhost'),
        database=os.environ.get('DB_NAME', 'Dashboard'),
        port=int(os.environ.get('DB_PORT', 3306))
    )

# --- Página principal ---
@app.route('/')
def index():
    return render_template('index.html')

# --- Endpoint para obtener usuarios (agentes) ---
@app.route('/usuarios')
def usuarios():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT id, nombre, apellido FROM users ORDER BY nombre, apellido")
        rows = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(rows)
    except Exception as e:
        print("Error en /usuarios:", e)
        return jsonify({"error": str(e)}), 500

# --- Endpoint para obtener campañas ---
@app.route('/campanias')
def campanias():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT id, nombre FROM campaigns ORDER BY nombre")
        rows = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(rows)
    except Exception as e:
        print("Error en /campanias:", e)
        return jsonify({"error": str(e)}), 500

# --- Endpoint para KPIs ---
@app.route('/reporte', methods=['POST'])
def generar_reporte():
    try:
        fecha_inicio = request.form.get('fecha_inicio')
        fecha_fin = request.form.get('fecha_fin')
        agente_id = request.form.get('agente_id')
        campania_id = request.form.get('campania_id')

        inicio = datetime.strptime(fecha_inicio, '%Y-%m-%d').strftime('%Y%m%d000000')
        fin    = datetime.strptime(fecha_fin, '%Y-%m-%d').strftime('%Y%m%d235959')

        query = """
        SELECT
            COUNT(CASE WHEN id_resultado = 16 THEN 1 END) / COUNT(*) * 100 AS penetracion_bruta,
            COUNT(CASE WHEN id_resultado IN (1 , 2, 7, 8, 9, 14, 15, 16) THEN 1 END) / COUNT(*) * 100 AS contactabilidad,
            COUNT(CASE WHEN id_resultado = 16 THEN 1 END) / COUNT(CASE WHEN id_resultado IN (1, 2, 4, 7, 8, 9, 14, 15, 16) THEN 1 END) * 100 AS penetracion_neta
        FROM gestiones 
        WHERE timestamp BETWEEN %s AND %s
        """
        params = [inicio, fin]

        if agente_id:
            query += " AND id_tipo = %s"
            params.append(agente_id)
        if campania_id:
            query += " AND id_campaign = %s"
            params.append(campania_id)

        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute(query, params)
        result = cursor.fetchone()
        cursor.close()
        conn.close()

        # Evitar None
        for k in result:
            if result[k] is None:
                result[k] = 0

        return jsonify(result)

    except Exception as e:
        print("Error en /reporte:", e)
        return jsonify({"error": str(e)}), 500

# --- Endpoint para distribución de resultados ---
@app.route('/distribucion', methods=['POST'])
def distribucion():
    try:
        fecha_inicio = request.form.get('fecha_inicio')
        fecha_fin = request.form.get('fecha_fin')
        agente_id = request.form.get('agente_id')
        campania_id = request.form.get('campania_id')

        inicio = datetime.strptime(fecha_inicio, '%Y-%m-%d').strftime('%Y%m%d000000')
        fin    = datetime.strptime(fecha_fin, '%Y-%m-%d').strftime('%Y%m%d235959')

        query = """
        SELECT gr.nombre AS resultado, COUNT(*) AS total
        FROM gestiones g
        LEFT JOIN gestiones_resultado gr ON g.id_resultado = gr.id
        WHERE g.timestamp BETWEEN %s AND %s
        """
        params = [inicio, fin]

        if agente_id:
            query += " AND g.id_tipo = %s"
            params.append(agente_id)
        if campania_id:
            query += " AND g.id_campaign = %s"
            params.append(campania_id)

        query += " GROUP BY gr.nombre"

        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute(query, params)
        rows = cursor.fetchall()
        cursor.close()
        conn.close()

        return jsonify(rows)

    except Exception as e:
        print("Error en /distribucion:", e)
        return jsonify({"error": str(e)}), 500

# --- Endpoint cantidad de agentes activos ---
@app.route('/cantAct')
def cant_activos():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT COUNT(*) AS cant FROM users WHERE id_estado = 1")
        cant = cursor.fetchone()
        cursor.close()
        conn.close()
        return jsonify(cant)
    except Exception as e:
        print("Error en /cantAct:", e)
        return jsonify({"error": str(e)}), 500

# --- Endpoint listar agentes activos ---
@app.route('/agentesAct')
def agentes_activos():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT CONCAT(users.nombre, ' ', users.apellido) AS nombre,
                users_estados.nombre AS estado
            FROM users
            INNER JOIN users_estados ON users.id_estado = users_estados.id
            WHERE users.id_estado = 1
            ORDER BY nombre
        """)
        rows = cursor.fetchall()
        cursor.close()
        conn.close()
        return jsonify(rows)
    except Exception as e:
        print("Error en /agentesAct:", e)
        return jsonify({"error": str(e)}), 500

# --- Endpoint listar snapshots ---
@app.route('/listar_snapshots')
def listar_snapshots():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT 
                snapshots.fecha_creacion, 
                snapshots.fec_intervalo, 
                IFNULL(users.nombre, 'Todos') AS nom_agente, 
                IFNULL(campaigns.nombre, 'Todas') AS nom_campania, 
                snapshots.contactabilidad, 
                snapshots.penetracion_bruta, 
                snapshots.penetracion_neta
            FROM snapshots
            LEFT OUTER JOIN users ON snapshots.id_broker = users.id
            LEFT OUTER JOIN campaigns ON snapshots.id_campaign = campaigns.id
            ORDER BY snapshots.fecha_creacion DESC
            LIMIT 20;
        """)
        rows = cursor.fetchall()
        cursor.close()
        conn.close()

        # Evitar None en métricas
        for r in rows:
            for k in r:
                if r[k] is None:
                    r[k] = 0

        return jsonify(rows)
    except Exception as e:
        print("Error en /listar_snapshots:", e)
        return jsonify({"error": str(e)}), 500

# --- Endpoint guardar snapshot ---
@app.route('/guardar_snapshot', methods=['POST'])
def guardar_snapshot():
    try:
        fecha_inicio = request.form.get('fecha_inicio', '')
        fecha_fin = request.form.get('fecha_fin', '')

        fec_intervalo = ''
        if fecha_inicio and fecha_fin:
            fec_intervalo = datetime.strptime(fecha_inicio, '%Y-%m-%d').strftime('%d/%m/%Y') + ' - ' + \
                            datetime.strptime(fecha_fin, '%Y-%m-%d').strftime('%d/%m/%Y')

        id_broker = request.form.get('id_broker') or None
        id_campaign = request.form.get('id_campaign') or None

        contactabilidad = float(request.form.get('contactabilidad', 0))
        penetracion_bruta = float(request.form.get('penetracion_bruta', 0))
        penetracion_neta = float(request.form.get('penetracion_neta', 0))

        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO snapshots (fecha_creacion, fec_intervalo, id_broker, id_campaign, contactabilidad, penetracion_bruta, penetracion_neta)
            VALUES (NOW(), %s, %s, %s, %s, %s, %s)
        """, (fec_intervalo, id_broker, id_campaign, contactabilidad, penetracion_bruta, penetracion_neta))
        conn.commit()
        cursor.close()
        conn.close()

        return jsonify({"success": True})
    except Exception as e:
        print("Error en /guardar_snapshot:", e)
        return jsonify({"error": str(e)}), 500

# --- Main ---
if __name__ == '__main__':
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port, debug=True)
