from re import S
import numpy as np
from scipy.fft import fft, ifft
import matplotlib.pyplot as plt
import librosa
import soundfile as sf
from glob import glob
import os


def source_separation(mixtures, aoa_est, M, N, space, sr, c, dir):

    fi = np.arange(0, 160000, 1)

    mixtures_fft = fft(mixtures)
    
    # trans the index of fft to the real fi
    trans = mixtures.shape[-1]/sr
    
    #Use Estimated AoA to separate out sources from mixture
    s1 = []
    for fi_i in fi:
        sum_s1 = 0
        for k in range(M):
            e = np.exp(1j * -2 * np.pi *fi_i/trans *
                       space * np.cos(aoa_est[0]) * k / c)
            sum_s1 += (e * mixtures_fft[k, fi_i])
        s1.append(sum_s1/4)
    s1 = np.array(s1)

    s2 = []
    for fi_i in fi:
        sum_s2 = 0
        for k in range(M):
            e = np.exp(1j * - 2 * np.pi *fi_i/trans *
                       space * np.cos(aoa_est[1]) * k / c)
            sum_s2 += (e * mixtures_fft[k, fi_i])
        s2.append(sum_s2/4)
        
    s2 = np.array(s2)
    # Write code for separating 2 sound sources

    # Overwrite source1 and source2 variables with separated audio sources
    source1 = 0
    source2 = 0

    source1 = np.real(ifft(s1))
    source2 = np.real(ifft(s2))
    dir_s1 = os.path.join(dir, 'source1.wav')
    dir_s2 = os.path.join(dir, 'source2.wav')

    # Save Separated Audio Sample for Submission in Results Folder

    sf.write(dir_s1, source1, 16000)
    sf.write(dir_s2, source2, 16000)

    return 0
