from tkinter import X
import numpy as np
import copy as cp
import matplotlib.pyplot as plt


def sigmoid(x):
    return 1 / (1 + np.exp(-x))

def loss(y, y_pred):
    return y - y_pred

def deltaSGD(x, label, W, alpha, epochs):
    loss_list = []
    for epoch in range(epochs):
        # shuffle x set
        x_size = x.shape[0]
        permutation = np.random.permutation(x_size)
        x = x[permutation, :]
        label = label[permutation]
        
        mse = 0
        for i in range(x_size):
            y_pred = np.dot(x[i], W)
            error = loss(label[i], y_pred)
            mse += error**2
            delta = sigmoid(y_pred) * (1-sigmoid(y_pred)) * error
            for j in range(len(x[1])):
                W[j] = W[j] + alpha * delta * x[i][j]

        mse /= x_size
        loss_list.append(mse)
        print('progress: ', epoch+1, 'loss=', mse)

    return W, loss_list


if __name__ == '__main__':
    x = np.array([[0, 0, 1], [0, 1, 1], [1, 0, 1], [1, 1, 1]])
    y = np.array([0, 1, 1, 0])

    # SGD
    w0 = []
    learning_rate = 0.9
    epochs = 3000
    for i in range(0, 3):
        w0.append(np.random.randn())
    w0, loss_list0 = SGD(x, y, w0, learning_rate, epochs)
