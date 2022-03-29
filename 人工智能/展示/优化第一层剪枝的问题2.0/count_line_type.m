function [human_count_line, pc_count_line] = count_line_type(line)    
global STWO; 
global TWO;
global STHREE;
global THREE;
global SFOUR; 
global FOUR;
global FIVE;

global HUMAN_FIVE; 
global HUMAN_FOUR; 
global HUMAN_SFOUR; 
global HUMAN_THREE; 
global HUMAN_STHREE; 
global HUMAN_TWO; 
global HUMAN_STWO;

global PC_FIVE;   
global PC_FOUR;   
global PC_SFOUR;  
global PC_THREE;  
global PC_STHREE; 
global PC_TWO;    
global PC_STWO;   

    % 注：line应该是字符串形式的
    human_count_line = zeros(1,7);
    pc_count_line = zeros(1,7);
    
    human_count_line(FIVE) = length( strfind(line, HUMAN_FIVE) );
    pc_count_line(FIVE) = length( strfind(line, PC_FIVE) );
    
    human_count_line(FOUR) = length( strfind(line, HUMAN_FOUR) );
    pc_count_line(FOUR) = length( strfind(line, PC_FOUR) );
    
    for i = 1 : 1 : length(HUMAN_SFOUR)
        human_count_line(SFOUR) = human_count_line(SFOUR) + length( strfind(line, HUMAN_SFOUR(i) ) );
        pc_count_line(SFOUR) = pc_count_line(SFOUR) + length( strfind(line, PC_SFOUR(i) ) );
    end
    
    for i = 1 : 1 : length(HUMAN_THREE)
        human_count_line(THREE) = human_count_line(THREE) + length( strfind(line, HUMAN_THREE(i) ) );
        pc_count_line(THREE) = pc_count_line(THREE) + length( strfind(line, PC_THREE(i) ) );
    end
    
    for i = 1 : 1 : length(HUMAN_STHREE)
        human_count_line(STHREE) = human_count_line(STHREE) + length( strfind(line, HUMAN_STHREE(i) ) );
        pc_count_line(STHREE) = pc_count_line(STHREE) + length( strfind(line, PC_STHREE(i) ) );
    end
    
    for i = 1 : 1 : length(HUMAN_TWO)
        human_count_line(TWO) = human_count_line(TWO) + length( strfind(line, HUMAN_TWO(i) ) );
        pc_count_line(TWO) = pc_count_line(TWO) + length( strfind(line, PC_TWO(i) ) );
    end
    
    for i = 1 : 1 : length(HUMAN_STWO)
        human_count_line(STWO) = human_count_line(STWO) + length( strfind(line, HUMAN_STWO(i) ) );
        pc_count_line(STWO) = pc_count_line(STWO) + length( strfind(line, PC_STWO(i) ) );
    end
    
end