# Lokales Deployment

Bevor der Applikation Stack auf der Cloud deployed wird, teste ich es auf der lokalen Umgebung, um allfällige Problematiken schneller lösen zu können. Mit `minikube` wird dies ermöglicht. 

## Minikube

Minikube startet lokal ein Kubernetes Cluster basierend, spezifisch in diesem Fall, auf `kvm2`, welches schnell bereit ist um direkt Deployments zu testen. 

<img width=50% height=50% alt="01_minikubestatus" src="../Medien/Umsetzung/new_deployment/01_minikubestatus.png">

<br>

## Deployment 

Jeder Service wird nun deployed und auf allfällige Problematiken getestet. 

### Traefik

Traefik ist ein Ingress Controller, der zuständig für das Routing und Load Balancing sein wird. 

<img width=50% height=50% alt="02_traefik" src="../Medien/Umsetzung/new_deployment/02_traefik.png">

<br>

### Cert Manager

Für die Verwendung von HTTPS wird ein Certification Manager benötigt, um ein Lets Encrypt Zertifikat zu beantragen. 

<img width=50% height=50% alt="03_certmanager" src="../Medien/Umsetzung/new_deployment/03_certmanager.png">

<br>

Im Cluster Issuer File sind die benötigten persönlichen Angaben erfasst. 

<img width=50% height=50% alt="04_cert" src="../Medien/Umsetzung/new_deployment/04_cert.png">

<br>

### MongoDB Cluster

Das Mongo DB Cluster wird zur Speicherung der Daten, der Chat Plattform verwendet. Gleichzeitig ist das Cluster hoch verfügbar, da die Datenbanken sich replizieren. 

<img width=60% height=50% alt="08_mongodbcluster" src="../Medien/Umsetzung/new_deployment/08_mongodbcluster.png">

<br>

Nach wenigen Momenten wechseln die Pods auf `Running` und sind somit bereit. 

<img width=30% height=50% alt="09_PodsRunningMongo" src="../Medien/Umsetzung/new_deployment/09_PodsRunningMongo.png">

<br>

### Initialisieren des Mongo Clusters

Die Datenbanken sind zwar am laufen, bilden allerdings noch kein Cluster. Daher muss ein Job deployed werden, der die Initialisierung des Clusters durchführt. Das Erstellen des Clusters funktioniert über den folgenden Befehl: 

```js
rs.initiate(
   {
      _id: "rs0",
      version: 1,
      members: [
	      { _id: 0, host: "mongo-0.mongo.rocketchat.svc.cluster.local:27017", priority: 2 },
	      { _id: 1, host: "mongo-1.mongo.rocketchat.svc.cluster.local:27017", priority: 1 },
	      { _id: 2, host: "mongo-2.mongo.rocketchat.svc.cluster.local:27017", priority: 1 }
      ]
   }
)
```

<br>

Ich verbinde mich auf die primäre Datenbank (`mongo-0`) und führe den oberen Befehl aus, um das Cluster zu initialisieren. 

<br>

Zur Kontrolle stelle ich eine Verbindung zu einem Datenbank Pod auf und prüfe den Status des Clusters mit `rs.status()`. Auf dem unteren Bild sieht man, dass das Cluster erfolgreich initialisiert wurde. 

<img width=50% height=50% alt="11_MongoClusterCheck" src="../Medien/Umsetzung/new_deployment/11_MongoClusterCheck.png">

<br>

### Rocketchat

Rocketchat ist eine Chat Applikation, auf der Nachrichten, Bilder, Videos oder andere Dateien versendet werden können. 

<br>

Auf dem nächsten Bild sieht man, dass Deployment mit einer personalisierten `rocketchat-values.yml` File. 

<img width=90% height=50% alt="12_RocketchatDeploy" src="../Medien/Umsetzung/new_deployment/12_RocketchatDeploy.png">

<br>

Die Pods starten nach kurzer Zeit und sind betriebsbereit. 

<img width=50% height=50% alt="13_RunningPods" src="../Medien/Umsetzung/new_deployment/13_RunningPods.png">

<br>

Die Prüfung des Lets Encrypt Zertifikats schlägt fehl, da ich zum Testen einen Eintrag in der `Hosts` File gemacht habe und die Domain eigentlich gar keine Records enthält. 

<img width=90% height=50% alt="14_FailedCert" src="../Medien/Umsetzung/new_deployment/14_FailedCert.png">

<br>

Um das Frontend zu erreichen muss ein Tunnel eingerichtet werden. Auf dem nächsten Bild sind zwei Terminal Fenster übereinander gestapelt, um in einem Bild den Tunnel und die DNS Funktionalität aufzuweisen. 

<img width=20% height=50% alt="16_DNSandTunnel" src="../Medien/Umsetzung/new_deployment/16_DNSandTunnel.png">



<br>

Die Applikation ist unter der definierten Domain erreichbar. 

<img width=90% height=50% alt="15_RocketchatBrowser" src="../Medien/Umsetzung/new_deployment/15_RocketchatBrowser.png">

<br>

Der nächste Schritt ist das Deployment in die Cloud zu bringen --> [Cloud Deployment](cloud_deployment.md). 