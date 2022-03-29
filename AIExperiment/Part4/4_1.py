from numpy import *
import pca
import matplotlib.pyplot as plt

dataMat = pca.loadDataSet('testSet.txt')
lowDMat, reconMat = pca.pca(dataMat, 2) 
shape(lowDMat)
fig = plt.figure(1)
ax = fig.add_subplot(1,1,1)
ax.scatter(dataMat[:,0].tolist(), dataMat[:,1].tolist(), marker = '^', s = 90)
ax.scatter(reconMat[:,0].tolist(), reconMat[:,1].tolist(), marker = 'o', s = 50, c = 'red')
plt.savefig("4-1-topNfeat(2).png", dpi = 400)
plt.show()

