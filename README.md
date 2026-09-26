# ILA Capture & MATLAB Analysis

A two-part workflow for capturing live FPGA signals with a Xilinx Integrated Logic Analyzer (ILA) and analyzing them in MATLAB:

| File | Language | Purpose |
|------|----------|---------|
| `runila.tcl` | TCL (Vivado Hardware Manager) | Continuously triggers the ILA, uploads the captured data, and exports it to a CSV file. |
| `ila.m` | MATLAB | Reads the CSV, decodes hex → signed 16-bit samples, FFTs each channel, and computes ADC performance metrics (SNR, SFDR, ENOB, phase difference). |

The two halves communicate through a single CSV file on disk, so they can run on different machines if the file is shared.
