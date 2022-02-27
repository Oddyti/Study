import pandas as pd
import kNN
from sklearn.model_selection import train_test_split

df = pd.read_table('datingTestSet2.txt',sep='\s+', names = ['A', 'B', 'C', 'Y'])
# 对特征进行归一化处理
df2 = df.iloc[:, :3]
df2 = (df2-df2.mean())/df2.std()    
lable =df.iloc[:,3:4]
df2.loc[:, 'Y'] = lable
# 对数据集进行测试集和训练集划分，90%作为训练集，10%作为测试集
X_train, X_test, Y_train, Y_test = train_test_split(df2.iloc[:, :3], df2.Y, train_size=.90)
# 将DataFrame格式转化为numpy格式处理
group = X_train.values
label = Y_train.values
length = len(X_test)
X_test.iloc[0:1,:]
# res以储存测试结果
res = []
# 设置错误正确数count以计算正确率
Tnum = 0
Fnum = 0
for i in range(length):
    inX = X_test.iloc[i:i+1 , :].values
    res.append(kNN.classify0(inX, group, label, k = 3))
    if(kNN.classify0(inX, group, label, k = 3) == Y_test.values[i]):
        Tnum += 1
    else:
        Fnum += 1
res1 = pd.DataFrame(data = res, columns=['TestResult'])
Y_test.reset_index(inplace=True,drop=True)
res1.loc[:, 'OriginTest'] = Y_test

print('前20个数据测试结果和原数据比较')
print('---------------------——----')
print(res1.head(20))
print('---------------------——----')
print('正确率%.2f%%' %(100*Tnum/(Tnum+Fnum)))

