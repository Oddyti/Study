# 第6章 数字基带传输

## 6.1 数字基带信号及其频谱特征

### 一、基本基带信号波形

### 二、数字脉冲幅度调制（PAM）信号的功率谱

由于理想方波脉冲**频带无限宽**，需要通过**脉冲成型滤波器**成为**有限带宽**的基带信号。

> 插图

$$
a\{n\} &=& \sum_{n = -\infty}^{\infty} a_n \delta(t-nT) \\
g(t) &\rightarrow & G(f) \\
V(t) &=& \sum_{n = -\infty}^{\infty} a_ng_T(t-nT)
$$

可以得到PAM信号$V(t)$的功率谱为：
$$
S_v(f) = \frac{1}{T}S_a(f) \cdot|G_T(f)|^2
$$
其中$S_a(f)$为随机序列$a\{n\}$的功率谱，$|G_T(f)|^2$是脉冲成型滤波器的功率谱。

**考虑最简单的情况：$a\{n\}$独立同分布序列时：**
$$
S_{V}(f)=\frac{\sigma_{a}^{2}}{T}\left|G_{T}(f)\right|^{2}+\frac{m_{a}^{2}}{T^{2}} \sum_{m=-\infty}^{\infty}\left|G_{T}\left(\frac{m}{T}\right)\right|^{2} \delta\left(f-\frac{m}{T}\right)
$$

> 其中第一项是连续谱，第二项是离散谱线，频率间隔为$\displaystyle \frac{1}{T}$，若选$a\{n\}$的均值为0，则可以消除离散谱线，只剩下连续谱。

## 6.2 常见的数字序列码型

见书

## 6.3 基带信号通过加性高斯噪声（AWGN）信道传输

假设传输噪声干扰为高斯噪声，传输信道带宽无限（即不存在码间干扰）。

### 一、解调和检测

解调：把接收到的波形恢复成发送的基带脉冲

检测：判断确定波形代表的数字含义

本节考虑简化后的二进制基带传输模型，如下图所示

> 插图

接受滤波器进行波形恢复，经过采样后由门限判决得到消息信号。

### 二、信号和噪声的矢量空间表示

掌握如何通过施密特正交化表示信号和噪声。

### 三、基函数相关解调

M个传输信号：$s_k(t) ,\, (k = 1,2,...,M)$，可以构造出N个正交规范基函数：$\{\phi_i(t), i = 1,2,...,N\, (N\le M)\}$

输出信号：$r(t) = s_k(t) + n(t)$

则
$$
正交基函数：\{\varphi_i(t), i = 1,2,...,N\, (N\le M)\} \\
发送信号矢量表示：\boldsymbol{s}_k = (s_{k1},s_{k2},...,s_{kN}) \\
接收信号矢量表示：\boldsymbol{r}_i = (r_{1},r_{2},...,r_{N}) \\
其中：s_{ki} = \int_{0}^{T}s_k(t)\phi_i(t)dt,\, r_{i} = \int_{0}^{T}r(t)\phi_i(t)dt = s_{ki}+n_i
$$
则可以用如下相关器解调：

> 插图

<img src="https://skyline010213.notion.site/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F27ff5b76-4232-46e6-a232-dbf945e1499b%2FUntitled.png?table=block&id=bef3378b-6e00-402b-9fe0-993fab41f33f&spaceId=b86df5a9-ace9-4f1a-8942-46932d78da59&width=2000&userId=&cache=v2" alt="img" style="zoom: 50%;" />



### 四、匹配滤波器

#### 1 定义

若$s(t)$定义在$0\leq t \leq T$上，则其匹配滤波为：
$$
h(t)=\begin{cases} 
	s(T-t) &,\quad 0\leq t \leq T\\
  0&,\quad else \end{cases}
\quad k = 1,2,...,N
$$

#### 2 性质

如果信号收到AWGN信号干扰，则信号通过与s(t)相匹配的滤波器，可获得最大输出信噪比。

#### 3 传递函数$H(f)$

若：
$$
h(t)=\begin{cases} 
	c\cdot s(T-t) &,\quad 0\leq t \leq T\\
  0&,\quad else \end{cases}
$$
则传递函数为：
$$
H(f) = c \cdot S^*(f)e^{-2\pi fT}
$$
其中$S(f)$为$s(t)$的频谱。

#### 4 信号输出

$s(t)$通过匹配滤波器的输出为：
$$
\begin{aligned}
y_s(t) &= s(t) * h(t) \\
			 &=	R_s(t-T)
\end{aligned}
$$

> 注意只有在$t=T$的时候匹配滤波器的输出才和相关器的输出相同。其他时刻不一定相同。

### 五、基函数匹配滤波器解调

> 可以用一组滤波器代替相关器

滤波器脉冲响应为：
$$
h(t)=\begin{cases} 
	\varphi_k(T-t) &,\quad 0\leq t \leq T\\
  0&,\quad else \end{cases}
\quad k = 1,2,...,N
$$
其中$\varphi _k(t)$是N个基函数

所以滤波器输出为：
$$
\begin{aligned}
y_k(t) &= r(t) * h_k(t) \\
			 &= \int_{0}^{t}r(\tau)h_k(t-\tau)d\tau \\
			 &= \int_{0}^{t}r(\tau)\varphi_k(T- t + \tau)d\tau, \, k = 1,2,...,N
\end{aligned}
$$
当$t = T$时，匹配滤波器的输出正好是N个基函数相关器的输出。

### 六、最佳检测判决器

相关解调和匹配滤波都产生一个判决矢量
$$
\mathbf{r} = (r_1, r_2,...,r_N) = \mathbf{s}_m + \mathbf{n}
$$
在信号空间里，$\mathbf{s}_m$视为一点，则$\mathbf{r}$可以表示为$\mathbf{s}_m$上叠加球对称分布的噪声$\mathbf{n}$。噪声奉茶$N_0/2$决定了围绕$\mathbf{s}_m$的噪声云团的密度和大小。

如何设计是的判决概率最大：采用最大后验概率最大。

最终公式：
$$
\arg \max _{m}\left\{\ln p\left(\mathbf{s}_{m}\right)-\frac{1}{N_{0}} \sum_{i = 1}^{N} s_{m i}^{2}+\frac{2}{N_{0}} \sum_{i = 1}^{N} r_{i} s_{m i}\right\} \\ 
= \arg \max _{m}\left\{\ln p\left(\mathbf{s}_{m}\right)-\frac{E_{m}}{N_{0}}+\frac{2}{N_{0}}\left(\boldsymbol{r}, \mathbf{s}_{m}\right)\right\}
$$
由此可以构建基函数相关解调和基函数匹配滤波的最佳检测判决器如下：

<img src="https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F6afbfe26-4eb5-41d6-a87e-2406416be3aa%2FUntitled.png" alt="img" style="zoom:50%;" />



<img src="https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2Fd87bfdb8-5e1f-4ceb-8ea0-2cad083fd053%2FUntitled.png" alt="img" style="zoom:50%;" />

### 七、AWGN上信号检测的错误（误符号）概率计算

见书上例题。

## 6.4 数字基带信号通过带限信道传输

前一节信道为AWGN信道，带宽无限制，相当于只加了一个高斯噪声。此节讨论的是线性带限信道，相当于在加噪声前先通过一个线性滤波器。如下图：

> 插图

信号波形：$g_T(t)$

线性带限信道：$c(t) \rightarrow C(f)$

通过信道输出：$h(t) = c(t)*g_T(t)$



























