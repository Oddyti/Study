import time
from posixpath import isabs
from tkinter.tix import CELL
from turtle import position
import pygame
from pygame.locals import *
from enum import Flag, IntEnum
from ChessAI import *

# color
BOARDCOLOR = (185, 215, 234)
BUTTONCOLOR = [(115, 153, 195), (73, 129, 180)]
# size
NAVBARHEIGHT = 60
BOARDHEIGHT = 750
WIDTH = 750
BUTTONWIDTH = 100
BUTTONHEIGHT = 40
CELLSIZE = 50
CELLNUMBER = 15

class MESSAGE_TYPE(IntEnum):
    PLAYING = 0,
    START = 1,
    GIVEUP = 2,
    TAKEBACK = 3,
    CHEAT = 4,
    WIN = 5,

class Game():
    def __init__(self):
        # pygame初始化
        pygame.init()
        self.screen = pygame.display.set_mode([WIDTH, NAVBARHEIGHT + BOARDHEIGHT])
        pygame.display.set_caption('五子棋')
        self.clock = pygame.time.Clock()
        self.buttons = []
        self.buttons.append(buttonStart(self.screen, '来一局', 20, (NAVBARHEIGHT-BUTTONHEIGHT)/2))
        self.buttons.append(buttonGiveUp(self.screen, '打扰了', 20 + BUTTONWIDTH + 20, (NAVBARHEIGHT-BUTTONHEIGHT)/2))
        self.buttons.append(buttonTakeBack(self.screen, '耍个赖', 20 + BUTTONWIDTH*2 + 20*2, (NAVBARHEIGHT-BUTTONHEIGHT)/2))
        self.buttons.append(buttonCheat(self.screen, '开个挂', 20 + BUTTONWIDTH*3 + 20*3, (NAVBARHEIGHT-BUTTONHEIGHT)/2))
        self.draw = Draw()
        self.message = 0
        self.state = MESSAGE_TYPE.PLAYING
        self.AI = ChessAI(15)

        self.isplaying = False   
        self.winner = 0 

        self.player = 1

        self.board = Board()

        self.action = None
        self.isTakeBack = False
        self.last_x = None
        self.last_y = None
        self.useAI = False

    def startGame(self):
        self.isplaying = True
        self.player = 1
        # self.board.reset()  # 重置棋盘



    def playGame(self):
        self.clock.tick(60)
        self.draw.DrawBasicelement(self.screen, self.buttons)
        
        # 显示按钮提示信息
        if self.state == MESSAGE_TYPE.PLAYING:
            self.state = MESSAGE_TYPE.PLAYING
        elif self.state == MESSAGE_TYPE.START:
            self.showMessage(1)
            self.state = MESSAGE_TYPE.PLAYING
        elif self.state == MESSAGE_TYPE.GIVEUP:
            self.showMessage(2)
            self.state = MESSAGE_TYPE.PLAYING
        elif self.state == MESSAGE_TYPE.TAKEBACK:
            self.showMessage(3)
            self.state = MESSAGE_TYPE.PLAYING
        elif self.state == MESSAGE_TYPE.CHEAT:
            self.showMessage(4)
            self.state = MESSAGE_TYPE.PLAYING
        
        # 游戏核心进程
        # 轮流
        if self.isplaying and not self.isOver():
            # if self.useAI:
            #     x, y = self.AI.find_bestmove(self.board.chessMap)
            #     self.board.placeChess(x, y, self.player, self)
            #     self.useAI = False
            if self.isTakeBack:
                self.checkClick(0,0)
            elif self.useAI:
                x, y = self.AI.find_bestmove(self.board.chessMap)
                self.checkClick(x, y, True)
                self.useAI = False
            elif self.action is not None:
                self.checkClick(self.action[0], self.action[1])
                self.action = None
            
            
            # if self.AI.is_win() == 1:
            #     self.winner = 1
            # elif self.AI.is_win() ==2:
            #     self.winner = 2
        # 下棋 
        if self.isplaying == True:
            # print('isplaying')
            self.board.drawChess(self.screen)
        else:
            # print('not playing')
            self.board.boardReset()
        
        if self.isOver():
            self.showMessage(5)
    
    def isOver(self):
        if self.winner != 0:
            return True
        else:
            return False

    def checkClick(self, x, y, isAI=False):
            if self.isTakeBack:
                self.board.placeChess(x, y, self.player, self)
            else:
                self.board.placeChess(x, y, self.player, self)
                if self.AI.is_win():
                    self.winner = self.AI.is_win()
                else:
                    self.player = self.board.exchange(self.player)
                    if not isAI:
                        self.useAI = True

    def inCell(self, mouse_x, mouse_y):
        print(self.winner, self.isOver())
        if self.isplaying and not self.isOver():
            if (0 < mouse_x and mouse_x < WIDTH and NAVBARHEIGHT < mouse_y and mouse_y < NAVBARHEIGHT + BOARDHEIGHT):
                x, y = self.board.PosToIndex(mouse_x, mouse_y)
                print('Postion: %d, %d' %(mouse_x,mouse_y))
                print('Index: %d, %d' %(x, y))
                if self.board.isEmpty(x, y):
                    self.action = (x, y)

    def inButton(self, mouse_x, mouse_y):
        for button in self.buttons:
            if button.rect.collidepoint(mouse_x, mouse_y):
                self.buttonClick(button)
                break
    
    def buttonClick(self, button):
        if button.click(self):
            for otherbutton in self.buttons:
                if otherbutton != button:
                    otherbutton.unclick(self)

    def showMessage(self, message):
        def showStr(screen, text, x, y, height):
            font = pygame.font.Font('C:/Windows/Fonts/simhei.ttf', height)
            font_image = font.render(text, True, (0, 0, 255), (255, 255, 255))
            font_image_rect = font_image.get_rect()
            font_image_rect.x = x
            font_image_rect.y = y
            screen.blit(font_image, font_image_rect)
        if message == MESSAGE_TYPE.START:
            str = '嗨害害，干了兄弟们'
        elif message == MESSAGE_TYPE.GIVEUP:
            str = '对不起对不起马老师'
        elif message == MESSAGE_TYPE.TAKEBACK:
            str = '艾克开大啦'
        elif message == MESSAGE_TYPE.WIN:
            str = '获胜啦'
        else:
            str = '不讲武德'   
        showStr(self.screen, str, WIDTH/4*3, 10, 20)
        pygame.mouse.set_visible(True)
        pygame.display.flip()
        time.sleep(0.5)
    
class Draw():
    def __init__(self):
        self.chessLen = 15
    def DrawBasicelement(self, screen, buttons):
        pygame.draw.rect(screen, 'white', pygame.Rect(0, 0, WIDTH, NAVBARHEIGHT))
        pygame.draw.rect(screen, BOARDCOLOR, pygame.Rect(0, NAVBARHEIGHT, WIDTH, BOARDHEIGHT))
        for i in buttons:
            i.draw()
        self.drawBoard(screen)

    def drawBoard(self, screen):
        for y in range(CELLNUMBER):
            # draw a horizontal line
            start_pos, end_pos= (CELLSIZE//2, CELLSIZE//2 + CELLSIZE * y + NAVBARHEIGHT), (WIDTH - CELLSIZE//2, CELLSIZE//2 + CELLSIZE * y + NAVBARHEIGHT)
            if y == (CELLNUMBER)//2:
                linewidth = 2
            else:
                linewidth = 1
            pygame.draw.line(screen, 'black', start_pos, end_pos, linewidth)
        
            for x in range(CELLNUMBER):
                # draw a horizontal line
                start_pos, end_pos= (CELLSIZE//2 + CELLSIZE * x, CELLSIZE//2 + NAVBARHEIGHT), (CELLSIZE//2 + CELLSIZE * x, BOARDHEIGHT + NAVBARHEIGHT - CELLSIZE//2)
                if x == (CELLNUMBER)//2:
                    linewidth = 2
                else:
                    linewidth = 1
                pygame.draw.line(screen, 'black', start_pos, end_pos, linewidth)

            cell_size = 8
            pos = [(3,3), (11,3), (3, 11), (11,11), (7,7)]
            for (x, y) in pos:
                pygame.draw.rect(screen, 'black', (CELLSIZE//2 + x * CELLSIZE - cell_size//2, CELLSIZE//2 + y * CELLSIZE - cell_size//2 + NAVBARHEIGHT, cell_size, cell_size))

class Buttons():
    def __init__(self, screen, text, x, y, color, enable):
        self.screen = screen
        self.buttonColor = color
        self.enable = enable
        self.font = pygame.font.Font('C:/Windows/Fonts/simhei.ttf', BUTTONHEIGHT*2//3)
        self.text = text
        self.rect = pygame.Rect(x, y, BUTTONWIDTH, BUTTONHEIGHT)

    # 按钮信息设置
    def drawMessage(self):
        if self.enable:
            self.messageText = self.font.render(self.text, True, 'white', BUTTONCOLOR[0])
        else:
            self.messageText = self.font.render(self.text, True, 'white', BUTTONCOLOR[1])
        self.messageRect = self.messageText.get_rect()
        self.messageRect.center = self.rect.center
    
    def draw(self):
        if self.enable:
            self.screen.fill(BUTTONCOLOR[0], self.rect)
        else:
            self.screen.fill(BUTTONCOLOR[1], self.rect)
        self.drawMessage()
        self.screen.blit(self.messageText, self.messageRect)

class buttonStart(Buttons):
    def __init__(self, screen, text, x, y):
        super().__init__(screen, text, x, y, BUTTONCOLOR, True)

    def click(self, game):
        if self.enable:
            # game.start()
            game.winner = 0
            game.isplaying = True
            game.state = MESSAGE_TYPE.START
            self.messageText = self.font.render(self.text, True, 'white', BUTTONCOLOR[1])
            self.enable = False
            return True
        else:
            return False
    def unclick(self, game):
        if not self.enable:
            self.messageText = self.font.render(self.text, True, 'white', BUTTONCOLOR[0])
            self.enable = True

class buttonGiveUp(Buttons):
    def __init__(self, screen, text, x, y):
        super().__init__(screen, text, x, y, BUTTONCOLOR, True) 

    def click(self, game):
        if self.enable:
            game.winner = 0
            print('Give Up后winner为%d , is_win 为%d' % (game.winner, game.AI.is_win()))
            
            game.player = 1
            game.isplaying = False
            game.state = MESSAGE_TYPE.GIVEUP
            self.messageText = self.font.render(self.text, True, 'white', BUTTONCOLOR[1])
            self.enable = False
            return True
        return False
    def unclick(self, game):
        if not self.enable:
            self.messageText = self.font.render(self.text, True, 'white', BUTTONCOLOR[0])
            self.enable = True

class buttonTakeBack(Buttons):
    def __init__(self, screen, text, x, y):
        super().__init__(screen, text, x, y, BUTTONCOLOR, True)  

    def click(self, game):
        if self.enable:
            # game.start()
            # game.winner = None
            game.isTakeBack = True
            game.state = MESSAGE_TYPE.PLAYING
            self.messageText = self.font.render(self.text, True, 'white', BUTTONCOLOR[1])
            # self.enable = False
            return True
        return False
    def unclick(self, game):
        if not self.enable:
            self.messageText = self.font.render(self.text, True, 'white', BUTTONCOLOR[0])
            self.enable = True

class buttonCheat(Buttons):
    def __init__(self, screen, text, x, y):
        super().__init__(screen, text, x, y, BUTTONCOLOR, True) 

    def click(self, game):
        if self.enable:
            # game.start()
            # game.winner = None
            game.state = MESSAGE_TYPE.CHEAT
            self.messageText = self.font.render(self.text, True, 'white', BUTTONCOLOR[1])
            self.enable = False
            return True
        return False
    def unclick(self, game):
        if not self.enable:
            self.messageText = self.font.render(self.text, True, 'white', BUTTONCOLOR[0])
            self.enable = True

class Board():
    def __init__(self):
        self.chessMap = [[0 for x in range(15)] for y in range(15)]
        self.chessList = []
    
    # 重置棋盘
    def boardReset(self):
        for y in range(15):
            for x in range(15):
                self.chessMap[y][x] = 0
        self.chessList = []
        # print('重置', self.chessMap, self.chessList)

    def exchange(self, player):
        if player == 1:
            return 2
        else:
            return 1
    
    def placeChess(self, x, y, player, game):    
        if game.isTakeBack and self.chessList:
            self.chessMap[game.last_y][game.last_x] = 0
            del(self.chessList[-1])
            game.isTakeBack = False
        elif game.isTakeBack and not self.chessList:
            self.chessMap[y][x] = 0
            game.isTakeBack = False
        else:
            self.chessMap[y][x] = player
            self.chessList.append((x,y))
            game.last_x, game.last_y =self.chessList[-1][0], self.chessList[-1][1]
        
        print('已经下了的棋', self.chessList)
        print('Last_xy%d, %d' % (game.last_x, game.last_y))

    def drawChess(self, screen):
        color = ['black', 'white']
        textcolor = ['white', 'black']
        font = pygame.font.Font('C:/Windows/Fonts/simhei.ttf', CELLSIZE*2//3)
        for i in range(len(self.chessList)):
            x, y = self.chessList[i]
            position = self.IndexToPos(x, y)
            # 当前棋子的玩家1,2
            player = self.chessMap[y][x] - 1
            pygame.draw.circle(screen, color[player], position, CELLSIZE//2)
            
            msg_image = font.render(str(i), True, textcolor[player], color[player])
            
            msg_image_rect = msg_image.get_rect()
   
            msg_image_rect.center = position
            screen.blit(msg_image, msg_image_rect)

    def PosToIndex(self, pos_x, pos_y):
        x = (pos_x)//CELLSIZE
        y = (pos_y - NAVBARHEIGHT)//CELLSIZE
        return (x, y)
    def IndexToPos(self, x, y):
        pos_x = x * CELLSIZE + CELLSIZE//2
        pos_y = NAVBARHEIGHT + y * CELLSIZE + CELLSIZE//2
        return (pos_x, pos_y)

    def isEmpty(self, x, y):
        if self.chessMap[y][x] == 0:
            print('x = %d, y = %d 空的 ' % (x, y))
            return True
        else:
            print('x = %d, y = %d 不空 ' % (x, y))
            return False