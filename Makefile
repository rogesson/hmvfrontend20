build:
	docker-compose build --no-cache	

run:
	docker-compose up

console:
	docker exec -it hmvfrontend20_app_1 sh

down:
	docker-compose down
