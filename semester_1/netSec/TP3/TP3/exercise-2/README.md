# Exercise 2

For this exercise you will have to update the server and implement two clients.

## Update the server

`server.py` contains some boilerplate code for a simple server listening at port 8080. The server has no authentication and runs on http. Your job here is to update the server so that: 

- HTTPs with mTLS is enabled
- The `/payment?amount=<number>` endpoint recognizes the client based on the certificate

## Implement clients

You will have to implement two clients:

- `alice_client.py`: this represents the alice client connecting to the server
- `bob_client.py`: this represents the bob client connecting to the server

Both clients connect to the server using mTLS. 