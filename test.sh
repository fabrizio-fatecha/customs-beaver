#!/bin/bash

# --- CONFIGURACIÓN ---
URL="http://localhost:3000/sync/download-db"
USER="4rancel!"
PASS="4rancel!"
OUTPUT_FILE="data_sync_test.json"

echo "------------------------------------------------"
echo "🚀 Iniciando prueba de descarga NCM..."
echo "------------------------------------------------"

# 1. Descarga los datos y mide el tiempo
echo "📥 Descargando datos desde NestJS..."
TIME_TAKEN=$(date +%s)

# Realiza la petición con Basic Auth
curl -s -u "$USER:$PASS" "$URL" -o "$OUTPUT_FILE"

END_TIME=$(date +%s)
ELAPSED=$((END_TIME - TIME_TAKEN))

# 2. Verificar si el archivo existe y no está vacío
if [ -s "$OUTPUT_FILE" ]; then
    echo "✅ Descarga completada en $ELAPSED segundos."
    
    # 3. Mostrar resumen de los datos usando 'jq' si está instalado (o python si no)
    echo "📊 Resumen de la información recibida:"
    
    if command -v jq &> /dev/null; then
        # Mostrar el conteo y los primeros 2 registros con JQ
        cat "$OUTPUT_FILE" | jq '{registros_recibidos: .count, fecha_servidor: .timestamp, primera_fila: .data[0]}'
    else
        # Alternativa con Python por si no tienes JQ instalado
        python3 -c "import json; f=open('$OUTPUT_FILE'); d=json.load(f); print(f'Registros: {d[\"count\"]}\nFecha: {d[\"timestamp\"]}\nPrimer Item: {d[\"data\"][0]}')"
    fi

    echo "------------------------------------------------"
    # 4. Borrar lo descargado
    echo "🗑️  Limpiando archivos temporales..."
    rm "$OUTPUT_FILE"
    echo "✨ Sistema limpio."
else
    echo "❌ Error: No se recibieron datos o las credenciales son incorrectas."
    rm -f "$OUTPUT_FILE"
fi

echo "------------------------------------------------"