import requests

BASE_URL = "http://localhost:5000"  # Or http://127.0.0.1:5000

def test_register():
    print("🔧 Testing registration...")
    r = requests.post(f"{BASE_URL}/register", data={
        "username": "ci_user",
        "password": "ci_pass"
    })
    assert r.status_code in [200, 302], f"Registration failed: {r.status_code}"
    print("✅ Register OK")

def test_login():
    print("🔧 Testing login...")
    r = requests.post(f"{BASE_URL}/login", data={
        "username": "ci_user",
        "password": "ci_pass"
    }, allow_redirects=True)
    assert r.status_code == 200, f"Login failed: {r.status_code}"
    assert "Welcome" in r.text or "Logout" in r.text, "Login did not redirect properly"
    print("✅ Login OK")

if __name__ == "__main__":
    test_register()
    test_login()