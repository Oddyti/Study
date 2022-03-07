
import matplotlib.pyplot as plt
from sklearn.linear_model import LogisticRegression
import numpy as np
from sklearn import datasets

iris = datasets.load_iris()
list(iris.keys())
X = iris["data"][:, 3:]
y = (iris["target"] == 2).astype(int)

model = LogisticRegression(random_state=1, solver='liblinear')
model.fit(X, y)
 
x_test_range = np.linspace(0, 3, 1000).reshape(-1, 1)
y_proba = model.predict_proba(x_test_range)
 
plt.plot(x_test_range, y_proba[:, 1], color = 'red', linewidth=1, label="Iris-Virginica")
plt.plot(x_test_range, y_proba[:, 0], color = 'blue', linewidth=1, label="Not Iris-Virginica")
plt.legend()
plt.savefig('figure3.png', dpi = 300)
plt.show


