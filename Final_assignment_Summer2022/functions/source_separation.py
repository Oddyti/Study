import numpy as np
from scipy.fft import fft, ifft
import matplotlib.pyplot as plt
import librosa
import soundfile as sf
from glob import glob
import os


def source_separation(mixtures, aoa_est, M, N, space, sr, c, dir):

    #Use Estimated AoA to separate out sources from mixture


    # Write code for separating 2 sound sources



    # Overwrite source1 and source2 variables with separated audio sources
    source1 = 0
    source2 = 0

    dir_s1 = os.path.join(dir, 'source1.wav')
    dir_s2 = os.path.join(dir, 'source2.wav')

    # Save Separated Audio Sample for Submission in Results Folder

    sf.write(dir_s1, source1, 16000)
    sf.write(dir_s2, source2, 16000)

    return 0
