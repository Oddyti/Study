function [data_out, data_info] = data_norm(data_in)
    data_in = data_in';
    data_real = real(data_in);
    data_imag = imag(data_in);
    [data_norm_real, mu_real, sigma_real] = zscore(data_real);
    [data_norm_imag, mu_imag, sigma_imag] = zscore(data_imag);
    data_info = [];
    data_info = [mu_real;sigma_real;mu_imag;sigma_imag];
    data_out = data_norm_real+data_norm_imag*1i;
    data_out = data_out';
    data_info = data_info';
end