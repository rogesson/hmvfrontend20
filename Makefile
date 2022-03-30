build:
	docker-compose build --no-cache

run:
	docker-compose up

down:
	docker-compose down

console:
	docker exec -it hmvfrontend20_web_1 /bin/bash

ssh:
	ssh -i hmv.pem ec2-user@ec2-54-210-241-6.compute-1.amazonaws.com
