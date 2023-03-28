#此部分为MZM外调制部分
import numpy as np
import math
import matplotlib.pyplot as plt
cos=math.cos
pi=math.pi
exp=np.exp
def MZM2(E_in_c,E_in_s,V_data,V_pi,V_bias,T):
    #变量说明：
    #E_zai即为输入的载波，这里需要为一个array结构
    #V_data即为需要调制的序列,也是一个嗄array
    #V_pi为此马曾调制器的半波点压
    #V_bias为偏置电压
    #输出需要为一个已经调制好的array
    #T表示码元宽度
    #E_out表示为输出的时域波形
    #I_out表示为输出功率图
    
    s=len(E_in_c)     #获取长度
    
    E_out=[]        #输出信号
    
    I_out=[]        #输出信号功率
    
    for i in range(s):
        
        E_out.append(E_in_c[i]*np.cos(pi*((V_data[0][math.ceil((i+1)/T)-1]+V_bias)/2/V_pi))+E_in_s[i]*np.cos(pi*((V_data[1][math.ceil((i+1)/T)-1]+V_bias)/2/V_pi)))
        
        
    
    return E_out
