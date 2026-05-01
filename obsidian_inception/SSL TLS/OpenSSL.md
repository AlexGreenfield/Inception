## Overview
OpenSSL is an open-source software, implementing a commercial-grade toolkit which offers a wide range of cryptographic functions using plaintext keys. It is used as a fundamental building block by a variety of applications dealing with general-purpose cryptography and secure communication.

OpenSSL is one of the most important, complete, and trusted collections of algorithms for cryptographic processing. It implements the TLS protocol used in particular by HTTPS. 
## Commands
### [`openssl-req`](https://docs.openssl.org/master/man1/openssl-req/)
PKCS#10 certificate request and certificate generating command. This command primarily creates and processes certificate requests (CSRs) in PKCS#10 format. It can additionally create self-signed certificates for use as root CAs for example.
#### Options
- `-in filename`: This specifies the input filename to read a request from. This defaults to standard input unless -x509 or -CA is specified. A request is only read if the creation options (-new or -newkey or -precert) are not specified
- `-x509`: This option outputs a certificate instead of a certificate request. This is typically used to generate test certificates. It is implied by the -CA option. This option implies the -new flag if -in is not given. If an existing request is specified with the -in option, it is converted to a certificate; otherwise a request is created from scratch. Unless specified using the -set_serial option, a large random number will be used for the serial number. Unless the -copy_extensions option is used, X.509 extensions are not copied from any provided request input file. X.509 extensions to be added can be specified in the configuration file, possibly using the -config and -extensions options, and/or using the -addext option. Unless -x509v1 is given, generated certificates bear X.509 version 3 even if no extensions are added. 


## References
- [What is OpenSSL](https://www.ibm.com/docs/en/linux-on-systems?topic=linuxone-openssl-introduction)
## Documentation
- [OpenSSL Documentation](https://docs.openssl.org/master/)
