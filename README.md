# UrlParser

**TODO: Add description**

## Problem
Write a function ​fetch(url)​ that fetches the page corresponding to the url and returns an object that has the following attributes:
- assets - an array of urls present in the <img> tags on the page
- links - an array of urls present in the <a> tags on the page

Assume that the code will run on a server. Assume that this work is a part of a web app that needs to be built further by multiple development teams and will be maintained and evolved for several years in the future. In addition to these, make any assumptions necessary, but list those assumptions explicitly.

## How to run it

It requires RUST on your computer because of `html5ever` dependency. Remove it from mix.exs and comment the code from `config/confix.ex` in order to compile the code without `html5ever`.

Start local server with:
```bash
mix run --no-halt
```

Then use this cURL commands to test it:
```bash
curl -X POST \
  http://127.0.0.1:8080/parser \
  -H 'Accept: */*' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: 127.0.0.1:8080' \
  -H 'User-Agent: PostmanRuntime/7.15.0' \
  -H 'accept-encoding: gzip, deflate' \
  -H 'cache-control: no-cache' \
  -H 'content-length: 113' \
  -d '{
    "url": "https://blackrockdigital.github.io/startbootstrap-shop-homepage/",
    "assets": "yes",
    "links": "yes"
}'
```

```bash
curl -X POST \
  http://127.0.0.1:8080/parser \
  -H 'Accept: */*' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: 127.0.0.1:8080' \
  -H 'User-Agent: PostmanRuntime/7.15.0' \
  -H 'accept-encoding: gzip, deflate' \
  -H 'cache-control: no-cache' \
  -H 'content-length: 113' \
  -d '{
    "url": "https://blackrockdigital.github.io/startbootstrap-shop-homepage/",
    "assets": "yes",
    "links": "no"
}'
```

```bash
curl -X POST \
  http://127.0.0.1:8080/parser \
  -H 'Accept: */*' \
  -H 'Cache-Control: no-cache' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/json' \
  -H 'Host: 127.0.0.1:8080' \
  -H 'User-Agent: PostmanRuntime/7.15.0' \
  -H 'accept-encoding: gzip, deflate' \
  -H 'cache-control: no-cache' \
  -H 'content-length: 113' \
  -d '{
    "url": "https://blackrockdigital.github.io/startbootstrap-shop-homepage/",
    "assets": "no",
    "links": "yes"
}'
```


