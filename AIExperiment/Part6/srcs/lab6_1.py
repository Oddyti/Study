import numpy as np
import matplotlib.pyplot as plt
from dl import reluBP
from dl import relu
from dl import softmax

if __name__ == "__main__":
    # define data set and label set
    data=np.zeros((5,25))
    data[0,:]=np.array([[0,1,1,0,0],[0,0,1,0,0],[0,0,1,0,0],[0,0,1,0,0],[0,1,1,1,0]]).reshape(1,25)
    data[1,:]=np.array([[1,1,1,1,0],[0,0,0,0,1],[0,1,1,1,0],[1,0,0,0,0],[1,1,1,1,1]]).reshape(1,25)
    data[2,:]=np.array([[1,1,1,1,0],[0,0,0,0,1],[0,1,1,1,0],[0,0,0,0,1],[1,1,1,1,0]]).reshape(1,25)
    data[3,:]=np.array([[0,0,0,1,0],[0,0,1,1,0],[0,1,0,1,0],[1,1,1,1,1],[0,0,0,1,0]]).reshape(1,25)
    data[4,:]=np.array([[1,1,1,1,1],[1,0,0,0,0],[1,1,1,1,0],[0,0,0,0,1],[1,1,1,1,0]]).reshape(1,25)
    # label = np.array([[0,0,0,0,1],[0,0,0,1,0],[0,0,1,0,0],[0,1,0,0,0],[1,0,0,0,0]])
    label = np.array([[1,0,0,0,0],
                      [0,1,0,0,0],
                      [0,0,1,0,0],
                      [0,0,0,1,0],
                      [0,0,0,0,1]]
    )

    # train and compute loss
    epochs = 8000
    alpha = 0.01
    W1, W2, W3, W4, loss_list = reluBP(data, label, alpha, epochs)

    prediction = np.zeros((5,5))
    for i in range(5):
        Y1 = relu(W1 @ data[i])
        Y2 = relu(W2 @ Y1)
        Y3 = relu(W3 @ Y2)
        Y4 = softmax(W4 @ Y3)
        prediction[i] = Y4
    print(prediction)

    fig = plt.figure()
    plt.plot(range(epochs), loss_list)
    plt.ylabel('MSE Loss')
    plt.xlabel('epoch')
    plt.savefig('../figs/lab6_1.jpg',dpi = 300)
    plt.show()