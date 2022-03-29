from itertools import count
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn import svm
# 读取训练数据
df = pd.read_table('training.data', sep=' ', names=[
                   'x1', 'x2', "x3", "x4", "x5", "x6", "y"])
# 删除数据集中缺失特征的数据
df = df.dropna()
# 分割
x = df.iloc[:, 0:6]
y = df.iloc[:, 6]
# 归一化
x = (x - x.mean())/x.std()
# 划分用于选择超参数的数据集与测试集
X_part1, X_remain, Y_part1, Y_remain = train_test_split(
    x, y, train_size=.10, random_state=1)
X_train1, X_test1, Y_train1, Y_test1 = train_test_split(
    X_part1, Y_part1, train_size=.6, random_state=1)
print('-----用于训练选择超参数的X_train长度-----')
print(len(X_train1))
print('-----用于选择超参数的Y_select长度-----')
print(len(Y_test1))

# 用于选择最佳的gamma, C的函数
def Choose_C_gamma(X_train1, Y_train1, X_test1, Y_test1):
    result = []
    for i in (-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5):
        C = 2 ** i
        for j in (-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5):
            G = 2 ** j
            clf1 = svm.SVC(kernel='rbf', gamma=G, C=C).fit(X_train1, Y_train1)
            Y_predict1 = clf1.predict(X_test1)
            count = 0
            for i in range(len(Y_test1)):
                if Y_predict1[i] == Y_test1.values[i]:
                    count += 1
            result.append([G, C, count])
    # 按照正确个数降序为第一排序条件，C升序排列
    result1 = sorted(result, key=lambda x: (-x[2], x[1]))
    return result1[0][0], result1[0][1]


gamma_best, C_best = Choose_C_gamma(X_train1, Y_train1, X_test1, Y_test1)
print('-----最终选择的gamma, C----')
print(gamma_best, C_best)

# 划分用于训练的数据集与测试集
X_train2, X_test, Y_train2, Y_test = train_test_split(
    x, y, train_size=.10, random_state=1)
print('-----用于训练的数据集的个数----')
print(len(X_train2))

clf_final = svm.SVC(kernel='rbf', gamma=gamma_best,
                    C=C_best).fit(X_train2, Y_train2)
Y_predict2 = clf_final.predict(X_test)
# 计算正确率
k = 0
for i in range(len(Y_predict2)):
    if Y_test.values[i] == Y_predict2[i]:
        k += 1
accuracy = float(k)/float(len(Y_predict2))
print("The accuracy of SVM is %f" % (accuracy))

df1 = pd.read_table('testingNoAnswer.data', sep=' ', names=[
                    'x1', 'x2', "x3", "x4", "x5", "x6"])
df1 = (df1 - df1.mean())/df1.std()
Y_predict_final = clf_final.predict(df1)
np.savetxt('submit.txt', Y_predict_final, fmt='%.00f')
