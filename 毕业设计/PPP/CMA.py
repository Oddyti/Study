import numpy as np
import math
'''
CMA常模盲均衡算法

'''
class CMA():
    
    #下面的两个参数是滤波器的抽头个数和迭代的次数
    def __init__(self,N,K):
        self.N=N
        self.K=K
    def cma(self,u_in,E_0,V_bias,V_pi,landa):
        y=[]
        e=[]
        
        u_in=u_in.reshape(1,-1)

        s1=pow(E_0,4)*np.cos(math.pi*((-3+V_bias)/2/V_pi))
        
        s2=pow(E_0,4)*np.cos(math.pi*((-1+V_bias)/2/V_pi))
        
        s3=pow(E_0,4)*np.cos(math.pi*((1+V_bias)/2/V_pi))
        
        s4=pow(E_0,4)*np.cos(math.pi*((3+V_bias)/2/V_pi))
        
        #Rr和Ri分别对应同相和正交的模值
        Rr=Ri=(pow(s1,4)+pow(s2,4)+pow(s3,4)+pow(s4,4))/(pow(s1,2)+pow(s2,2)+pow(s3,2)+pow(s4,2))
        
        w=np.zeros((1,self.N))
        w[0][25]=1
        m=0
        for j in range(self.K-self.N):
            filter_in=u_in[0][j:j+self.N]
            y.append(np.sum(w[0][:]*filter_in))
            e.append(y[m]*(math.pow(abs(y[m]),2)-Rr))
            w=w-landa*e[m]*filter_in
            m=m+1
        
        return y