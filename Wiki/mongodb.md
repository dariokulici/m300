# MongoDB Commands


## Cluster initialisieren

Um das Cluster zu initialisieren muss auf der primären Instanz dieser Befehl ausgeführt werden. 

```js

rs.initiate(
   {
      _id: "myReplSet",
      version: 1,
      members: [
         { _id: 0, host : "mongodb0.example.net:27017" },
         { _id: 1, host : "mongodb1.example.net:27017" },
         { _id: 2, host : "mongodb2.example.net:27017" }
      ]
   }
)

```

<br>

## Read erlauben

Standardmässig können sekundäre Instanzen nicht die Datenbanken der primären Instanz lesen. Mit dem folgenden Befehl wird dies pro Session aktiviert, sodass die Datenbanken der primären Instanz geklont werden. 

```js
rs.slaveOk()
```

<br>

Wenn die Chat Applikation läuft und auf die Datenbank zugreifen muss kann im URI ein Wert, der angibt, die sekundären Instanzen zu präferieren, angegeben werden. 

```bash
mongodb://host1:27017,host2:27017/dbname?replicaSet=rsName&readPreference=secondaryPreferred
```

So gehen die Lesezugriffe auf die Datenbank an die sekundären Datenbanken und lasten die primäre Datenbank, die zuständig für Write Vorgänge ist, aus. 