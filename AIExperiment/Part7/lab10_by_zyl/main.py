import numpy as np
import matplotlib.pyplot as plt
from pyparsing import alphas
from scipy import signal
from LoadMnistData import *
from Softmax import *
from ReLU import *
from Conv import *
from Pool import *
from MnistConv import *



def train_neu(conv_W, hidden_W, output_W, X, D, alpha, beta, epochs):
    loss_list = []
    dataSize = len(D)
    conv_Moment=np.zeros_like(conv_W)
    hidden_Moment=np.zeros_like(hidden_W)
    output_Moment=np.zeros_like(output_W)
    conv_dW = np.zeros_like(conv_W)
    hidden_dW = np.zeros_like(hidden_W)
    output_dW = np.zeros_like(output_W)
    #one-hot转化
    L=np.zeros((10,2000))
    for i in range(dataSize):
        L[D[i][0]][i] = 1

    for epoch in range(epochs):
        mse = 0
        for i in range(dataSize):
            #前向传播
            x=X[i, :, :]
            d=L[:,i].reshape(10,1)
            conv_Y=Conv(x,conv_W)
            relu_Y=ReLU(conv_Y)
            pool_Y=Pool(relu_Y)
            feature_vector=np.reshape(pool_Y, (-1, 1)) #转化成2000*1的列向量
            hidden_Y=ReLU(np.dot(hidden_W,feature_vector))
            output_Y=Softmax(np.dot(output_W,hidden_Y))
            #后向传播
            e=d-output_Y
            mse += np.sum(e**2) / 10
            delta=e
            e5=np.dot(output_W.T,delta)
            delta5 = (hidden_Y > 0) * e5
            e4=np.dot(hidden_W.T, delta5)
            e3 = np.reshape(e4, pool_Y.shape)
            e2 = np.zeros_like(relu_Y)             # pooling
            W3 = np.ones_like(relu_Y) / (2*2)            
            for c in range(20):
                e2[:, :, c] = np.kron(e3[:, :, c], np.ones((2, 2))) * W3[:, :, c]
            delta2 = (relu_Y > 0) * e2
            delta1_x = np.zeros_like(conv_W)            
            for c in range(20):
                delta1_x[:, :, c] = signal.convolve2d(x[:, :], np.rot90(delta2[:, :, c], 2), 'valid')
            conv_dW =delta1_x
            hidden_dW =np.dot(delta5, feature_vector.T)
            output_dW =np.dot(delta, hidden_Y.T)
            conv_Moment = (1-beta) * conv_dW + beta * conv_Moment
            hidden_Moment = (1-beta) * hidden_dW + beta * hidden_Moment
            output_Moment = (1-beta) * output_dW + beta * output_Moment
            conv_W = conv_W + alpha * conv_Moment
            hidden_W = hidden_W + alpha * hidden_Moment
            output_W = output_W + alpha * output_Moment

        mse /= dataSize
        loss_list.append(mse)
        print('progress: ', epoch+1, 'loss=', mse)

    return conv_W, hidden_W, output_W, loss_list


if __name__ == '__main__':
# Learn
#
    Images, Labels = LoadMnistData('MNIST/t10k-images-idx3-ubyte.gz', 'MNIST/t10k-labels-idx1-ubyte.gz')
    Images = np.divide(Images, 255)
    conv_W = 1e-2 * np.random.randn(9, 9, 20)
    hidden_W = 1e-2 * np.random.uniform(-1, 1, (100, 2000))
    output_W = 1e-2 * np.random.uniform(-1, 1, ( 10,  100))
    X = Images[0:2000, :, :]
    D = Labels[0:2000]    
    # for epoch in range(4):
    #     print(epoch)
    #     conv_W, hidden_W, output_W =train_neu(conv_W, hidden_W, output_W, X, D)

    epochs = 100
    alpha = 0.01
    beta = 0.9
    conv_W, hidden_W, output_W, loss_list = train_neu(conv_W, hidden_W, output_W, X, D, alpha, beta, epochs)

    X = Images[2000:2500, :, :]
    D = Labels[2000:2500]
    acc=0
    dataSize=500
    for i in range(dataSize):
        x  = X[i, :, :]
        y1 = Conv(x, conv_W)
        y2 = ReLU(y1)
        y3 = Pool(y2)
        y4 = np.reshape(y3, (-1, 1))
        v5 = np.dot(hidden_W, y4)
        y5 = ReLU(v5)
        v  = np.dot(output_W, y5)
        y  = Softmax(v)
        index_y_max = np.argmax(y)
        if index_y_max == D[i][0]:
            acc = acc + 1
            
    acc = acc / dataSize
    print("Accuracy is : ", acc)

    fig = plt.figure()
    plt.plot(range(epochs), loss_list)
    plt.ylabel('MSE Loss')
    plt.xlabel('epoch')
    plt.savefig('../figs/lab7_1.jpg',dpi = 300)
    plt.show()