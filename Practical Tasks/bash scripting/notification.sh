#!/bin/bash

url="https://app.whistleit.io/api/webhooks/64d1c24d14d13578b2208536" #Web Url
message="I am Hassnain and i am sending message through bash script :)" #Enter any message that you want to send
curl -X POST -d "message=$message" "$url"
# curl -X POST  "https://app.whistleit.io/api/webhooks/64d1c24d14d13578b2208536" -d "key=Testing 2 I am Hassnain and i am sending message through bash script :)"















