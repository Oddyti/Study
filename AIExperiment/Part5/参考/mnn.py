from itertools import permutations
import numpy as np

# sigmoid function
def sigmoid(x):
    return 1 / (1 + np.exp(-x))

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
    W1 = np.random.randn(3,4)
    W0 = np.random.randn(1,4)

    for epoch in range(epochs):
        
        mse = 0

        # shuffle data set随机排列数据
        dataSize = data.shape[0]
        # permutation = np.random.permutation(dataSize)
        # data = data[permutation,:]
        # label = label[permutation]

        for i in range(dataSize):
            y_hidden = sigmoid(data[i] @ W1)
            y_pred = sigmoid(np.sum(y_hidden * W0))
            error_0 = loss(label[i], y_pred)
            mse += error_0**2
            delta_0 = y_pred * (1-y_pred) * error_0
            error_1 = W1 * delta_0
            delta_1 = y_hidden * (1-y_hidden) * error_1
            W1 = W1 + alpha * (np.reshape(data[i],(3,1)) @ delta_1.reshape((1,4)))
            W0 = W0 + alpha * (delta_0 * y_hidden)
        
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
