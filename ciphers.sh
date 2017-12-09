#!/bin/bash
# parameter 1 is ip address
# parameter 2 is port
for v in ssl2 ssl3 tls1 tls1_1 tls1_2; do
  for c in $(openssl ciphers 'ALL:eNULL' | tr ':' ' '); do
      #printf "$v $c:"
      openssl s_client -connect $1:$2 \
          -cipher $c -$v < /dev/null > /dev/null 2>&1 && printf "$v $c: \tOK\n"
      #printf "\n"
  done
done

