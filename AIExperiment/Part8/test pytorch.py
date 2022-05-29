 
 
import warnings
warnings.filterwarnings('ignore')
 
 
import torch
import time
 
 
if torch.cuda.is_available():
    device=torch.device('cuda:0')
    print('The current device is GPU. ',end='\n\n')
else:
    device=torch.device('cpu')
    print('The current device is CPU. ',end='\n\n')
 
 
a=torch.normal(mean=0, std=1, size=(32,128,128))
    
 
b=a.clone()
d=a.clone()
d=d.to(device)
 
 
Test_times=20
 
 
time_cost=0
for _ in range(Test_times):
    time_0=time.time()
    for i in range(100000):
        c=b**2
    time_1=time.time()
    
    time_cost=time_cost + time_1-time_0
time_cost=time_cost/Test_times
    
print(f'Average CPU Time : {time_cost:.5f} ')
 
 
time_cost=0
for _ in range(Test_times):
    time_2=time.time()
    for i in range(100000):
        e=d**2
    time_3=time.time()
    
    time_cost=time_cost + time_3-time_2
time_cost=time_cost/Test_times
 
print(f'Average GPU Time : {time_cost:.5f} ')
 
 
 
 
 