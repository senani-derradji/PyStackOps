import requests

BASE_URL = "http://localhost:5000"

def test_register():
    r = requests.get(f"{BASE_URL}/register")
    print("Register GET:", r.status_code, r.text[:100])

    r = requests.post(f"{BASE_URL}/register", data={
        "username": "testuser",
        "password": "testpass"
    })
    print("Register POST:", r.status_code, r.text[:100])


def test_login():
    r = requests.get(f"{BASE_URL}/login")
    print("Login GET:", r.status_code, r.text[:100])

    r = requests.post(f"{BASE_URL}/login", data={
        "username": "testuser",
        "password": "testpass"
    })
    print("Login POST:", r.status_code, r.text[:100])


if __name__ == "__main__":
    test_register()
    test_login()
