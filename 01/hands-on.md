# Hands-on Übungen

<br>

### Web-App ohne Container

Als erstes clone ich das Repository und installiere die Pakete mit `npm install`. Danach starte ich die App mit `node app.js &` als Prozess und teste ob ich mich zur App verbinden kann.  

<img width=100% height=80% alt="01LokaleWebApp.png" src="media/01LokaleWebApp.png">

<br>

### Web-App mit Container

Ich lasse mir eine Dockerfile generieren und ändere die Werte so, dass das Image gebaut werden kann. Für solche "kleinen" Aufgaben, wenn das Verständnis schon da ist, ist KI etwas sehr praktisches. 

<img width=100% height=80% alt="02BuildImage.png" src="media/02BuildImage.png">

<br>

Dann starte ich einen Container mit dem gebauten Image. 

<img width=80% height=100% alt="03AppRunning.png" src="media/03AppRunning.png">

<br>

### Docker Hub Limits

Hier geht es um das "Pull Rate Limit", welches für verschiedene Arten von User Accounts zählt. 

| User Typ                 | Pull Rate Limit für 6 Stunden | Anzahl öffentliche Repositories | Anzahl private Repositories |
| ------------------------ | ----------------------------- | ------------------------------- | --------------------------- |
| Business (authenticated) | Unlimited                     | Unlimited                       | Unlimited                   |
| Team (authenticated)     | Unlimited                     | Unlimited                       | Unlimited                   |
| Pro (authenticated)      | Unlimited                     | Unlimited                       | Unlimited                   |
| Personal (authenticated) | 200                           | Unlimited                       | Up to 1                     |
| Unauthenticated users    | 100                           | -                               | -                           |

