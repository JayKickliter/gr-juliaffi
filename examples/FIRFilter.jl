using DSP

taps = digitalfilter(Lowpass(0.3), WindowFIR(transitionwidth=0.05))

const myfilt = FIRFilter(taps)


work(y,x) = filt!(y,myfilt,x)