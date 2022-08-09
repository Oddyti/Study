import numpy as np
from scipy.fft import fft, ifft
import matplotlib.pyplot as plt


def aoa_est(mixtures, M, N, space, sr, c):

    theta = np.arange(0, np.pi, np.pi/200)
    # thetas defined to check the objective function at

    # Compute the value of objective function across all thetas

    # Estimated AoA as per Eq 1 in assignmnt doc
    est_aoa = np.zeros((1,N)) # Save estimated AoA in this variable and return in the function. For N multiple sound sources est_aoa is a Nx1 dimension vector


    # Plot the variation of objective function with thetas. Add the plot in your assignment report.

    return est_aoa
