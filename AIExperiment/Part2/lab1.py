import matplotlib.pyplot as plt
import numpy as np

x = 2 * np.random.rand(100, 1)
y = 4 + 3 * x + np.random.randn(100, 1)
x1 = np.c_[np.ones(100 , float) , x]

theta= np.dot(np.dot(np.linalg.inv(np.dot(np.transpose(x1), x1)), np.transpose(x1)), y)

print('%c = [%f, %f]' %(chr(952), theta[0], theta[1]))
y1 = theta[0] + theta[1] * 0
print('x = 0 , y = %f' %(y1))
y2 = theta[0] + theta[1] * 2
print('x = 2 , y = %f' %(y2))
y3 = theta[0] + theta[1] * x 

plt.scatter(x, y, label='original')
plt.plot(x, y3, color='red', label='Predict')
plt.legend()
plt.xlabel('x')
plt.ylabel('y')
plt.savefig('figure1.png', dpi = 300)
plt.show