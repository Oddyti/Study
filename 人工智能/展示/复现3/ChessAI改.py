import time
from sklearn.metrics import precision_score
from Game import *
from enum import IntEnum
from random import randint
import re
import numpy as np

class CHESS_TYPE(IntEnum):
	NONE = 0,
	SLEEP_TWO = 1,
	LIVE_TWO = 2,
	SLEEP_THREE = 3
	LIVE_THREE = 4,
	CHONG_FOUR = 5,
	LIVE_FOUR = 6,
	LIAN_FIVE = 7,

class MAP_ENTRY_TYPE(IntEnum):
	MAP_EMPTY = 0,
	MAP_PLAYER_ONE = 1,
	MAP_PLAYER_TWO = 2,
	MAP_NONE = 3, # out of map range

HUMAN_FIVE = '11111'
HUMAN_LFOUR = '011110'
HUMAN_SFOUR = ['211110','011112','10111','11101','11011']
HUMAN_LTHREE = ['01110','1011','1101']
HUMAN_STHREE = ['211100','001112','211010','010112','210110','011012','11001','10011','10101','2011102']
HUMAN_LTWO = ['001100','01010','1001']
HUMAN_STWO = ['211000','000112','210100','001012','210010','010012','10001']

PC_FIVE = '22222'
PC_LFOUR = '022220'
PC_SFOUR = ['122220','022221','20222','22202','22022']
PC_LTHREE = ['02220','2022','2202']
PC_STHREE = ['122200','002221','122020','020221','120220','022021','22002','20022','20202','1022201']
PC_LTWO = ['002200','02020','2002']
PC_STWO = ['122000','000221','120200','002021','120020','020021','20002']

CHESS_TYPE_NUM = 8
FIVE, FOUR, THREE, TWO, SFOUR, STHREE, STWO = CHESS_TYPE.LIAN_FIVE.value,CHESS_TYPE.LIVE_FOUR.value, CHESS_TYPE.LIVE_THREE.value, CHESS_TYPE.LIVE_TWO.value,CHESS_TYPE.CHONG_FOUR.value, CHESS_TYPE.SLEEP_THREE.value, CHESS_TYPE.SLEEP_TWO.value

SCORE_MAX = 0x7fffffff
SCORE_MIN = -1 * SCORE_MAX
SCORE_FIVE, SCORE_FOUR, SCORE_SFOUR = 100000, 10000, 1000
SCORE_THREE, SCORE_STHREE, SCORE_TWO, SCORE_STWO = 100, 10, 8, 2
AI_SEARCH_DEPTH, AI_LIMITED_MOVE_NUM = 4, 20
DIR_OFFSET = [(1, 0), (0, 1), (1, 1), (1, -1)]

HUMAN_FIVE_N = HUMAN_LFOUR_N = HUMAN_SFOUR_N = HUMAN_LTHREE_N = HUMAN_STHREE_N = HUMAN_LTWO_N = HUMAN_STWO_N = PC_FIVE_N = PC_LFOUR_N = PC_SFOUR_N = PC_LTHREE_N = PC_STHREE_N = PC_LTWO_N = PC_STWO_N = 0

class ChessAI():
    	
	# 初始化pc_count,human_count
	def __init__(self, chess_len):
		self.len = chess_len
		self.pc_count = [0 for type in range(CHESS_TYPE_NUM)]
		self.human_count = [0 for type in range(CHESS_TYPE_NUM)]
		self.human, self.pc = 1,2 # 玩家先行
		self.win = 0

	# 将pc_count,human_count归零
	def reset(self):
		for i in range(len(self.pc_count)):
				self.pc_count[i] = 0
				self.human_count[i] = 0
	
	# 判断是否胜利
	def is_win(self):
		if self.human_count[FIVE] > 0:
			self.win = 1
		elif self.pc_count[FIVE] > 0:
			self.win = 2
		
	# 用于电脑进行计算时,human与pc的攻防角度转换
	def defense(self,who):
		if who == 1:	
			return 2
		elif who == 2:
			return 1

	# 查看某空点附近是否有棋子(策略驱使我们往聚集处落子)
	def has_neighbor(self, board, x, y, radius):
		start_x, end_x, start_y, end_y = (x - radius), (x + radius), (y - radius), (y + radius)	

		for i in range(start_x, end_x + 1):
			for j in range(start_y, end_y + 1):
				if 0 <= i < self.len and 0 <= j < self.len:
					if board[i][j] != 0:
						return True
		return False
	
	# 统计一条线上的棋型
	def count_line_type(self, str_line, pc_count, human_count):	
		self.human_count[7] += len(re.findall(HUMAN_FIVE,str_line))
		self.human_count[6] += len(re.findall(HUMAN_LFOUR,str_line))
		self.pc_count[7] += len(re.findall(PC_FIVE,str_line))
		self.pc_count[6] += len(re.findall(PC_LFOUR,str_line))

		for str in HUMAN_SFOUR:
			self.human_count[5] +=  len(re.findall(str,str_line))
		for str in HUMAN_LTHREE:
			self.human_count[4] +=  len(re.findall(str,str_line))
		for str in HUMAN_STHREE:
			self.human_count[3] +=  len(re.findall(str,str_line))
		for str in HUMAN_LTWO:
			self.human_count[2] +=  len(re.findall(str,str_line))
		for str in HUMAN_STWO:
			self.human_count[1] +=  len(re.findall(str,str_line))

		for str in PC_SFOUR:
			self.pc_count[5] +=  len(re.findall(str,str_line))
		for str in PC_LTHREE:
			self.pc_count[4] +=  len(re.findall(str,str_line))
		for str in PC_STHREE:
			self.pc_count[3] +=  len(re.findall(str,str_line))
		for str in PC_LTWO:
			self.pc_count[2] +=  len(re.findall(str,str_line))
		for str in PC_STWO:
			self.pc_count[1] +=  len(re.findall(str,str_line))

	# 遍历棋盘,统计全局的棋型
	def count_global_type(self, board):
		self.reset()
		board = np.array(board, dtype = int)

		for row in range(15):
			line = board[row,:]
			list_line = line.tolist()
			str_line = [str(x) for x in list_line]
			str_line = ''.join(str_line)
			self.count_line_type(str_line, self.pc_count, self.human_count)
		
		for col in range(15):
			line = board[:,col]
			list_line = line.tolist()
			str_line = [str(x) for x in list_line]
			str_line = ''.join(str_line)
			self.count_line_type(str_line, self.pc_count, self.human_count)
		
		for x in range(2,12):
			y = x
			wide = min(x,14-x)
			tilt_line = []
			for i in range(-wide, wide+1):
				tilt_line.append( board[ x + i*DIR_OFFSET[3][0], y + i*DIR_OFFSET[3][1] ] )
			#list_line = tilt_line.tolist()
			str_line = [str(x) for x in tilt_line]
			str_line = ''.join(str_line)
			self.count_line_type(str_line, self.pc_count, self.human_count)
		
		for x in range(2,12):	
			y = 14 - x
			wide = min(x,y)
			tilt_line = []
			for i in range(-wide, wide+1):
				tilt_line.append( board[ x + i*DIR_OFFSET[2][0], y + i*DIR_OFFSET[2][1] ] )
			#list_line = tilt_line.tolist()
			str_line = [str(x) for x in tilt_line]
			str_line = ''.join(str_line)
			self.count_line_type(str_line, self.pc_count, self.human_count)

	# 对于pc或human，由pc_count或human_count计算其分数
	def calc_score(self, count):	
		# 连五或者冲四，直接返回
		if count[FIVE] > 0:
			return SCORE_FIVE
		if count[FOUR] > 0:
			return SCORE_FOUR
		
		score = 0
		# 如果没有活三，眠四试作等同于活三优先级
		if count[SFOUR] > 1:
			score += count[SFOUR] * SCORE_SFOUR
		elif count[SFOUR] > 0 and count[THREE] > 0:
			score += count[SFOUR] * SCORE_SFOUR
		elif count[SFOUR] > 0:
			score += SCORE_THREE 
		
		if count[THREE] > 1:
			score += count[THREE] * SCORE_THREE
		elif count[THREE] > 0:
			score += SCORE_THREE

		if count[STHREE] > 0:
			score += count[STHREE] * SCORE_STHREE
		if count[TWO] > 0:
			score += count[TWO] * SCORE_TWO
		if count[STWO] > 0:
			score += count[STWO] * SCORE_STWO
		
		return score

	# 如果下出这个点,双方的棋局分数,返回pc_score和human_score
	def evaluate_both(self, board, x, y):
    	
		board[x][y] = self.pc
		self.count_global_type(board)
		temp_pc_score = self.calc_score(self.pc_count)
		board[x][y] = 0

		board[x][y] = self.human
		self.count_global_type(board)
		temp_human_score = self.calc_score(self.human_count)
		board[x][y] = 0
		
		return (temp_pc_score, temp_human_score)
   				
	# pc根据全局的count和score生成可下棋点有序列表(score, x, y)
	def get_moves(self, board):
		moves = []
		radius = 1
		for x in range(self.len):
			for y in range(self.len):
				if board[x][y] == 0 and self.has_neighbor(board, x, y, radius):
					self.pc_score, self.human_score = self.evaluate_both(board, x, y)
					global_score = self.pc_score - self.human_score
					point = (global_score, x, y)
					moves.append(point)
				
		moves.sort(reverse=True)
		if len(moves) > AI_LIMITED_MOVE_NUM:
			moves = moves[:AI_LIMITED_MOVE_NUM]
		return moves

	"""
	# AI_search函数,调用MAX_value和MIN_value函数
	def AI_search(self, board, depth = 4):	
		self.maxdepth = depth
		score, x, y = self.MAX_value(self, board, depth)
		self.bestmove = x, y
		return score, x, y
	"""

	# 找到最优下棋点
	def find_bestmove(self, board):
		moves = self.get_moves(board)
		bestmove = moves[0]
		print('human count',self.human_count[5]) 
		print('pc count',self.pc_count[5])
		return (bestmove[1],bestmove[2])