`docker run -t -i --rm -p 8000:8000 amazon/dynamodb-local`
# or
`docker run -t -i --rm --network host amazon/dynamodb-local`


Now you can do shit like:
```
aws dynamodb list-tables --endpoint-url http://localhost:8000
aws dynamodb scan --table-name indybooks_inventory_development --endpoint-url http://localhost:8000
```
