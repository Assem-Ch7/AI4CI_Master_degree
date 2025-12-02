import ssl
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs

BALANCES = {
    "alice": 1000,
    "bob": 150
}

def get_amount_for_user(user:str) -> int:
    return BALANCES[user]

class RequestHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        parsed_url = urlparse(self.path)
        path = parsed_url.path
        query_params = parse_qs(parsed_url.query)
        if path == "/payment":
            amount = query_params.get('amount', ['0'])[0]
            try:
                amount = int(amount)
                
                if amount <= 0:
                    raise ValueError("Amount must be positive")

                cert = self.connection.getpeercert()
                print("DEBUG CERT:", cert)

                user,is_authorized = "",False 

                if cert:  # Only if a client certificate is present
                    subject = dict(x[0] for x in cert['subject'])
                    user = subject.get('commonName', '')
                    is_authorized = user in BALANCES

                if not is_authorized:
                    self.send_response(400)
                    self.end_headers()
                    self.wfile.write("You are not authorized".encode())
                else:
                    account_amount = get_amount_for_user(user)
                    if amount > account_amount:
                        self.send_response(400)
                        self.end_headers()
                        self.wfile.write("You do not have enough funds in your account".encode())
                    else:
                        BALANCES[user] -= amount
                        self.send_response(200)
                        self.end_headers()
                        self.wfile.write(f"Payment successful. New balance: {BALANCES[user]}".encode())

            except Exception as e:
                print(e)
                self.send_response(400)
                self.end_headers()
                self.wfile.write(f"Error processing request: {e}".encode())


def run_server():
    server_address = ('localhost', 8080)
    httpd = HTTPServer(server_address, RequestHandler)

    context = ssl.create_default_context(ssl.Purpose.CLIENT_AUTH)
    # Ensure these paths point to valid files on your disk
    context.load_cert_chain(certfile="./certs/server-cert.pem", keyfile="./certs/server-key.pem", password="your_passphrase")
    context.load_verify_locations(cafile="./certs/ca-cert.pem")
    context.verify_mode = ssl.CERT_REQUIRED

    httpd.socket = context.wrap_socket(httpd.socket, server_side=True)

    print("Server running on https://localhost:8080")
    httpd.serve_forever()


if __name__ == "__main__":
    run_server()
