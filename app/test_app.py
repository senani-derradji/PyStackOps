import requests

def test_home():
    try:
        res = requests.get("http://localhost:80/")
        assert res.status_code == 200
        print("✅ Home Page is OK")
    except Exception as e:
        print("❌ Failed to reach Home Page:", e)
        assert False

def test_login():
    try:
        res = requests.post("http://localhost:80/login", data={"username": "test", "password": "test"})
        assert res.status_code in (200, 302)
        print("✅ Login is OK")
    except Exception as e:
        print("❌ Login failed:", e)
        assert False
