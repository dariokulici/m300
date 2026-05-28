# Container Runtime


## Container

Mit Containern können Software Entwickler Programme entwerfen, die später genau so auch auf z.B Cloud Umgebungen oder Servern laufen können ohne etwas zusätzliches anzupassen. 

### Merkmale

- Container nutzen die Ressourcen des Hosts. 
- Container sind leichtgewichtig und haben keinen Overhead. 
- Container sind portierbar, da sie überall gleich ausgeführt werden. 

## Container Runtime

### Docker Architektur

Docker hat die Linux-Containertechnologie verpackt und zu einer benutzerfreundlichen Schnittstelle gemacht. 

#### Docker Daemon

Der Docker Daemon läuft im Hintergrund und ist zuständig für das Erstellen, Ausführen und Überwachen von Containern. Ausserdem baut und speichert er Images. Seit der Version 1.11 besteht der Docker Daemon aus zwei Prozessen, `runc` zum Starten von Containern und `containerd` um Container zu betreiben. 

#### Docker Client

Der Docker Client ist eine CLI App und kommuniziert über eine REST API mit dem Docker Daemon. 

#### Container

Container entstehen anhand des gegeben Images. Eine Applikation wird als Image verpackt und ein Container mit dem Image gestartet. Es können mehrere Container mit dem selben Image laufen. Bei Änderungen während des Betriebs kann das Union File System genutzt werden, welches Änderungen zusätzlich auf die Basis des Images speichert. 

#### Container Registry

Auf dem Registry werden Images abgelegt.  Von den Registries können die Images heruntergeladen werden. Das grösste Registry ist der Docker Hub, auf dem jeder ein Image hochladen kann. Docker prüft und markiert offizielle Images auf dem Docker Hub. 