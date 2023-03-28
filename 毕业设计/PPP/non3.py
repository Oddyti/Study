import numpy as np
import math
import random
import matplotlib.pyplot as plt
# import tensorflow as tf
from KNN import KNN
from LMS import LMS
from MMA import MMA
from MMA2 import MMA2
from CMA import CMA
# from SVM import SVM
# from LSTM import LSTM
from MZM import MZM
from UTC_PD import UTC_PD
from LABEL_TR import *
# 画图时能显示中文标题

plt.rcParams['font.sans-serif'] = ['SimHei']

plt.rcParams['axes.unicode_minus'] = False

'''
下面这一部分是对激光器的参数设置
(设置凭感觉，可能有不符合实际的地方，但尽量会按照调研到的来)
包括激光器的波长，时域上的幅度，相位噪声等等
'''

pi = math.pi  # 常数pi

nanda1 = 1550.18e-9  # 激光器1波长

nanda2 = 1547.38e-9  # 激光器2波长

c = 3e8  # 光速

fc1 = c/nanda1  # 激光器1光载频

fc2 = c/nanda2  # 激光器2光载频

delta_v1 = 1e6  # 激光器线宽

delta_v2 = 1.5e6  # 激光器线宽2

t = np.arange(100000)*1e-14  # 构造时间序列

fs = abs(fc1-fc2)  # 两个激光器差频即太赫兹载波频率

E0 = 0.002  # 两个激光器输出的连续光的幅度

P0 = math.pow(E0, 2)/2  # 激光器的输出光功率

phy1t = [0]  # 激光器1相位

phy2t = [0]  # 激光器2相位

for i in range(len(t)-1):
    phy1t.append(phy1t[i])
    phy2t.append(phy2t[i])
    # phy1t.append(phy1t[i]+random.gauss(0,math.sqrt(delta_v1*5e-12)))
    # phy2t.append(phy2t[i]+random.gauss(0,math.sqrt(delta_v2*5e-12)))

E1t = [E0*np.exp(1j*(2*(pi)*fc1*i*1e-15))
       for i in range(len(t))]  # 激光器1的输出连续光波

E2t = [E0*np.exp(1j*(2*(pi)*fc1*i*1e-15))
       for i in range(len(t))]  # 激光器2的输出连续光波

# 画出激光器1产生的载波
'''
plt.figure(1)
plt.plot(t,E1t)
plt.xlim(1e-14,100e-14)
plt.title('激光器1的连续信号')
plt.show()
'''

'''
下面这一部分是对MZM调制器的参数设置
'''
# MZM参数设置
Vpi = 3.5  # 半波电压

Vbias = 3.5  # 偏置电压

fd = 2e6  # 驱动电压频率

T_last = 20  # 码元的宽度，每个码元20个采样值

V_or = np.ceil(np.random.rand(2, 5000)-0.5)  # 这里产生随机0，1信号

V_tr = V_or.reshape(1, 10000)

'''
系统采用16QAM调制的方法,于是要将信号的两个比特编码成四个电平，并且每个码元有两个电平(包含同向的和正交的)
'''
# 编码成-3，-1，1，3电平
length = V_or.shape[1]

V_data = []

for i in range(length):

    if V_or[0][i]*2+V_or[1][i] == 0:

        V_data.append(-3)

    if V_or[0][i]*2+V_or[1][i] == 1:

        V_data.append(-1)

    if V_or[0][i]*2+V_or[1][i] == 2:

        V_data.append(1)

    if V_or[0][i]*2+V_or[1][i] == 3:

        V_data.append(3)

V_data = np.asarray(V_data)

V_dataori = V_data.reshape(2, 2500)

# V_data=V_d*np.sin(2*math.pi*fd*t)
'''
plt.figure(2)
for j in range(V_dataori.shape[1]):
    a=V_dataori[0][j]
    b=V_dataori[1][j]
    complexSpot=complex(a,b)
    plt.scatter(a,b,c='pink')
plt.title('驱动信号')
plt.show()
'''

[Eout, Iout] = MZM(E1t, V_data, Vpi, Vbias, T_last)  # 调用函数输出MZM的结果

# 画出MZM调制后的信号结果图
plt.figure(3)
plt.plot(t, Eout)
plt.xlim(1e-14, 500e-14)
plt.title('MZM输出的调制后信号')
plt.show()


'''
下面是调制后的信号进入UTC-PD后产生Thz信号的部分,其中会引入PD的量子噪声和热噪声
'''

R = 0.5  # UTC_PD的响应度(单独放在这里好丑陋)

[EThz, IThz] = UTC_PD(Eout, Iout, E2t, fc1, fc2, 0, 0, t, R)  # 调用UTC-PD函数

# 画出产生太赫兹载波后的信号图
'''
plt.figure(4)
plt.plot(t,EThz)
plt.xlim(1e-14,5000e-14)
plt.title('无噪声太赫兹波')
plt.show()
'''

# 引入UTC_PD的噪声
Ip = R*pow(E0, 2)*pow(E0, 2)  # 信号产生的平均光电流

q = 1.6e-19  # 电荷常量

h = 6.63e-34  # 普朗克常量

B = 1e9  # 带宽

Kb = 1.38e-23  # 玻尔兹曼常量

T = 300  # 温度23摄氏度

RL = 50  # 负载50欧姆

Fn = 1  # 噪声系数

# 计算出噪声功率
n_s = 2*q*Ip*B  # 量子噪声功率

n_k = 4*Kb*T*Fn*B/RL  # 热噪声功率

SNR = (sum(pow(np.abs(EThz), 2))/len(EThz)/(n_s+n_k))  # 信噪比

noise = np.random.randn(len(EThz))*np.sqrt(n_s+n_k)  # 构造高斯噪声

EThz_n = EThz+noise  # 带噪声的信号

# 画出从UTC_PD出来后的信号
'''
plt.figure(5)
plt.plot(t,EThz_n)
plt.xlim(1e-14,5000e-14)
plt.title('含噪声的太赫兹波')
plt.show()
'''

'''
下面进入混频器进行两次下变频从而得到基带的信号,其中混频器会有各种谐波混进去,不能一一写出来
带外谐波可以通过滤波后去除,而带内谐波不可以,此处只考虑镜像信号,幅度自行假设
'''
# 进入混频器进行下变频
fLO = 12e9  # 本振信号频率

phyLO = 0  # 本振信号初相位

ELO = [E0*np.exp(1j*(2*(pi)*fLO*t[i]+phyLO)) for i in range(len(t))]

G = 24  # 倍频

fLO_G = fLO*G  # 倍频后的频率

ELO_G = [E0*np.exp(1j*(2*(pi)*fLO_G*t[i]+phyLO))
         for i in range(len(t))]  # 倍频后的信号

f_IF = abs(fc1-fc2)-fLO_G  # 产生信号的中频

E_mi = [0.00002*E0*np.exp(1j*(2*(pi)*(fLO_G-f_IF)*t[i]+phyLO))
        for i in range(len(t))]  # 镜像信号产生干扰

# 第一次变频后的信号为
EIFt = [((IThz[i]+noise[i])*E0)*np.cos(2*math.pi*f_IF*t[i])
        for i in range(len(t))]

# 画出第一次下变频后的时域信号
'''
plt.figure(6)
plt.plot(t,EIFt)
plt.xlim(1e-14,5000e-14)
plt.title('第一次下变频后的输出信号')
plt.show()
'''

# 第二次下变频
# E_mi2 = [0.00001*E0*np.exp(1j*(2*(pi)*(f_IF)*t[i]+phyLO))
#          for i in range(len(t))]  # 第二次下变频的镜像信号

E_LAST = [(((IThz[i]+noise[i])*E0)*E0)*np.exp(1j*0) for i in range(len(t))]

E_LAST = np.asarray(E_LAST)
E_LAST = E_LAST.reshape(2, -1)
E_last = np.zeros((2, 50000))
for i in range(50000):
    E_last[0][i] = E_LAST[0][i] * \
        np.cos(phy1t[i]-phy2t[i])+E_LAST[1][i]*np.sin(phy1t[i]-phy2t[i])
    E_last[1][i] = E_LAST[1][i] * \
        np.cos(phy1t[i]-phy2t[i])-E_LAST[0][i]*np.sin(phy1t[i]-phy2t[i])

E_last = E_last.reshape(1, -1)
# 画出最终的基带信号
E_last = E_last


# 考虑到相位的旋转
E_last = E_last.reshape(2, -1)
E_QAM_1 = [E_last[0][20*(i)+10] for i in range(2500)]
E_QAM_2 = [E_last[1][20*(i)+10] for i in range(2500)]
E_QAM_3 = E_LAST[0][0:2500]
E_QAM_4 = E_LAST[1][0:2500]

plt.figure(7)
plt.plot(t[0:2500], E_QAM_1)
plt.xlim(1e-14, 200e-14)
plt.title('第二次下变频后的输出解调信号')
# plt.show()


plt.figure(8)
for j in range(2500):
    a = E_QAM_1[j]*13.5e10
    b = E_QAM_2[j]*13.5e10
    complexSpot = complex(a, b)
    plt.scatter(a, b, c='pink')
plt.title('接收信号星座')
plt.show()


E_LAST = E_last.reshape(1, -1)  # E_LAST类型为一个array，是二维的

'''
#未进行信道均衡的星座图
E_QAM=[E_LAST[20*(i)+10] for i in range(len(V_data))]
E_QAM=np.asarray(E_QAM)
E_QAM=E_QAM.reshape(2,2500)

#E_XINGZUO=[]
#for i in range(E_QAM.shape[1]):
#    E_XINGZUO.append((E_QAM[0][i]*2+E_QAM[1][i])*2-3)
#E_XINGZUO=np.asarray(E_XINGZUO)
#E_XINGZUO=E_XINGZUO.reshape(2,2500)

plt.figure(8)
for j in range(E_QAM.shape[1]):
    a=E_QAM[0][j]
    b=E_QAM[1][j]
    complexSpot=complex(a,b)
    plt.scatter(a,b,c='pink')
plt.title('接收信号星座')
plt.show()
'''

'''
下面要进行信道均衡,其中V_data是我们发送的-3,-1,1,3信号,这里重复20倍是因为我们假设一个码元有20个采样点
下面将时间序列的100000个采样点对半分开,一半用来训练,一半用来测试,当然大部分情况下不会全用上
'''

V_real = label_real = V_data.repeat(20)  # 真实实例标签

V_tran = E_LAST[0][0:50000]  # 训练集

V_test = E_LAST[0][50000:95000]  # 测试集

label_tran = label_real[0:50000]  # 训练集标签

label_test = label_real[50000:95000]  # 测试集标签

a = 1
# 调用KNN进行信道均衡
'''
print('正在进行KNN信道均衡计算中,稍后可见误码率')

print('--------------------------------------')

KNN=KNN()                       #调用写好的KNN

test_label=[]                   #这里的标签list用来保存我们通过KNN投票出来的标签，下面用来与实际标签比较计算误码率

for sample in V_test:
    
    test_label.append(KNN.vote(sample,V_tran,label_tran))

#计算误码率
ber=np.sum(test_label!=label_test)/len(label_test)

print("KNN信道均衡后误码率为{}".format(ber))
print("如果感觉不对请检查数据结构是不是list和array搞错了,array是二维的")
'''

# 这一步是LMS信道均衡的运用
'''
print('正在进行LMS信道均衡计算中,稍后可见星座图')
print("如果感觉不对请检查数据结构是不是list和array搞错了,array是二维的")
print('--------------------------------------')

label_tran_lms=label_real[0:10000]      #从标签训练集里取出前10000个点

label_LMS=(np.asarray([pow(E0,4)*np.cos(pi*((label_tran[i]+Vbias)/2/Vpi)) for i in range(len(label_tran_lms))]))                    #这里需要将标签的四电平信号转换成理想接收到基带信号，使之幅度与实际接收到的相匹配

V_tran_LMS=(V_tran[0:10000])          #从数据训练集中取前1000个点

V_test_LMS=(V_test[0:10000])       #从数据测试集中取前1000个点

LMS=LMS(100,1000)                      #构造出有100个抽头的横向滤波器,迭代1000次

w_lms=LMS.lms(V_tran_LMS,label_LMS)        #算出训练好的50阶滤波器权重

v_lms_out=LMS.clu(w_lms,V_test_LMS)            #算出均衡后的信号值

v_lms_out=np.asarray(v_lms_out)

v_lms_out=v_lms_out.reshape(2,-1)

#画出LMS信道均衡后的星座点
plt.figure(9)
for j in range(v_lms_out.shape[1]):
    a=v_lms_out[0][j]*3e10
    b=v_lms_out[1][j]*3e10
    complexSpot=complex(a,b)
    plt.scatter(a,b,c='pink')
plt.title('LMS信道均衡后信号星座')
plt.show()
'''

'''#下面是基于支持向量机进行信道均衡
SVM=SVM()

label_tran_SVM=V_data[0:2500]

#label_tran_SVM=[pow(E0,4)*np.cos(pi*((label_tran_SVM[i]+Vbias)/2/Vpi)) for i in range(len(label_tran_SVM))]

label_test_SVM=V_data[2500:4750]

#label_test_SVM=[pow(E0,4)*np.cos(pi*((label_test_SVM[i]+Vbias)/2/Vpi)) for i in range(len(label_test_SVM))]

V_tran_svm=[V_tran[i]*1e8 for i in range(len(V_tran))]

V_test_svm=[V_test[i]*1e8 for i in range(len(V_test))]

[lable_tr_svm,samples_tr_svm]=SVM.transform(label_tran_SVM,V_tran_svm,T_last)      #数据转换为模型可读的

[lable_te_svm,samples_te_svm]=SVM.transform(label_test_SVM,V_test_svm,T_last)      

model=SVM.SVM_train(lable_tr_svm,samples_tr_svm)                    #训练模型

[label_r,ac_r,value_r]=SVM.SVM_predict(lable_te_svm,samples_te_svm,model)   #测试

value_r=np.asarray(value_r)

v_last=value_r.reshape(2,-1)

plt.figure(10)
for j in range(v_last.shape[1]):
    a=v_last[0][j]
    b=v_last[1][j]
    complexSpot=complex(a,b)
    plt.scatter(a,b,c='pink')
plt.title('SVM信道均衡后信号星座')
plt.show()
'''


# 下面是基于CMA算法的信道均衡
'''
print('正在进行CMA信道均衡计算中,稍后可见星座图')

print('--------------------------------------')
V_CMA=np.vstack([np.asarray(E_QAM_1),np.asarray(E_QAM_2)])

CMA=CMA(50,5000)

y_cam=CMA.cma(V_CMA,E0,Vbias,Vpi,1e35)

y_cam=np.asarray(y_cam).reshape(2,-1)
#画出cma算法均衡后的星座图
plt.figure(11)
for j in range(y_cam.shape[1]):
    a=y_cam[0][j]
    b=y_cam[1][j]
    complexSpot=complex(a,b)
    plt.scatter(a,b,c='pink')
plt.title('CMA信道均衡后信号星座,此时步长为100000*1e-{}'.format(i))
plt.show()
'''

'''
#下面是基于MMA算法的信道均衡
print('正在进行MMA信道均衡计算中,稍后可见星座图')

print('--------------------------------------')

#V_MMA=E_LAST[0][0:5000]            #均衡器接收到的信号

V_MMA=np.vstack([np.asarray(E_QAM_1),np.asarray(E_QAM_2)])

MMA=MMA(50,2500)

for i in range(12):
    [w_mma,y_mma]=MMA.mma(V_MMA,E0,Vbias,Vpi,(1.0+0j)*pow(10,-i+35))

    V_MMA=np.asarray(V_MMA)

    V_MMA=V_MMA.reshape(2,-1)

    V_MMA_r=V_MMA[0,:]               #接收信号的同向分量

    V_MMA_i=V_MMA[1,:]               #接收信号的正交分量

    V_MMA=V_MMA_r+1j*V_MMA_i   #接收到的信号

    v_mma_out=MMA.clu(w_mma,V_MMA)

    v_mma_r=np.real(v_mma_out)

    v_mma_i=np.imag(v_mma_out)

    #画出mma算法均衡后的星座图
    plt.figure(11)
    for j in range(len(y_mma)):
        a=np.real(y_mma)[j]*3e10
        b=np.imag(y_mma)[j]*3e10
        complexSpot=complex(a,b)
        plt.scatter(a,b,c='pink')
    plt.title('MMA信道均衡后信号星座')
    plt.show()
    
    V_MMA=E_LAST[0][0:5000]
'''

'''
#下面使用LSTM网络进行分类或均衡，调用GPU

#设置GPU为按需求占用内存
gpus=tf.config.list_physical_devices(device_type='GPU')

for gpu in gpus:
    
    tf.config.experimental.set_memory_growth(device=gpu,enable=True)

#LSTM用的训练集和测试集数据
label_tran_lstm=label_real[0:20000]               #训练集的标签，这里标签设置为真实的基带数据，且20个采样点为一组数据，一个标签
label_tran_lstm_both=V_data[0:1000]               #双向lstm的标签

#label_tran_lstm=[pow(E0,4)*np.cos(pi*((label_tran_lstm[i]+Vbias)/2/Vpi)) for i in range(len(label_tran_lstm))]                #训练集转化后的标签

V_tran_LSTM=V_tran[0:20000]                 #训练集的数据

V_test_LSTM=V_test[0:20000]                 #测试集的数据

label_test_lstm=label_real[50000:70000]           #测试集的标签

label_test_lstm_both=label_real[2500:3500]               #双向lstm的标签

#label_test_lstm=[pow(E0,4)*np.cos(pi*((label_test_lstm[i]+Vbias)/2/Vpi)) for i in range(len(label_test_lstm))]                #测试集转化后的标签
#构建LSTM网络模型

BATCH_START=0   #batch data的初始index

TIME_STEPS=20  #时间步长

BATCH_SIZE=int(len(V_tran_LSTM)/TIME_STEPS) #时间序列的组数


#训练集的标签:
#训练集单向网络
label_tran_lstm=trans_lable_one(label_tran_lstm,BATCH_SIZE,TIME_STEPS,dim_out=4)

#训练集双向网络
label_tran_lstm_both=trans_lable_both(label_tran_lstm_both,BATCH_SIZE,dim_out=4)

#测试集的标签:
#测试集单向
label_test_lstm=trans_lable_one(label_test_lstm,BATCH_SIZE,TIME_STEPS,dim_out=4)

#测试集双向
label_test_lstm_both=trans_lable_both(label_test_lstm_both,BATCH_SIZE,dim_out=4)


#训练集的数据
V_tran_LSTM=value_one(V_tran_LSTM,BATCH_SIZE,TIME_STEPS,dim_features=1)

#测试集的数据
V_test_LSTM=value_one(V_test_LSTM,BATCH_SIZE,TIME_STEPS,dim_features=1)


LSTM_one=LSTM(20,4,0.2)
LSTM_both=LSTM(1,4,0.3)

model_one=LSTM_one.get_model_one()                  #得到模型

model_both=LSTM_both.get_model_both()


#单向LSTM运用
history_one=model_one.fit(np.real((V_tran_LSTM*1e10)),np.real(label_tran_lstm),epochs=50,batch_size=100,validation_data=(np.real((V_test_LSTM*1e10)), np.real(label_test_lstm)),verbose=1)

print("单向lstm的网络信息")
print("--------------------")
model_one.summary()

#单向lstm准确率
train_acc=history_one.history['accuracy']
val_acc=history_one.history['val_accuracy']
#损失
train_loss=history_one.history['loss']
val_loss=history_one.history['val_loss']

plt.plot(train_acc)
plt.plot(val_acc)
plt.title('model accuracy')
plt.xlabel('epoch')
plt.ylabel('accuracy')
plt.legend(['acc', 'val_acc'], loc='lower right')
plt.show()

plt.plot(train_loss)
plt.plot(val_loss)
plt.title('model loss')
plt.xlabel('epoch')
plt.ylabel('loss')
plt.legend(['train loss', 'val loss'], loc='lower right')
plt.show()



#双向LSTM运用
history_both=model_both.fit(np.real((V_tran_LSTM*1e10)),np.real(label_tran_lstm_both),epochs=50,batch_size=100,validation_data=(np.real((V_test_LSTM*1e10)), np.real(label_test_lstm_both)),verbose=1)

print("双向lstm的网络信息")
print("--------------------")
model_both.summary()

#双向lstm准确率
train_acc_both=history_both.history['accuracy']
val_acc_both=history_both.history['val_accuracy']

#损失
train_loss_both=history_both.history['loss']
val_loss_both=history_both.history['val_loss']

plt.plot(train_acc_both)
plt.plot(val_acc_both)
plt.title('双向model accuracy')
plt.xlabel('epoch')
plt.ylabel('accuracy')
plt.legend(['acc', 'val_acc'], loc='lower right')
plt.show()

plt.plot(train_loss_both)
plt.plot(val_loss_both)
plt.title('双向model loss')
plt.xlabel('epoch')
plt.ylabel('loss')
plt.legend(['train loss', 'val loss'], loc='lower right')
plt.show()
'''
