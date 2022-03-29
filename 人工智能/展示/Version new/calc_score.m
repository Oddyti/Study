function score = calc_score(count, who)		
global STWO; 
global TWO;
global STHREE;
global THREE;
global SFOUR; 
global FOUR;
global FIVE;

global HUMAN_SCORE_FIVE; 
global HUMAN_SCORE_FOUR; 
global HUMAN_SCORE_SFOUR; 
global HUMAN_SCORE_THREE; 
global HUMAN_SCORE_STHREE; 
global HUMAN_SCORE_TWO; 
global HUMAN_SCORE_STWO;

global PC_SCORE_FIVE;   
global PC_SCORE_FOUR;   
global PC_SCORE_SFOUR;  
global PC_SCORE_THREE;  
global PC_SCORE_STHREE; 
global PC_SCORE_TWO;    
global PC_SCORE_STWO;   

        score = 0;

        if who == 1
			score = score + count(FIVE) * HUMAN_SCORE_FIVE;
			score = score + count(FOUR) * HUMAN_SCORE_FOUR;
			score = score + count(SFOUR) * HUMAN_SCORE_SFOUR;
			score = score + count(THREE) * HUMAN_SCORE_THREE;
			score = score + count(STHREE) * HUMAN_SCORE_STHREE;
			score = score + count(TWO) * HUMAN_SCORE_TWO;
			score = score + count(STWO) * HUMAN_SCORE_STWO;
        
        elseif who == 2
			score = score + count(FIVE) * PC_SCORE_FIVE;
			score = score + count(FOUR) * PC_SCORE_FOUR;
			score = score + count(SFOUR) * PC_SCORE_SFOUR;
			score = score + count(THREE) * PC_SCORE_THREE;
			score = score + count(STHREE) * PC_SCORE_STHREE;
			score = score + count(TWO) * PC_SCORE_TWO;
			score = score + count(STWO) * PC_SCORE_STWO;
        end
        
end