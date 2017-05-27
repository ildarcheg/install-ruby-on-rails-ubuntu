# Working with MongoDB

### Install MongoDB
Download and install following instructions https://www.mongodb.com/download-center#community

### Shell Quick Reference
Use mongo shell https://docs.mongodb.com/manual/reference/mongo-shell/

### Download sample data
Use link to download data  
```
curl -O http://media.mongodb.org/zips.json
```

### Create database and upload data
Create 'test' database and updato sample data to 'zips' collection  
```
mongoimport --db test --collection zips --drop --file ~/Downloads/zips.json
```


