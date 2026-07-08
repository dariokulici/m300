# Cloud Deployment

## Vorbereitung

Um das Deployment so einfach wie möglich zu gestalten, erfasse ich alle benötigten Befehle in ein [Skript](../Projektdateien/Deploy/deploy.sh). Das Skript richtet die Datenbank automatisch ein und fragt Secrets über das Terminal ab, sodass ich das Skript auf das Repository pushen kann. 

<br>

## Manifest-Anpassungen

### Storage Class

Google Cloud hat andere Storage Klassen, um Volumen zu erstellen, daher passte ich die Storage Class von `standard` auf `standard-rwx` an. 

<img width=40% height=50% alt="18_StorageClass" src="../Medien/Umsetzung/new_deployment/18_StorageClass.png">

<br>

### Ressource Requests

Lokal sind, in diesem spezifischen Fall, viel mehr Ressourcen nutzbar im Vergleich  zur Cloud. Wenn zu viel Ressourcen angefragt werde, fängt der Provisioner an Pods zu killen. Dies ergibt einen Crash Loop, weil das Manifest besagt es müssen eine definierte Anzahl an Replicas laufen während der Provisioner die neuen Pods direkt killt. Daher passte ich die Requests so an, dass keine Crash Loops entstanden. 

<img width=40% height=50% alt="17_Ressources" src="../Medien/Umsetzung/new_deployment/17_Ressources.png">

<br>

## Deployment

Im unteren Bild erkennt man die laufenden Pods auf dem Cluster. 

<img width=90% height=50% alt="19_RunningPodsGKE" src="../Medien/Umsetzung/new_deployment/19_RunningPodsGKE.png">

<br>

Der Service ist auf der Public IP des Clusters erreichbar. 

<img width=90% height=50% alt="20_RocketchatView" src="../Medien/Umsetzung/new_deployment/20_RocketchatView.png">

<br>

Nun ist der Server registriert. 

<img width=90% height=50% alt="21_RocketchatSetup" src="../Medien/Umsetzung/new_deployment/21_RocketchatSetup.png">

<br>

Nach dem neuen Ausrollen der Cert Manager Manifeste ist die Webseite durch ein Lets Encrypt Zertifikat gesichert. 

<img width=70% height=50% alt="22_HTTPS" src="../Medien/Umsetzung/new_deployment/22_HTTPS.png">


## Monitoring

Der Agent wird über einen vorgefertigten Deploy Befehl direkt auf dem Cluster deployed. 

<img width=90% height=50% alt="21_GrafanaDeploy" src="../Medien/Umsetzung/new_deployment/21_GrafanaDeploy.png">

<br>

Auf dem Dashboard werden die Metrics des Clusters sauber angezeigt. 

<img width=90% height=50% alt="23_GrafanaOverview" src="../Medien/Umsetzung/new_deployment/23_GrafanaOverview.png">

<br>

