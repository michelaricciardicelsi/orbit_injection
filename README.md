# orbit_injection

# 🚀 Orbit Injection of a Satellite in Minimum Time

This project explores the **optimal control problem of satellite orbit injection**, aiming to compute the optimal guidance law that transfers a satellite into a target circular orbit in the minimum possible time. The solution minimizes fuel consumption by reducing transfer time, which is critical in aerospace missions where efficiency is paramount.

The study models the physical dynamics of satellite injection using non-linear differential equations and applies numerical optimization techniques to derive optimal control laws. The project implements both:

- **Direct methods** using MATLAB’s `fmincon` function.
- **Indirect methods** via the Bryson approach (Euler-Lagrange formulation with Newton-Raphson minimization).

Both methods are compared in terms of performance, computational complexity, and accuracy.

---

## 🛰️ Project Objectives

- Simulate the satellite orbit injection process.
- Minimize time to orbit to reduce propellant consumption.
- Compute optimal control law 𝛼(𝑡) for satellite guidance.
- Compare eastward and westward launches.
- Analyze results: velocity, slope, radius, mass, and trajectory profiles.

---

## 🛠️ Methodology

- **Mathematical Modeling:**  
  Derive dynamic equations of motion for a satellite considering velocity, heading, slope, and thrust control variables.
  
- **Optimization Techniques:**  
  - *Direct approach:* MATLAB `fmincon` minimizes time to orbit under dynamic constraints.
  - *Indirect approach:* Bryson's method using calculus of variations and Euler-Lagrange equations.

- **Simulation Cases:**  
  - **Eastward launch:** Faster and less costly (~250 seconds to reach orbit).
  - **Westward launch:** Slower and more expensive (~400 seconds to reach orbit).

- **Tools & Languages:**  
  - MATLAB
  - Numerical integration and optimization routines

---

## References 
[1] A.J. Calise and M.S.K. Leung, Optimal Guidance Law
Development for an Advanced Launch System, NASA Report,
1995.
[2] J.M. Longuski, J.J. Guzmàn, J.E. Prussing, Optimal
Control With Aerospace Applications, Springer, 2014.
[3] S.D. Ilcev, Global Mobile Satellite Communications
Theory for Maritime, Land and Aeronautical Applications,
Springer, 2017.
[4] B. Etkin, Dynamics of Atmospheric Flight, Dover
Publications, 1972.
[5] L. Mangiacasale, Fondamenti di Automatica e Controllo
dei Veicoli Aerospaziali, ARACNE, 2008.
[6] A.E. Bryson, and Y.C. Ho, Applied Optimal Control,
CRC Press, 1975.
[7] A.E. Bryson, Dynamic Optimization, Addison Wesley,
1999.
[8] N.K. Poulsen, Dynamic Optimization, 2012.
---

## 📂 Project Structure

```bash
/Orbit-Injection-Optimization
│
├── main.m                           # Main script to set up and run the optimization
├── objfun.m                         # Objective function (minimizes time)
├── constraints.m                    # System dynamics and boundary constraints
├── orbequa3d.m                      # Differential equations for satellite motion
├── README.md                        # Project description and details
└── Orbit Injection_RicciardiCelsi.pdf  # Detailed project report




