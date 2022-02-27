import kNN
group, lables = kNN.createDataSet()
print(kNN.classify0([0, 0], group, lables, k = 3))
print(kNN.classify0([0.8, 0.7], group, lables, k = 3))


