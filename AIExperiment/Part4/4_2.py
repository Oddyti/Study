import numpy as np
import pca
import matplotlib.pyplot as plt

dataMat = pca.replaceNanWithMean()
meanVals = np.mean(dataMat, axis = 0)
meanRemoved = dataMat - meanVals
covMat = np.cov(meanRemoved, rowvar = 0)
eigVals, eigVects = np.linalg.eig(np.mat(covMat))

# 计算降维后恢复的数据与原始数据相对误差小于9%的topNfeat
topNfeat = 0
Re_err = 0 
for i in range(999):
    lowDMat, reconMat = pca.pca(dataMat, i)
    Err = np.linalg.norm(dataMat - reconMat) / np.linalg.norm(dataMat)
    if Err < 0.09:
        topNfeat = i
        Re_err = Err
        break
    
print('降维后恢复的数据与原始数据相对误差小于9%的topNfeat为:',topNfeat)
print('此时相对误差为：%0.5f%%' % (Re_err*100) )

