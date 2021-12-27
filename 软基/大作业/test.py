# -*- coding: utf-8 -*-
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pandas import DataFrame,Series
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression

# 导入数据 使用pandas库pd.read_csv函数
data = pd.read_csv("data.csv")
# 显示部分数据
print(data)
# 数据统计信息
    #  count：数量统计，此列共有多少有效值
    #    unipue：不同的值有多少个
    #    std：标准差
    #    min：最小值
    #    25%：四分之一分位数
    #    50%：二分之一分位数
    #    75%：四分之三分位数
    #    max：最大值
    #    mean：均值
print(data.describe())
# 计算相关系数
    # 相关系数0~0.3弱相关0.3~0.6中等程度相关0.6~1强相关
print(data.corr());
# 构建训练集和测试集
    #  前80%划分为训练集，后20%为测试集
X_train,X_test,Y_train,Y_test = train_test_split(data.iloc[:,:9],data.y, train_size=.80)
print(Y_train)
# 放入LinearRegression模型中使用fit函数进行训练，最后得到对应的线性回归方程
# a 为截距，b 为回归系数
model = LinearRegression
model.fit(X_train, Y_train)
a = model.intercept
b = model.coef_  

# 数据预测与模型评
# 使用predict 与 score 函数
# 此处使用R方检测，score 为决定系数R方，0～1，预测值和测试值越接近，score越大
score = model.score(X_test,Y_test)
 
#对线性回归进行预测
Y_pred = model.predict(X_test)
 
print(Y_pred)
 
plt.plot(range(len(Y_pred)),Y_pred,'b',label="predict")
#显示图像
plt.show()

# 预测值与测试值对比
plt.figure()
plt.plot(range(len(Y_pred)),Y_pred,'b',label="predict")
plt.plot(range(len(Y_pred)),Y_test,'r',label="test")
plt.legend(loc="upper right")
plt.xlabel("index")
plt.ylabel('value of y')
plt.show()

