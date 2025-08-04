# Embedded Systems and Computer Architecture Course Outline

---

## 1. Foundations of Embedded and Computer Systems

- **Introduction to Embedded Systems**
Sistemi specializzati integrati in dispositivi più grandi, spesso a tempo reale e con risorse limitate.
↳ [Intro](https://en.wikipedia.org/wiki/Embedded_system)

- **Computer Design Basics**
Fondamenti dell’architettura dei computer: CPU, ALU, unità di controllo e memoria.
↳ [Computer Architecture](https://en.wikipedia.org/wiki/Computer_architecture)

- **Instruction Set Architecture (ISA)**
Livello di astrazione che definisce istruzioni, registri e modalità di indirizzamento del processore.
↳ [ARM Info](https://developer.arm.com/architectures/cpu-architecture/m-profile)

- **Digital Logic & Analog Reminders**
Ripasso di logica combinatoria/sequenziale e circuiti analogici base come op-amp e comparatori.
↳ [Digital Logic](https://en.wikipedia.org/wiki/Digital_electronics) | [Op-Amps](https://en.wikipedia.org/wiki/Operational_amplifier)

---

## 2. Processor Architecture and Optimization Techniques

- **Pipelining and Hazards**
Tecnica per aumentare la parallelizzazione; include gestione di conflitti (hazards).
↳ [Pipelining](https://en.wikipedia.org/wiki/Instruction_pipelining)

- **Instruction-Level Parallelism (ILP)**
Esecuzione parallela di istruzioni per migliorare le prestazioni.
↳ [ILP (PDF)](https://www.cs.princeton.edu/courses/archive/fall04/cos471/papers/ilp.pdf)

- **Advanced Processors**
Architetture evolute (Superscalar, VLIW) e studi di caso su CPU moderne.
↳ [VLIW](https://en.wikipedia.org/wiki/Very_long_instruction_word)

- **Branch Prediction and Reordering**
Tecniche per prevedere salti condizionali e riordinare istruzioni per efficienza.
↳ [Branch Predictors](https://en.wikipedia.org/wiki/Branch_predictor)

- **Task-Level Parallelism (TLP)**
Parallelismo tra thread o processi su core multipli.
↳ [TLP](https://en.wikipedia.org/wiki/Task_parallelism)

---

## 3. Memory and Storage Systems

- **Volatile/Non-Volatile Memories**
Tipi di memoria: volatili (SRAM, DRAM) e non volatili (ROM, Flash, EEPROM).
↳ [Memory Types](https://en.wikipedia.org/wiki/Computer_memory)

- **Memory Timing and Interfaces**
Analisi dei tempi di accesso alla memoria e delle interfacce elettroniche.
↳ [Timing Diagrams](https://en.wikipedia.org/wiki/Timing_diagram_(digital_electronics))

- **Memory Hierarchies and Caches**
Organizzazione gerarchica della memoria (cache, RAM, storage) e gestione degli indirizzi.
↳ [Caches (PDF)](https://people.cs.pitt.edu/~childers/CS447/slides/memory.pdf)

---

## 4. Programmable and Integrated Logic Systems

- **Programmable Logic Devices**
Dispositivi configurabili come CPLD e FPGA usati per creare logica personalizzata.
↳ [FPGA Intro](https://www.intel.com/content/www/us/en/products/details/fpga/what-is-an-fpga.html)

- **Design Flow**
Processo di progettazione: RTL, sintesi, simulazione, layout fisico.
↳ [EDA Tools](https://en.wikipedia.org/wiki/Electronic_design_automation)

- **System-Level Design**
Modellazione a livello di sistema con SystemC, modelli sincroni e a flusso di dati.
↳ [SystemC](https://en.wikipedia.org/wiki/SystemC)

- **Formal Verification**
Metodi matematici per garantire correttezza funzionale, sicurezza e schedulabilità.
↳ [Formal Verification](https://en.wikipedia.org/wiki/Formal_verification)

---

## 5. Interfacing and Communication Protocols

- **Serial and Parallel Buses**
Protocolli di comunicazione come UART, SPI, I2C, USB, CAN, AMBA.
↳ [Protocols](https://en.wikipedia.org/wiki/Serial_communication)

- **Signal Integrity & Timing**
Gestione di integrità del segnale: ritardi, skew, crossing tra domini di clock.
↳ [Signal Integrity](https://en.wikipedia.org/wiki/Signal_integrity)

- **Bus Transactions**
Meccanismi di trasferimento dati su bus: arbitraggio, DMA, decodifica indirizzi.
↳ [Bus Arbitration](https://en.wikipedia.org/wiki/Bus_arbitration)

---

## 6. Processor Peripherals and I/O Systems

- **General Purpose Peripherals**
Periferiche standard: GPIO, timer, contatori, PWM, controller memoria.
↳ [GPIO](https://en.wikipedia.org/wiki/General-purpose_input/output)

- **Peripheral Control**
Tecniche di gestione: polling, interrupt e trasferimento via DMA.
↳ [Interrupts](https://en.wikipedia.org/wiki/Interrupt)

- **Analog I/O Systems**
Conversione ADC/DAC, tecniche di campionamento e condizionamento del segnale.
↳ [ADC/DAC](https://en.wikipedia.org/wiki/Analog-to-digital_converter)

---

## 7. Microcontroller Systems Programming

- **Embedded C & ASM**
Programmazione in C per microcontrollori con uso di assembly inline.
↳ [GCC Inline ASM](https://gcc.gnu.org/onlinedocs/gcc/Using-Assembly-Language-with-C.html)

- **Cortex-M3 Programming**
Programmazione a basso livello per ARM Cortex-M3: tick system, eccezioni, SVC.
↳ [Cortex-M3 Guide](https://developer.arm.com/documentation/dui0552/a/)

- **Human Interfaces**
Interfacce utente: debounce pulsanti, polling joystick, gestione display e speaker.
↳ [Debounce](https://www.ni.com/en-us/innovations/debounce.html)

- **Low Power Operation**
Modalità di risparmio energetico: sleep, deep sleep, gestione tensione.
↳ [Low Power Modes](https://developer.arm.com/documentation/101207/0200/Power-control-and-sleep-modes)

---

## 8. Power Electronics and Conversion

- **Power Devices and Drivers**
Controllo di dispositivi di potenza: MOSFET, H-bridge, driver alto/basso lato.
↳ [H-Bridge](https://en.wikipedia.org/wiki/H_bridge)

- **Voltage Regulation**
Regolazione di tensione: LDO lineari, convertitori switching (buck, boost).
↳ [Voltage Regulators](https://en.wikipedia.org/wiki/Voltage_regulator)

- **Thermal Design and Ripple Control**
Gestione termica dei circuiti e riduzione del ripple di alimentazione.
↳ [Thermal Design](https://www.eetimes.com/designing-for-thermal-management-in-electronics/)

---

## 9. RF and Analog Signal Processing

- **RF System Components**
Componenti RF: mixer, oscillatori, amplificatori (classe A, B, D, E).
↳ [RF Basics](https://www.rficworld.com/rf-basics/)

- **Nonlinear Circuits and Harmonic Balancing**
Analisi di circuiti non lineari e gestione degli armonici.
↳ [Harmonic Balance](https://en.wikipedia.org/wiki/Harmonic_balance)

- **Noise and Interference Management**
Tecniche per minimizzare rumore elettronico e interferenze.
↳ [Noise in Electronics](https://en.wikipedia.org/wiki/Noise_(electronics))

---

## 10. Physical Design and Semiconductor Technologies

- **MOS Gate Topologies**
Tecnologie logiche CMOS e varianti per circuiti digitali.
↳ [CMOS Logic](https://en.wikipedia.org/wiki/CMOS)

- **Fabrication Processes**
Processo di fabbricazione dei chip: layout, packaging, interconnessioni.
↳ [IC Fabrication](https://en.wikipedia.org/wiki/Photolithography)

- **Emerging Technologies**
Nuove tecnologie: FinFET, Tunnel FET, integrazione 3D.
↳ [FinFET](https://en.wikipedia.org/wiki/FinFET)

---

## 11. Algorithmic Mapping and Arithmetic Architectures

- **Algorithm-to-Architecture**
Tecniche di trasformazione algoritmica: pipelining, retiming, unfolding.
↳ [Pipelining Techniques](https://en.wikipedia.org/wiki/Pipeline_(computing))

- **Arithmetic Units**
Progettazione di unità aritmetiche: sommatrici, moltiplicatori, radici quadrate.
↳ [Arithmetic Circuits](https://en.wikipedia.org/wiki/Arithmetic_logic_unit)

- **On-Chip Interconnects**
Comunicazione interna ai chip tramite bus e reti NoC.
↳ [Networks on Chip](https://en.wikipedia.org/wiki/Network_on_a_chip)

---

## 12. Embedded Software Automation and Tooling

- **Scripting Tools**
Automazione con script da shell: bash, sed, grep.
↳ [Bash Scripting](https://www.gnu.org/software/bash/manual/bash.html)

- **Software Structure**
Strutturazione del firmware embedded: RTOS, versioning, CI/CD.
↳ [RTOS Integration](https://en.wikipedia.org/wiki/Real-time_operating_system)

- **C++ Automation**
Automazione e simulazione con C++ orientato agli oggetti.
↳ [C++ in Embedded](https://embeddedartistry.com/blog/2018/07/09/using-c-in-embedded-development/)

---

## 13. Digital Signal Processing and Wireless Communications

---

### 13.1 Fondamenti di Digital Signal Processing (DSP)

- **Introduction to DSP (4h)**
Concetti fondamentali del DSP: segnali discreti, sistemi LTI, risposte impulsive.
↳ [DSP Basics](https://en.wikipedia.org/wiki/Digital_signal_processing)

- **Sampling, Quantization and Aliasing (3h)**
Conversione da analogico a digitale e teoria del campionamento di Nyquist.
↳ [Sampling Theorem](https://en.wikipedia.org/wiki/Nyquist–Shannon_sampling_theorem)

- **DFT and FFT Algorithms (4h)**
Trasformata discreta di Fourier e algoritmi FFT per l’analisi in frequenza.
↳ [FFT](https://en.wikipedia.org/wiki/Fast_Fourier_transform)

- **Digital Filters (FIR, IIR) (4h)**
Progettazione e uso di filtri digitali a risposta finita e infinita.
↳ [Digital Filters](https://en.wikipedia.org/wiki/Digital_filter)

- **Spectral Analysis and Windowing (2h)**
Tecniche per analisi spettrale precisa: finestre (Hamming, Hann, Blackman).
↳ [Spectral Analysis](https://en.wikipedia.org/wiki/Spectral_density)

---

### 13.2 Codifica e Sincronizzazione nei Sistemi Digitali

- **Error Detection (CRC) and Correction (Block Codes) (6h)**
Tecniche per individuare e correggere errori nei dati digitali.
↳ [CRC](https://en.wikipedia.org/wiki/Cyclic_redundancy_check) | [ECC](https://en.wikipedia.org/wiki/Error_correction_code)

- **Randomizer and Data Scrambling (2h)**
Pre-elaborazione dei dati per migliorare la trasmissione.
↳ [Scrambling](https://en.wikipedia.org/wiki/Scrambler)

- **Frame and Symbol Synchronization (3h)**
Rilevamento accurato dell’inizio di trame e simboli ricevuti.
↳ [Frame Sync](https://en.wikipedia.org/wiki/Frame_synchronization)

---

### 13.3 Modulazioni Digitali e Modelli di Canale

- **Introduction to Digital Modulation (QAM, PSK, FSK) (3h)**
Tecniche di modulazione digitale e loro rappresentazione nel piano I/Q.
↳ [Digital Modulation](https://en.wikipedia.org/wiki/Digital_modulation)

- **Recap on QAM Modulations (2h)**
Approfondimento sulla modulazione QAM e sul numero di bit per simbolo.
↳ [QAM](https://en.wikipedia.org/wiki/Quadrature_amplitude_modulation)

- **OFDM Modulation (12h)**
Modulazione multicarrier che combatte il fading e ottimizza la banda.
↳ [OFDM](https://en.wikipedia.org/wiki/Orthogonal_frequency-division_multiplexing)

- **Multiplexing and Multiple Access (6h)**
TDM, FDM, CDMA, NOMA: tecniche per condividere risorse e canali.
↳ [Multiple Access](https://en.wikipedia.org/wiki/Multiple_access)

- **Wireless Channel Models (AWGN, Multipath, Doppler) (6h)**
Caratterizzazione di canali reali: rumore, fading, mobilità.
↳ [Wireless Channels](https://en.wikipedia.org/wiki/Wireless_channel_model)

- **Link Budget Analysis (5G & Space Links) (3h)**
Stima della potenza ricevuta in diversi scenari: satelliti, 5G.
↳ [Link Budget](https://en.wikipedia.org/wiki/Link_budget)

---

### 13.4 Sistemi Wireless, Reti Mobili e Applicazioni

- **Mobile Networks and D2D Communication (4h)**
Classificazione, topologie e comunicazione diretta tra dispositivi.
↳ [Device-to-Device](https://en.wikipedia.org/wiki/Device-to-device_communication)

- **Channel Access in Distributed Wireless Networks (6h)**
Tecniche MAC distribuite: CSMA, ALOHA, backoff.
↳ [MAC Protocols](https://en.wikipedia.org/wiki/Media_access_control)

- **The Bluetooth Technology (4h)**
Stack protocollare e funzionamento di Bluetooth Classic e BLE.
↳ [Bluetooth](https://en.wikipedia.org/wiki/Bluetooth)

- **Connected Cars: Services, Architecture, Challenges (4h)**
V2X, servizi ITS, architettura di rete e problemi di latenza/affidabilità.
↳ [Connected Cars](https://en.wikipedia.org/wiki/Connected_car)

- **Wireless Sensor Networks (5h)**
Architetture, applicazioni e tecniche di accesso per reti a basso consumo.
↳ [WSN](https://en.wikipedia.org/wiki/Wireless_sensor_network)

- **Routing Protocols for Mobile Networks (7h)**
Protocolli proattivi (OLSR) e reattivi (AODV) per topologie dinamiche.
↳ [Ad Hoc Routing](https://en.wikipedia.org/wiki/Routing_protocol)

- **Topology Control and Routing for Sensor Networks (4h)**
Strategie di ottimizzazione della topologia e del traffico in WSN.
↳ [Topology Control](https://en.wikipedia.org/wiki/Topology_control)

