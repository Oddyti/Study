function data_new = modify_data(data_x, data_y,mem_n)
    L = length(data_x);
    data_temp = zeros(1,L + mem_n-1); %#ok<PREALL>
    data_temp = [data_x,data_x(1:mem_n-1)];
    data_new =[];
    for i = 1:L
        data_new =[data_new,data_temp(i:i+mem_n-1)'];
    end
    data_new = [data_new;data_y];
end