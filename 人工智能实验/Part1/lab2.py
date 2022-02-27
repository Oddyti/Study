import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
import kNN

df = pd.read_table('datingTestSet2.txt',sep='\s+', names = ['A', 'B', 'C', 'Y'])
df2 = df.iloc[:, :3]
df2 = (df2-df2.mean())/df2.std()    
lable =df.iloc[:,3:4]
df2.loc[:, 'Y'] = lable
X_train, X_test, Y_train, Y_test = train_test_split(df2.iloc[:, :3], df2.Y, train_size=.90)
group = X_train.values
label = Y_train.values
length = len(X_test)
X_test.iloc[0:1,:]
res = []
Tnum = 0
Fnum = 0
for i in range(length):
    inX = X_test.iloc[i:i+1 , :].values
    res.append(kNN.classify0(inX, group, label, k = 3))
    if(kNN.classify0(inX, group, label, k = 3) == Y_test.values[i]):
        # print('True')
        Tnum += 1
    else:
        # print('False')
        Fnum += 1
print('正确率%%%.2f' %(100*Tnum/(Tnum+Fnum)))

