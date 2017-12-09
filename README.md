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

# Acknowledgements
From the [actor TCPConnection](https://github.com/ponylang/ponyc/blob/master/packages/net/tcp_connection.pony) documentation in the [ponyc](https://github.com/ponylang/ponyc) repo.
