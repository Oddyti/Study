import numpy as np
import matplotlib.pyplot as plt

x1 = np.random.random((30, 2))*3 + 10
x2 = np.random.random((30, 2))*3 + 15
N1 = 30
u1 = np.mean(x1, axis=0)
u1 = np.mat(u1)
u2 = np.mean(x2, axis=0)
u2 = np.mat(u2)
cov1 = np.cov(x1[:, 0], x1[:, 1])
cov2 = np.cov(x2[:, 0], x2[:, 1])
S_w = cov1 + cov2
S_b = (u1-u2).T*(u1-u2)
S_w = np.mat(S_w)
w = S_w.I*(u1 - u2).T
k = w[1]/w[0]
plt.figure()
plt.scatter(x1[:, 0], x1[:, 1])
plt.scatter(x2[:, 0], x2[:, 1])
plt.plot([9, 19], [9, 9+10*k], 'k')
plt.savefig('4-3.png', dpi = 300)
plt.show()
