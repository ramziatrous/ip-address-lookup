# IP Checker 
 ### Ziel
 - In dieser Aufgabe sollst du eine Angular-App erstellen, die eine IP-Adresse über ein Formular entgegennimmt und dann mithilfe der ip-api.com-API zusätzliche Informationen zur IP-Adresse abruft. Schließlich sollst du die Angular-App in einem Docker-Container verpacken und auf einer AWS EC2-Instanz bereitstellen. Als Herausforderung soll Nginx als Reverse-Proxy verwendet werden. 

### Angular-App entwickeln
- Erstelle eine Angular-App mit einem Formular, das eine IP-Adresse akzeptiert.
Implementiere eine Funktion, die die eingegebene IP-Adresse verwendet, um einen API-Aufruf an ip-api.com durchzuführen und die erhaltenen Daten anzuzeigen.

### Docker-Container für die Angular-App erstellen
- Erstelle ein Dockerfile für deine Angular-App.
Baue den Docker-Container, der deine Angular-App enthält.

### AWS-Ressourcen ersetllen und deployen
- Starte eine EC2-Instanz in AWS. Deploye den Docker Container auf der EC2 Instanz und stelle sicher, dass die App über das Internet erreichbar ist.
## Herausforderungen
#### Nginx als Reverse-Proxy konfigurieren

- Installiere Nginx auf deiner EC2-Instanz.
Konfiguriere Nginx als Reverse-Proxy, um Anfragen an die React-App in deinem Docker-Container weiterzuleiten.

#### Schütze deine App!

- Stelle sicher, dass die App nicht einfach aufgerufen werden kann. Konfiguriere NGINX so, sodass der Zugriff erst nach Eingabe von einem bestimmten Username und Passwort erfolgen kann (BasicAuth).

