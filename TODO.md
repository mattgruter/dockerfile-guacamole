#TODO.md

## webserver image
- HTTPS instead of HTTP
- override hostname to guacd and db with environment variable

## guacd image
- slim down guacd image (remove dev libs & tools)

## db image
- fix db restart issue: execute run.sh during build not when starting the container

## gneneral
- one-liner to start all 3 containers without relying on fig