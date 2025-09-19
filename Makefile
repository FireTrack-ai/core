-include .env
export $(shell sed 's/=.*//' .env)

start:
	cp ./configs/.env.yml.dist ./configs/.env.yml
	make build
build:
	docker-compose up -d --build
up:
	docker-compose up -d

## Apply all up migrations
migrate-up:
	migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" up

## Rollback last migration
migrate-down:
	migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" down 1

## Rollback everything
migrate-reset:
	migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" down -all

## Apply exactly N migrations up
migrate-up-n:
	migrate -path $(MIGRATIONS_PATH) -database "$(DB_URL)" up 1

## Create new migration
migrate-create:
	@read -p "Enter migration name: " name; \
	migrate create -ext sql -dir migrations $$name