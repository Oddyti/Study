from textwrap import indent
import numpy as np
import scipy as sp
from scipy.fft import fft, ifft
import scipy.signal as sg
import matplotlib.pyplot as plt


def aoa_est(mixtures, M, N, space, sr, c):

    theta = np.arange(0, np.pi, np.pi/200)

    N = mixtures.shape[-1]
    trans = N/sr
    # trans the index of fft to the real fi

    mixtures_fft = fft(mixtures)

    fi = np.arange(0, 8500, 100)
    # set the fi with step=10Hz

    ofunction = np.zeros(200)
    # save the objective function result

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
    max = sg.argrelmax(ofunction)
    for i in max:
        print(theta[i])
    est_aoa = np.zeros((1, N))

    plt.figure
    plt.plot(theta, ofunction)
    plt.show
    # Plot the variation of objective function with thetas. Add the plot in your assignment report.

    return est_aoa
