import socket

ESP32_IP = "192.168.4.1"  # O ESP32 que atua como AP tem este IP padrão
PORT = 5000

client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client.connect((ESP32_IP, PORT))

data = client.recv(1024).decode()
print("Localização recebida:", data)

client.close()
