using DSP

taps = digitalfilter(Lowpass(0.1), FIRWindow(transitionwidth=0.1))

const myfilt = FIRFilter(taps)

work(y,x) = filt!(y,myfilt,x)