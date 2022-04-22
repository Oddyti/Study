import math
import numpy as np
import random
import matplotlib.pyplot as plt

# W:传递权重的参数, X:训练数据, D:标准输出, alpha:学习率


def SGD(W, X, D, alpha):
    for i in range(len(X)):
        v = 0
        d = D[i]
        for j in range(len(X[0])):
            v = v + W[j]*X[i][j]
        y = sig(v)
        e = d - y
        for j in range(len(X[0])):
            dw = y*(1-y)*e*alpha*X[i][j]
            W[j] = W[j] + dw
    return W


def Batch(W, X, D, alpha):
    wSum = []
    for i in range(len(W)):
        wSum.append(0)
    for i in range(len(X)):
        v = 0
        d = D[i]
        for j in range(len(X[0])):
            v = v + W[j]*X[i][j]
        y = sig(v)
        e = d - y
        for j in range(len(X[0])):
            dw = y*(1-y)*alpha*e*X[i][j]
            wSum[j] = wSum[j] + dw
    for i in range(len(W)):
        W[i] = W[i] + wSum[i]*1.0/len(D)
    return W


def sig(x):
    return 1.0/(1+math.exp(-x))


if __name__ == '__main__':
    data = [[0, 0, 1], [0, 1, 1], [1, 0, 1], [1, 1, 1]]
    D = [0, 0, 1, 1]
    MSESGD = []
    MSEBatch = []
    WSGD = []
    WBatch = []
    for i in range(len(data[0])):
        WSGD.append(2*random.random()-1)
        WBatch.append(2*random.random()-1)
    alpha = 0.1
    for i in range(1000):
        WSGD = SGD(WSGD, data, D, alpha)
        WBatch = Batch(WBatch, data, D, alpha)
        y_SGD = []
        y_Batch = []
        for j in range(len(data)):
            v_SGD = 0
            v_Batch = 0
            for q in range(len(data[0])):
                v_SGD = v_SGD + WSGD[q]*data[j][q]
                v_Batch = v_Batch + WBatch[q]*data[j][q]
            y_SGD.append(sig(v_SGD))
            y_Batch.append(sig(v_Batch))
        MSEBatch.append(np.mean(np.square(np.array(D)-np.array(y_Batch))))
        MSESGD.append(np.mean(np.square(np.array(D)-np.array(y_SGD))))

    plt.plot(range(1000), MSEBatch)
    plt.plot(range(1000), MSESGD)
    plt.savefig('5-1.png')
    plt.show()
