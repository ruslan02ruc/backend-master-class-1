postgres:
	docker run --name postgres --network bank-network -p 5436:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=123456 -d postgres

createdb:
	docker exec -it postgres createdb --username=postgres --owner=postgres postgres

dropdb:
	docker exec -it postgres dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:postgres@simple-bank.cvmuwkm0aohe.eu-north-1.rds.amazonaws.com:5436/simple-bank" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:postgres@simple-bank.cvmuwkm0aohe.eu-north-1.rds.amazonaws.com:5436/simple-bank" -verbose down

sqlc:
	sqlc generate

test:
	go test -v ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go simplebank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server mock