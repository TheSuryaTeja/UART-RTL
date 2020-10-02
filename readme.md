# UART with Variable Baud Rate

This is a **Verilog** code for basic UART communication protocol with variable baud rate.

## Basic
* UART stands for Universal Asynchronous Receiver/Transmitter
* It is serial communication that performs parallel – to – serial data conversion at the transmitter side (Tx) and serial – to – parallel data conversion at the receiver side (Rx). 
* It is universal because the parameters like transfer speed, data speed, etc. are configurable.
> UART Data Frame

![](https://github.com/TheSuryaTeja/UART/blob/master/Images/uart.png?raw=true)

## Design
* baud_rate is a 32-bit input port to set as per requirement.
* Standard baud rates include 110, 300, 600, 1200, 2400, 4800, 9600, 14400, 19200, 38400, 57600, 115200, 128000, and 256000 bits per second.
* State Machine approach is used for Tx and Rx. 



## Results

>**Simulation**

* 9600 baud-rate

![](https://github.com/TheSuryaTeja/UART/blob/master/Images/9600_baud.PNG?raw=true)

* 19200 baud-rate

![](https://github.com/TheSuryaTeja/UART/blob/master/Images/19200_baud.PNG?raw=true)

* 115200 baud-rate

![](https://github.com/TheSuryaTeja/UART/blob/master/Images/115200_baud.PNG?raw=true)

>**Schematic**

* top

![](https://github.com/TheSuryaTeja/UART/blob/master/Images/top_schematic.PNG?raw=true)

* Tx

![](https://github.com/TheSuryaTeja/UART/blob/master/Images/tx_schematic.PNG?raw=true)

* Rx

![](https://github.com/TheSuryaTeja/UART/blob/master/Images/rx_schematic.PNG?raw=true)

>Post-Synthesis

![](https://github.com/TheSuryaTeja/UART/blob/master/Images/post-synthesis.PNG?raw=true)


## Author
* Surya Teja 
* Mail - **heysuryateja@gmail.com**
* Connect on [Linkedin](https://www.linkedin.com/in/suryateja2000/)
