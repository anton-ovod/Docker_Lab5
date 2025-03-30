# Backend Express + TypeScript + Docker

## Opis

To backendowa aplikacja napisana w Node.js z wykorzystaniem Express i TypeScript.  
Aplikacja działa w kontenerze Docker, bazując na lekkim systemie Alpine Linux.  
Kod źródłowy jest kompilowany do JavaScript przed uruchomieniem w kontenerze.

---

## Zadanie 1 (bez użycia serwera ngnix)

### 1. **Zbudowanie obrazu Docker**

Aby zbudować obraz aplikacji, użyj następującego polecenia:

```sh
docker build --build-arg VERSION=2.0.0 -t my-backend-app .
```

### Wynik działania polecenia build

```sh
[+] Building 2.7s (11/11) FINISHED
 => [internal] load build definition from Dockerfile                            0.0s
 => [internal] load .dockerignore                                               0.0s
 => [internal] load build context                                               0.0s
 => CACHED [base 1/1] ADD alpine-minirootfs-3.21.3-x86_64.tar /                 0.0s
 => CACHED [builder 1/6] RUN apk add --no-cache nodejs pnpm                     0.0s
 => CACHED [builder 2/6] WORKDIR /app                                           0.0s
 => CACHED [builder 3/6] COPY package.json tsconfig.json .env ./                0.0s
 => CACHED [builder 4/6] RUN pnpm install                                       0.0s
 => CACHED [builder 5/6] COPY src ./src                                         0.0s
 => [builder 6/6] RUN pnpm build                                                1.9s
 => exporting to image                                                          0.6s
 => => naming to docker.io/library/my-backend-app:v2                            0.0s
 => => unpacking to docker.io/library/my-backend-app:v2                                                              0.0s
```

### 2. Uruchomienie kontenera

Po zbudowaniu obrazu uruchom aplikację:

```sh
docker run -d -p 3000:3000 my-backend-app
```

Aplikacja będzie dostępna na `http://localhost:3000/`

### 3. Sprawdzenie działania aplikacji

Aby sprwadzić, czy aplikacja działa, użyj:

```sh
curl http://localhost:3000/
```

Jeśli aplikacja działa poprawnie, powinieneś otrzymać odpowiedź JSON

### Wynik działania aplikacji

![Image](wynik_1.png)

---
