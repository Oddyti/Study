# -*- coding: utf-8 -*-
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from pandas import DataFrame
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.preprocessing import PolynomialFeatures 
from sklearn.metrics import r2_score, explained_variance_score as EVS, mean_squared_error as MSE

# 导入需要的模块



# 用来绘图的，封装了matplot
# 要注意的是一旦导入了seaborn，
# matplotlib的默认作图风格就会被覆盖成seaborn的格式
import seaborn as sns       

from scipy import stats
from scipy.stats import  norm
from sklearn.preprocessing import StandardScaler



df = pd.read_csv("data.csv")

print(df.describe())

corrmat = df.corr()
f, ax = plt.subplots(figsize=(20, 9))
p1 = sns.heatmap(corrmat, vmax=0.8, square=True, annot = True)

ax.set_title('Heat Map')
s1 = p1.get_figure()
s1.savefig('HeatMap.jpg',dpi=300,bbox_inches='tight')

sns.set()
cols = ['y','x3','x4', 'x5','x6']
sns.pairplot(df[cols], size = 2.5)
plt.show()


