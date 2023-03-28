import re
import numpy as np
import math
class KNN():
    '''
    K近邻算法

    参数:k的值,即最近邻的个数,此处设置为10
    '''
    def __init__(self,k=11):
        
        self.k=k

    #计算样本与训练集所有样本距离的函数
    def distance(self,sample,V_train):
        
        distances=np.tile(sample,len(V_train))-V_train
        
        return distances
    
    #获取k个近邻的标签
    def get_label(self,distances,label_train):
        
        dis=np.sort(np.abs(distances))[:self.k]      #找出最小的k个距离            
        
        labels=[]                            #存放跟他距离最近的k个实例的label
        
        for distance in dis:
            
            index=np.where(np.abs(distances)==distance)
            
            labels.append(label_train[index])
        
        return np.asarray(labels)
    
    #进行投票，票数最多的就是对应的类
    def vote(self,sample,V_train,label_train):
        
        distances=self.distance(sample,V_train)
        
        labels=self.get_label(distances,label_train)
        
        count_3=0
        
        count_1=0
        
        count3=0
        
        count1=0
        
        for label in labels:
            if label==1:
                count1=count1+1
            if label==-1:
                count_1=count_1+1
            if label==3:
                count3=count3+1
            if label==-3:
                count_3=count_3+1
        
        count=[count_3,count_1,count1,count3]    
        
        count_mx=np.max(count)
        
        max_count=np.where(count==count_mx)
        
        return max_count[0][0]*2-3