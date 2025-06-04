# Lab 1-5 Overview
The objective of labs 1-6 is to build a 8x8 multiplier. The input to the multiplier will be two 8-bit multiplicands (***dataa*** and ***datab***) and the output from the multiplier will be 16-bit product (***product8x8_out***). There will be additional outputs to signal and display other signals such as a done bit (***done_flag***) and seven signals to drive a seven segment display (***seg_a***, ***seg_b***, ***seg_c***, ***seg_d***, ***seg_e***, ***seg_f***, ***seg_g***), which will show the state of the state machine on the seven segment display.

The principle behind this design, is that the multiplication result is:

result[15..0] = a[7..0] * b[7..0]
    =       ( (a[7..4] * b[7..4]) * 2^8)
        +   ( (a[7..4] * b[3..0]) * 2^4)
        +   ( (a[3..0] * b[7..4]) * 2^4)
        +   ( (a[3..0] * b[3..0]) * 2^0)


This requires four clock cycles to perform the multiplication. Each cycle utilizes a pair of 4-bit portions of each multiplicand, which is multiplied by a 4x4 multiplier and then shifted. After each cycle, on the 5th cycle, the fully composed 16-bit product can be read at the output. 

![Top-Level Diagram](images/Lab1-5%20Partial%20Block%20Diagram.PNG)

Top-Level-Diagram
