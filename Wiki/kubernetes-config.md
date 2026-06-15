# Kubeconfig Management

Eine Kubeconfig ist eine lokale Datei (`config`), die Informationen über ein Cluster enthält, die benötigt für den Zugriff aufs Cluster benötigt werden. Sie befindet sich typischerweise unter `~/.kube` bei Linux Systeme. 

### Mehrere Cluster managen

Um mehrere Cluster zu managen können verschiedene Configs merged werden. In der folgenden Anleitung dokumentiere ich den Vorgang. 

#### 1. Backup der aktuellen Config

```bash
cp -r ~/.kube ~/backup-kube
```

#### 2. Zusätzliche Config speichern

Nehmen wir an die Config des zusätzlichen Clusters ist gespeichert unter `~/new-config`. 

#### 3. Variable KUBECONFIG vorbereiten

In der Variable `KUBECONFIG` müssen die Pfade, aller Configs, die kombiniert werden sollen, eingefügt werden. 

```bash
export KUBECONFIG=~/.kube/config:~/new-config
```

Die Pfade müssen `:`  getrennt gespeichert werden. 

#### 4. Configs kombinieren

```bash
kubectl config view --flatten > .kube/config-merged
```

Der Befehl greift auf die Variable `KUBECONFIG` zu und kombiniert alle definierten Configs zu einer Datei (`config-merged`). 

#### 5. KUBECONFIG bereinigen

```bash
unset KUBECONFIG
```

#### 6. Neue Config hinterlegen

```bash
rm ~/.kube/config
rm ~/new-config

mv ~/.kube/config-merged ~/.kube/config
```

#### 7. Kontext prüfen

```bash
kubectl config get-contexts
```

Der Befehl listet alle Kubernetes Cluster auf, die kombiniert wurden. 

```bash
kubectl use-context CONTEXT
```

Dieser Befehl wechselt den Kontext zum gewünschten Cluster. 