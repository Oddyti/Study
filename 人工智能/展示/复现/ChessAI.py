import time
from Game import *
from sklearn.metrics import precision_score
from Game import *
from enum import IntEnum
from random import randint

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


CHESS_TYPE_NUM = 8
FIVE, FOUR, THREE, TWO, SFOUR, STHREE, STWO = CHESS_TYPE.LIAN_FIVE.value,CHESS_TYPE.LIVE_FOUR.value, CHESS_TYPE.LIVE_THREE.value, CHESS_TYPE.LIVE_TWO.value,CHESS_TYPE.CHONG_FOUR.value, CHESS_TYPE.SLEEP_THREE.value, CHESS_TYPE.SLEEP_TWO.value

SCORE_MAX = 0x7fffffff
SCORE_MIN = -1 * SCORE_MAX
SCORE_FIVE, SCORE_FOUR, SCORE_SFOUR = 100000, 10000, 1000
SCORE_THREE, SCORE_STHREE, SCORE_TWO, SCORE_STWO = 100, 10, 5, 1
AI_SEARCH_DEPTH, AI_LIMITED_MOVE_NUM = 4, 20
DIR_OFFSET = [(1, 0), (0, 1), (1, 1), (1, -1)]

class ChessAI():
    	
	# 初始化record,pc_count,human_count
	def __init__(self, chess_len):
		self.len = chess_len
		self.record = [[[0,0,0,0] for x in range(chess_len)] for y in range(chess_len)]
		self.pc_count = self.human_count = [0 for type in range(CHESS_TYPE_NUM)]
		self.human, self.pc = 1,2 # 玩家先行

	# 将record,pc_count,human_count归零
	def reset(self):
		for x in range(self.len):
			for y in range(self.len):
				for i in range(4):
					self.record[x][y][i] = 0
		for i in range(len(self.pc_count)):
				self.pc_count[i] = 0
				self.human_count[i] = 0
	
	# 判断是否胜利
	def is_win(self):
		if self.human_count[FIVE] > 0:
			return 1
		if self.pc_count[FIVE] > 0:
			return 2
		return 0

	# 用于电脑进行计算时,human与pc的攻防角度转换
	def defense(self,who):
		if who == 1:	
			return 2
		elif who == 2:
			return 1

	# 查看某空点附近是否有邻居(策略驱使我们往聚集处落子)
	def has_neighbor(self, board, x, y, radius):
		start_x, end_x, start_y, end_y = (x - radius), (x + radius), (y - radius), (y + radius)	

		for i in range(start_x, end_x + 1):
			for j in range(start_y, end_y + 1):
				if 0 <= i < self.len and 0 <= j < self.len:
					if board[i][j] != 0:
						return True
		return False
	
	# 对于一个空点，检测以其为中心长度为9的线段
	def get_line(self, board, x, y, dir_index, who):	
		dir = DIR_OFFSET[dir_index]
		line = [0 for i in range(9)]
		temp_x = x + (-5 * dir[0])
		temp_y = y + (-5 * dir[1])

		for i in range(9):
			temp_x += dir[0]
			temp_y += dir[1]
			# 界外视为对手落子
			if(temp_x < 0 or temp_x >= self.len or temp_y < 0 or temp_y >= self.len):	
				line[i] = self.defense(who)
			else:
				line[i] = board[temp_x][temp_y]
		return line

	# 对于pc或human,判断以某点为中心一条线上形成的棋型。
	def analy_line(self, board, x, y, dir_index, count, who):
		dir = DIR_OFFSET[dir_index]
		def set_record(self, x, y, left, right, dir_index, dir):
			temp_x = x + (-5 + left) * dir[0]
			temp_y = y + (-5 + left) * dir[1]
			for i in range(left, right+1):
				temp_x += dir[0]
				temp_y += dir[1]
				self.record[temp_x][temp_y][dir_index] = 1
		
		empty = MAP_ENTRY_TYPE.MAP_EMPTY.value
		left_idx, right_idx = 4, 4

		line = self.get_line(board, x, y, dir_index, who)

		while right_idx < 8:
			if line[right_idx+1] != who:
				break
			right_idx += 1
		while left_idx > 0:
			if line[left_idx-1] != who:
				break
			left_idx -= 1
		
		left_range, right_range = left_idx, right_idx
		while right_range < 8:
			if line[right_range+1] == self.defense(who):
				break
			right_range += 1
		while left_range > 0:
			if line[left_range-1] == self.defense(who):
				break
			left_range -= 1
		
		chess_range = right_range - left_range + 1
		if chess_range < 5:
			set_record(self, x, y, left_range, right_range, dir_index, dir)
			return CHESS_TYPE.NONE
		
		set_record(self, x, y, left_idx, right_idx, dir_index, dir)
		
		m_range = right_idx - left_idx + 1

		# M:电脑棋, P:玩家棋或者界外, X: empty
		if m_range >= 5:
			count[FIVE] += 1
		
		# 活四: XMMMMX 
		# 冲四: XMMMMP, PMMMMX
		if m_range == 4:
			left_empty = right_empty = False
			if line[left_idx-1] == empty:
				left_empty = True			
			if line[right_idx+1] == empty:
				right_empty = True
			if left_empty and right_empty:
				count[FOUR] += 1
			elif left_empty or right_empty:
				count[SFOUR] += 1
		# Chong Four : MXMMM, MMMXM, the two types can both exist
		# Live Three : XMMMXX, XXMMMX
		# Sleep Three : PMMMX, XMMMP, PXMMMXP
		if m_range == 3:
			left_empty = right_empty = False
			left_four = right_four = False
			if line[left_idx-1] == empty:
				if line[left_idx-2] == who: # MXMMM
					set_record(self, x, y, left_idx-2, left_idx-1, dir_index, dir)
					count[SFOUR] += 1
					left_four = True
				left_empty = True
				
			if line[right_idx+1] == empty:
				if line[right_idx+2] == who: # MMMXM
					set_record(self, x, y, right_idx+1, right_idx+2, dir_index, dir)
					count[SFOUR] += 1
					right_four = True 
				right_empty = True
			
			if left_four or right_four:
				pass
			elif left_empty and right_empty:
				if chess_range > 5: # XMMMXX, XXMMMX
					count[THREE] += 1
				else: # PXMMMXP
					count[STHREE] += 1
			elif left_empty or right_empty: # PMMMX, XMMMP
				count[STHREE] += 1
		
		# 冲四: MMXMM, only check right direction
		# 活三: XMXMMX, XMMXMX the two types can both exist
		# 眠三: PMXMMX, XMXMMP, PMMXMX, XMMXMP
		# 活二: XMMX
		# 眠二: PMMX, XMMP
		if m_range == 2:
			left_empty = right_empty = False
			left_three = right_three = False
			if line[left_idx-1] == empty:
				if line[left_idx-2] == who:
					set_record(self, x, y, left_idx-2, left_idx-1, dir_index, dir)
					if line[left_idx-3] == empty:
						if line[right_idx+1] == empty: # XMXMMX
							count[THREE] += 1
						else: # XMXMMP
							count[STHREE] += 1
						left_three = True
					elif line[left_idx-3] == self.defense(who): # PMXMMX
						if line[right_idx+1] == empty:
							count[STHREE] += 1
							left_three = True
						
				left_empty = True
				
			if line[right_idx+1] == empty:
				if line[right_idx+2] == who:
					if line[right_idx+3] == who:  # MMXMM
						set_record(self, x, y, right_idx+1, right_idx+2, dir_index, dir)
						count[SFOUR] += 1
						right_three = True
					elif line[right_idx+3] == empty:
						#setRecord(self, x, y, right_idx+1, right_idx+2, dir_index, dir)
						if left_empty:  # XMMXMX
							count[THREE] += 1
						else:  # PMMXMX
							count[STHREE] += 1
						right_three = True
					elif left_empty: # XMMXMP
						count[STHREE] += 1
						right_three = True
						
				right_empty = True
			
			if left_three or right_three:
				pass
			elif left_empty and right_empty: # XMMX
				count[TWO] += 1
			elif left_empty or right_empty: # PMMX, XMMP
				count[STWO] += 1
		
		# 活二: XMXMX, XMXXMX only check right direction
		# 眠二: PMXMX, XMXMP
		if m_range == 1:
			left_empty = right_empty = False
			if line[left_idx-1] == empty:
				if line[left_idx-2] == who:
					if line[left_idx-3] == empty:
						if line[right_idx+1] == self.defense(who): # XMXMP
							count[STWO] += 1
				left_empty = True

			if line[right_idx+1] == empty:
				if line[right_idx+2] == who:
					if line[right_idx+3] == empty:
						if left_empty: # XMXMX
							#setRecord(self, x, y, left_idx, right_idx+2, dir_index, dir)
							count[TWO] += 1
						else: # PMXMX
							count[STWO] += 1
				elif line[right_idx+2] == empty:
					if line[right_idx+3] == who and line[right_idx+4] == empty: # XMXXMX
						count[TWO] += 1
	
		return CHESS_TYPE.NONE
	
	# 对一个点的四个方向棋型都进行检查,更新pc_count或human_count
	# 传入self.pc_count 或self.human_count即可全局改变
	def examine_point(self, board, x, y, who, count = None):
    	
		if who == self.human:
			count = self.human_count
		else:
			count = self.pc_count

		for i in range(4):
			if self.record[x][y][i] == 0:
				self.analy_line(board, x, y, i, count, who)
	
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

	# 评估当前双方的棋局分数,返回pc_score和human_score
	def evaluate_both(self, board):
		self.reset()

		for x in range(self.len):
			for y in range(self.len):
				if board[x][y] == self.pc:
					self.examine_point(board, x, y, self.pc, self.pc_count)
				elif board[x][y] == self.human:
					self.examine_point(board, x, y, self.human, self.human_count)
	
		self.pc_score = self.calc_score(self.pc_count)
		self.human_score = self.calc_score(self.human_count)

		return (self.pc_score, self.human_score)

	# pc生成可下棋点有序列表(score, x, y)
	def get_moves(self, board):
		moves = []
		radius = 1
		for x in range(self.len):
			for y in range(self.len):
				if board[x][y] == 0 and self.has_neighbor(board, x, y, radius):
					self.pc_score, self.human_score = self.evaluate_both(board)
					global_score = self.pc_score - self.human_score
					point = (global_score, x, y)
					moves.append(point)

		moves.sort(reverse=True)
		if len(moves) > AI_LIMITED_MOVE_NUM:
			moves = moves[:AI_LIMITED_MOVE_NUM]
		return moves

	"""
	# AI_search函数，调用MAX_value和MIN_value函数
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
		return (bestmove[1],bestmove[2])
