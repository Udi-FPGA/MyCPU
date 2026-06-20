// OpCode|OpDes|OpSor|OpData 
nop              // nop line               Add 0
load IntAdd mem 20   // load registerA with 00 Add 1
load regD mem 02     // nop line               Add 2
load regD mem 03     // nop line               Add 3
load regD mem 04     // nop line               Add 4
load regD mem 05     // nop line               Add 6
load regD mem 06     // nop line               Add 7
b   mem  mem  02     // last loop              Add 5
nop                  // nop line               Add 8
nop                  // nop line               Add 9
nop                  // nop line               Add a 10
nop                  // nop line               Add b 11
nop                  // nop line               Add c 12
nop                  // nop line               Add d 13
nop                  // nop line               Add e 14
nop                  // nop line               Add f 15
nop                  // nop line               Add 10 16
nop                  // nop line               Add 11 17
nop                  // nop line               Add 12 18
nop                  // nop line               Add 13 19
load regA mem 00     // nop line               Add 14 20 
load regB mem 00     // last loop              Add 15 21
load regC mem 00     // nop line               Add 16 22
load regC InDa0 00   // nop line               Add 17 23
load regB InDa1 00   // nop line               Add 18 24
add regA regC 00     // nop line               Add 19 25 
add regB mem 255    // nop line               Add 1a 26
bnz regB  mem 25      // nop line               Add 1b 27
nop                  // nop line               Add 1c 28
nop                  // nop line               Add 1d 29
nop                  // nop line               Add 1e 30
nop                  // nop line               Add 1f 31
return mem IntSaved 00 // nop line               Add 20 32
nop                  // nop line               Add 21 33
nop                  // nop line               Add 22 34
nop                  // nop line               Add 23 35
nop                  // nop line               Add 24 36 
nop                  // nop line               Add 25 37
nop                  // nop line               Add 26 38
nop                  // nop line               Add 27 39
nop                  // nop line               Add 28 40
nop                  // nop line               Add 29 41 
nop                  // nop line               Add 2a 42
nop                  // nop line               Add 2b 43
nop                  // nop line               Add 2c 44
nop                  // nop line               Add 2d 45
nop                  // nop line               Add 2e 46
nop                  // nop line               Add 2f 47
nop                  // return           Add 30 48
nop                  // nop line               Add b  
nop                  // nop line               Add c
nop                  // nop line               Add d
nop                  // nop line               Add e
nop                  // nop line               Add f
