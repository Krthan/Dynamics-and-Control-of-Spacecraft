# LQR vs MPC for quaternion-based satellite control
## Introduction
This repo contains the MATLAB code files for project under the course: Dynamics and Control of Spacecraft.
The course project is based on the paper: Hegrenæs, Øyvind, Jan Tommy Gravdahl, and Petter Tøndel. "Spacecraft attitude control using explicit model predictive control." Automatica 41.12 (2005): 2107-2114.
The paper has implemented an explicit-MPC for the ESEO (European Student Earth Orbiter), which is a micro-satellite that uses cold-gas system and reaction wheel for providing torque about the principal body axis. The ESEO uses sun, earth-horizon sensors, star trackers and magnetometers for its attitude measurements. An EKF (Extended Kalman Filter)
is used for noise filtering and attitude determination.

## System Modelling
The system dynamics model is derived and provided in the paper in state-space form. The A and B matrix of size 8x8 and 8x4 respectively.
