## Overview
An SSL/TLS certificate is a digital object that allows systems to verify the identity & subsequently establish an encrypted network connection to another system using the Secure Sockets Layer/Transport Layer Security (SSL/TLS) protocol. Certificates are used within a cryptographic system known as a public key infrastructure (PKI). PKI provides a way for one party to establish the identity of another party using certificates if they both trust a third-party - known as a certificate authority. SSL/TLS certificates thus act as digital identity cards to secure network communications, establish the identity of websites over the Internet as well as resources on private networks.
### Secure Sockets Layer (SSL)
SSL, or Secure Sockets Layer, is an encryption-based Internet security protocol. It was first developed by Netscape in 1995 for the purpose of ensuring privacy, authentication, and data integrity in Internet communications. SSL is the predecessor to the modern TLS encryption used today.

![HTTP vs HTTPS using SSL](https://www.cloudflare.com/img/learning/security/glossary/what-is-ssl/http-vs-https.svg)

- In order to provide a high degree of privacy, SSL encrypts data that is transmitted across the web. This means that anyone who tries to intercept this data will only see a garbled mix of characters that is nearly impossible to decrypt.
- SSL initiates an authentication process called a handshake between two communicating devices to ensure that both devices are really who they claim to be.
- SSL also digitally signs data in order to provide data integrity, verifying that the data is not tampered with before reaching its intended recipient.

There have been several iterations of SSL, each more secure than the last. In 1999 SSL was updated to become TLS.

### Transport Layer Security (TLS)
TLS was proposed by the Internet Engineering Task Force (IETF), an international standards organization, and the first version of the protocol was published in 1999. The most recent version is TLS 1.3, which was published in 2018.

TLS evolved from a previous encryption protocol called Secure Sockets Layer (SSL), which was developed by Netscape. TLS version 1.0 actually began development as SSL version 3.1, but the name of the protocol was changed before publication in order to indicate that it was no longer associated with Netscape. Because of this history, the terms TLS and SSL are sometimes used interchangeably.
![Evolution of SSL/TLS](https://www.cloudflare.com/resources/images/slt3lc6tev37/6LJWu0HvkaTE5wM0bhULyI/b2415217ca87e38cc222b8ea288ad71d/tls_ssl_development_timeline.png)

A TLS connection is initiated using a sequence known as the TLS handshake. When a user navigates to a website that uses TLS, the TLS handshake begins between the user's device (also known as the client device) and the web server.

During the TLS handshake, the user's device and the web server:

- Specify which version of TLS (TLS 1.0, 1.2, 1.3, etc.) they will use
- Decide on which cipher suites (see below) they will use
-  Authenticate the identity of the server using the server's TLS certificate
-  Generate session keys for encrypting messages between them after the handshake is complete

The TLS handshake establishes a cipher suite for each communication session. The cipher suite is a set of algorithms that specifies details such as which shared encryption keys, or session keys, will be used for that particular session. TLS is able to set the matching session keys over an unencrypted channel thanks to a technology known as public key cryptography.

The handshake also handles authentication, which usually consists of the server proving its identity to the client. This is done using public keys. Public keys are encryption keys that use one-way encryption, meaning that anyone with the public key can unscramble the data encrypted with the server's private key to ensure its authenticity, but only the original sender can encrypt data with the private key. The server's public key is part of its TLS certificate.

Once data is encrypted and authenticated, it is then signed with a message authentication code (MAC). The recipient can then verify the MAC to ensure the integrity of the data. This is kind of like the tamper-proof foil found on a bottle of aspirin; the consumer knows no one has tampered with their medicine because the foil is intact when they purchase it.

![TLS handshake](https://cf-assets.www.cloudflare.com/slt3lc6tev37/3wZIhjRIjfVSmCbVqkBKzb/4a7aa34324108c725dc25fc9e7c4ea4a/tls-ssl-handshake.png)

## References
- [What is an SSL/TLS Certificate?](https://aws.amazon.com/what-is/ssl-certificate/)
- [What is TLS (Transport Layer Security)?](https://www.cloudflare.com/learning/ssl/transport-layer-security-tls/)
[- What happens in a TLS handshake? | SSL handshake](https://www.cloudflare.com/learning/ssl/what-happens-in-a-tls-handshake/)

## Documentation
-  [RFC 5246 (TLS 1.2)](https://datatracker.ietf.org/doc/html/rfc5246)
- [RFC 8446 (TLS 1.3)](https://datatracker.ietf.org/doc/html/rfc8446)