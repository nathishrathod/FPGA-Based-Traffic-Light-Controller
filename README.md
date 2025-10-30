# 🚦 FPGA-Based Traffic Light Controller with Priority System

## 📘 Overview
This project implements a **2-way traffic light controller** using **Verilog HDL**, designed for FPGA platforms such as **Xilinx Spartan**.  
The system automatically manages traffic lights for **North-South (NS)** and **East-West (EW)** directions and includes an **emergency vehicle priority override system**.

✅ Fully simulated using **EDA Playground** and **Vivado/ModelSim**.  
No physical hardware required — only simulation proof via waveform.

---

## 🧠 Objective
- To design and simulate an FPGA-based traffic light controller.
- To integrate an **emergency override mechanism** to prioritize emergency vehicles.
- To verify correct behavior via **waveform simulation**.

---

## ⚙️ Features
- FSM (Finite State Machine)-based design.
- Directional control: NS ↔ EW traffic cycle.
- Emergency input overrides normal operation.
- Synthesizable on FPGA hardware (Spartan, Artix, etc.).
- Clean simulation output waveform confirming logic correctness.

---

## 🧩 Tools & Technologies
| Tool | Purpose |
|------|----------|
| **Verilog HDL** | Design and Testbench |
| **EDA Playground** | Online implementation & testing |
| **Vivado / ModelSim** | Simulation and waveform analysis |
| **GitHub** | Code versioning and documentation |

---

## 📂 Project Structure
```
📁 traffic-light-controller-fpga
│
├── traffic_controller.v      # Main Verilog design
├── tb_traffic.v              # Testbench file
├── traffic.vcd               # Generated waveform dump
├── waveform.png              # Screenshot of final waveform
└── README.md                 # Project documentation
```

---

## 🚀 Simulation Steps
1. Open **EDA Playground** or **Vivado**.
2. Upload both files:  
   - `traffic_controller.v`  
   - `tb_traffic.v`
3. Select **Verilog 2001** and run the simulation.
4. View the waveform (`traffic.vcd`) in **EPWave** or **Vivado Waveform Viewer**.
5. Observe normal traffic cycles and emergency override activation.

---

## 🧾 Expected Behavior (Waveform Verification)
| Condition | Expected Output |
|------------|----------------|
| Normal mode | NS and EW alternate green-yellow-red cycles |
| Emergency on NS | NS stays green; EW all red |
| Emergency on EW | EW stays green; NS all red |
| After emergency clears | Resumes normal cycle automatically |

---

## 📊 Example Waveform
![Traffic Light Waveform](waveform.png)

*(Shows state transitions, emergency response, and light control signals)*

---

## 🧮 Finite State Machine (FSM)
| State Code | Description |
|-------------|-------------|
| `000` | NS Green |
| `001` | NS Yellow |
| `010` | All Red (Transition) |
| `011` | EW Green |
| `100` | EW Yellow |
| `101` | All Red (Transition) |
| `110` | Emergency NS |
| `111` | Emergency EW |

---

## 💡 How to Extend
- Add pedestrian crossing control.
- Include countdown timer display.
- Add UART or sensor-based emergency trigger.

---

## 👤 Author
**Nathish Rathod**  
🎓 *Electronics and Communication Engineering (ECE)*  
📧 [adnanahmed68517@gmail.com](mailto:adnanahmed68517@gmail.com)  
🔗 [LinkedIn Profile](https://www.linkedin.com/in/adnan-ahmed-b1a06b29b)

---

## 🏁 Result
✅ Successfully designed and simulated a **Traffic Light Controller with Emergency Priority System**.  
The waveform confirms accurate FSM transitions and priority override operation.
