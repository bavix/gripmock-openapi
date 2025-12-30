.PHONY: *

gen-rest:
	go run github.com/oapi-codegen/oapi-codegen/v2/cmd/oapi-codegen@latest -generate gorilla,types -package rest https://raw.githubusercontent.com/bavix/gripmock/refs/heads/master/api/api.yaml > api.gen.go
	sed -i '' 's/interface{}/any/g' api.gen.go
