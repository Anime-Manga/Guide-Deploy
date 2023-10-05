# Anime Manga 🎬
Scarica le serie tv/film dal sito [AnimeSaturn](https://www.animesaturn.in/) e/o manga dal sito [MangaWorld](https://www.mangaworld.so/).
Grazie al Web integrato in questo progetto è possibile scaricare e vedere da solo oppure con gli amici l'anime oppure manga.

## La struttura del progetto
Il progetto si suddivide in 9 progetti:
- 🧮Api Service (C#)
- 📩Download Service (C#)
- 📨Notify Service (C#)
- 💾Update Service (C#)
- 💽Upgrade Service (C#)
- 💱Conversion Service (C#)
- 🏠Room Server (Hapi)
- 📁Path Server (Nodejs)
- 🌐Web Server([Nuxtjs](https://nuxt.com/) V3)
- 🎭Tor Proxy (Python)

Servizi utilizzati:
- 🐰[RabbitMQ](https://www.rabbitmq.com/)
- 🗄[Postgresql](https://www.postgresql.org/)
- 📄[MongoDB](https://www.mongodb.com/)

### Le immagini sono disponibili su DockerHub
| Nome Immagine | Link |
| ------ | ------ |
| 🧮Api Service | [Link](https://hub.docker.com/r/kju7pwd2/animemanga-apiservice) |
| 📩Download Service | [Link](https://hub.docker.com/r/kju7pwd2/animemanga-downloadservice) |
| 📨Notify Service | [Link](https://hub.docker.com/r/kju7pwd2/animemanga-notifyservice) |
| 💾Update Service | [Link](https://hub.docker.com/r/kju7pwd2/animemanga-updateservice) |
| 💽Upgrade Service | [Link](https://hub.docker.com/r/kju7pwd2/animemanga-upgradeservice) |
| 💱Conversion Service | [Link](https://hub.docker.com/r/kju7pwd2/animemanga-conversionservice) |
| 🏠Room server (Hapi) | [Link](https://hub.docker.com/r/kju7pwd2/animemanga-roomserver) |
| 🌐Web Client | [Link](https://hub.docker.com/r/kju7pwd2/animemanga-web) |
| 🎭Tor Proxy | [Link](https://hub.docker.com/r/kju7pwd2/animemanga-torproxy) |

#### Istruzioni per avviare i servizi
1. Completare alcuni campi vuoti nel file docker-compose.yml
2. Ho creato un file bash per gestire il progetto, ti basta solo avviare in `bash management.sh` oppure in `./management.sh` e Goditi!😊😁🥴
2. Se vuoi sapere di più dallo script, ti basterà fare solo `./management.sh -h` oppure `./management.sh --help`

## 🌐Web Server
Questo progetto verrà utilizzato per gli utenti che vorranno scaricare anime e/o manga.
Hanno la possibilità di vedere l'anime con gli amici in tempo reale.

| Expose ports | Protocol |
| ------ | ------ |
| 3000 | TCP |

### Dependencies
| Services | Required |
| ------ | ------ |
| Api | ✅  |
| Ftp | ✅  |
| Room server | ⛔ |

### Variabili globali richiesti:
```sh
example:
    #--- API ---
    NUXT_API_BASE: 'http://localhost:3333' #http://localhost:5000 [default]

    #--- Path ---
    NUXT_PUBLIC_HTTP_BASE: 'http://localhost:3333' #http://localhost:5002 [default]
    NUXT_PUBLIC_BASE_PATH: "/path" #"/public" [default]

    #--- WebSocket ---
    NUXT_PUBLIC_SOCKET_BASE: "ws://localhost:1111/path" #ws://localhost:5001/room [default]
    
    #--- Share link ---
    NUXT_PUBLIC_WEB_BASE: "http://localhost:33333" #http://localhost:3000 [default]

    #--- AUTH ---
    NUXT_PUBLIC_SECRET: "secret" #animemanga [default]
```

## 🧮Api Service
Questo progetto verrà utilizzato per esporre i dati in maniera facile e veloce con il database postgresql e mongo.

| Expose ports | Protocol |
| ------ | ------ |
| 80 | TCP |

### Information general:
> Note: `not` require volume mounted on Docker

### Dependencies
| Services | Required |
| ------ | ------ |
| Mongo | ✅  |
| Postgresql | ✅  |
| RabbitMQ | ✅  |
| Notify | ⛔ |

### Variabili globali richiesti:
```sh
example:
    #--- DB ---
    DATABASE_CONNECTION: User ID=guest;Password=guest;Host=localhost;Port=33333;Database=db; [require]
    DATABASE_CONNECTION_MONGO: "mongodb://ip:port"
    NAME_DATABASE_MONGO: "name db"
    
    #--- Rabbit ---
    USERNAME_RABBIT: "guest" #guest [default]
    PASSWORD_RABBIT: "guest" #guest [default]
    ADDRESS_RABBIT: "localhost" #localhost [default]

    #--- API ---
    PORT_API: "33333" #5000 [default]
    
    #--- Logger ---
    LOG_LEVEL: "Debug|Info|Error" #Info [default]
    WEBHOOK_DISCORD_DEBUG: "url" [not require]
    
    #--- General ---
    BASE_PATH: "/folder/anime" or "D:\\\\Directory\Anime" #/ [default]
    LIMIT_THREAD_PARALLEL: "8" #5 [default]
```

## 💾Update Service
Questo progetto verrà utilizzato per controllare se sono presenti nel file locale se non ci sono, invia un messaggio a DownloadService che scarica l'episodio mancante.
### Information general:
> Note: `require` volume mounted on Docker

### Dependencies
| Services | Required |
| ------ | ------ |
| Api | ✅  |
| RabbitMQ | ✅  |
### Variabili globali richiesti:
```sh
example:
    #--- Rabbit ---
    USERNAME_RABBIT: "guest" #guest [default]
    PASSWORD_RABBIT: "guest" #guest [default]
    ADDRESS_RABBIT: "localhost" #localhost [default]
    
    #--- API ---
    ADDRESS_API: "localhost" #localhost [default]
    PORT_API: "33333" #5000 [default]
    PROTOCOL_API: "http" or "https" #http [default]
    
    #--- Logger ---
    LOG_LEVEL: "Debug|Info|Error" #Info [default]
    WEBHOOK_DISCORD_DEBUG: "url" [not require]
    
    #--- General ---
    BASE_PATH: "/folder/anime" or "D:\\\\Directory\Anime" #/ [default]
    TIME_REFRESH: "60000" <-- milliseconds #120000 [default] 2 minutes
    LIMIT_THREAD_PARALLEL: "8" #5 [default]
    SELECT_SERVICE: "book or video" #video
```

## 💽Upgrade Service
Questo progetto verrà utilizzato per scaricare i nuovi episodi
### Information general:
> Note: `not` require volume mounted on Docker

### Dependencies
| Services | Required |
| ------ | ------ |
| Api | ✅  |
| RabbitMQ | ✅  |
| Notify | ⛔ |

### Variabili globali richiesti:
```sh
example:
    #--- rabbit ---
    USERNAME_RABBIT: "guest" #guest [default]
    PASSWORD_RABBIT: "guest" #guest [default]
    ADDRESS_RABBIT: "localhost" #localhost [default]
    
    #--- API ---
    ADDRESS_API: "localhost" #localhost [default]
    PORT_API: "33333" #5000 [default]
    PROTOCOL_API: "http" or "https" #http [default]
    
    #--- Logger ---
    LOG_LEVEL: "Debug|Info|Error" #Info [default]
    WEBHOOK_DISCORD_DEBUG: "url" [not require]
    
    #--- General ---
    BASE_PATH: "/folder/anime" or "D:\\\\Directory\Anime" #http [default]
    TIME_REFRESH: "60000" <-- milliseconds #1200000 [default] 20 minutes
    LIMIT_THREAD_PARALLEL: "8" #5 [default]
    SELECT_SERVICE: "book or video" #video
```

## 📩Download Service
Questo progetto verrà utilizzato per scaricare i video e mettere nella cartella.
### Information general:
> Notes: `require` volume mounted on Docker and se hai abilitato il proxy, nella cartella proxy devi inserire gli indirizzi ip con il comma, come in questo esempio: `http:1111:1234,http:2222:1234`

### Dependencies
| Services | Required |
| ------ | ------ |
| Api | ✅  |
| RabbitMQ | ✅  |

### Variabili globali richiesti:
```sh
example:
    #--- rabbit ---
    USERNAME_RABBIT: "guest" #guest [default]
    PASSWORD_RABBIT: "guest" #guest [default]
    ADDRESS_RABBIT: "localhost" #localhost [default]
    LIMIT_CONSUMER_RABBIT: "5" #3 [default]
    
    #--- API ---
    ADDRESS_API: "localhost" #localhost [default]
    PORT_API: "33333" #3000 [default]
    PROTOCOL_API: "http" or "https" #http [default]
    
    #--- Logger ---
    LOG_LEVEL: "Debug|Info|Error" #Info [default]
    
    #--- proxy ---
    PROXY_ENABLE: "true" #false [default]

    #--- General ---
    DELAY_RETRY_ERROR: "60000" #10000 [default]
    MAX_DELAY: "40" #5 [default]
    LIMIT_THREAD_PARALLEL: "100" #5 [default]
    PATH_TEMP: "/tmp/folder" #D:\\TestAnime\\temp [default]
    BASE_PATH: "/folder/anime" or "D:\\\\Directory\Anime" #/ [default]
    ENABLE_VIDEO: "false" #true [default]
    ENABLE_BOOK: "true" #true [default]
```

## 📨Notify Service
### Information general:
> Note: `not` require volume mounted on Docker

### Dependencies
| Services | Required |
| ------ | ------ |
| Api | ✅  |
| RabbitMQ | ✅  |

```sh
example:
    #--- rabbit ---
    USERNAME_RABBIT: "guest" #guest [default]
    PASSWORD_RABBIT: "guest" #guest [default]
    ADDRESS_RABBIT: "localhost" #localhost [default]

    #--- API ---
    ADDRESS_API: "localhost" #localhost [default]
    PORT_API: "33333" #5000 [default]
    PROTOCOL_API: "http" or "https" #http [default]
    
    #---Webhook---
    WEBHOOK_DISCORD: "url" [require]
    
    #---logger---
    LOG_LEVEL: "Debug|Info|Error" #Info [default]
    WEBHOOK_DISCORD_DEBUG: "url" [not require]
```

## 💱Conversion Service
Questo progetto verrà utilizzato per convertire file ts in mp4 da poter riprodurre in streaming
### Information general:
> Note: `require` volume mounted on Docker

### Dependencies
| Services | Required |
| ------ | ------ |
| Api | ✅  |
| RabbitMQ | ✅  |

### Variabili globali richiesti:
```sh
example:
    #--- rabbit ---
    USERNAME_RABBIT: "guest" #guest [default]
    PASSWORD_RABBIT: "guest" #guest [default]
    ADDRESS_RABBIT: "localhost" #localhost [default]
    LIMIT_CONSUMER_RABBIT: "5" #3 [default]
    
    #--- API ---
    ADDRESS_API: "localhost" #localhost [default]
    PORT_API: "33333" #3000 [default]
    PROTOCOL_API: "http" or "https" #http [default]
    
    #--- Logger ---
    LOG_LEVEL: "Debug|Info|Error" #Info [default]
    WEBHOOK_DISCORD_DEBUG: "url" [not require]
    
    #--- General ---
    MAX_THREAD: "3" #3 default
    PATH_TEMP: "/folder/temp" [require]
    PATH_FFMPEG: "/folder/bin" #/usr/local/bin/ffmpeg [default]
    BASE_PATH: "/folder/anime" or "D:\\\\Directory\Anime" #/ [default]
```

## 🏠Room server (Hapi)
questo progetto viene gestito le sessioni di streaming e le interazioni dei video degli altri, per esempio se viene messo in pausa tutte le persone che sono presenti in quella stanza viene messo in pausa il video.
### Information general:
> Note: `not` require volume mounted on Docker
### Variabili globali richiesti:
```sh
example:
    #--- General ---
    HOST: "localhost" #0.0.0.0 [default]
    PORT: "33333" #1234 [default]
    PATH_URL: "/path" #/room [default]
```
## 📁Path server (Nodejs)
Questo servizio serve ad esporre i file video per web.
### Information general:
Creare un container che contiene una lts di linux.
Installare `nodejs` e `npm`, infine installare il pacchetto ftp: `npm install --global http-server`
Avviare con `http-server '/root/anime'` come avvio della macchina

Oppure si può usare questa immagine: `danjellz/http-server`, la cartella che viene esposta è la seguente: `/public`

## 🎭Tor Proxy
Questo progetto verrà utilizzato per fare proxy attraverso tor per evitare che venga tracciato e se dovesse bloccare per le troppe richieste viene riavviato.
### Information general:
> Note: `not require` volume mounted on Docker

### Dependencies
| Services | Required |
| ------ | ------ |
| RabbitMQ | ✅  |

### Variabili globali richiesti:
```sh
example:
    #--- rabbit ---
    USERNAME_RABBIT: "guest" #guest [default]
    PASSWORD_RABBIT: "guest" #guest [default]
    ADDRESS_RABBIT: "localhost" #localhost [default]
    
    #--- General ---
    EXPECTED_ADDRESS: "127.0.0.1" #127.0.0.1 [default][require]
    REPLICAS: 10 #10 [default][require]
    EXCHANGE_NAME: "example_exchange" #Cesxhin.AnimeManga.Domain.DTO:ProxyDTO [default][require]
```