from cmath import exp
from itertools import count
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split

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
        
    print('loss = \n', mse, '\n')
    return W0,W1
        
if __name__ == '__main__':

    # 读取训练数据
    df = pd.read_table('training.data', sep=' ', names=[
                    'x1', 'x2', "x3", "x4", "x5", "x6", "y"])
    df.head()
    # 分割
    x = df.iloc[:, 0:6]
    y = df.iloc[:, 6]
    x = (x - x.mean())/x.std()

    X_1, X_2, Y_1, Y_2 = train_test_split(
        x, y, train_size=.0012, random_state=1)


    X_train, X_test, Y_train, Y_test = train_test_split(
        X_1, Y_1, train_size=.6, random_state=1)


    train_data = np.array(X_train)
    train_lable = np.array(Y_train)
    test_data = np.array(X_test)
    test_lable = np.array(Y_test)
    
    layer = [6,10,1]
    
    learn_rate = 0.9
    
    epochs = 5000
    
    W0,W1 = bp(train_data, train_lable, layer, learn_rate, epochs)
    
    y_pred = []
    # predict
    for i in range(test_data.shape[0]):
            # 隐藏层
            hidden = sigmod(np.dot(test_data[i], W0))
            # 输出层
            output = sigmod(np.dot(hidden, W1))
            output = np.around(output)
            y_pred.append(output)
    # np.savetxt('result_pred.txt', y_pred, fmt='%.00f')
    # np.savetxt('result_lable.txt', test_lable, fmt='%.00f')
    count = 0
    for i in range(test_lable.shape[0]):
        if test_lable[i] == y_pred[i]:
            count += 1
    print('正确率 %d // %d ' % (count, test_lable.shape[0]))



