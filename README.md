#POD2C
Partially-Observed Decoupled Data-based Control implementation on MuJoCo 200 Win64

------

The algorithm has two steps:
1. Find the optimal control sequence in the deterministic system using arma-ilqr method.
2. Wrap a linear local feedback policy around the openloop nominal trajectory using arma-lqg method.

Requirements
- Matlab 2018 or later
- MuJoCo 200 Windows x64 version

  Authors: Ran Wang, Raman Goyal. 
