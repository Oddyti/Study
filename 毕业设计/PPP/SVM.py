import numpy as np
import math
from libsvm323.python.svmutil import *
from libsvm323.python.svm import *
'''
SVR回归算法

#需要进行数据转换,每个实际数据的标签即是它的理想值

#采用libsvm323库,需要将数据转换成模型能接收的形式:其中label为数组,而value为字典形式,每个sample只有一个特征
'''
class SVM():
    
    def transform(self,label,samples,T_last):
        
        label_new=label         #存放标签
        
        samples_new=[]          #存放特征values           
        
        samples=np.asarray(samples)
        
        samples=samples.reshape(-1,T_last)
        
        for i in range(samples.shape[0]):
            
            sample_one={}       #存放一个sample的特征，采用字典
            
            for j in range(samples.shape[1]):
                
                sample_one[j+1]=samples[i][j]
            
            samples_new.append(sample_one)
        
        return[label_new,samples_new]
    
    #下面进行训练
    def SVM_train(self,label,samples):
        
        print("正在训练SVM模型中")
        
        print("------------------------")
        
        label=np.asarray(label)
        
        model=svm_train(label,samples,'-s 3 -t 2 -c 5 -g 0.8 -h 0')
        
        return model
    
    #下面进行预测
    def SVM_predict(self,label,samples,model):
        
        print("正在预测中")
        
        print("------------------------")
        
        label=np.asarray(label)
        
        label_r,ac_r,value_r=svm_predict(label,samples,model)        
        
        return [label_r,ac_r,value_r]


