import time
import os
import serial
from flask import Flask, jsonify
from flask_cors import CORS  # Permitir acesso de outras origens (Flutter)

# Impede que o Flask reinicie automaticamente e abra a porta duas vezes
os.environ["FLASK_RUN_FROM_CLI"] = "false"

app = Flask(__name__)
CORS(app)  # Permitir acesso de outros domínios

# Configurar porta serial
SERIAL_PORT = "COM10"  # Verifica se esta é a porta correta
BAUD_RATE = 115200

ser = None  # Inicializa a variável

def abrir_serial():
    global ser
    if ser is None or not ser.is_open:
        try:
            ser = serial.Serial(SERIAL_PORT, BAUD_RATE, timeout=1)
            print(f"✅ Porta serial {SERIAL_PORT} aberta com sucesso!")
        except serial.SerialException as e:
            print(f"❌ Erro ao abrir a porta serial: {e}")
            ser = None

# Chama a função para abrir a porta serial apenas uma vez
abrir_serial()

@app.route("/location", methods=["GET"])  # Garante que a rota é "/location"
def get_gps_data():
    if ser is None:
        return jsonify({"error": "Porta serial não aberta"}), 500

    try:
        tentativas = 5
        data = ""

        # Continuar lendo até obter dados GPS válidos
        while True:
            data = ser.readline().decode("utf-8").strip()

            # Ignorar mensagens de inicialização ou configuração
            if any(keyword in data for keyword in ["rst:", "boot:", "configsip:", "clk_drv:", "mode:", "clock", "load:", "entry"]):
                continue  # Ignora e tenta ler novamente

            # Se encontrar dados válidos, quebra o loop
            if data and ',' in data:  # Garantir que os dados têm vírgula (formato de GPS)
                break

        if not data:
            return jsonify({"error": "Nenhum dado GPS válido encontrado"}), 500

        latitude, longitude = data.split(",")

        # Tenta converter latitude e longitude para float, e verifica se não falhou
        try:
            latitude = float(latitude)
            longitude = float(longitude)
        except ValueError:
            return jsonify({"error": f"Dados inválidos: {data}"}), 500

        return jsonify({"latitude": latitude, "longitude": longitude})

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    from waitress import serve  # Usar um servidor de produção estável
    print("🚀 Servidor iniciado em http://127.0.0.1:5000/location")
    serve(app, host="0.0.0.0", port=5000)
