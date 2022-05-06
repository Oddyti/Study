import imp
from itertools import permutations
from unittest import makeSuite
import numpy as np

# sigmoid function
def sigmoid(x):
    return 1 / (1 + np.exp(-x))

# relu function
def relu(x):
    for i in range(x.shape[0]):
        if x[i] < 0:
            x[i] = 0
    return x

# deviation of relu function
def reluD(x):
    for i in range(x.shape[0]):
        if x[i] < 0:
            x[i] = 0
        else:
            x[i] = 1
    return x

# softmax function
def softmax(x):
    softmax_sum = np.sum(np.exp(x))
    for i in range(x.shape[0]):
        x[i] = np.exp(x[i]) / softmax_sum 
    return x


# loss function
def loss(y, y_pred):
    return y - y_pred

# training by delta rule and SGD
def deltaSGD(data, label, W, alpha, epochs):
    loss_list = []
    for epoch in range(epochs):
        # shuffle data set
        dataSize = data.shape[0]
        permutation = np.random.permutation(dataSize)
        data = data[permutation,:]
        label = label[permutation]

        # SGD process
        mse = 0
        for i in range(dataSize):
            y_pred = np.dot(data[i], W)
            error = loss(label[i], y_pred)
            mse += error**2
            delta = sigmoid(y_pred) * (1-sigmoid(y_pred)) * error
            for j in range(len(data[1])):
                W[j] = W[j] + alpha * delta * data[i][j]

        mse /= dataSize
        loss_list.append(mse)
        print('progress: ', epoch+1, 'loss=', mse)
    
    return W, loss_list

# training by delta rule and Batch
def deltaBatch(data, label, W, alpha, epochs):
    loss_list = []
    for epoch in range(epochs):
        # shuffle data set
        dataSize = data.shape[0]
        permutation = np.random.permutation(dataSize)
        data = data[permutation,:]
        label = label[permutation]

        # Batch process
        mse = 0
        Y_pred = data @ W
        error = loss(label, Y_pred)
        mse = np.sum(error**2)
        delta = sigmoid(Y_pred) * (1-sigmoid(Y_pred)) * error / dataSize
        W = W + alpha * (data.T @ delta)
        
        mse /= dataSize
        loss_list.append(mse)
        print('progress: ', epoch+1, 'loss=', mse / dataSize)
    
    return W, loss_list


# training by back-propagation rule and Momentum
def backPropagation(data, label, alpha, epochs):
    loss_list = []
    W0 = np.random.randn(3,4)
    W1 = np.random.randn(1,4)

    for epoch in range(epochs):
        mse = 0

        # shuffle data set
        dataSize = data.shape[0]
        permutation = np.random.permutation(dataSize)
        data = data[permutation,:]
        label = label[permutation]

        for i in range(dataSize):
            y_hidden = sigmoid(data[i] @ W0)
            y_pred = sigmoid(np.sum(y_hidden * W1))
            error_0 = loss(label[i], y_pred)
            mse += error_0**2
            delta_0 = y_pred * (1-y_pred) * error_0
            error_1 = W1 * delta_0
            delta_1 = y_hidden * (1-y_hidden) * error_1
            W0 = W0 + alpha * (np.reshape(data[i],(3,1)) @ delta_1.reshape((1,4)))
            W1 = W1 + alpha * (delta_0 * y_hidden)
        
        mse /= dataSize
        loss_list.append(mse)
        print('progress: ', epoch+1, 'loss=', mse)
        
    return loss_list

# training by back-propagation rule and Momentum
def momentumBP(data, label, alpha, beta, epochs):
    loss_list = []
    moment_0 = np.zeros((1,4))
    moment_1 = np.zeros((3,4))

    W0 = np.random.randn(3,4)
    W1 = np.random.randn(1,4)

    for epoch in range(epochs):
        mse = 0

        # shuffle data set
        dataSize = data.shape[0]
        permutation = np.random.permutation(dataSize)
        data = data[permutation,:]
        label = label[permutation]

        for i in range(dataSize):
            y_hidden = sigmoid(data[i] @ W0)
            y_pred = sigmoid(np.sum(y_hidden * W1))
            error_0 = loss(label[i], y_pred)
            delta_0 = y_pred * (1-y_pred) * error_0
            error_1 = W1 * delta_0
            mse += error_0**2
            delta_1 = y_hidden * (1-y_hidden) * error_1

            moment_0 = beta * moment_0 + (1-beta) * (delta_0 * y_hidden)
            moment_1 = beta * moment_1 + (1-beta) * (np.reshape(data[i],(3,1)) @ delta_1.reshape((1,4)))
            W0 = W0 + alpha * moment_1
            W1 = W1 + alpha * moment_0
        
        mse /= dataSize
        loss_list.append(mse)
        print('progress: ', epoch+1, 'loss=', mse)
        
    return loss_list

# training by BP, SGD, softmax and ReLu
def reluBP(data, label, alpha, epochs):
    loss_list = []
    dataSize = data.shape[0]
    dataDim = data.shape[1]
    # W1 = np.random.random([20,25]) - 0.5
    # W2 = np.random.random([20,20]) - 0.5
    # W3 = np.random.random([20,20]) - 0.5
    # W4 = np.random.random([5,20]) - 0.5
    W1 = np.load('../W1.npy').T - 0.5
    W2 = np.load('../W2.npy').T - 0.5
    W3 = np.load('../W3.npy').T - 0.5
    W4 = np.load('../W4.npy').T - 0.5
    for epoch in range(epochs):
        mse = 0

        # # shuffle the data
        # permutation = np.random.permutation(dataSize)
        # data = data[permutation]
        # label = label[permutation]

        # SGD training
        for i in range(dataSize):
            Y1 = relu(W1 @ data[i]) # dim = (20,1)
            Y2 = relu(W2 @ Y1) # dim = (20,1)
            Y3 = relu(W3 @ Y2) # dim = (20,1)
            Y4 = softmax(W4 @ Y3) # dim = (5,1)

            # 4th layer BP
            error_4 = loss(label[i], Y4) # dim = (5,1)
            mse += np.sum(error_4**2) / dataDim
            delta_4 = 1 * error_4
            W4 = W4 + alpha * (delta_4.reshape(5,1) @ Y3.reshape(1,20))

            # 3th layer BP
            error_3 = W4.T @ delta_4.reshape(5,1) # dim = (20,1)
            delta_3 = reluD(Y3).reshape(20,1) * error_3
            W3 = W3 + alpha * (delta_3.reshape(20,1) @ Y2.reshape(1,20))

            # 2th layer BP
            error_2 = W3.T @ delta_3.reshape(20,1) # dim = (20,1)
            delta_2 = reluD(Y2).reshape(20,1) * error_2
            W2 = W2 + alpha * (delta_2.reshape(20,1) @ Y1.reshape(1,20))

            # 1th layer BP
            error_1 = W2.T @ delta_2.reshape(20,1) # dim = (20,1)
            delta_1 = reluD(Y1).reshape(20,1) * error_1
            W1 = W1 + alpha * (delta_1.reshape(20,1) @ np.reshape(data[i], (1,25)))
        
        mse /= dataSize
        loss_list.append(mse)
        print('progress: ', epoch+1, 'loss=', mse)
        
    return W1, W2, W3, W4, loss_list

# training by BP, SGD, dropout, softmax and sigmoid
def dropoutBP(data, label, alpha, dropout_rate, epochs):
    loss_list = []
    dataSize = data.shape[0]
    dataDim = data.shape[1]
    W1 = np.random.random([20,25]) - 0.5
    W2 = np.random.random([20,20]) - 0.5
    W3 = np.random.random([20,20]) - 0.5
    W4 = np.random.random([5,20]) - 0.5

    # dropout by a mask
    savedNodeNum = int(np.around(dropout_rate * 20))
    mask = np.ones((20,1)) / (1 - dropout_rate)
    for i in range(savedNodeNum):
        mask[i] = 0
    

    for epoch in range(epochs):
        mse = 0

        # shuffle the data
        permutation = np.random.permutation(dataSize)
        data = data[permutation]
        label = label[permutation]

        # shuffle the mask
        permutation = np.random.permutation(20)
        mask = mask[permutation]

        # SGD training
        for i in range(dataSize):
            Y1 = sigmoid(W1 @ data[i]).reshape(20,1) * mask # dim = (20,1)
            Y2 = sigmoid(W2 @ Y1) * mask # dim = (20,1)
            Y3 = sigmoid(W3 @ Y2) * mask # dim = (20,1)
            Y4 = softmax(W4 @ Y3) # dim = (5,1)

            # 4th layer BP
            error_4 = loss(label[i].reshape(5,1), Y4) # dim = (5,1)
            mse += np.sum(error_4**2) / dataDim
            delta_4 = 1 * error_4
            W4 = W4 + alpha * (delta_4.reshape(5,1) @ Y3.reshape(1,20))

            # 3th layer BP
            error_3 = W4.T @ delta_4.reshape(5,1) # dim = (20,1)
            delta_3 = Y3.reshape(20,1) * (1-Y3).reshape(20,1) * error_3
            W3 = W3 + alpha * (delta_3.reshape(20,1) @ Y2.reshape(1,20))

            # 2th layer BP
            error_2 = W3.T @ delta_3.reshape(20,1) # dim = (20,1)
            delta_2 = (1-Y2).reshape(20,1) * Y2.reshape(20,1) * error_2
            W2 = W2 + alpha * (delta_2.reshape(20,1) @ Y1.reshape(1,20))

            # 1th layer BP
            error_1 = W2.T @ delta_2.reshape(20,1) # dim = (20,1)
            delta_1 = (1-Y1).reshape(20,1) * Y1.reshape(20,1) * error_1
            W1 = W1 + alpha * (delta_1.reshape(20,1) @ np.reshape(data[i], (1,25)))
        
        mse /= dataSize
        loss_list.append(mse)
        print('progress: ', epoch+1, 'loss=', mse)
        
    return W1, W2, W3, W4, loss_list