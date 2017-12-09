# SSL+Tcp echo client written in Pony

A [Pony](https://ponylang.org) SSL client that sends a
text message to a server over a TCP connection and
expects the server to echo the data back.

# Compile
To run on Arch Linux you need the openssl 1.1
[patches](https://github.com/winksaville/ponyc/tree/test-openss1.1)
```
$ cd tcp_echo_client
$ ponyc -DOPENSSL_API_COMPAT_1_1_0 ../pony-ssl_tcp_echo_client/
```
# Run
Start server in one terminal window:
```
wink@wink-envy:~/prgs/ponylang/pony-ssl_tcp_echo_client (master)
$ ../../c-ssl_server/ssl_server 8989

```
In another terminal window run the client:
```
wink@wink-envy:~/prgs/ponylang/pony-ssl_tcp_echo_client (master)
$ ./pony-ssl_tcp_echo_client 
GOT:hello world
```

# Ciphers.sh
Executing `ciphers.sh` will list the enabled ciphers for a server
```
$ ./ciphers.sh 127.0.0.1 8989
tls1_2 ECDHE-RSA-AES256-GCM-SHA384: 	OK
tls1_2 ECDHE-RSA-CHACHA20-POLY1305: 	OK
tls1_2 ECDHE-RSA-AES128-GCM-SHA256: 	OK
tls1_2 ECDHE-RSA-AES256-SHA384: 	OK
tls1_2 ECDHE-RSA-AES128-SHA256: 	OK
```

# Acknowledgements
From the [actor TCPConnection](https://github.com/ponylang/ponyc/blob/master/packages/net/tcp_connection.pony) documentation in the [ponyc](https://github.com/ponylang/ponyc) repo.
ciphers.sh is based on [Using openSSL to determine which Ciphers are Enabled on a Server](https://securityevaluators.com/knowledge/blog/20151102-openssl_and_ciphers/) from [securityevaluators.com](https://securityevaluators.com/)
