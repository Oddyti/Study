from http.client import ImproperConnectionState
from numpy import *
from collections import Counter
import operator
def createDataSet():
    group = array([[1.0, 1.1], [1.0, 1.0], [0, 0], [0, 0.1]])
    labels = ['A', 'A', 'B', 'B']
    return group, labels

def classify0(inX, group, labels, k = 3):
    res1 = (inX - group)**2
    dist = res1[:,0] + res1[:,1]
    dic = argsort(dist)
    dic = dic[0:k:1]
    newdic = []
    for i in range(k):
        newdic.append(labels[dic[i]])
    c = Counter(newdic).most_common(1)
    return c[0][0]