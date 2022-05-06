import numpy as np
import matplotlib.pyplot as plt

def sigmoid(x):
    return 1 / (1 + np.exp(-x))

def sigmoid_derivative(x):
    return x * (1 - x)

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
    x -= np.max(x)
    softmax_sum = np.sum(np.exp(x))
    for i in range(x.shape[0]):
        x[i] = np.exp(x[i]) / softmax_sum 
    return x

def DNN(data, y, layer, learn_rate, epochs):
    
    loss_list = []
    
    W1 = np.random.randn(layer[0], layer[1])
    W2 = np.random.randn(layer[1], layer[2])
    W3 = np.random.randn(layer[2], layer[3])
    W4 = np.random.randn(layer[3], layer[4])

    for epoch in range(epochs):
        mse = 0
        for i in range(data.shape[0]):
            hidden_1 = ReLu(data[i] @ W1)
            hidden_2 = ReLu(hidden_1 @ W2)
            hidden_3 = ReLu(hidden_2 @ W3)
            output = softmax(hidden_3 @ W4)
            error_4 = y[i] - output
            mse += np.sum(error_4**2) / 25
            delta_4 = error_4 * 1
            error_3 = delta_4 @ W4.T
            delta_3 = error_3 * ReLu_derivative(hidden_3)
            error_2 = delta_3 @ W3.T
            delta_2 = error_2 * ReLu_derivative(hidden_2)
            error_1 = delta_2 @ W2.T
            delta_1 = error_1 * ReLu_derivative(hidden_1)
            # 更新 W
            W4 = W4 + learn_rate * (hidden_3.reshape(layer[3], 1) @ delta_4.reshape(1, layer[4]))
            W3 = W3 + learn_rate * (hidden_2.reshape(layer[2], 1) @ delta_3.reshape(1, layer[3]))
            W2 = W2 + learn_rate * (hidden_1.reshape(layer[1], 1) @ delta_2.reshape(1, layer[2]))
            W1 = W1 + learn_rate * (data[i].reshape(layer[0], 1) @ delta_1.reshape(1, layer[1]))
        mse /= data.shape[0]
        loss_list.append(mse)
        print('progress: ', epoch+1, 'loss=', mse)
    return W1, W2, W3, W4, loss_list

def DNN_dropout(data, y, layer, learn_rate, epochs, dropout_rate = 0):
    loss_list = []
    
    mask_1 = np.ones(layer[1]) / (1 - dropout_rate)
    for i in range(int(np.around(dropout_rate * layer[1]))):
        mask_1[i] = 0
    mask_2 = np.ones(layer[2]) / (1 - dropout_rate)
    for i in range(int(np.around(dropout_rate * layer[2]))):
        mask_2[i] = 0
    mask_3 = np.ones(layer[3]) / (1 - dropout_rate)
    for i in range(int(np.around(dropout_rate * layer[3]))):
        mask_3[i] = 0

    W1 = np.random.randn(layer[0], layer[1])
    W2 = np.random.randn(layer[1], layer[2])
    W3 = np.random.randn(layer[2], layer[3])
    W4 = np.random.randn(layer[3], layer[4])

    for epoch in range(epochs):
        mse = 0
        np.random.shuffle(mask_1)
        np.random.shuffle(mask_2)
        np.random.shuffle(mask_3)
        for i in range(data.shape[0]):
            hidden_1 = sigmoid(data[i] @ W1) * mask_1
            hidden_2 = sigmoid(hidden_1 @ W2) * mask_2
            hidden_3 = sigmoid(hidden_2 @ W3) * mask_3
            output = softmax(hidden_3 @ W4)
            error_4 = y[i] - output
            mse += np.sum(error_4**2) / 25
            delta_4 = error_4 * 1
            error_3 = delta_4 @ W4.T
            delta_3 = error_3 * sigmoid_derivative(hidden_3)
            error_2 = delta_3 @ W3.T
            delta_2 = error_2 * sigmoid_derivative(hidden_2)
            error_1 = delta_2 @ W2.T
            delta_1 = error_1 * sigmoid_derivative(hidden_1)
            # 更新 W
            W4 = W4 + learn_rate * (hidden_3.reshape(layer[3], 1) @ delta_4.reshape(1, layer[4]))
            W3 = W3 + learn_rate * (hidden_2.reshape(layer[2], 1) @ delta_3.reshape(1, layer[3]))
            W2 = W2 + learn_rate * (hidden_1.reshape(layer[1], 1) @ delta_2.reshape(1, layer[2]))
            W1 = W1 + learn_rate * (data[i].reshape(layer[0], 1) @ delta_1.reshape(1, layer[1]))
        mse /= data.shape[0]
        loss_list.append(mse)
        # print('progress: ', epoch+1, 'loss=', mse)
    return W1, W2, W3, W4, loss_list

if __name__ == '__main__':
    data = np.array([[0, 1, 1, 0, 0,
                    0, 0, 1, 0, 0,
                    0, 0, 1, 0, 0,
                    0, 0, 1, 0, 0,
                    0, 1, 1, 1, 0],
                    [1, 1, 1, 1, 0,
                    0, 0, 0, 0, 1,
                    0, 1, 1, 1, 0,
                    1, 0, 0, 0, 0,
                    1, 1, 1, 1, 1],
                    [1, 1, 1, 1, 0,
                    0, 0, 0, 0, 1,
                    0, 1, 1, 1, 0,
                    0, 0, 0, 0, 1,
                    1, 1, 1, 1, 0],
                    [0, 0, 0, 1, 0,
                    0, 0, 1, 1, 0,
                    0, 1, 0, 1, 0,
                    1, 1, 1, 1, 1,
                    0, 0, 0, 1, 0],
                    [1, 1, 1, 1, 1,
                    1, 0, 0, 0, 0,
                    1, 1, 1, 1, 0,
                    0, 0, 0, 0, 1,
                    1, 1, 1, 1, 0]
    ])
    label = np.array([[1,0,0,0,0],
                      [0,1,0,0,0],
                      [0,0,1,0,0],
                      [0,0,0,1,0],
                      [0,0,0,0,1]]
    )
    
    layer = ([25, 20, 20, 20, 5])
    learn_rate = 0.01
    epochs_1 = 800
    epochs_2 = 10000
    dropout_rate = 0.2
    
    W1, W2, W3, W4, loss_list_1 = DNN(data, label, layer, learn_rate, epochs_1)
    np.save('W1.npy', W1)
    np.save('W2.npy', W2)
    np.save('W3.npy', W3)
    np.save('W4.npy', W4)
    y_pred = np.empty(shape=label.shape)
    
    for i in range(data.shape[0]):
        hidden_1 = ReLu(data[i] @ W1)
        hidden_2 = ReLu(hidden_1 @ W2)
        hidden_3 = ReLu(hidden_2 @ W3)
        output = softmax(hidden_3 @ W4)
        y_pred[i] = output
    # y_pred = np.around(y_pred, 3)
    
    for i in y_pred:
        print(i)

    W1_2, W2_2, W3_2, W4_2, loss_list_2 = DNN_dropout(data, label, layer, learn_rate, epochs_2, dropout_rate)
    np.save('W1_2.npy', W1_2)
    np.save('W2_2.npy', W2_2)
    np.save('W3_2.npy', W3_2)
    np.save('W4_2.npy', W4_2)
    y_pred_1 = np.empty(shape=label.shape)

    for i in range(data.shape[0]):
        hidden_1 = sigmoid(data[i] @ W1_2)
        hidden_2 = sigmoid(hidden_1 @ W2_2)
        hidden_3 = sigmoid(hidden_2 @ W3_2)
        output = softmax(hidden_3 @ W4_2)
        y_pred_1[i] = output
    y_pred_1 = np.around(y_pred_1,3)
    
    for i in y_pred_1:
        print(i)
    
    
    fig1 = plt.figure(1)
    plt.plot(range(epochs_1), loss_list_1)
    plt.title('DNN')
    plt.ylabel('MSE Loss')
    plt.xlabel('epoch')
    plt.savefig('6_1.png',dpi = 300)
    plt.show()

    fig2 = plt.figure(2)
    plt.plot(range(epochs_2), loss_list_2)
    plt.title('DNN dropout')
    plt.ylabel('MSE Loss')
    plt.xlabel('epoch')
    plt.savefig('6_2.png',dpi = 300)
    plt.show()