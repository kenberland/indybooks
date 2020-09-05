Run locally:
```
export INDY_ENV=development

docker run -t -i --rm -p 8000:8000 amazon/dynamodb-local
# or
docker run -t -i --rm --network host amazon/dynamodb-local

```

visit https://docs.google.com/spreadsheets/d/1Z58VKiVBOZmpggklix81JunBuHMnJXDe1x5-iTU6DRg/edit?usp=sharing
File -> Download -> CSV
change the constant to match your file

for production:
```
export INDY_ENV=production
```

