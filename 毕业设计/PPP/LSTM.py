from prometheus_client import Metric
import tensorflow as tf
import pandas as pd
import numpy as np
'''
参数说明：

dim_hid表示隐层的维度

dim_out表示输出的维度

drop表示dropout的参数

'''
class LSTM():
    def __init__(self,dim_hid,dim_out,drop):
        
        self.dim_hid=dim_hid

        self.dim_out=dim_out

        self.drop=drop
    
    #下面是构建单向lstm的函数
    def get_model_one(self):

        model=tf.keras.Sequential()
        
        #加一层隐层
        model.add(tf.keras.layers.LSTM(self.dim_hid,return_sequences=True,activation='relu',recurrent_activation="sigmoid"))

        
        model.add(tf.keras.layers.Dropout(self.drop))

        #输出层
        model.add(tf.keras.layers.Dense(4,activation='tanh'))
        
        #查看模型信息
        #model.summary()

        #设置模型的优化器，损失函数
        adam=tf.keras.optimizers.Adam(lr=0.01, beta_1=0.9, beta_2=0.999, epsilon=1e-08)

        model.compile(optimizer='adam',loss=('mse'),metrics=['accuracy'])

        return model

    #下面是构建双向lstm的网络
    def get_model_both(self):

        model=tf.keras.Sequential()
        
        #构造前向层和后向层
        forward_lstm=tf.keras.layers.LSTM(self.dim_hid,activation='relu',recurrent_activation="sigmoid",kernel_regularizer=tf.keras.regularizers.l2(0.1))
        
        backward_lstm=tf.keras.layers.LSTM(self.dim_hid,go_backwards=True,kernel_regularizer=tf.keras.regularizers.l2(0.1))
        
        #加一层双向层
        model.add(tf.keras.layers.Bidirectional(forward_lstm,merge_mode='concat',backward_layer=backward_lstm))


        model.add(tf.keras.layers.Dropout(self.drop))

        #输出层
        model.add(tf.keras.layers.Dense(4,activation='softmax'))
        
        #查看模型信息
        #model.summary()

        #设置模型的优化器，损失函数
        adam=tf.keras.optimizers.Adam(lr=0.001, beta_1=0.9, beta_2=0.999, epsilon=1e-08)

        model.compile(optimizer='adam',loss=('categorical_crossentropy'),metrics=['accuracy'])

        return model







