from tkinter import BOTH
import numpy as np
import math


def L_TR(label):
    
    #此函数实现功能为将原来的lable数据转换为LSTM分类需要投喂的label数据格式 如 -3 -1 1 3 数据转换成[-3,0,0,0]之类的数据

    label_r=[]
    
    for i in range(len(label)):
        
        if label[i]==-3:
            
            label_r.append([1,0,0,0])
        
        if label[i]==-1:
            
            label_r.append([0,1,0,0])
        
        if label[i]==1:
            
            label_r.append([0,0,1,0])
        
        if label[i]==3:
            
            label_r.append([0,0,0,1])
    
    return label_r

def trans_lable_one(label,BATCH_SIZE,TIME_STEPS,dim_out):

    #此函数为单向LSTM的label数据类型转换函数，将list类型的label转换成LSTM可读的label数据类型

    label_r=L_TR(label)


    label_r=np.asarray(label_r)


    label_r=label_r.reshape(BATCH_SIZE,TIME_STEPS,dim_out)               #训练序列的特征数为1维，输入序列的重构

    label_r=label_r.astype(np.complex128)               #标签类型转化为复数 

    return label_r

def trans_lable_both(label,BATCH_SIZE,dim_out):

    #此函数为双向LSTM的label数据类型转换函数，将list类型的label转换成LSTM可读的label数据类型

    label_r=L_TR(label)


    label_r=np.asarray(label_r)


    label_r=label_r.reshape(BATCH_SIZE,dim_out)               #训练序列的特征数为1维，输入序列的重构

    label_r=label_r.astype(np.complex128)               #标签类型转化为复数

    return label_r

def value_one(value,BATCH_SIZE,TIME_STEPS,dim_features):
    
    #这是输入单向LSTM的数据转换函数

    V_r=np.asarray(value)

    V_r=V_r.reshape(BATCH_SIZE,TIME_STEPS,dim_features)

    return V_r

def value_both(value,BATCH_SIZE,TIME_STEPS,dim_features):
    
    #这是输入双向LSTM的数据转换函数

    V_r=np.asarray(value)

    V_r=V_r.reshape(BATCH_SIZE,TIME_STEPS,dim_features)

    return V_r