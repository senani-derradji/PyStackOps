import pytest
from flask import session
from app import app as flask_app

# THIS IS JUST A SIMPLE TEST FILE FOR A FLASK APPLICATION

@pytest.fixture
def client():
    flask_app.config["TESTING"] = True
    flask_app.config["SECRET_KEY"] = "testsecret"
    with flask_app.test_client() as client:
        yield client

def test_register_get(client):
    response = client.get("/register")
    assert response.status_code == 200
    assert b"Register" in response.data or b"register" in response.data

def test_login_get(client):
    response = client.get("/login")
    assert response.status_code == 200
    assert b"Login" in response.data or b"login" in response.data

def test_home_redirect_if_not_logged_in(client):
    response = client.get("/", follow_redirects=True)
    assert b"login" in response.data or b"Login" in response.data
