# SRAM-BIST

Description:

This project implements a 256 x 4b SRAM (Static Random Access Memory) with a Built-In Self-Test (BIST) engine. The BIST engine allows for comprehensive testing of the SRAM using various test patterns to ensure its reliability and functionality. The SRAM is designed using Behavioral Verilog descriptions, which specify the behavior and functionality of each component in the design. The components include a Counter, BIST Controller, Comparator, and Multiplexers, each playing a crucial role in the testing and operation of the SRAM.

Features:

256 x 4b SRAM design
BIST engine for comprehensive memory testing
Behavioral Verilog descriptions for each component
Self-disabling BIST engine upon completion of relevant coverage
Support for four test patterns:
  1. Blanket 0 and 1
  2. Checkerboard and reverse Checkerboard
  3. March C-
  4. March A

Usage:

Ensure that the necessary software tools are installed.
Review the Verilog descriptions of each component to understand their behavior and functionality.
Use any tool like ModelSim to simulate the design and verify its functionality.
Enter the algorithm number(BIST_ALGO) in the testbench to test that particular algorithm.

Contributing:
Contributions to this project are welcome. If you find any issues or have suggestions for improvements, please feel free to open an issue or submit a pull request.

Author:
Anish Miryala,
New York University

Acknowledgments:
I would like to thank Professor Azeez Bhavanagarwala for their guidance and support throughout the development of this project.
