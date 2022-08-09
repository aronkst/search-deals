build :
	docker compose build

run:
	docker compose up

start:
	docker compose up -d

stop:
	docker compose stop

bash:
	docker exec -it search-deals-web bash

logs:
	docker compose logs -f

console:
	docker exec -it search-deals-web rails console

migrate:
	docker exec search-deals-web rails db:migrate

reset-database:
	docker exec search-deals-web rails db:drop db:create db:migrate
