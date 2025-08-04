# Accesso a repository GitHub con 2FA e SAML SSO

Questa guida spiega come configurare Git e/o la GitHub CLI per accedere a repository protetti da:
- Autenticazione a due fattori (2FA)

---

## ✅ Requisiti

- Account GitHub con 2FA abilitato
- Accesso a un’organizzazione GitHub che usa SAML SSO
- Git e/o GitHub CLI installati

---

## 🔐 Usare **SSH** per accedere ai repository

### 1. Generare una chiave SSH

Apri il terminale ed esegui:

    ssh-keygen -t ed25519 -C "tuo@email.com"

Premi `Enter` per accettare il percorso predefinito (`~/.ssh/id_ed25519`).  
Puoi lasciare vuota la passphrase.

---

### 2. Aggiungere la chiave SSH all’agente

    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519

---

### 3. Copiare la chiave pubblica

    cat ~/.ssh/id_ed25519.pub

Copia il contenuto visualizzato.

---

### 4. Aggiungere la chiave SSH su GitHub

1. Vai su [https://github.com/settings/keys](https://github.com/settings/keys)
2. Clicca **"New SSH key"**
3. Inserisci un titolo e incolla la chiave pubblica nel campo "Key"
4. Salva

---

### 5. Abilitare l'uso della porta 443 (per reti aziendali o VPN)

Modifica o crea il file `~/.ssh/config` e inserisci:

    Host github.com
      HostName ssh.github.com
      Port 443
      User git

---

---

## ✅ Test di connessione SSH

Puoi testare la connessione SSH con:

    ssh -T git@github.com

Dovresti vedere un messaggio simile a:

    Hi your-username! You've successfully authenticated, but GitHub does not provide shell access.

---

## ℹ️ Risorse utili

- Impostazioni 2FA GitHub:  
  https://github.com/settings/security

