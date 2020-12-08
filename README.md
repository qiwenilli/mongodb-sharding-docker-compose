# mongodb-sharding-docker-compose

## 实现三个副本集，三个conifg，二个router，三个sharding


### 开启一个admin

> db.createUser({user:"admin",pwd:"admin",roles:[{role:"dbAdminAnyDatabase",db:"admin"}]})

### 启动一个db&collection切片
```
use admin

sh.enableSharding("xxx")

db.createCollection('xxx.a1')

sh.shardCollection("xxx.a1", {"_id" : "hashed"})


// 集合的切片，如果使用了upset，fillter字段做为切片key
sh.shardCollection("xxx.a1", {"name" : 1}, {"cn":1})
```

