postgres:
	docker run --name postgres -p 5436:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=123456 -d postgres

createdb:
	docker exec -it postgres createdb --username=postgres --owner=postgres postgres

dropdb:
	docker exec -it postgres dropdb simple_bank

migrateup:
	mirage -path db/migration -database "postgresql://postgres:123456@localhost:5436/postgres?sslmode=disable" -verbose up

migratedown:
	mirage -path db/migration -database "postgresql://postgres:123456@localhost:5436/postgres?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v ./...

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test