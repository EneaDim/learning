# 📚 Teoria: Basi di Computer, Sistema Operativo, Linux e Shell

🔗 Approfondimento: [Polito - Informatica](https://github.com/polito-informatica)

---

## 1️⃣ Concetti base di informatica
**Definizione generale:**
L’informatica è la disciplina che studia i metodi e le tecnologie per elaborare informazioni in modo automatico utilizzando calcolatori.
Si occupa della rappresentazione dei dati, della loro elaborazione e della comunicazione tra sistemi.

**Concetti fondamentali:**
- **Dati:** rappresentazioni grezze di fatti o misurazioni (es. numeri, testi, immagini).
- **Informazione:** dati interpretati e dotati di significato.
- **Programma:** insieme strutturato di istruzioni che un computer può eseguire.
- **Algoritmo:** sequenza finita e ordinata di operazioni per risolvere un problema.

🔗 Approfondimento: [Wikipedia – Informatica](https://it.wikipedia.org/wiki/Informatica)
🔗 Approfondimento: [Youtube – Informatica](https://youtu.be/CxGSnA-RTsA)

---

## 2️⃣ Architettura di un computer
**Definizione generale:**
L’architettura di un computer è la struttura logica e fisica dei suoi componenti e il modo in cui interagiscono per eseguire istruzioni.

**Componenti principali dell’hardware:**
- **CPU (Central Processing Unit):** esegue le istruzioni dei programmi e coordina tutte le operazioni.
- **RAM (Random Access Memory):** memoria temporanea e volatile dove vengono caricati dati e istruzioni in uso.
- **Memoria di massa:** dispositivi di archiviazione persistente (HDD, SSD, NVMe) per salvare dati a lungo termine.
- **Scheda madre:** circuito principale che collega CPU, memoria e periferiche.
- **Dispositivi di input:** strumenti per fornire dati al computer (tastiera, mouse, scanner).
- **Dispositivi di output:** strumenti per visualizzare o produrre risultati (monitor, stampante, altoparlanti).
- **Dispositivi di rete:** hardware per la connessione a reti locali o Internet (schede Ethernet, Wi-Fi).

**Componenti principali del software:**
- **Sistema operativo:** gestisce risorse e interfacce tra hardware e applicazioni.
- **Applicazioni:** programmi che eseguono compiti specifici per l’utente.
- **Utility:** strumenti di supporto per la manutenzione e configurazione del sistema.

🔗 Approfondimento: [Wikipedia – Architettura del computer](https://it.wikipedia.org/wiki/Computer)

---

## 3️⃣ Cos’è un sistema operativo
**Definizione generale:**
Un sistema operativo (SO) è un software di base che gestisce risorse hardware e software, fornisce servizi ai programmi e un’interfaccia agli utenti.

**Funzioni principali:**
1. **Gestione processi:** avvio, sospensione e terminazione dei programmi in esecuzione.
2. **Gestione memoria:** allocazione e liberazione di RAM e spazio di swap.
3. **Gestione file system:** organizzazione, creazione, lettura e scrittura dei file.
4. **Gestione periferiche:** controllo di dispositivi hardware tramite driver.
5. **Sicurezza:** protezione delle risorse tramite utenti, permessi e autenticazione.
6. **Interfaccia utente:** strumenti per interagire col sistema (CLI o GUI).

🔗 Approfondimento: [Wikipedia – Sistema operativo](https://it.wikipedia.org/wiki/Sistema_operativo)

---

## 4️⃣ Organizzazione di Linux
**Definizione generale:**
Linux è un sistema operativo libero e open-source, derivato da Unix, formato dal kernel Linux e da un insieme di strumenti, librerie e applicazioni.

**Componenti principali:**
- **Kernel Linux:** gestisce risorse hardware e processi.
- **GNU Tools:** insieme di comandi e utilità di base (ls, cp, mv…).
- **Librerie di sistema:** funzioni comuni per i programmi.
- **Gestore pacchetti:** sistema per installare e aggiornare software.
- **Ambiente desktop:** interfaccia grafica opzionale (GNOME, KDE, XFCE).

🔗 Approfondimento: [GNU/Linux – Wikipedia](https://it.wikipedia.org/wiki/Linux)
🔗 Approfondimento: [GNU/Linux – Youtube](https://youtu.be/h_xSovNStSE)

---

## 5️⃣ Kernel, Shell e Terminale
**Definizione generale:**
Sono tre elementi distinti che collaborano per permettere all’utente di comunicare con il sistema.

**Componenti:**
- **Kernel:** nucleo del sistema operativo, interagisce direttamente con l’hardware.
- **Shell:** interprete dei comandi che riceve input dall’utente e comunica col kernel.
- **Terminale:** programma che fornisce l’interfaccia testuale per usare la shell.

🔗 Approfondimento: [Kernel.org – Cos’è il kernel](https://www.kernel.org/doc/html/latest/)

---

## 6️⃣ File system di Linux e gerarchia
**Definizione generale:**
Il file system è l’organizzazione logica dei file e delle directory, strutturata ad albero con un’unica radice `/`.

**Directory principali:**
- **`/`**: radice del sistema.
- **`/home`**: directory degli utenti.
- **`/etc`**: file di configurazione.
- **`/bin`** e **`/usr/bin`**: programmi eseguibili.
- **`/var`**: file variabili (log, cache).
- **`/tmp`**: file temporanei.
- **`/dev`**: rappresentazione dei dispositivi hardware come file.
- **`/mnt`** e **`/media`**: punti di montaggio.

🔗 Approfondimento: [Filesystem Hierarchy Standard](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html)
🔗 Approfondimento: [Filesystem Hierarchy Standard - Youtube](https://youtu.be/995-SYn6960)

---

## 7️⃣ Avvio del sistema
**Definizione generale:**
Il processo di avvio (boot) è la sequenza di operazioni che porta il computer dallo stato spento alla piena operatività.

**Fasi:**
1. **BIOS/UEFI:** inizializza l’hardware.
2. **Bootloader (GRUB):** seleziona e carica il kernel.
3. **Kernel:** inizializza risorse e driver.
4. **Init system:** avvia servizi di sistema.
5. **Login:** autenticazione dell’utente.
6. **Sessione utente:** ambiente pronto all’uso.

🔗 Approfondimento: [Ubuntu – Boot process](https://wiki.ubuntu.com/BootProcess)

---

## 8️⃣ Utenti e permessi
**Definizione generale:**
Linux è multiutente, ogni utente ha un’identità e permessi specifici per accedere a file e risorse.

**Concetti:**
- **UID:** identificativo univoco utente.
- **GID:** identificativo univoco gruppo.
- **Permessi:** lettura (r), scrittura (w), esecuzione (x).
- **Categorie:** utente (u), gruppo (g), altri (o).

🔗 Approfondimento: [Linux – Permessi dei file](https://linuxcommand.org/lc3_lts0090.php)

---

## 9️⃣ Processi e gestione delle risorse
**Definizione generale:**
Un processo è un programma in esecuzione, gestito dal kernel tramite il multitasking.

**Caratteristiche:**
- **PID:** identificativo univoco del processo.
- **Stato:** running, sleeping, zombie.
- **Risorse:** CPU, memoria, file aperti.
- **Priorità:** influenza l’ordine di esecuzione.

🔗 Approfondimento: [Linux – Process Management](https://tldp.org/LDP/tlk/kernel/processes.html)
🔗 Approfondimento: [Linux – Process Management - Youtube](https://youtu.be/JxbhrVmN6XU)

---

## 1️⃣0️⃣ Introduzione alla shell
**Definizione generale:**
La shell è un interprete dei comandi che permette di interagire col sistema operativo.

**Tipi:**
- **Interattiva:** comandi scritti dall’utente.
- **Non interattiva:** esecuzione di script.

**Funzioni:**
- Gestione variabili di ambiente.
- Uso di pipe e redirezioni.
- Automazione con script bash.

🔗 Approfondimento: [GNU Bash Manual](https://www.gnu.org/software/bash/manual/bash.html)

---

## 1️⃣1️⃣ Perché usare il terminale
**Definizione generale:**
Il terminale offre un’interfaccia testuale che consente un controllo diretto e avanzato del sistema.

**Vantaggi:**
- Maggior controllo.
- Automazione.
- Funzioni avanzate.
- Rapidità di esecuzione.
- Fondamentale per server e sistemi embedded.

🔗 Approfondimento: [Why use the Linux terminal](https://ubuntu.com/tutorials/command-line-for-beginners#1-overview)

---

# 🐧 Terminale Linux da Zero

## 1️⃣ Installazione di Ubuntu (distribuzione Linux) su WSL

WSL (Windows Subsystem for Linux) permette di eseguire Ubuntu direttamente su Windows senza una macchina virtuale.

### Passaggi
1. Apri **PowerShell** come amministratore:
 Dal menu Start (barra di ricerca) cerca **PowerShell**, clicca con il tasto destro e scegli **Esegui come amministratore**.
2. Installa WSL con Ubuntu:
 `wsl --install -d Ubuntu`
3. Riavvia il computer se richiesto.
4. Alla prima apertura di Ubuntu, imposta un **nome utente** e una **password** Linux.
5. Avvia Ubuntu dal menu Start.

---

## 2️⃣ Introduzione

Il terminale Linux è un’interfaccia testuale che consente di comunicare con il sistema operativo.
Su Ubuntu, la **shell** (tipicamente `bash`) interpreta i comandi e mostra i risultati.

---

## 3️⃣ Avviare WSL con Ubuntu

1. Dal menu Start (barra di ricerca) cerca **WSL**
2. Avvia l’applicazione.
3. Attendi il prompt (`utente@PC:~$`) che indica che sei pronto a digitare comandi.

---

## 4️⃣ Installare GVim

GVim è la versione grafica di `vim`, un editor di testo potente.

Per installarlo in Ubuntu su WSL:
1. Aggiorna la lista dei pacchetti:
 `sudo apt update`
2. Installa GVim:
 `sudo apt install vim-gtk3`

---

## 5️⃣ Spiegare `sudo` e `apt`

- **`sudo`** (*superuser do*): esegue comandi con privilegi di amministratore.
- **`apt`** (*Advanced Package Tool*): gestisce l’installazione, aggiornamento e rimozione di programmi su Ubuntu.

Esempio:
`sudo apt install vim-gtk3`
`sudo` concede i permessi di amministratore, `apt install` avvia l’installazione, `vim-gtk3` è il pacchetto da installare.

---

## 6️⃣ Esempio: creazione di un file con GVim

1. Vai nella tua home:
 `cd ~`
2. Verifica dove ti trovi:
 `pwd`
 (es. `/home/tuo_utente`)
3. Crea o apri un file con GVim:
 `gvim appunti.txt`
4. Premi `i` per entrare in modalità inserimento.
5. Scrivi:
 Questi sono i miei primi appunti su Ubuntu in WSL.
6. Premi `Esc`, digita `:wq` e premi `Invio` per salvare ed uscire.
7. Visualizza il contenuto:
 `cat appunti.txt`

---

## 7️⃣ Tabella comandi base di Vim

| Modalità| Tasto | Azione|
|-----------|--------|---------------------------------------|
| Normale | i| Inserire testo (modalità inserimento) |
| Normale | :w | Salvare |
| Normale | :q | Uscire|
| Normale | :wq| Salvare e uscire|
| Normale | u| Annulla ultima modifica |
| Normale | /testo | Cercare la parola "testo" |
| Normale | dd | Eliminare la riga corrente|
| Normale | yy | Copiare la riga corrente|
| Normale | p| Incollare il testo copiato|

---

## 4️⃣ Comandi principali della shell

### 4.1 pwd – Mostra directory corrente
Uso: mostra il percorso assoluto della directory in cui ti trovi.
Opzioni principali:
- Nessuna opzione: percorso corrente
- -P: mostra il percorso fisico (senza link simbolici)

Esempi:
1. `pwd`
2. `pwd -P`

---

### 4.2 ls – Elenca file e directory
Uso: mostra il contenuto di una directory.
Opzioni principali:
- -l: formato lungo (dettagli)
- -a: mostra anche file nascosti
- -h: dimensioni leggibili (KB, MB)
- -t: ordina per data

Esempi:
1. `ls -la`
2. `ls -lh /var/log`

---

### 4.3 cd – Cambia directory
Uso: spostarsi tra directory.
Opzioni principali:
- cd /path/: vai alla directory specificata
- cd ~: vai alla home dell’utente
- cd -: torna alla directory precedente

Esempi:
1. `cd /etc`
2. `cd -`

---

### 4.4 cp – Copia file o directory
Uso: copia file o cartelle.
Opzioni principali:
- -r: copia ricorsiva (cartelle)
- -i: chiede conferma prima di sovrascrivere
- -v: output dettagliato

Esempi:
1. `cp file1.txt file2.txt`
2. `cp -rv cartella1/ cartella2/`

---

### 4.5 mv – Sposta o rinomina
Uso: sposta file/cartelle o rinomina.
Opzioni principali:
- -i: conferma prima di sovrascrivere
- -v: mostra le operazioni

Esempi:
1. `mv documento.txt documento_vecchio.txt`
2. `mv /tmp/file.txt /home/user/`

---

### 4.6 rm – Rimuove file o directory
Uso: elimina file o cartelle.
Opzioni principali:
- -r: elimina ricorsivamente
- -i: chiede conferma prima di cancellare
- -f: forza la rimozione senza conferma

Esempi:
1. `rm file.txt`
2. `rm -rf cartella/`

---

### 4.7 mkdir – Crea una directory
Uso: crea una nuova cartella.
Opzioni principali:
- -p: crea directory annidate senza errori

Esempi:
1. `mkdir nuova_cartella`
2. `mkdir -p cartella1/cartella2/cartella3`

---

### 4.8 rmdir – Rimuove directory vuote
Uso: elimina cartelle vuote.
Opzioni principali:
- Nessuna opzione: rimuove solo directory vuote

Esempi:
1. `rmdir cartella_vuota`
2. `rmdir -p cartella1/cartella2 (se entrambe vuote)`

---

### 4.9 touch – Crea file vuoti o aggiorna timestamp
Uso: crea un file vuoto o aggiorna la data di modifica.
Opzioni principali:
- -c: non crea file se non esiste
- -t: imposta una data e ora specifica

Esempi:
1. `touch nuovo_file.txt`
2. `touch -t 202501011200 file.txt`

---

### 4.10 cat – Visualizza contenuto di file
Uso: stampa il contenuto di uno o più file.
Opzioni principali:
- -n: mostra numeri di riga

Esempi:
1. `cat documento.txt`
2. `cat -n documento.txt`

---

### 4.11 grep – Cerca testo all’interno di file
Uso: cerca una stringa o un’espressione regolare all’interno di file o output.
Opzioni principali:
- -i: ignora maiuscole/minuscole
- -n: mostra numeri di riga
- -r: ricerca ricorsiva nelle cartelle
- --color: evidenzia il testo trovato

Esempi:
1. `grep "errore" log.txt`
2. `grep -rin --color "main" src/`

---

### 4.12 sed – Editor di flussi per modifiche di testo
Uso: `sed` (stream editor) permette di filtrare e trasformare testo in modo non interattivo, leggendo da file o input standard e producendo un output modificato.
Opzioni principali:
- `-n`: sopprime l’output automatico (utile per mostrare solo il risultato di comandi specifici)
- `-e`: specifica un comando di modifica direttamente nella riga di comando
- `-i`: modifica direttamente il file (in-place)
- `s/pattern/sostituzione/`: sostituisce la prima occorrenza di “pattern” con “sostituzione” in ogni riga
- `g` alla fine del comando di sostituzione: sostituisce **tutte** le occorrenze nella riga

Esempi:
1. `sed 's/ciao/salve/' file.txt`
 (sostituisce la prima occorrenza di “ciao” con “salve” in ogni riga)

2. `sed -i 's/error/ok/g' log.txt`
 (modifica direttamente il file log.txt sostituendo **tutte** le occorrenze di “error” con “ok”)

---

### 4.13 ps – Mostra i processi in esecuzione
Uso: elenca i processi attivi nel sistema.
Opzioni principali:
- -e: mostra tutti i processi
- -f: formato completo con dettagli
- aux: mostra tutti i processi con uso CPU e memoria

Esempi:
1. `ps -ef`
2. `ps aux | grep firefox`

---

### 4.14 df – Mostra lo spazio disco disponibile
Uso: visualizza lo spazio libero e occupato sui filesystem.
Opzioni principali:
- -h: formato leggibile (KB, MB, GB)
- -T: mostra tipo di filesystem

Esempi:
1. `df -h`
2. `df -hT /home`

---

### 4.15 du – Mostra spazio occupato da file e directory
Uso: calcola lo spazio utilizzato da file e cartelle.
Opzioni principali:
- -h: formato leggibile
- -s: solo totale per ogni directory
- -c: totale complessivo

Esempi:
1. `du -sh /var/log`
2. `du -h --max-depth=1 /home`

---

### 4.16 find – Cerca file e directory nel filesystem
Uso: ricerca file o cartelle in base a nome, tipo, dimensione o altri criteri.
Opzioni principali:
- -name: cerca per nome
- -type: tipo di file (f = file, d = directory)
- -size: filtra per dimensione
- -exec: esegue un comando sui risultati

Esempi:
1. `find /home/user -name "*.txt"`
2. `find /var/log -type f -size +10M -exec ls -lh {} \;`

---

### 4.17 chmod – Modifica i permessi di file e directory
Uso: cambia i permessi di lettura, scrittura ed esecuzione.
Opzioni principali:
- Modalità simbolica: u (utente), g (gruppo), o (altri), a (tutti), con + (aggiungi), - (rimuovi), = (imposta)
- Modalità numerica: valori 4 (lettura), 2 (scrittura), 1 (esecuzione)
- -R: applica ricorsivamente alle sottodirectory

Esempi:
1. `chmod u+x script.sh` (aggiunge permesso di esecuzione all’utente)
2. `chmod 755 programma` (utente: lettura/scrittura/esecuzione, gruppo e altri: lettura/esecuzione)

---

### 4.18 kill – Termina un processo
Uso: invia un segnale a un processo per terminarlo o modificarne lo stato.
Opzioni principali:
- -9: termina forzatamente il processo (SIGKILL)
- -15: termina in modo gentile (SIGTERM)
- -l: elenca tutti i segnali disponibili

Esempi:
1. `kill -15 1234` (termina il processo con PID 1234 in modo gentile)
2. `kill -9 5678` (termina forzatamente il processo con PID 5678)

---

# 📚 Concetti base del linguaggio C (con array e puntatori)

## 1️⃣ `#include`
Serve per inserire in un programma il contenuto di un altro file, spesso file di intestazione `.h` con dichiarazioni di funzioni.  
Esempio:  
`#include <stdio.h>`    → importa funzioni di input/output come printf, scanf, fopen, fclose.

---

## 2️⃣ `#define`
Usato per creare **costanti** o **macro** sostituite dal preprocessore prima della compilazione.  
Esempio:  
`#define MAX 100`    → ovunque nel codice si scrive MAX, il compilatore usa 100.

---

## 3️⃣ Variabili e tipi di variabile
Una variabile è uno spazio in memoria per memorizzare un dato. Il tipo della variabile definisce dimensione e formato dei dati.

Tipi principali:
- int → intero (es. 42)
- float → decimale singola precisione (es. 3.14)
- double → decimale doppia precisione
- char → carattere singolo (es. 'A')
- char[] → stringa (sequenza di caratteri terminata da '\0')

---

## 4️⃣ Array
Un array è una sequenza di elementi dello stesso tipo memorizzati in posizioni contigue in memoria.

Esempio array di interi:  
int numeri[5] = {1, 2, 3, 4, 5};  

Accesso agli elementi:  
numeri[0] = 10;   → modifica il primo elemento  
printf("%d", numeri[2]);   → stampa il terzo elemento

---

## 5️⃣ Puntatori
Un puntatore è una variabile che contiene l’indirizzo di memoria di un’altra variabile.

Esempio:  
int x = 5;  
int *p = &x;   → p contiene l’indirizzo di x  
printf("%d", *p);   → stampa il valore di x usando il puntatore  

Puntatori e array:  
Il nome di un array (`numeri`) è in realtà un puntatore al primo elemento.  
*numeri equivale a numeri[0].

---

## 6️⃣ Strutture condizionali (`if` / `else`)
Permettono di eseguire istruzioni in base a condizioni.

Esempio:  

```c
if (x > 0) {  
    printf("x positivo");  
} else {  
    printf("x negativo o zero");  
}
```

---

## 7️⃣ Ciclo `for`
Serve per iterare un blocco di codice un numero noto di volte.

Esempio

```c
for (int i = 0; i < 5; i++) {  
    printf("%d\n", i);  
}
```

---

## 8️⃣ Ciclo `while`
Serve per ripetere un blocco finché una condizione è vera.

Esempio

```c
while (x < 10) {  
    x++;  
}
```

---

## 9️⃣ File handling (con array e puntatori)
Il C gestisce i file tramite puntatori a FILE e funzioni della libreria <stdio.h>.

Principali funzioni:

- fopen(nome, modalità) → apre un file.
```c
  FILE *f = fopen("dati.txt", "r");  
  if (f == NULL) {  
      perror("Errore apertura file");  
  }
```

- fclose(file) → chiude un file.  
```c
  fclose(f);
```

- fprintf(file, formato, dati) → scrive su un file.  
```c
  FILE *f = fopen("output.txt", "w");  
  int numeri[3] = {10, 20, 30};  
  for (int i = 0; i < 3; i++) {  
      fprintf(f, "Numero: %d\n", numeri[i]);  
  }  
  fclose(f);
```

- fscanf(file, formato, &variabili) → legge da un file.  
```c
  FILE *f = fopen("input.txt", "r");  
  int x;  
  while (fscanf(f, "%d", &x) == 1) {  
      printf("%d\n", x);  
  }  
  fclose(f);
```

- fgets(buffer, dimensione, file) → legge una riga intera.  
```c
  FILE *f = fopen("testo.txt", "r");  
  char riga[100];  
  while (fgets(riga, sizeof(riga), f) != NULL) {  
      printf("%s", riga);  
  }  
  fclose(f);
```

---

## 🔟 Esempio completo con array, puntatori e file
Questo programma:
1. Legge numeri da `numeri.txt`  
2. Li salva in un array  
3. Calcola la somma usando un puntatore  
4. Scrive il risultato in `somma.txt`

```c
#include <stdio.h>  
#define MAX 100  

int main() {  
    FILE *in, *out;  
    int numeri[MAX];  
    int *p = numeri;   // puntatore al primo elemento dell’array  
    int count = 0, somma = 0;  

    in = fopen("numeri.txt", "r");  
    if (in == NULL) {  
        perror("Errore apertura numeri.txt");  
        return 1;  
    }  

    // Lettura numeri dal file  
    while (fscanf(in, "%d", p) == 1) {  
        p++;        // sposta il puntatore al prossimo elemento  
        count++;  
    }  
    fclose(in);  

    // Calcolo somma usando il puntatore  
    p = numeri;  
    for (int i = 0; i < count; i++) {  
        somma += *(p + i);  
    }  

    // Scrittura risultato  
    out = fopen("somma.txt", "w");  
    if (out == NULL) {  
        perror("Errore apertura somma.txt");  
        return 1;  
    }  
    fprintf(out, "Somma dei numeri: %d\n", somma);  
    fclose(out);  

    printf("Elaborazione completata, somma salvata in somma.txt\n");  
    return 0;  
}
```


---

# 📂 Esempio in C con strutture dati, file di input e output (Ubuntu su WSL)

## Diagramma testuale del programma

[INPUT FILE: studenti.txt]
↓
[LETTURA DATI] → Legge da file e salva in un array di strutture `Studente`
↓
[ELABORAZIONE] → Calcola la media dei voti di ciascuno studente
↓
[SCRITTURA DATI] → Salva i risultati (nome, età, media) in un file `report.txt`
↓
[FINE PROGRAMMA]

---

## File di input di esempio (`studenti.txt`)

Mario Rossi 20 28 30 25
Luigi Bianchi 22 27 26 29
Anna Verdi 21 30 30 30

Ogni riga: Nome Cognome Età Voto1 Voto2 Voto3

---

## Codice C completamente commentato (`studenti.c`)

```c
#include <stdio.h> // Libreria standard per input/output
#include <stdlib.h>// Libreria per funzioni di allocazione memoria e gestione
#include <string.h>// Libreria per funzioni di manipolazione stringhe

// Definizione di una struttura per memorizzare i dati di uno studente
struct Studente {
  char nome[50];    // Nome dello studente
  char cognome[50]; // Cognome dello studente
  int eta;          // Età dello studente
  int voti[3];      // Array di 3 voti
  float media;      // Media calcolata dei voti
};

int main() {
  FILE *input, *output;          // Puntatori a file per input e output
  struct Studente studenti[100]; // Array di strutture Studente (max 100 studenti)
  int count = 0;                 // Numero di studenti letti
  
  // Apertura del file di input in modalità lettura
  input = fopen("studenti.txt", "r");
  if (input == NULL) { // Controllo apertura file
    perror("Errore nell'aprire studenti.txt");
    return 1;          // Uscita con codice di errore
  }
  
  // Lettura riga per riga dal file e salvataggio nei campi della struttura
  while (fscanf(input, "%s %s %d %d %d %d",
    studenti[count].nome,
    studenti[count].cognome,
    &studenti[count].eta,
    &studenti[count].voti[0],
    &studenti[count].voti[1],
    &studenti[count].voti[2]) == 6) {
    
    // Calcolo della media dei voti
    studenti[count].media = (studenti[count].voti[0] +
                             studenti[count].voti[1] +
                             studenti[count].voti[2]) / 3.0f;
    
    count++; // Incremento del numero di studenti letti
  }
  
  // Chiusura del file di input
  fclose(input);
  
  // Apertura del file di output in modalità scrittura
  output = fopen("report.txt", "w");
  if (output == NULL) {
    perror("Errore nel creare report.txt");
    return 1;
  }
  
  // Scrittura dei risultati nel file di output
  for (int i = 0; i < count; i++) {
    fprintf(output, "Studente: %s %s, Età: %d, Media voti: %.2f\n",
    studenti[i].nome,
    studenti[i].cognome,
    studenti[i].eta,
    studenti[i].media);
  }
  
  // Chiusura del file di output
  fclose(output);
  
  // Messaggio di conferma
  printf("Elaborazione completata. Risultati salvati in report.txt\n");
  
  return 0;// Uscita con codice 0 (successo)
}
```


---

## Compilazione con `gcc`

`gcc studenti.c -o studenti`

---

## Esecuzione

`./studenti`

---

## Risultato atteso in `report.txt`

Studente: Mario Rossi, Età: 20, Media voti: 27.67
Studente: Luigi Bianchi, Età: 22, Media voti: 27.33
Studente: Anna Verdi, Età: 21, Media voti: 30.00

---

## Spiegazione hardware del processo

1. **Codice sorgente** (`studenti.c`) memorizzato su disco.
2. **Compilazione con `gcc`**:
 - Traduzione in linguaggio macchina comprensibile alla CPU.
 - Link con librerie di sistema (es. funzioni di `stdio.h`).
3. **Esecuzione dell’eseguibile**:
 - Il kernel Linux carica il programma in RAM.
 - La CPU legge le istruzioni dalla RAM ed esegue:
 - Lettura da disco (`studenti.txt`) → controller del disco → RAM
 - Elaborazione dei dati in CPU (calcolo medie)
 - Scrittura dei risultati su disco (`report.txt`)
4. **Uscita**: il programma libera la memoria e termina.

---

