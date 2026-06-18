# Lokales Deployment

Bevor der Applikation Stack auf der Cloud deployed wird, teste ich es auf der lokalen Umgebung. Mit `minikube` wird dies ermöglicht. 

### Minikube

Minikube startet lokal ein Kubernetes Cluster basierend, spezifisch in diesem Fall, auf `kvm2`, welches schnell bereit ist um direkt Deployments zu testen. 

<img width=50% height=50% alt="01_minikubestatus" src="../Medien/Umsetzung/new_deployment/01_minikubestatus.png">

<br>

### Deployment 

Jeder Service wird nun deployed und auf allfällige Problematiken getestet. 

#### Traefik

Traefik ist ein Ingress Controller, der zuständig für das Routing und Load Balancing sein wird. 

<img width=50% height=50% alt="02_traefik" src="../Medien/Umsetzung/new_deployment/02_traefik.png">

<br>

#### Cert Manager

Für die Verwendung von HTTPS wird ein Certification Manager benötigt, um ein Lets Encrypt Zertifikat zu beantragen. 

<img width=50% height=50% alt="03_certmanager" src="../Medien/Umsetzung/new_deployment/03_certmanager.png">

<br>

Im Cluster Issuer File sind die benötigten persönlichen Angaben erfasst. 

<img width=50% height=50% alt="04_cert" src="../Medien/Umsetzung/new_deployment/04_cert.png">

<br>

#### MongoDB Cluster

Das Mongo DB Cluster wird zur Speicherung der Daten, der Chat Plattform verwendet. Gleichzeitig ist das Cluster hoch verfügbar, da die Datenbanken sich replizieren. 

##### MongoDB Operator

Der Operator managed Kubernetes Komponenten für das MongoDB Cluster. 

<img width=50% height=50% alt="05_mongocluster" src="../Medien/Umsetzung/new_deployment/05_mongocluster.png">

##### MongoDB Datenbanken


<br>

