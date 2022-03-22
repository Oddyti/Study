import pygame
from pygame.locals import *
from Game import *
game = Game()
while True:
    game.playGame()
    pygame.display.update()
    # 循环获取事件，监听事件状态
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            exit()
        elif event.type == pygame.MOUSEBUTTONDOWN:
            mouse_x, mouse_y = pygame.mouse.get_pos()
            game.inButton(mouse_x, mouse_y)
            game.inCell(mouse_x, mouse_y)
            