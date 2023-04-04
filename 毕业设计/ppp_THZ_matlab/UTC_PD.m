function E_thz = UTC_PD(E1, E2, fc_1, fc_2, phy_1, phy_2, ut, R, Ts)
    % E1: 光波1的根号功率
    % E2: 光波2的根号功率
    % fc_1, fc_2: 两路光波的频率
    % phy_1, phy_2: 两路光波的初始相位
    % ut: MZM调制后的ut
    % R: UTC_PD的响应度

    t = (1:length(ut))*Ts;
    E_thz = 2 * R * E1 * E2 * ut .* cos(2 * pi * abs(fc_1 - fc_2) * t + abs(phy_1 - phy_2));

end
