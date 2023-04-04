function [E_out, ut] = MZM(E_in, data, V_pi, V_bias, T)
    % E_in: 光载波
    % data: 码元数据
    % V_pi: 调制器的半波点电压
    % V_bias: 调制器的偏置电压
    % T: 码元宽度

    E_out = [];
    ut = [];

    for i = 1:length(E_in)
        ut = [ut, cos(pi * (data(ceil(i / T)) + V_bias) / 2 / V_pi)];
        E_out = [E_out, E_in(i) * cos(pi * (data(ceil(i / T)) + V_bias) / 2 / V_pi)];
    end

end
