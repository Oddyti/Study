import kNN
group, lables = kNN.createDataSet()
print('分类结果')
print('[0, 0] %c' %(kNN.classify0([0, 0], group, lables, k = 3)))
print('[0.8, 0.7] %c' %(kNN.classify0([0.8, 0.7], group, lables, k = 3)))


