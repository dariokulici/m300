# Projektumfang

### OCI Images

| ID  | Name          | Tag                                  | Beschreibung                                                         |
| --- | ------------- | ------------------------------------ | -------------------------------------------------------------------- |
| 1   | Saleor        | ghcr.io/saleor/saleor:3.23           | Die Saleor API, das Hauptimage                                       |
| 2   | Dashboard     | ghcr.io/saleor/saleor-dashboard:3.23 | Saelor Frontend                                                      |
| 3   | Postgres DB   | library/postgres:15-alpine           | Das Datenbank Image, welches die Daten speichert                     |
| 4   | Cache         | valkey/valkey:8.1-alpine             | Cache, der Daten zwischenspeichert für einen schnellen Abruf         |
| 5   | Saleor Worker | ghcr.io/saleor/saleor:3.23           | Der Saelor Worker bearbeitet bspw. Bestellungen, die getätigt werden |
| 6   | Jaeger        | jaegertracing/jaeger                 | Rückverfolgung der Netzwerkanfragen zwischen den Containern          |
| 7   | Mail          | axllent/mailpit                      | Ein Mail Container, der fürs Senden von Mails verantwortlich ist     |

<br>

Referenz für die Images ist dieses [File](../Projektdateien/docker-compose.yml). 

<br>

### Cloud Plattform

Die E-Commerce Plattform soll auf der Google Kubernetes Engine deployed werden. 