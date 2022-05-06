import numpy as np

def ReLu(x):
    for i in range(x.shape[0]):
        if x[i] < 0:
            x[i] = 0
    return x

def ReLu_derivative(x):
    for i in range(x.shape[0]):
        if x[i] < 0:
            x[i] = 0
        else:
            x[i] = 1
    return x
    
def softmax(x):
    # x -= np.max(x)
    softmax_sum = np.sum(np.exp(x))
    for i in range(x.shape[0]):
        x[i] = np.exp(x[i]) / softmax_sum 
    return x

def DNN(data, y, layer, learn_rate, epochs):
    
    layer = ([25, 20, 20, 20, 5])

    # W1 = np.random.randn(layer[0], layer[1])
    # W2 = np.random.randn(layer[1], layer[2])
    # W3 = np.random.randn(layer[2], layer[3])
    # W4 = np.random.randn(layer[3], layer[4])
    W1 = np.load('W1.npy').T - 0.5
    W2 = np.load('W2.npy').T - 0.5
    W3 = np.load('W3.npy').T - 0.5
    W4 = np.load('W4.npy').T - 0.5
    for epoch in range(epochs):
        mse = 0
        for i in range(data.shape[0]):
            hidden_1 = ReLu(W1 @ data[i])
            hidden_2 = ReLu(W2 @ hidden_1)
            hidden_3 = ReLu(W3 @ hidden_2)
            output = softmax(W4 @ hidden_3)
            
            error_4 = y[i] - output
            mse += np.sum(error_4**2) / 25
            delta_4 = error_4 * 1
            W4 = W4 + learn_rate * (delta_4.reshape(5,1) @ hidden_3.reshape(1,20))
            
            error_3 = W4.T @ delta_4.reshape(5,1)
            delta_3 = ReLu_derivative(hidden_3).reshape(20,1)* error_3
            W3 = W3 + learn_rate * (delta_3.reshape(20,1) @ hidden_2.reshape(1,20))
            
            error_2 = W3.T @ delta_3.reshape(20,1)
            delta_2 = ReLu_derivative(hidden_2).reshape(20,1)* error_2
            W2 = W2 + learn_rate * (delta_2.reshape(20,1) @ hidden_1.reshape(1,20))
            
            error_1 = W2.T @ delta_2.reshape(20,1)
            delta_1 = ReLu_derivative(hidden_3).reshape(20,1)* error_1
            W1 = W1 + learn_rate * (delta_1.reshape(20,1) @ np.reshape(data[i],(1,25)))
            
        mse /= data.shape[0]
        print('progress: ', epoch+1, 'loss=', mse)
    return W1, W2, W3, W4
if __name__ == '__main__':
    data=np.zeros((5,25))
    data[0,:]=np.array([[0,1,1,0,0],[0,0,1,0,0],[0,0,1,0,0],[0,0,1,0,0],[0,1,1,1,0]]).reshape(1,25)
    data[1,:]=np.array([[1,1,1,1,0],[0,0,0,0,1],[0,1,1,1,0],[1,0,0,0,0],[1,1,1,1,1]]).reshape(1,25)
    data[2,:]=np.array([[1,1,1,1,0],[0,0,0,0,1],[0,1,1,1,0],[0,0,0,0,1],[1,1,1,1,0]]).reshape(1,25)
    data[3,:]=np.array([[0,0,0,1,0],[0,0,1,1,0],[0,1,0,1,0],[1,1,1,1,1],[0,0,0,1,0]]).reshape(1,25)
    data[4,:]=np.array([[1,1,1,1,1],[1,0,0,0,0],[1,1,1,1,0],[0,0,0,0,1],[1,1,1,1,0]]).reshape(1,25)
    label = np.array([[1,0,0,0,0],
                      [0,1,0,0,0],
                      [0,0,1,0,0],
                      [0,0,0,1,0],
                      [0,0,0,0,1]]
    )
    layer = ([25, 20, 20, 20, 5])
    
    W1, W2, W3, W4 = DNN(data, label, layer, 0.01, 1000)
    
    y_pred = np.empty(shape=label.shape)
    
    for i in range(data.shape[0]):
        hidden_1 = ReLu(W1 @ data[i])
        hidden_2 = ReLu(W2 @ hidden_1)
        hidden_3 = ReLu(W3 @ hidden_2)
        output = softmax(W4 @ hidden_3)
        y_pred[i] = np.around(output)
    for i in y_pred:
        print(i)

    
            