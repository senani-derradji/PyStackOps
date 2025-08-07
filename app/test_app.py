import requests

def test_home():
    response = requests.get("http://localhost:5000/")
    assert response.status_code == 200, f"❌ ERROR: got {response.status_code}"
    print("✅ OK - Homepage works")

def test_register():
    response = requests.post("http://localhost:5000/register", data={"username": "u", "password": "p"})
    assert response.status_code == 200, f"❌ ERROR: got {response.status_code}"
    print("✅ OK - Register works")

def test_login():
    response = requests.post("http://localhost:5000/login", data={"username": "u", "password": "p"})
    assert response.status_code == 200, f"❌ ERROR: got {response.status_code}"
    print("✅ OK - Login works")

test_home()
test_register()
test_login()