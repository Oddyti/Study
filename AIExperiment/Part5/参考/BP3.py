from cmath import exp
import numpy as np


def sigmod(x):
    return 1 / (1 + np.exp(-x))

def sigmod_derivative(x):
    return x * (1 - x)


'''
data: 输入值
y: 期望结果
layer: BP网络各层的节点数
'''


def bp(data, y, layer,learn_rate, epochs):
    
    # 初始化输入到隐藏层权重矩阵
    W0 = np.random.randn(layer[0], layer[1])
    # 初始化输入到隐藏层权重矩阵
    W1 = np.random.randn(layer[1], layer[2])
    
    for epoch in range(epochs):
        mse = 0
        for i in range(data.shape[0]):
            # 隐藏层
            hidden = sigmod(np.dot(data[i], W0))
            # 输出层
            output = sigmod(np.dot(hidden, W1))
            # 输出到隐藏层误差
            error1 = y[i] - output
            # 误差
            mse += error1**2
            # 输出到隐藏层delta
            delta1 = error1 * sigmod_derivative(output)
            # 隐藏层到输入层误差
            error0 = (delta1*W1).T
            # 隐藏层到输入层delta
            delta0 = error0 * sigmod_derivative(hidden)
            # 更新W1
            W1 = W1 + learn_rate * delta1 * hidden.reshape(layer[1],layer[2])
            W0 = W0 + learn_rate * np.dot(data[i].reshape(layer[0], 1), delta0)
            
        mse /= data.shape[0]
        # print('progress: ', epoch+1, 'loss=', mse)
        
    print('loss = \n', mse, '\n', 'input_weight\n', W0, '\n', 'output_weight\n', W1)
    return W0,W1
        
if __name__ == '__main__':
    data = np.array([
        [0, 0, 1, 1],
        [0, 1, 1, 0],
        [1, 1, 1, 1],
        [1, 1, 1, 0]
    ])
    y = np.array([0,1,1,0])
    layer = [4,4,1]
    learn_rate = 0.9
    epochs = 2500
    W0,W1 = bp(data, y, layer, learn_rate, epochs)
    y_pred = []
    # predict
    for i in range(data.shape[0]):
            # 隐藏层
            hidden = sigmod(np.dot(data[i], W0))
            # 输出层
            output = sigmod(np.dot(hidden, W1))
            y_pred.append(output)
    print(y_pred)

