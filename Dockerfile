# Etap 1: Tworzenie własnego obrazu bazowego
# Używamy pustego obrazu bazowego (scratch), na którym budujemy Alpine Linux
FROM scratch AS base
# Dodajemy minimalny system plików Alpine Linux do obrazu
ADD alpine-minirootfs-3.21.3-x86_64.tar /

# Etap 2: Instalacja wymaganych pakietów i budowanie aplikacji
# Tworzymy nową warstwę obrazu na podstawie wcześniej utworzonego `base`
FROM base AS builder
# Instalujemy Node.js i pnpm (menedżer pakietów dla Node.js)
RUN apk add --no-cache nodejs pnpm

# Ustawiamy katalog roboczy w kontenerze na `/app`
WORKDIR /app

# Kopiujemy pliki konfiguracyjne projektu do katalogu roboczego
COPY package.json tsconfig.json .env ./

# Instalujemy zależności projektu
RUN pnpm install 

# Kopiujemy kod źródłowy aplikacji do katalogu roboczego
COPY src ./src 

# Tworzymy zmienną ARG dla wersji aplikacji, domyślnie ustawioną na "1.0.0"
ARG VERSION="1.0.0"
# Przekazujemy wartość ARG do zmiennej środowiskowej ENV, aby była dostępna w kontenerze
ENV APP_VERSION=$VERSION

# Budujemy aplikację (kompilacja TypeScript do JavaScript)
RUN pnpm build

# Dokumentujemy port 3000, na którym będzie działać aplikacja
EXPOSE 3000

# Uruchamiamy aplikację po starcie kontenera
CMD ["pnpm", "start"]
