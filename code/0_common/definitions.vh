`timescale 1ns / 1ps
`define CYCLE 10
`define WORD  64
`define INSTR_LEN 32
`define DMEMFILE  "H:/ELC3338/Spring2018/potter/ARM-Lab/testfiles/ramData.data"
`define IMEMFILE  "H:/ELC3338/Team9/ARM-Lab_Spring2019_S1_P2_Team9/testfiles/instrData.data"
`define RMEMFILE  "H:/ELC3338/Team9/ARM-Lab_Spring2019_S1_P2_Team9/testfiles/regData.data"

`define ADD  11'b10001011000
`define SUB  11'b11001011000
`define CBZ  11'b10110100XXX
`define B    11'b000101XXXXX
`define LDUR 11'b11111000010
`define STUR 11'b11111000000
`define ORR  11'b10101010000
`define AND  11'b10001010000
