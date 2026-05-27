# kubectl Befehls-Spickzettel (GKE-Projekt)

Ein kompakter Spickzettel für die wichtigsten `kubectl`-Befehle. 

---

## 1. Den Zustand prüfen
Mit `get` wird nachgeschaut, was im Cluster gerade existiert.

```bash
# Alle Nodes (Server-Instanzen) anzeigen
kubectl get nodes

# Alle laufenden Pods im aktuellen Namespace anzeigen
kubectl get pods

# Pods mit erweiterten Details (z.B. IP-Adressen, Node-Zuweisung) anzeigen
kubectl get pods -o wide

# Alle Services (Netzwerk-Endpunkte / Load Balancer) anzeigen
kubectl get services

# Alle Ressourcen (Pods, Services, Deployments etc.) im aktuellen Namespace anzeigen
kubectl get all


```


## Tiefenanalyse & Fehlersuche

```bash

# Die Live-Logs eines bestimmten Pods ausgeben
kubectl logs <pod-name>

# Logs live mitverfolgen (wie "tail -f")
kubectl logs -f <pod-name>

# Detaillierte Infos, Konfigurationen und Lebenslauf (Events) eines Objekts anzeigen
kubectl describe pod <pod-name>

# Direkt in den Container einloggen (interaktive Terminal-Session / SSH-Ersatz)
kubectl exec -it <pod-name> -- /bin/bash

```

<br>


## Erstellen & Verändern (Management)

```bash

# Eine Konfigurationsdatei (YAML) auf den Cluster anwenden (Erstellen/Aktualisieren)
kubectl apply -f dateiname.yaml

# Einen bestimmten Pod direkt manuell löschen
kubectl delete pod <pod-name>

# Alle über eine YAML-Datei erstellten Ressourcen wieder aus dem Cluster löschen
kubectl delete -f dateiname.yaml

# Schnell einen einzelnen Test-Pod starten (ohne YAML-Datei)
kubectl run test-pod --image=nginx

```

<br>

## Ressourcen & Performance überwachen

```bash

# Aktuellen CPU- und RAM-Verbrauch der Nodes anzeigen
kubectl top nodes

# Aktuellen CPU- und RAM-Verbrauch der einzelnen Pods anzeigen
kubectl top pods

```

<br>

