# 版本二：分别传输两次，一次作为训练，一次作为测试
import torch
import torch.nn as nn
import scipy.io as scio
import numpy as np
import matplotlib.pyplot as plt


def modify_data(path, key, mem_n):
    data = scio.loadmat(path)
    data_x = data[key+'_x']
    data_y = data[key+'_y']
    L = len(data_x)
    data_x_temp = np.pad(data_x, ((0, mem_n), (0, 0)), 'wrap').T
    data_x_temp_real = np.real(data_x_temp)
    data_x_temp_imag = np.imag(data_x_temp)
    data_x_new_real = np.zeros([L, mem_n])
    data_x_new_imag = np.zeros([L, mem_n])
    for i in range(L):
        data_x_new_real[i, :] = data_x_temp_real[:, i:mem_n+i]
        data_x_new_imag[i, :] = data_x_temp_imag[:, i:mem_n+i]

    data_y_real = np.real(data_y)
    data_y_imag = np.imag(data_y)
    return data_x_new_real, data_x_new_imag, data_y_real, data_y_imag


def train(epochs, model, x_train, y_train, criterion, optimizer):
    train_loss = []
    for i in range(epochs):
        x_train = x_train
        y_train = y_train
        y_pred = model.forward(x_train)
        loss = criterion(y_pred, y_train)
        train_loss.append(loss.item())
        if i % 10 == 0:
            print(f'Epoch: {i} Loss: {loss}')

        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

    # 绘图代码
    plt.plot(np.arange(len(train_loss)), train_loss, label="train loss")
    plt.legend()  # 显示图例
    plt.xlabel('epoches')
    plt.title('loss')
    # plt.show()

    return model


class Model(nn.Module):
    def __init__(self):
        super(Model, self).__init__()
        self.linear1 = nn.Linear(30, 36)
        self.act1 = nn.ReLU()
        self.linear2 = nn.Linear(36, 40)
        self.act2 = nn.ReLU()
        self.linear3 = nn.Linear(40, 24)
        self.act3 = nn.ReLU()
        self.linear4 = nn.Linear(24, 16)
        self.act4 = nn.ReLU()
        self.output = nn.Linear(16, 1)

    # 前向传播
    def forward(self, x):
        x = self.linear1(x)
        x = self.act1(x)
        x = self.linear2(x)
        x = self.act2(x)
        x = self.linear3(x)
        x = self.act3(x)
        x = self.linear4(x)
        x = self.act4(x)
        x = self.output(x)
        return x


mem_n = 30
model_real = Model()
model_imag = Model()
loss_real = nn.MSELoss()
loss_imag = nn.MSELoss()

optimizer_real = torch.optim.Adam(model_real.parameters(), lr=0.001)
optimizer_imag = torch.optim.Adam(model_imag.parameters(), lr=0.001)

[X_real, X_imag, Y_real, Y_imag] = modify_data(
    '../data/data_train.mat', 'mt', mem_n)

x_train_real = torch.FloatTensor(X_real)
y_train_real = torch.FloatTensor(Y_real)
x_train_imag = torch.FloatTensor(X_imag)
y_train_imag = torch.FloatTensor(Y_imag)

model_real = train(300, model_real, x_train_real,
                   y_train_real, loss_real, optimizer_real)
model_imag = train(300, model_imag, x_train_imag,
                   y_train_imag, loss_imag, optimizer_imag)

[X_real, X_imag, Y_real, Y_imag] = modify_data('../data/data.mat', 'mt', mem_n)

x_test_real = torch.FloatTensor(X_real)
y_test_real = torch.FloatTensor(Y_real)
x_test_imag = torch.FloatTensor(X_imag)
y_test_imag = torch.FloatTensor(Y_imag)

Y_pred_real = []
Y_pred_imag = []
with torch.no_grad():
    for val in x_test_real:
        y_pred = model_real.forward(val)
        Y_pred_real.append(y_pred.item())

with torch.no_grad():
    for val in x_test_imag:
        y_pred = model_real.forward(val)
        Y_pred_imag.append(y_pred.item())

Y_pred_real = np.array(Y_pred_real)
Y_pred_real = Y_pred_real.reshape(-1, 1)
Y_pred_imag = np.array(Y_pred_imag)
Y_pred_imag = Y_pred_imag.reshape(-1, 1)
X_real_new = X_real[:, 0].reshape(-1, 1)
X_imag_new = X_imag[:, 0].reshape(-1, 1)
scio.savemat('../data_out/E_eq_mt.mat', mdict={'E_tx_mt_real': Y_real,
                                               'E_tx_mt_imag': Y_imag,
                                               'E_rx_mt_real': X_real_new,
                                               'E_rx_mt_imag': X_imag_new,
                                               'E_eq_mt_real': Y_pred_real,
                                               'E_eq_mt_imag': Y_pred_imag})
# SF0.mat为保存的自定义文件名，label_test、predlabel为需要保存的数据

plt.figure(2)
plt.plot(np.arange(len(Y_pred_real)), Y_pred_real, label="pred real")
plt.plot(np.arange(len(Y_pred_real)), np.real(Y_real), label="label real")
plt.plot(np.arange(len(Y_pred_real)), np.real(X_real_new), label="test real")
plt.legend()
plt.xlim(0, 20)
plt.show()
