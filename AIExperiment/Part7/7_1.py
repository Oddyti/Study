from cProfile import label
import numpy as np
from Conv import Conv
from Pool import Pool
from scipy import signal

def ReLu(x):
    return np.maximum(x,0)

def ReLu_derivative(x):
    for i in range(x.shape[0]):
        if x[i] < 0:
            x[i] = 0
        else:
            x[i] = 1
    return x
    
def softmax(x):
    x -= np.max(x)
    softmax_sum = np.sum(np.exp(x))
    for i in range(x.shape[0]):
        x[i] = np.exp(x[i]) / softmax_sum 
    return x

def CNN(data, labels, alpha, epochs, beta):

    # Data <Cov kernel><ReLu> Y1 <Pool> Y2 <W1 ReLu> hidden <W2 Softmax> output
    kernel = np.random.random((9,9,20)) * 0 # dim 9,9,20
    W1 = np.random.random((2000,100)) # dim 2000,100
    M1 = np.random.random((2000,100))
    W2 = np.random.random((100,10)) # dim 100,10
    M2 = np.random.random((100,10))

    for epoch in range(epochs):
        for i in range(data.shape[0]):
            y1 = ReLu(Conv(data[i], kernel))
            y2 = Pool(y1)
            y2_v = y2.reshape(2000)
            hidden = ReLu(y2_v @ W1)
            output = softmax(hidden @ W2)

            error_o = labels[i] - output
            delta_o = error_o * 1
            M2 = alpha * hidden.reshape(100,1) @ delta_o.reshape(1, 10) + beta * M2
            W2 = W2 + M2

            error_h = delta_o @ W2.T
            delta_h = error_h * ReLu_derivative(hidden)
            M1 = alpha * y2_v.reshape(2000,1) @ delta_h.reshape(1, 100) + beta * M1
            W1 = W1 + M1

            error_y2_v = delta_h @ W1.T
            error_y2 = np.reshape(error_y2_v, y2.shape)
            error_y1 = np.zeros_like(y1)
            W0 = np.ones_like(y1) / (2*2)
            for c in range(20):
                error_y1[:,:,c] = np.kron(error_y2[:,:,c], np.ones((2,2)))*W0[:,:,c]
            delta_y1 = (y1 > 0) * error_y1
            delta1_x = np.zeros_like(kernel)            
            for c in range(20):
                delta1_x[:, :, c] = signal.convolve2d(data[i][:, :], np.rot90(delta_y1[:, :, c], 2), 'valid')
            kernel_dW =delta1_x
            kernel_moment = alpha * kernel_dW + beta * kernel_moment
            kernel = kernel + kernel_moment
            


            







if __name__ == '__main__':
    data = np.load('data.npy')
    labels = np.load('label.npy')
    # data = np.rollaxis(data,0,3)
    lables_new = np.zeros((labels.shape[0],10))
    for i in range(labels.shape[0]):
        lables_new[i][labels[i]] = 1
    learn_rate = 0.01
    beta = 0.01
    epochs = 1

    CNN(data, labels, learn_rate, epochs, beta)
    
