#!/usr/bin/env bash

#API linked contributors
cat api* | grep "\"login\"" >> aplogin0
cat aplogin0 | cut -c 15- > aplogin1
sed -i 's/\",//' aplogin1
awk '$0="https://github.com/"$0' aplogin1 > aplogin2

#API anonymous contributors
cat api* | grep "noreply.github" >> apnoreply0
cat apnoreply0 | cut -c 15- > apnoreply1
sed -i 's/@users.noreply.github.com\",//' apnoreply1
sed -i 's/*+//' apnoreply1
sed -i 's/^[^+]*+//' apnoreply1
awk '$0="https://github.com/"$0' apnoreply1 > apnoreply2


#Output results
cat aplogin2 apnoreply2 > apoutput
