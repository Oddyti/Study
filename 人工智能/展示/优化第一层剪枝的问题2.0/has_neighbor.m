function [symbol] = has_neighbor(board, x, y, radius)
    
    start_x = x - radius;   
    end_x = x + radius;
    start_y = y - radius;   
    end_y = y + radius;
    symbol = 0;
    
    for i = start_x : 1 : end_x
        
        for j = start_y : 1 : end_y
            
            if  i>=1 && i<=15 && j>=1 && j <= 15
                
                if board(i,j) ~= 0
                    symbol = 1;
                end
                
            end
            
        end
        
    end
     
end