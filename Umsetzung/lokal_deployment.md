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

### Automatischer Init Job fürs Mongo Cluster

Die Datenbanken sind zwar am laufen, bilden allerdings noch kein Cluster. Daher muss ein Job deployed werden, der die Initialisierung des Clusters durchführt. 

<br>

Der Job wird gestartet und löscht sich nach dem Ausführen des Jobs. 

<img width=80% height=50% alt="10_JobComplete" src="../Medien/Umsetzung/new_deployment/10_JobComplete.png">

<br>
Zur Kontrolle stelle ich eine Verbindung zu einem Datenbank Pod auf und prüfe den Status des Clusters mit `rs.status()`. Auf dem unteren Bild sieht man, dass das Cluster erfolgreich initialisiert wurde. 

<img width=50% height=50% alt="11_MongoClusterCheck" src="../Medien/Umsetzung/new_deployment/11_MongoClusterCheck.png">

<br>

