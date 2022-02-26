from cProfile import label
from numpy import *
import operator
group = array([[1.0, 1.1], [1.0, 1.0], [0, 0], [0, 0.1]])
inX = array([[0.5, 0.5]])
res1 = (inX - group)**2
dist = res1[:,0] + res1[:,1]
dic = argsort(dist)
print(dist)
print(dic)
k = 3
dic = dic[0:k:1]
print(dic)
labels = ['A', 'A', 'B', 'B']


