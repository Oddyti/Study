import sys
import os
import pickle
import numpy as np
import matplotlib
import scipy.io as sio
import matplotlib.pyplot as plt
from svmutil import *
from numpy import *
decisionValues = sio.loadmat('decisionValues.mat')
decisionValues = decisionValues['decisionValues']

yTest = sio.loadmat('yTest.mat')
yTest = yTest['yTest']
yTest = yTest[0,:]

totalScores = sorted(decisionValues)
index = sorted(range(len(decisionValues)), key=decisionValues.__getitem__)
labels = yTest

for i in range(len(labels)):
    labels[i] = yTest[index[i]]

truePositive = zeros(len(labels)+1)
falsePositive = zeros(len(labels)+1)

for i in range(len(totalScores)):
    if labels[i]>0.5:
        truePositive[0] +=1
    else:
        falsePositive[0] +=1

for i in range(len(totalScores)):
    if labels[i]>0.5:
        truePositive[i + 1] = truePositive[i] - 1
        falsePositive[i + 1] = falsePositive[i]
    else:
        falsePositive[i + 1] = falsePositive[i] - 1
        truePositive[i + 1] = truePositive[i]

truePositive = truePositive/truePositive[0]
falsePositive = falsePositive/falsePositive[0]

fig = plt.figure()
ax = fig.add_subplot(111)
ax.plot(falsePositive,truePositive)
plt.show()

count = 0
for i in labels:
    if i ==1:
        count+=1


count = 0
for i in yTrain:
    if i ==1:
        count+=1



