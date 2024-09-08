# NEEDED FOR CERTIFICATE GEN

# openssl x509 -inform DER -outform PEM -in AppleIncRootCertificate.cer -out root.crt.pem
# openssl x509 -inform DER -outform PEM -in AppleWWDRCA.cer -out Intermediate.crt.pem
# openssl smime -sign -in apple.mobileconfig -out SignedVerifyExample.mobileconfig -signer fuck.pem -certfile root.crt.pem -outform der -nodetach      

# Create the CA Key and Certificate for signing Client Certs
# openssl genrsa -des3 -out ca.key 2048
# openssl req -new -x509 -days 365 -key ca.key -out ca.crt

# Create the Server Key, CSR, and Certificate
# openssl genrsa -des3 -out server.key 1024
# openssl req -new -key server.key -out server.csr

# We're self signing our own server cert here.  This is a no-no in production.
# openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt

# Verify Server Certificate
# openssl verify -purpose sslserver -CAfile ca.crt server.crt

# Using the server certificate and key, we convert them into .pem for later use.
openssl x509 -in server.crt -out signingCert.pem -outform PEM
openssl rsa -in server.key -text > signingKey.pem

# Now we sign, all passwords are llll.
# openssl smime -sign -in apple.mobileconfig -out signed.mobileconfig -signer server.crt -inkey server.key -certfile ca.crt -outform der -nodetach
