function [tx_data, tx_sig] = QAM_Modulator(input_sig, num_symb, bits_per_sym, coding, draw)
    %> @QAM调制函数

    %> @input_sig,输入的0-1比特序列，可采用例如PRBS15序列来模拟
    %> @num_symb,QAM信号的符号数
    %> @bits_per_sym,QAM信号每符号比特数

    %> @tx_data,发送端0-1数据源
    %> @tx_sig,生成的QAM信号

    % uiwait(msgbox('进入发送端DSP(QAM调制)','提示','help'));
    fprintf(1, [' #   QAM调制计算中------ ' '\n']);
    fprintf(1, [' ---------------------------\n']);

    rep_input_sig = ceil(num_symb * bits_per_sym / (length(input_sig))); % 根据符号数对input_sig序列进行周期性延展，rep_input_sig为重复周期数
    tx_data = repmat(input_sig, [rep_input_sig 1]); % 发送端0-1数据
    tx_data = reshape(tx_data, bits_per_sym, num_symb); % 串并转换，方便进行QAM调制
    data_trace = bi2de(tx_data', 'left-msb'); %二进制转换为十进制

    if draw
        PlotCons = true;
    else
        PlotCons = false;
    end

    tx_sig = qammod(data_trace, 2 ^ bits_per_sym, coding, 'UnitAveragePower', true, 'PlotConstellation', PlotCons);
    title('QAM调制星座图', 'FontSize', 12);
    scnsize = get(0, 'ScreenSize');
    set(gcf, 'position', [scnsize(3) / 2 - scnsize(4) / 3, scnsize(4) / 6, scnsize(4) * 2/3, scnsize(4) * 2/3]); % 绘图区位置

end
