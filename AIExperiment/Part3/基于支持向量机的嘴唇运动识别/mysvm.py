
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn import svm

df = pd.read_table('training.data', sep = ' ', names = ['x1', 'x2', "x3", "x4", "x5", "x6", "y"])
df.iloc[25257:25274,:]
print('-----查找 NaN值的数据-----')
print(df[df.isnull().values==True]) # 查找所有带NaN值的数据
df = df.dropna()
print('-----查找 NaN值的数据（删除后）-----')
print(df[df.isnull().values==True]) # 查找所有带NaN值的数据

x = df.iloc[:,0:6]
y = df.iloc[:,6]
print('-----x-----')
print(x.head())
print('-----y-----')
print(y.head())

x = (x - x.mean())/x.std()
print('-----归一化后的x-----')
print(x.head())

X_train, X_select, Y_train, Y_select = train_test_split(x, y, train_size=.99, random_state=1)
print('-----用于选择超参数的Y_select长度-----')
print(len(Y_select))

result =[]
for i in (-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5):
    C = 2 ** i
    for j in (-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5):
        G = 2 ** j
        clf1 = svm.SVC(kernel='rbf', gamma=G, C=C).fit(X_train, Y_train)
        y_predictions1=clf1.predict(X_select)
        k=0
        for i in range(len(Y_select)):
            if y_predictions1[i]==Y_select[i]:
                k+=1
        result.append([C,G,k])
        print('C, G, k', [C,G,k])
result1 = sorted(result, key=lambda x:(-x[2], x[1]))


X_train2, X_test, Y_train2, Y_test = train_test_split(x, y, train_size=.20, random_state=1)
clf_final= svm.SVC(kernel='rbf', gamma=0.25, C=0.5).fit(X_train2, Y_train2)
Y_predict = clf_final.predict(X_test)
k = 0
for i in range(len(Y_predict)):
    if Y_test[i]==Y_predict[i]:
        k+=1
accuracy=float(k)/float(len(Y_predict))
print("The accuracy of SVM is %f"%(accuracy))

df1 = pd.read_table('testingNoAnswer.data', sep = ' ', names = ['x1', 'x2', "x3", "x4", "x5", "x6"])
df1 = (df1 - df1.mean())/df1.std()
#调用训练好的模型对测试数据进行分类
Y_predict_final = clf_final.predict(df1)
#保存结果
np.savetxt('submit.txt',Y_predict_final, fmt='%.00f')


