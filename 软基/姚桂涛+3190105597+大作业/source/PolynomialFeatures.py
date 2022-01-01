# -*- coding: utf-8 -*-
# 导入库
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns  
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import PolynomialFeatures
from sklearn.metrics import r2_score, mean_squared_error as MSE

#解决图片输出中文显示问题
plt.rcParams['font.sans-serif'] = ['SimHei'] # 指定默认字体
plt.rcParams['axes.unicode_minus'] = False # 解决保存图像是负号'-'显示为方块的问题

# 读入数据
df = pd.read_csv("data.csv")
x = df.iloc[:,:9]
y = df['y']

# 绘制相关性热图 
corrmat = df.corr()
f, ax = plt.subplots(figsize=(20, 9))
p1 = sns.heatmap(corrmat, vmax=0.8, square=True, annot = True)
ax.set_title('Heat Map')
s1 = p1.get_figure()
s1.savefig('HeatMap.jpg',dpi=300,bbox_inches='tight')

# 线性回归模型
X_train1, X_test1, Y_train1, Y_test1 = train_test_split(x, y, train_size=.80, random_state=1)
LinearR = LinearRegression()
LinearR.fit(X_train1, Y_train1)
print("截距：",LinearR.intercept_)
print("系数：",LinearR.coef_)
Y_pred1 = LinearR.predict(X_test1)

# 平均误差相对于样本真实值均值偏差
print("mse相对于测试值平均值的偏差：", np.sqrt(MSE(Y_test1, Y_pred1))/Y_test1.mean())
# R^2检测
print("r2检测：", r2_score(y_true=Y_test1, y_pred=Y_pred1))

# 生成对比图
plt.close()
plt.figure()
plt.plot(range(len(Y_pred1)), Y_pred1, 'b', label="predict")
plt.plot(range(len(Y_pred1)), Y_test1, 'r', label="test")
plt.legend(loc="upper right")
plt.title("线性回归模型预测",fontsize = 16)
plt.xlabel("Index",fontsize = 16)
plt.ylabel('Value of y',fontsize = 16)
plt.savefig('LinearR', dpi = 300)
plt.show()

# 非线性回归模型
PolyF = PolynomialFeatures(degree=2, interaction_only=False, include_bias=False)
X_Poly = PolyF.fit_transform(x)
X_train2, X_test2, Y_train2, Y_test2 = train_test_split(X_Poly, y, train_size=0.80, random_state=1)
LinearR2 = LinearRegression().fit(X_train2, Y_train2)
print("截距：",LinearR2.intercept_)
print("系数：",LinearR2.coef_)
Y_pred2 = LinearR2.predict(X_test2)

# 平均误差相对于样本真实值均值偏差
print("mse相对于测试值平均值的偏差：", np.sqrt(MSE(Y_test2, Y_pred2))/Y_test2.mean())
# R^2检测
print("r2检测：", r2_score(y_true=Y_test2, y_pred=Y_pred2))

# 生成对比图
plt.figure()
plt.plot(range(len(Y_pred2)), Y_pred2, 'b', label="Predict")
plt.plot(range(len(Y_pred2)), Y_test2, 'r', label="Test")
plt.legend(loc="upper right")
plt.title("非线性回归模型预测",fontsize = 16)
plt.xlabel("Index",fontsize = 16)
plt.ylabel('Value of y',fontsize = 16)
plt.savefig('LinearR2', dpi = 300 )
plt.show()
