import numpy as np
import copy as cp
import matplotlib.pyplot as plt
from mnn import deltaSGD
from mnn import backPropagation

if __name__ == '__main__':
    # training data
    data = np.array([[0,0,1],[0,1,1],[1,0,1],[1,1,1]])
    label = np.array([0,1,1,0])


    # train with Back Propagation rule
    learning_rate = 0.9
    epochs = 500
    loss_list1 = backPropagation(data, label, learning_rate, epochs)

