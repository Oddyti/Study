function str = arr2str(array)
    % 将[1,2,3,4,5] 转换为'12345'
    len = length(array);
    str = [ ];
    for i = 1 : 1 : len
        add_str = num2str( array(i) );
        str = strcat(str,add_str);
    end
end