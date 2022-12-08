#!/bin/bash

: '
@file oauth.sh
@author Leon Wang
@date Fall 2022

Single-purpose script to generate an access token for
Spotify user data via client credentials flow.
'

client_id="8fc022f1733c4462898f676b94563e72"
client_secret="fa2d9f4caa764de996543dbe885942e5"
code=$(echo -n "$client_id:$client_secret" | base64)
token=$(curl -s -X "POST" -H "Authorization: Basic $code" -d grant_type=client_credentials https://accounts.spotify.com/api/token | awk -F"\"" '{print $4}')
echo -n $token
