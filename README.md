# Atharvaraj4924-Traffic-Light-Controller-using-Verilog-FPGA
Traffic Light Controller implemented in Verilog HDL on the Basys 3  FPGA. This repository includes three FSM-based implementations: a Basic Traffic Light Controller, a Two-Way Traffic Signal Controller, and a Pedestrian Interrupt Controller, along with source code, testbenches, XDC files, hardware demonstrations, and project documentation.
# 🚦 Traffic Light Controller using Verilog HDL on Basys 3 FPGA

A collection of **Traffic Light Controller** implementations developed using **Verilog HDL** and implemented on the **Basys 3 FPGA (Xilinx Artix-7)**. This repository demonstrates the design and verification of Finite State Machine (FSM)-based traffic control systems with increasing levels of complexity.

---

## 📖 Project Overview

This repository contains **three different Traffic Light Controller implementations**:

### 1️⃣ Basic Traffic Light Controller
- Implements the standard traffic light sequence:
  - 🟢 Green
  - 🟡 Yellow
  - 🔴 Red
- Designed using a Finite State Machine (FSM).
- Simulated and verified on FPGA hardware.

---

### 2️⃣ Two-Way Traffic Signal Controller
- Controls traffic at a two-road intersection.
- Ensures safe coordination between both traffic signals.
- Includes asynchronous reset functionality.
- Verified through simulation and hardware implementation.

---

### 3️⃣ Pedestrian Interrupt Traffic Controller
- Adds a pedestrian request button.
- Gives pedestrians a dedicated crossing phase.
- Safely resumes the normal traffic sequence after pedestrian crossing.
- Implemented and tested on FPGA hardware.

---

## ✨ Features

- Verilog HDL implementation
- Finite State Machine (FSM) design
- Modular RTL design
- Hardware verification on Basys 3 FPGA
- Asynchronous Reset
- Pedestrian Interrupt Feature
- Simulation Testbenches
- XDC Constraint Files

---

## 🛠️ Hardware Used

- Basys 3 FPGA Development Board
- Xilinx Artix-7 (XC7A35T)
- LEDs
- Push Buttons
- USB Programming Cable

---

## 💻 Software Used

- Xilinx Vivado Design Suite
- Verilog HDL

---

## 📂 Repository Structure

```
Traffic-Light-Controller-Verilog-FPGA
│
├── Basic_Traffic_Controller
│   ├── Source Code
│   └── XDC File
│
├── Two_Way_Traffic_Controller
│   ├── Source Code
│   └── XDC File
│
├── Pedestrian_Interrupt_Controller
│   ├── Source Code
│   └── XDC File
│
├── Videos
│
└── README.md
```

---

## ▶️ How to Run

1. Clone this repository.

```
git clone https://github.com/<Atharvaraj4924>/Traffic-Light-Controller-Verilog-FPGA.git
```

2. Open the desired project in **Xilinx Vivado**.

3. Add the Verilog source files.

4. Add the corresponding XDC constraints file.

5. Run:
   - Synthesis
   - Implementation
   - Generate Bitstream

6. Program the **Basys 3 FPGA**.

7. Observe the traffic light operation on the onboard LEDs.

---

## 📸 Project Demonstration

The repository includes:

- Project demonstration videos
- FSM implementation
- Verilog source code

---

## 🎯 Learning Outcomes

This project helped strengthen my understanding of:

- Finite State Machines (FSM)
- Sequential Logic Design
- RTL Design using Verilog HDL
- FPGA Prototyping
- Hardware Verification
- Digital System Design
- Vivado Design Flow

---

## 🚀 Future Enhancements

- Emergency Vehicle Priority
- Adaptive Traffic Control
- Traffic Density Detection
- IoT-based Traffic Monitoring
- Timer Display using Seven-Segment Display

---

## 👨‍💻 Author

**Atharvaraj Aditya Mali**

B.Tech Electronics & Telecommunication Engineering
