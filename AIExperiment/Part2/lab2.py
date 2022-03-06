import numpy as np
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt

m = 100
X = 6 * np.random.rand(m, 1) - 3
y = 0.5 * X**2 + X + 2 + np.random.randn(m, 1)
poly_features = PolynomialFeatures(degree = 2, include_bias= False)
X_poly = poly_features.fit_transform(X)
X_train, X_test, Y_train, Y_test = train_test_split(X_poly, y, train_size=.80, random_state=1)
model = LinearRegression().fit(X_train, Y_train)
Y_pred = model.predict(X_poly)
b = model.intercept_
a = model.coef_
a = a.flatten()
x_test_range = np.arange(-3, 3, 0.01)
y2 = a[1] * x_test_range**2 + a[0] * x_test_range + b
plt.scatter(X, y, label = 'Original')
plt.plot(x_test_range, y2, color = 'red', label = 'Predict')
plt.legend()
plt.savefig('figure2.png', dpi = 300)
plt.show

