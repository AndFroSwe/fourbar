# File: linkage-solver.py
# Author: andfro
# Description: Solver for linkage of four bar linkage

from scipy.linalg import lstsq
import math

# Linkage constants
r1 = 1
r2 = 2
r3 = 3
r4 = 4
theta2 = 1 # [rad]


# Functions for four bar linkage

def f(theta3, theta4):
    # Function that determines linkage positions
    return ([[r2*math.cos(theta2) + r3*math.cos(theta3) - r1 - r4*math.cos(theta4)], 
        [r2*math.sin(theta2) - r3*math.sin(theta3) - r4*math.sin(theta4)]])

def J(theta3, theta4):
    # Jacobi matrix of problem
    return ([[-r3*math.sin(theta3), r4*math.sin(theta4)],
        [-r3*math.cos(theta3), -r4*math.cos(theta4)]])

# Newton-Rhapson non-linear equation solver
def nr(theta3, theta4):
    delta = 0.1 # Solver tolerance
    vals = [theta3, theta4] # Start values
    dx = 1 # Iteration error
    i = 0 # Number of iterations

    # Loop until value is found
    while abs(dx) < delta or i < 10:
        dx = lstsq(J(theta3, theta4), f(theta3, theta4))
        vals = vals + dx
        i = i + 1

if __name__ == "__main__":
    print("Hello, World!")
    print(f(1,1))
    print(J(1,1))
    print(lstsq(J(1,1),f(1,1)))
    print(nr(1,1))
    

