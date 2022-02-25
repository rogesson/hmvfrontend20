build:
	docker-compose build --no-cache	

run:
	docker-compose up

down:
	docker-compose down

console:
	docker exec -it hmvfrontend20_web_1 /bin/bash
