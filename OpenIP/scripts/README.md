- compile:
+ compile verilog files
- simulate:
- wave
show waveform

## How to run:
1.Config:
parameter top_tb
- input text file (line 36)
- output text file (line 69)

2.run scripts 
- clean
- compile
- simulate
- show wave:
```
vsim -do "do wave.do /*" -view results/test.wlf 
```

# Testcases:
- Valid: luon luon bang 1???
- FIFO_in: FULL, Empty
    + Empty: => gen khong doc text file, khong ghi data vao fifo
    + Full: ImageWrite ko doc du lieu tu fifo => fifo_out full => fifo_in full