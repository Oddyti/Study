# 第四章 IIR数字滤波器设计和实现

## 滤波器概述

### 滤波器的性能指标

### IIR滤波器的设计方法

**模拟原型法**

根据性能指标通过巴特沃斯或切比雪夫逼近得到频率幅度函数$|H(j\Omega)|$，再通过频率响应和传输函数的关系得到模拟低通滤波器传输函数$H_1(s)$，然后通过模拟频率变换法/数字频率变换法得到所要求的数字低通、高通、带通或带阻滤波器的传输函数$H_d(z)$，从而得到IIR滤波器。

## 模拟滤波器设计

### 理想滤波器及其频率响应

#### 理想滤波器

理想低通滤波器：可以无失真传播信号，存在时延$t_d$
$$
y(t) = Ax(t-t_d)
$$
得到频率响应
$$
\begin{aligned}
&H(\mathrm{j} \Omega)=\frac{Y(\mathrm{j} \Omega)}{X(\mathrm{j} \Omega)}=\frac{A \mathrm{e}^{-\mathrm{i} \Omega t_{\mathrm{d}}} X(\mathrm{j} \Omega)}{X(\mathrm{j} \Omega)}=A \mathrm{e}^{-\mathrm{i} \Omega_{\mathrm{d}}} \\
&|H(\mathrm{j} \Omega)|= \begin{cases}A & \text { 通带 } \\
0 & \text { 阻带 }\end{cases} \\
&\arg [H(\mathrm{j} \Omega)]=-\Omega t_{\mathrm{d}}
\end{aligned}
$$

#### 通过频率响应$H(j\Omega)$求传输函数$H(s)$

**重要性质：**
$$
|H(j \Omega)|^{2}=H(j \Omega) H^{*}(j \Omega) \xlongequal{实函数}H(j \Omega) H(-j \Omega)=\left.H(s) H(-s)\right|_{s=j \Omega} 
$$
**过程：**
$$
\begin{aligned}
H(j\Omega) \stackrel{重要性质}{\longrightarrow}H(s)H(-s)\stackrel{零极点分配}{\longrightarrow}H(s)
\end{aligned}
$$
**零极点分配的原则：**

左半平面的极点，任意一半（通常为左半平面）的零点（成共轭对）分配给$H(s)$得到
$$
H(s)=K_{0} \frac{\left(s-z_{0}\right)\left(s-z_{1}\right) \cdots\left(s-z_{m}\right)}{\left(s-p_{0}\right)\left(s-p_{1}\right) \cdots\left(s-p_{n}\right)}
$$
同时根据$\left.H(\mathrm{j} \Omega)\right|_{\Omega=0}=\left.H(s)\right|_{s=0}$确定$K_0$

### 巴特沃斯滤波器

**幅度平方函数：**
$$
|H(\mathrm{j} \Omega)|^{2}=\frac{1}{1+\left(\Omega / \Omega_{\mathrm{c}}\right)^{2 N}}
$$


**给定指标要求：**$(\Omega_p, \, A_p), \, (\Omega_s, \, A_s)$

**求N：**
$$
\begin{aligned}
&\left(\frac{\Omega_{p}}{\Omega_{c}}\right)^{2 N}=10^{0.1 A_{p}}-1 \\
&\left(\frac{\Omega_{s}}{\Omega_{c}}\right)^{2 N}=10^{0.1 A_{s}}-1
\end{aligned}
$$

$$
\left(\frac{\Omega_{s}}{\Omega_{p}}\right)^{2 N}=\frac{10^{0.1 A_{s}}-1}{10^{0.1 A_{p}}-1}
$$

$$
N \geq \frac{\lg \frac{10^{0.1 A_{s}}-1}{10^{0.1 A_{p}}-1}}{2 \lg \left(\frac{\Omega_{s}}{\Omega_{p}}\right)}
$$

取整数得到N

**求$\Omega_c$：**

若由$\Omega_{c}=\frac{\Omega_{p}}{\sqrt[2 N]{10^{0.1 A_{p}-1}}}$确定，则阻带满足，通带可能不满足。
若由$\Omega_{c}=\frac{\Omega_{s}}{\sqrt[2 N]{10^{0.1 A_{s}-1}}}$确定，则通带满足，阻带可能不满足。

**求传输函数$H(s)$：**
$$
|H(\mathrm{j} \Omega)|^{2}=\frac{1}{1+\left(\Omega / \Omega_{\mathrm{c}}\right)^{2 N}}
$$

令$\Omega = \frac{s}{j} (\Omega^2 = -s^2)$，得
$$
H(s) H(-s)=\frac{1}{1+\left(\frac{s}{j \Omega_{c}}\right)^{2 N}}
$$
**零极点分配：**
$$
s_{k}=j \Omega_{c}(-1)^{\frac{1}{2 N}}=\Omega_{c} e^{j\left(\frac{1}{2}+\frac{2 k-1}{2 N}\right) \pi} \quad k=1,2, \cdots, N
$$
归一化，令$p = \frac{s}{\Omega_c}$
$$
p_{k}=\frac{s_{k}}{\Omega_{c}}=e^{j\left(\frac{1}{2}+\frac{2 k-1}{2 N}\right) \pi} \quad k=1, \cdots, N
$$
**得到$H(s)$**

得到，分母多项式也可以通过查表得到
$$
H(p)=\frac{1}{\prod_{k=1}^{N}\left(p-p_{k}\right)}
$$
从而得到
$$
H(s) = H(p)|_{p = \frac{s}{\Omega_c}} = \frac{\Omega_c^N}{\prod^{N}_{k = 1}(s-s_k)}
$$

### 切比雪夫滤波器

**幅度平方函数：**
$$
|H(j\Omega)|^2 = \frac{1}{1+\varepsilon^2C^2_N(\Omega/\Omega_p)}\\
C_{N}(x)=\left\{\begin{array}{lc}
\cos [N \arccos x] & 0 \leqslant x \leqslant 1 \\
\cosh [N \operatorname{arcosh} x] & x>1
\end{array}\right.
$$
其中$\varepsilon$	为波动参数，越小，（通带）幅度波动越小。

**给定指标要求：**$(\Omega_p, \, A_p), \, (\Omega_s, \, A_s)$

**求 $\varepsilon$ 和 $N$**
$$
\varepsilon=\sqrt{10^{0.1 A_{\mathrm{p}}}-1} \quad N \geq \frac{\operatorname{ch}^{-1}\left(\frac{\sqrt{10^{0.1 A_{s}-1}}}{\sqrt{10^{0.1 A_{p}}-1}}\right)}{\operatorname{ch}^{-1}\left(\frac{\Omega_{s}}{\Omega_{p}}\right)}
$$
**求幅度平方函数**

$$
|H(\mathrm{j} \Omega)|^{2}=\frac{1}{1+\varepsilon^{2} C_{N}^{2}\left(\frac{\Omega}{\Omega_{\mathrm{p}}}\right)}
$$
**求传输函数**
$$
H(s) H(-s)=\left.|H(\mathrm{j} \Omega)|^{2}\right|_{\Omega=\frac{s}{\mathrm{j}}}=\frac{1}{1+\varepsilon^{2} C_{N}^{2}\left(\frac{s}{\mathrm{j} \Omega_{\mathrm{p}}}\right)}
$$
**零极点分配**

归一化，令$p = \frac{s}{\Omega_c}$
$$
p_{k}=\frac{s_{k}}{\Omega_{p}} \quad k=1, \cdots, N
$$
**得到$H(s)$**

查表得到$H(p)$
$$
H(p)=\frac{1}{\epsilon \cdot 2^{N-1} \prod_{k=1}^{N}\left(p-p_{k}\right)} 
$$
从而得到$H(s)$
$$
H(s)=\left.H(p)\right|_{p=\frac{s_{k}}{\Omega_{p}}}=\frac{1}{\epsilon \cdot 2^{N-1} \prod_{k=1}^{N}\left(\frac{s}{\Omega_{p}}-p_{k}\right)}=\frac{\Omega_{p}^{N}}{\epsilon \cdot 2^{N-1} \prod_{k=1}^{N}\left(s-p_{k} \Omega_{p}\right)}
$$

### 模拟滤波器的频率变换

如何求得低通滤波器后得到其他通

## 冲激响应不变法

已知模拟滤波器传输函数$H(s)$，如何得到数字滤波器传输函数$H(z)$

### 冲激响应不变法步骤（通过模拟滤波器设计数字滤波器的步骤）

**给定的数字滤波指标：**$\omega_p, \, A_p, \, \omega_s, \, A_s$

1. 确定取样间隔 $T$ ，计算模拟滤波器指标$\Omega_p, \, \Omega_s$

$$
T<\frac{2 \pi}{\Omega_{m}} \quad \Omega_{\mathrm{p}}=\frac{\omega_{\mathrm{p}}}{T} \quad \Omega_{\mathrm{s}}=\frac{\omega_{\mathrm{s}}}{T}
$$
2. 根据模拟滤波器指标 $\Omega_{\mathrm{p}} 、 \Omega_{\mathrm{s}} 、 A_{\mathrm{p}} 、 A_{\mathrm{s}}$设计模拟低通滤波器 $H_{\mathrm{a}}(s)$ ( 巴特沃斯 切比雪夫等 )
3. 部分分式展开 $H_{\mathrm{a}}(s)$

$$
H_{\mathrm{a}}(s)=\sum_{i=1}^{N} \frac{A_{i}}{s-s_{i}}
$$
4. 得到数字滤波器传输函数 $H(z)$

$$
H(z)=T \sum_{i=1}^{N} \frac{A_{i}}{1-\mathrm{e}^{s_{i} T} z^{-1}}
$$

### 冲激响应不变法的缺点

可能会出现混叠失真，适合用来设计**低通、带通**滤波器，不适合**高通、带阻**滤波器。

## 双线性变换法

### 双线性变换法设计步骤

**数字滤波器技术指标 $\omega_{p}, \omega_{s}, A_{p}, A_{s}$ **

1. 确定数字滤波器技术指标 $\omega_{p}, \omega_{s}, A_{p}, A_{s}$ ( 弧度表示) 或 $f_{p}, f_{s}, A_{p}, A_{s}$ ( $\mathrm{Hz}$ 表示 ) 如果是 $\mathrm{Hz}$ 表示的指标，转换为弧度表示的 $\omega_{p}, \omega_{s}(\omega=2 \pi f T)$
2. 计算预畸变模拟滤波器指标 $\Omega_{s}, \Omega_{p}$
   预畸变公式: $\Omega=\frac{2}{T} \tan \frac{\omega}{2}$
3. 根据模拟滤波器指标 $\Omega_{s}, \Omega_{p}, A_{s}, A_{p}$ ，设计模拟低通原型，得到传输函数 $H_{a}(s)$
4. 利用双线性变换，得到数字滤波器传输函数
   $H(z)=\left.H_{a}(s)\right|_{s=\frac{2}{T} \frac{1-z^{-1}}{1+z^{-1}}}$

### 冲激响应不变法和双线性变换法的优缺点

见ppt

## 高通、带通、带阻IIR数字滤波器的设计



## IIR数字滤波器的实现结构

### 数字系统的基本单元

### 直接型

### 级联型

### 并联型
