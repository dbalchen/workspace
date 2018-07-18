#!/usr/bin/env bash


file=$1

echo "Pushing $file"
scp $file prdwrk2@10.176.177.178:~/eps/monitors/$file
scp $file prdwrk3@10.176.177.179:~/eps/monitors/$file
scp $file prdtc1@10.176.181.116:~/eps/monitors/$file
scp $file prdtc2@10.176.181.117:~/eps/monitors/$file
scp $file prdtc3@10.176.181.118:~/eps/monitors/$file
scp $file prdtc4@10.176.181.119:~/eps/monitors/$file
scp $file prdtc5@10.176.181.120:~/eps/monitors/$file
scp $file prdtc6@10.176.181.121:~/eps/monitors/$file
