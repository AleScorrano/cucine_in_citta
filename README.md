# Cucine in città

Micro app Flutter che permette di esplorare le cucine disponibili in una città tramite le API pubbliche di BestieBite.

---

## Features

* Ricerca città con autocomplete
* Debounce sulle chiamate API
* Lista suggerimenti realtime
* Visualizzazione cucine disponibili per città
* Skeleton loading states
* Gestione completa degli stati:

  * Idle
  * Searching
  * Suggestions loaded
  * No results
  * Loading cuisines
  * Empty cuisines
  * Error
* Retry delle chiamate fallite
* Gestione race conditions nelle ricerche async

---

## Tech stack

* Flutter
* flutter_bloc (Cubit)
* Dio
* Retrofit
* json_serializable
* GetIt
* Skeletonizer
* Mocktail
* bloc_test

---

## Avvio del progetto

### 1. Installare le dipendenze

```bash id="l4bd0k"
flutter pub get
```

### 2. Generare i file Retrofit/json_serializable

```bash id="jlwm4v"
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Verificare i device disponibili

```bash id="6g31em"
flutter devices
```

### 4. Avviare un emulator/simulatore oppure collegare un device fisico

### 5. Avviare l'app

Flutter utilizzerà automaticamente il device selezionato:

```bash id="50fzcm"
flutter run
```

Oppure specificare direttamente il device:

```bash id="9xvjlwm"
flutter run -d <device-id>
```

Esempio:

```bash id="p70t3j"
flutter run -d emulator-5554
```

### 6. Eseguire i test

```bash id="qg1c6d"
flutter test
```

---

## Architettura

L’app segue una struttura feature-first con separazione tra presentation, datasource e networking layer.

### Scelte architetturali principali

* Cubit per la gestione dello stato UI
* Retrofit + Dio per il networking type-safe
* Result pattern per la gestione esplicita di success/failure
* GetIt per dependency injection
* Debounce custom per limitare le chiamate autocomplete
* Invalidazione delle request async obsolete per evitare race conditions

---

## Testing

Il progetto include unit test per:

* Cubit
* Datasource
* Parsing DTO
* Success/failure flows
* Gestione stati async

---

## Una cosa di cui sono orgoglioso

La gestione del flusso autocomplete asincrono.

L’app invalida correttamente le request obsolete quando l’utente digita velocemente o seleziona una città mentre sono ancora presenti chiamate pendenti, evitando stati inconsistenti nella UI.

---

## Una cosa che farei diversamente con più tempo

Con più tempo aggiungerei:

* Animazioni e transizioni più rifinite
* Layout adattivi per tablet/web
* Cache locale delle ultime ricerche



