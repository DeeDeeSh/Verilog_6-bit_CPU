# Verilog_6-bit_CPU
Designed a custom 6-bit CPU from scatch in verilog!!


A simple **6-bit CPU** designed in **Verilog**, featuring a
two-state **FETCH / EXEC** finite state machine, instruction ROM,
data RAM, and basic arithmetic and control instructions.

The design is fully simulated using **Icarus Verilog** and
visualized with **GTKWave**.

---

## 🧠 Architecture Overview

- 6-bit accumulator (ACC)
- 3-bit program counter (PC)
- FSM-based instruction cycle
  - FETCH: instruction fetch from ROM
  - EXEC: instruction execution
- Clock-enable (`tick`) for controlled execution
- Active-low LED output (`acc_out`)

---

## 📘 Instruction Set

| Opcode | Mnemonic | Description |
|------|----------|-------------|
| 000 | NOP | No operation |
| 001 | LDI | Load immediate |
| 010 | LDM | Load from data memory |
| 011 | STM | Store to data memory |
| 100 | ADD | Add memory to ACC |
| 101 | SUB | Subtract memory from ACC |
| 110 | JMP | Jump to address |
| 111 | JZ  | Jump if zero flag set |

Instruction format:
opcode (3 bits) | operand (3 bits)

🛠 Tools Used

Verilog HDL
Icarus Verilog
GTKWave

🎯 Purpose

This project was built to strengthen understanding of:
CPU architecture fundamentals
FSM-based control logic
Instruction cycles

Author:
Devansh Sharma
BTech, Undergrad /(*-*)/
