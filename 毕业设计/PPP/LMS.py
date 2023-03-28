import numpy as np
import math
'''
LMS算法

相关参数:滤波器的阶数N,迭代的次数K,先取50和1000吧
'''
class LMS():
    
    #下面两个参数是滤波器的抽头个数和迭代的次数
    def __init__(self,N,K):
        
        self.N=N
        
        self.K=K
    
    def lms(self,u_in,u_d):
        
        #u_in为输入信号，是非理想的
        #u_d为理想信号
        
        u_in=np.asarray(u_in)
        
        u_in=u_in.reshape(1,-1)
        
        u_inT=u_in.T                  #向量转置
        
        u_dot=np.dot(u_inT,u_in)      #自相关矩阵
        
        #tao,v=np.linalg.eig(u_dot)    #计算特征向量
        
        landa=1e15            #权重改变步长因子
        
        w=np.vstack([np.ones((1,self.K+1)),np.zeros((self.N-1,self.K+1))])   #滤波器的系数，每一列对应每一次迭代
        
        e=np.zeros((1,self.K))          #误差

        u_n=np.hstack([u_in,np.zeros((1,self.N-1))])                       #水平拼接N-1个零，防止下标越界

        #迭代过程如下
        for i in range(self.K):
            
            U=u_n[0][i:i+self.N]
            
            y_n=np.sum(w[:,i]*U)           #滤波器的输出信号
            
            e=u_d[i]-y_n
            
            w[:,i+1]=w[:,i]+landa*np.conj(U)*e #权重更新
        
        return w[:,self.K].reshape(1,self.N)
    
    def clu(self,w,u_test):
        
        u_test=np.asarray(u_test)
        
        u_test=u_test.reshape(1,-1)
        
        M=w.shape[1]
        
        u_t=np.hstack([u_test,np.zeros((1,M))])  #拓展测试信号，防止下标越界
        
        y_t=[]
        
        for i in range((u_test.shape[1])):
            
            y_t.append(np.sum(w*u_t[0][i:M+i]))
        
        return y_t
