# Container Standards und Technologien

<br>

### OCI

Open Container Initiative ist eine Führungsstruktur, die definiert, wie Container Images für industrielle Zwecke gespeichert werden. Die OCI wurde 2015 von Docker kreiert. Sie enthällt drei Spezifikationen, die Runtime Specification (runtime-spec), die Image Specification (image-spec) und die Distribution Specification (distribution-spec). Die erstere definiert wie ein Filesystem auf einer Festplatte entpackt werden soll. 

<br>

### Linux Namespaces

Linux Namespaces ist die Technologie hinter Containern. Die verschiedenen Namespaces sind unten aufgelistet: 

- PID (Process ID)
- NET (Network)
- MNT (Mount)
- UTS (Hostname & Domain)
- USER (User ID)

Es gibt einen Default Namespace, auf dem alle Prozesse gemeinsam enthalten sind. 

<br>

### Container Engine

Container Engines wie bspw. Docker, Podman oder CRI-O sind nichts anderes als Wrapper für Linux Namespaces. Statt dass man selbst für einen Container mehrere Namespaces erstellen und managen muss, macht es die Container Engine. 