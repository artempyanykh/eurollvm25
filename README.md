# EuroLLVM 2025 presentation

This is a support repository for my presentation at EuroLLVM 2025 (April) titled:

> Accidentally quadratic in compiler-rt/asan

The slides are [available here](./slides.pdf).

## Repro

1. Clone this repository with submodules:

```
git clone --recurse-submodules git@github.com:artempyanykh/eurollvm25.git
```

2. Build the before and after executables (this will also build 2 versions of LLVM):

```
make before_patch after_patch
```

3. Compare the runtime:

```
~/d/eurollvm25 > time ./before_patch
Hello EuroLLVM!

________________________________________________________
Executed in    5.62 secs    fish           external
   usr time    5.51 secs   19.00 micros    5.51 secs
   sys time    0.04 secs  487.00 micros    0.04 secs

~/d/eurollvm25 > time ./after_patch
Hello EuroLLVM!

________________________________________________________
Executed in   96.12 millis    fish           external
   usr time   46.96 millis    0.00 micros   46.96 millis
   sys time   48.77 millis  543.00 micros   48.23 millis
```