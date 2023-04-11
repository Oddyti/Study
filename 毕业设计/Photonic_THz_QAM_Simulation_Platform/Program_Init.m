%> @程序启动函数，可自动囊括各子文件夹

%% 系统设置
    clear all; % 数据空间清空
    close all; % 图片空间清空
    clc; % 显示空间清空
    warning off; % 警告不显示（可开为on）
    draw = 1; % 为1则作图，为0仅显示最后结果
    
%% 添加子文件夹
    root = mfilename('fullpath');
    root = root(1:find(root==filesep,1,'last')-1);
    fprintf(1,' @  光电混合的太赫兹通信系统仿真平台\n');
    fprintf(1,' @  MATLAB启动----程序初始化.添加下列路径:\n');
    fprintf(' @  %s\n',root);
    addpath(root);
    dirs = {'OE_Modules','DSP_Modules','Sub_Fuctions','Sim_Results','Data_Traces','System_Parameters'}; % 可补充定义子文件夹名称
    for i=1:numel(dirs)
        add = [root filesep dirs{i}];
        fprintf(' @  %s\\*\n',add);
        addpath(genpath(add));
    end    
    pause(5);
    clc;fprintf(1,' @  光电混合的太赫兹通信系统仿真平台-----运行中-----\n');
