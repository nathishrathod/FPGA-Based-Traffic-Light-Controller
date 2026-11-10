# 🚦 FPGA-Based Traffic Light Controller with Priority System

## Overview
Verilog-based 2-way traffic light controller (North–South and East–West) with **emergency vehicle priority override**.  
Designed for FPGA implementation (e.g., Xilinx Spartan) and fully simulated online using **EDA Playground / Vivado**.  
This repository contains the Verilog design, testbench, and waveform output demonstrating the system’s behavior.

---

## 🧩 Files Included
- `traffic_controller.v` — Main Verilog RTL Design  
- `tb_traffic.v` — Testbench (stimulus and waveform generation)  
- `waveform.png` — Screenshot of simulation waveform  
- `README.md` — Project documentation (this file)

---

## 📊 Simulation Waveform

The waveform below demonstrates:
- Normal operation cycle (NS Green → NS Yellow → All-Red → EW Green → EW Yellow → All-Red → repeat)
- Priority override for emergency vehicles (`emg_ns` or `emg_ew`) that immediately grants a Green signal to that direction

**Waveform Output:**

![Traffic Light Waveform](./outputwaveform.PNG)

---

## ⚙️ Key Features
- Fully **digital FSM-based traffic controller**
- **Emergency vehicle priority** handling (via `emg_ns` and `emg_ew`)
- **Synchronous design** using clock and reset
- **Configurable timing** parameters (for simulation and FPGA)
- Easily portable to FPGA tools like **Vivado** or **Quartus**

---

## 🧾 Results Summary
✅ Smooth state transitions  
✅ Correct light sequencing for both directions  
✅ Proper emergency override response  
✅ Verified waveform output (EPWave/Vivado)

---

## 👨‍💻 Author
**Nathish Rathod**  
📧 Email: [nathishrathod3774@gmail.com](mailto:nathishrathod3774@gmail.com)  
🔗 LinkedIn: [linkedin.com/in/nathish-rathod](http://linkedin.com/in/nathish-rathod)

---

## 🏁 Conclusion
This project demonstrates a simple yet effective FPGA-based **Traffic Light Controller with Emergency Priority System**.  
It showcases your understanding of **FSM design**, **Verilog coding**, and **simulation analysis** — making it ideal for both **academic submission** and **portfolio presentation**.

---
