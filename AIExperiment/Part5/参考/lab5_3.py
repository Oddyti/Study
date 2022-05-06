import numpy as np
import copy as cp
import matplotlib.pyplot as plt
from mnn import momentumBP

if __name__ == '__main__':
    # training data
    data = np.array([[0,0,1],[0,1,1],[1,0,1],[1,1,1]])
    label = np.array([0,1,1,0])

    # Back Propagation and Momentum training with various beta
    fig = plt.figure()
    learning_rate = 1.0
    epochs = 4000
    for beta in np.arange(0,1.0,0.2):
        loss_list = momentumBP(data, label, learning_rate, beta, epochs)
        plt.plot(range(epochs), loss_list, label = f'beta = {beta:.1f}')
        plt.legend()

    plt.ylabel('Mse Loss')
    plt.xlabel('Epochs')
    plt.savefig('lab5_3.jpg',dpi = 300)
    plt.show()
