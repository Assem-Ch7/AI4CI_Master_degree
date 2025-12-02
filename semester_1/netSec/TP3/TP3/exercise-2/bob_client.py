import requests
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

def bob_payment(amount):
    url = f"https://localhost:8080/payment?amount={amount}"
    try:
        response = requests.post(
            url,
            cert=("./certs/bob-cert.pem", "./certs/bob-key.pem"),
            verify="./certs/ca-cert.pem"
        )
        print(f"Bob - Status: {response.status_code}")
        print(f"Bob - Response: {response.text}")
    except Exception as e:
        print(f"Bob - Error: {e}")

if __name__ == "__main__":
    bob_payment(100)
    bob_payment(100)  # Should fail due to insufficient funds after first payment
