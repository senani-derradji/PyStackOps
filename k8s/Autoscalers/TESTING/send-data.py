import requests

data = {
    "username": "testuser",
    "password": "testpass"
}

while True:
    try:
        response = requests.post("http://*****/login", json=data)
        print(f"Attempt {i+1}: Status Code:", response.status_code)
    except Exception as e:
        print(f"Attempt {i+1}: Failed to connect. Error:", e)