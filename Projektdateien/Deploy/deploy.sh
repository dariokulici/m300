#!/bin/bash

set -e

# Preparation
kubectl create namespace rocketchat || echo "Namespace existiert bereits"

# Trafik
helm repo add traefik https://traefik.github.io/charts
helm repo update
helm install traefik traefik/traefik \
  --namespace traefik \
  --create-namespace

# Cert Manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.3/cert-manager.yaml

echo "Warte auf Cert-Manager Webhook..."
kubectl wait --for=condition=Available deployment/cert-manager-webhook -n cert-manager --timeout=60s

kubectl apply -f Cert/clusterissuer.yml

# MongoDB
kubectl apply -f Mongo-Dependencies/
kubectl delete secret mongo-keyfile -n rocketchat --ignore-not-found
kubectl create secret generic mongo-keyfile --from-file=keyfile=keyfile.txt -n rocketchat
kubectl apply -f statefulset_mongodb.yml

echo "Warte, bis die MongoDB-Pods (mongo-0, -1, -2) den Status 'Ready' erreichen..."
kubectl wait --for=condition=Ready pod/mongo-0 pod/mongo-1 pod/mongo-2 -n rocketchat --timeout=180s

############################################################
# Cluster-Check vor dem DB Setup
############################################################
echo ""
echo "Prüfe MongoDB Replica Set Status..."

# Wir fangen sowohl die Standardausgabe als auch Fehlermeldungen ab
set +e
MONGO_OUTPUT=$(kubectl -n rocketchat exec mongo-0 -- mongosh --quiet --eval "rs.status().ok" 2>&1)
set -e

# Fall 1: Cluster läuft und antwortet mit "1" (noch keine Auth aktiv)
# Fall 2: Mongosh wirft "Unauthorized" oder "AuthenticationFailed" -> Cluster & User existieren bereits
if [[ "$MONGO_OUTPUT" == *"1"* || "$MONGO_OUTPUT" == *"Unauthorized"* || "$MONGO_OUTPUT" == *"AuthenticationFailed"* ]]; then
    echo "--> MongoDB ist bereits initialisiert und abgesichert! Überspringe DB-Setup..."
else
    echo "--> Kein aktives Replica Set gefunden (Meldung: $MONGO_OUTPUT). Starte MongoDB Konfiguration..."
    echo ""

    # Zugangsdaten Admin DB
    read -p "Username für Admin eingeben [default: rocketchat]: " ADMIN_MONGO_USER
    ADMIN_MONGO_USER=${ADMIN_MONGO_USER:-rocketchat}

    read -s -p "Passwort eingeben: " ADMIN_MONGO_PW
    echo ""
    read -s -p "Passwort zur Bestätigung wiederholen: " ADMIN_MONGO_PW_CONFIRM
    echo ""

    if [ "$ADMIN_MONGO_PW" != "$ADMIN_MONGO_PW_CONFIRM" ]; then
        echo "Fehler: Die Passwörter stimmen nicht überein."
        exit 1
    fi

    # Zugangsdaten Rocketchat DB
    read -p "Username für Rocketchat eingeben [default: rocketchat]: " ROCKETCHAT_MONGO_USER
    ROCKETCHAT_MONGO_USER=${ROCKETCHAT_MONGO_USER:-rocketchat}

    read -s -p "Passwort eingeben: " ROCKETCHAT_MONGO_PW
    echo ""
    read -s -p "Passwort zur Bestätigung wiederholen: " ROCKETCHAT_MONGO_PW_CONFIRM
    echo ""

    if [ "$ROCKETCHAT_MONGO_PW" != "$ROCKETCHAT_MONGO_PW_CONFIRM" ]; then
        echo "Fehler: Die Passwörter stimmen nicht überein."
        exit 1
    fi

    echo "=== Schritt 1: Replica Set initialisieren ==="
    kubectl -n rocketchat exec mongo-0 -- mongosh --quiet --eval 'rs.initiate({_id: "rs0", version: 1, members: [{_id: 0, host: "mongo-0.mongo.rocketchat.svc.cluster.local:27017", priority: 2}, {_id: 1, host: "mongo-1.mongo.rocketchat.svc.cluster.local:27017", priority: 1}, {_id: 2, host: "mongo-2.mongo.rocketchat.svc.cluster.local:27017", priority: 1}]})'

    echo "Warte 15 Sekunden auf die Primary-Wahl..."
    sleep 15

    echo "=== Schritt 2: Admin User erstellen ==="
    kubectl -n rocketchat exec mongo-0 -- mongosh --quiet --eval "db.getSiblingDB('admin').createUser({user: '${ADMIN_MONGO_USER}', pwd: '${ADMIN_MONGO_PW}', roles: [{role: 'root', db: 'admin'}]})"

    echo "=== Schritt 3: Rocketchat User erstellen (inkl. Authentifizierung) ==="
    kubectl -n rocketchat exec mongo-0 -- mongosh --quiet \
      -u "${ADMIN_MONGO_USER}" \
      -p "${ADMIN_MONGO_PW}" \
      --authenticationDatabase "admin" \
      --eval "db.getSiblingDB('rocketchat').createUser({user: '${ROCKETCHAT_MONGO_USER}', pwd: '${ROCKETCHAT_MONGO_PW}', roles: [{role: 'readWrite', db: 'rocketchat'}]})"

    echo "MongoDB Setup abgeschlossen."
fi

echo ""

############################################################
# Rocketchat Deployment
############################################################
read -p "Fortfahren mit Rocketchat Deployment? (y/n): " answer

if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    echo "Rocketchat wird installiert..."
    # Helm-Installation ausführen (upgrade --install ist sicherer falls es schon existiert)
    helm upgrade --install rocketchat -f Rocketchat/rocketchat-values.yml rocketchat/rocketchat -n rocketchat
else
    echo "Installation abgebrochen."
    exit 0
fi