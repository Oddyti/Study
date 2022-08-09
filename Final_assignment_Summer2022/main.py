# This is a sample Python script.

import sys
sys.path.insert(1, './functions/')

import numpy as np
import matplotlib.pyplot as plt
from aoa_est import *
from source_separation import *

import wave
from scipy.io import wavfile
import librosa
import soundfile as sf
from glob import glob
import os


def load_audio_file(channel_path):
    audio, _ = librosa.load(channel_path, sr=16000)
    return audio


if __name__ == '__main__':

    space = 0.2 # Spacing Between Antenna Array Microphones
    sr = 16000 # Sampling Rate of Audio File
    c = 340 # Speed of sound in air


    ## Part 1 and Part 2 of Assignment - Single Source for both Clean and Noisy Audio

    M = 4 # Number of microphones in array
    N = 1 # Number of sound sources

    data_dir = './dataset/Single_Source_Data/'

    aoa_est_noise = []
    aoa_est_clean = []
    for setup in range(4):
        curr_set_dir = os.path.join(data_dir, str(M) + '-' + str(N) + '-v'+str(setup+1))
        mix_dir_clean = os.path.join(curr_set_dir, 'mix','Clean')
        mix_dir_noise = os.path.join(curr_set_dir, 'mix', 'Noise')

        mixtures_noise = []
        mixtures_clean = []

        for i in range(M):
            channel_path_noise = os.path.join(mix_dir_noise, 'channel' + str(i + 1) + '.wav')
            channel_path_clean = os.path.join(mix_dir_clean, 'channel' + str(i + 1) + '_clean.wav')
            mixture_noise = load_audio_file(channel_path_noise)
            mixture_clean = load_audio_file(channel_path_clean)
            mixtures_noise.append(mixture_noise)
            mixtures_clean.append(mixture_clean)

        mixtures_noise = np.array(mixtures_noise)
        mixtures_clean = np.array(mixtures_clean)

        aoa_est_noise.append(aoa_est(mixtures_noise, M, N, space, sr, c))
        aoa_est_clean.append(aoa_est(mixtures_clean, M, N, space, sr, c))


    ## Part 3 - Multiple Sources with Noisy Audio from different AoAs

    M = 4 # Number of microphones in array
    N = 2 # Number of sound sources

    data_dir = './dataset/Multiple_Source_Data/'

    aoa_est_noise = []
    aoa_est_clean = []

    curr_set_dir = os.path.join(data_dir, str(M) + '-' + str(N) + '-v1')
    mix_dir_clean = os.path.join(curr_set_dir, 'mix','Clean')
    mix_dir_noise = os.path.join(curr_set_dir, 'mix', 'Noise')

    mixtures_noise = []
    mixtures_clean = []

    for i in range(M):
        channel_path_noise = os.path.join(mix_dir_noise, 'channel' + str(i + 1) + '.wav')
        channel_path_clean = os.path.join(mix_dir_clean, 'channel' + str(i + 1) + '_clean.wav')
        mixture_noise = load_audio_file(channel_path_noise)
        mixture_clean = load_audio_file(channel_path_clean)
        mixtures_noise.append(mixture_noise)
        mixtures_clean.append(mixture_clean)

    mixtures_noise = np.array(mixtures_noise)
    mixtures_clean = np.array(mixtures_clean)

    aoa_est_noise = aoa_est(mixtures_noise, M, N, space, sr, c)
    aoa_est_clean = aoa_est(mixtures_clean, M, N, space, sr, c)

    ## Part 4 - Using Estimated AoAs from Part 3, separate out sources from mixture

    data_dir = './Results/Multiple_Source_Separation/Beamforming/'

    dir_clean = os.path.join(data_dir, 'Clean')
    dir_noise = os.path.join(data_dir, 'Noise')

    source_separation(mixtures_noise, aoa_est_noise, M, N, space, sr, c, dir_noise)
    source_separation(mixtures_clean, aoa_est_clean, M, N, space, sr, c, dir_clean)

    ## Part 5 (BONUS) - Perform source separation using MUSIC

    # Fill in skeleton code here yourself and save separated audio sample in MUSIC subfolder inside Results

