import requests
import urllib3

urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

def alice_payment(amount):
    url = f"https://localhost:8080/payment?amount={amount}"
    try:
        response = requests.post(
            url,
            cert=("./certs/alice-cert.pem", "./certs/alice-key.pem"),
            verify="./certs/ca-cert.pem"
        )
        print(f"Alice - Status: {response.status_code}")
        print(f"Alice - Response: {response.text}")
    except Exception as e:
        print(f"Alice - Error: {e}")

if __name__ == "__main__":
    alice_payment(500)
    alice_payment(600)  # Should fail due to insufficient funds
