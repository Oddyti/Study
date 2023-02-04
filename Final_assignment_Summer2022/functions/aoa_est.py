from textwrap import indent
import numpy as np
import scipy as sp
from scipy.fft import fft, ifft
import scipy.signal as sg
import matplotlib.pyplot as plt


def aoa_est(mixtures, M, N, space, sr, c):

    theta = np.arange(0, np.pi, np.pi/200)
        
    # trans the index of fft to the real fi
    trans = mixtures.shape[-1]/sr

    mixtures_fft = fft(mixtures)

    # set the fi with step=100
    fi = np.arange(0, 8500, 100)

    # save the objective function result
    ofunction = np.zeros(200)

    for i in range(200):
        sum_1 = 0
        for fi_i in fi:
            sum_2 = 0
            for k in range(M):
                e = np.exp(1j * 2 * np.pi * fi_i/trans *
                           space * np.cos(theta[i]) * k / c)
                sum_2 += (e * mixtures_fft[k, fi_i])
            sum_1 += abs(sum_2)
        ofunction[i] = sum_1
    
    # Estimated AoA as per Eq 1 in assignmnt doc
    # Save estimated AoA in this variable and return in the function. For N multiple sound sources est_aoa is a Nx1 dimension vector
    est_aoa = np.zeros((1, N))
    if N == 1:
        index = np.argmax(ofunction)
        est_aoa = theta[index]
    else:
        est_aoa = theta[sg.argrelmax(ofunction)[0]]

    # Plot the variation of objective function with thetas. Add the plot in your assignment report.
    plt.figure
    plt.plot(theta, ofunction)
    plt.xlabel("theta")
    plt.ylabel("argmax")
    plt.show()

    return est_aoa
