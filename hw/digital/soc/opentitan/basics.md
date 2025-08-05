# OpenTitan – Interrupts, Alerts e IP di Sicurezza

## 1. Interrupt – **RV_PLIC** (RISC‑V Platform-Level Interrupt Controller)

**Scopo**
Gestisce gli interrupt standard originati da periferiche, con supporto claim/complete, priorità e threshold per il core RISC‑V Ibex.
[Documentazione OpenTitan](https://opentitan.org/book/hw/top_earlgrey/ip_autogen/rv_plic/?utm_source=chatgpt.com)

**Interfaccia bus (TL‑UL)**
Mappa registri: `PRIO_i`, `THRESHOLD0`, `IE0_n`, `IP`, `CC0` (Claim/Complete), `MSIP0`.
[Dettagli mappa registri](https://opentitan.org/book/hw/top_earlgrey/ip_autogen/rv_plic/data/rv_plic.html?utm_source=chatgpt.com)

**Flusso software**
Il driver legge `CC0` per ottenere l’ID di interrupt in attesa, gestisce l’evento, quindi scrive lo stesso ID in `CC0` per segnalare il completamento.
[Programmer's Guide](https://opentitan.org/book/hw/top_earlgrey/ip_autogen/rv_plic/doc/programmers_guide.html?utm_source=chatgpt.com)

**Approfondimenti esterni**
[Specifiche RISC‑V PLIC 1.0](https://courses.grainger.illinois.edu/ece391/su2025/docs/riscv-plic-1.0.0.pdf?utm_source=chatgpt.com) – Analisi dettagliata della logica claim/complete e priorità.

---

## 2. Alerts – **Alert Handler**

**Scopo**
Riceve segnali di alert (fault o attacchi) da IP critici, li classifica in 4 classi (A–D) e attiva escalation hardware se ignorati.
[Documentazione OpenTitan](https://opentitan.org/book/hw/top_earlgrey/ip_autogen/alert_handler/?utm_source=chatgpt.com)

**Interfaccia bus e hardware**
Configurazione via TL‑UL (registri per interrupt enable, stato classe, cause, timer) e connessioni multi-wire differenziali (MUBI) per handshake alert/ping/escalation.
[Theory of Operation](https://opentitan.org/book/hw/top_earlgrey/ip_autogen/alert_handler/doc/theory_of_operation.html?utm_source=chatgpt.com)

**Registri principali**
`CLASSx_EVENT`, `CLASSx_CLR`, `INTR_ENABLE`, `ALERT_CAUSE`, `LOC_ALERT_CAUSE`, timer escalation/ping timeout, regwen.
[Register Reference](https://opentitan.org/book/hw/top_earlgrey/ip_autogen/alert_handler/data/alert_handler.html?utm_source=chatgpt.com)

**Countermeasures**
Bus integrity, encoding MUBI, FSM sparse, ping timer ridondanti, shadow registers.

**Flusso software**
1. CPU riceve interrupt classe X
2. Legge `ALERT_CAUSE`, `LOC_ALERT_CAUSE`
3. Esegue `CLASSX_CLR` e clear di `INTR_STATE`
[Programmer's Guide](https://opentitan.org/book/hw/top_earlgrey/ip_autogen/alert_handler/doc/programmers_guide.html?utm_source=chatgpt.com)

**Approfondimenti esterni**
Checklist hardware/software DIF per la verifica di implementazione ([link](https://opentitan.org/book/hw/top_earlgrey/ip_autogen/alert_handler/doc/checklist.html?utm_source=chatgpt.com))

---

## 3. IP di Sicurezza (Security-Critical IP)

### **CSRNG**
- **Funzione**: Generatore sicuro di numeri pseudo-random conformi NIST e AIS31
- **Interfaccia**: comandi via TL‑UL, input da `entropy_src`, interrupt su `cs_cmd_req_done`, alert su fault
- **Contromisure**: FSM sparse, bus integrity, regwen, MUBI encoding
[Documentazione OpenTitan](https://opentitan.org/book/hw/ip/csrng/?utm_source=chatgpt.com)

### **Key Manager (keymgr)**
- **Funzione**: Gestione e derivazione sicura di chiavi root con KMAC
- **Interfaccia**: comandi TL‑UL, sideloading chiavi in AES/KMAC/OTBN
- **Interrupt**: `op_done`
- **Alert**: fault hardware/operativo
[Documentazione OpenTitan](https://opentitan.org/book/hw/ip/keymgr/?utm_source=chatgpt.com)

### **AES, KMAC, HMAC, OTBN**
- **Funzione**: Acceleratori crittografici con protezioni SCA/FI
- **Interfaccia**: TL‑UL, alert su bus corruption e FSM fault
[AES Theory of Operation](https://opentitan.org/book/hw/ip/aes/doc/theory_of_operation.html?utm_source=chatgpt.com)

### **Entropy Source** (`entropy_src`, edn)
- **Funzione**: Raccolta e filtraggio rumore fisico, output a CSRNG

### **sram_ctrl**, **pattgen**
- `sram_ctrl`: Memoria scrambled con wipe e integrità, alert su errori
- `pattgen`: Pattern generator con interrupt `done_chX` e alert integrità bus

**Approfondimenti esterni**
- [Performance evaluation su AES/HMAC/OTBN](https://arxiv.org/abs/2402.10395?utm_source=chatgpt.com)
- [SCRAMBLE‑CFI](https://arxiv.org/abs/2303.03711?utm_source=chatgpt.com) – Protezione hardware da fault injection con Control-Flow Integrity
- [Antmicro: Pre-silicon secure ASIC development](https://antmicro.com/blog/2023/03/pre-silicon-secure-asic-development-based-on-opentitan-in-renode/?utm_source=chatgpt.com)

---

## 📊 Riepilogo Tabellare

| Categoria| IP | Interrupt / Alert | Contromisure sicurezza| Documenti OpenTitan | Riferimenti esterni|
|------------------------|------------------------|------------------------------------------|-----------------------------------------------------------------------|------------------------------------------|-----------------------------------------|
| Interrupt| RV_PLIC| Interrupt standard, claim/complete | Priorità, threshold, bus integrity | [Spec](https://opentitan.org/book/hw/top_earlgrey/ip_autogen/rv_plic/doc/theory_of_operation.html?utm_source=chatgpt.com) / [Guide](https://opentitan.org/book/hw/top_earlgrey/ip_autogen/rv_plic/doc/programmers_guide.html?utm_source=chatgpt.com) | [RISC‑V PLIC spec](https://courses.grainger.illinois.edu/ece391/su2025/docs/riscv-plic-1.0.0.pdf?utm_source=chatgpt.com) |
| Alert Handler| alert_handler| Alert → interrupt di classe A–D → escalation | Differential/MUBI encoding, ping timer, FSM sparse, regwen | [Spec](https://opentitan.org/book/hw/top_earlgrey/ip_autogen/alert_handler/?utm_source=chatgpt.com) / [Theory](https://opentitan.org/book/hw/top_earlgrey/ip_autogen/alert_handler/doc/theory_of_operation.html?utm_source=chatgpt.com) / [Registers](https://opentitan.org/book/hw/top_earlgrey/ip_autogen/alert_handler/data/alert_handler.html?utm_source=chatgpt.com) | [Checklist](https://opentitan.org/book/hw/top_earlgrey/ip_autogen/alert_handler/doc/checklist.html?utm_source=chatgpt.com) |
| Security-critical IP | CSRNG, keymgr, AES, KMAC, OTBN, sram_ctrl, pattgen | Interrupt sui comandi, Alert su fault | FSM sparse, masking, bus integrity, side-channel protections| [Security Docs](https://opentitan.org/book/doc/security/?utm_source=chatgpt.com) / [Top Earlgrey Design](https://opentitan.org/book/hw/top_earlgrey/doc/design/index.html?utm_source=chatgpt.com) | [Performance paper](https://arxiv.org/abs/2402.10395?utm_source=chatgpt.com), [SCRAMBLE‑CFI](https://arxiv.org/abs/2303.03711?utm_source=chatgpt.com) |

---

## 🔍 Esempio Pratico Completo: Generazione Sicura di Chiavi con Key Manager

**Scenario**: Il software deve generare una chiave per AES senza mai esporla in memoria software.

1. **Configurazione**
 - Software configura `keymgr` via TL‑UL impostando parametri di derivazione (`generate`).
2. **Interazione hardware**
 - `keymgr` richiede entropia a `CSRNG` (che la ottiene da `entropy_src`).
 - Usa KMAC per derivare la chiave secondo policy hardware.
3. **Sideloading**
 - La chiave derivata viene inviata internamente all’IP AES tramite bus interno, non visibile alla CPU.
4. **Segnalazione completamento**
 - `keymgr` genera interrupt `op_done` → PLIC lo inoltra alla CPU.
5. **Gestione software**
 - Driver keymgr legge stato e conferma operazione.
6. **Gestione errori**
 - Se durante l’operazione si verifica un fault (es. integrità bus), `keymgr` invia alert → `alert_handler` lo classifica → CPU riceve interrupt → se ignorato → escalation hardware (reset/wipe).


