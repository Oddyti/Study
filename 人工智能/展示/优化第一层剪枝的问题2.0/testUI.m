function five()
 
figure(1);
axis([0 17 0 17]);
hold on
axis off
axis equal
for i = 1:16%??????
    line([1 16],[i i]);
    line([i i],[1 16]);
end


qishou = 1; % ???????????????????????¡À?¨°???¨¬??????0?¡À??????
boardstatus = zeros(15);% ????¡Á??????¨®????0????????1???¨¬????2????
 
 
while 1
    hold on
    posflag = 1;  % ????????????????¡¤????¡ì????1???¡Â?????????¡ì??????????
    while posflag
        [xpos,ypos] = ginput(1);
        xpos = 0.5*(floor(xpos)+ceil(xpos));
        ypos = 0.5*(floor(ypos)+ceil(ypos));
        if xpos<=0.5||xpos>=16||ypos<=0.5||ypos>=16% ????????????
            continue;
        end        
        rx = floor(xpos);
        ry = floor(ypos);
        if boardstatus(rx,ry)==1||boardstatus(rx,ry)==2%??????????????¡Á?
            continue;
        end        
        posflag = 0;
    end
        
    if qishou==1
        drawthego(xpos,ypos,qishou);
        boardstatus(rx,ry)=1;
        qishou = 0;
    else
        drawthego(xpos,ypos,qishou);
        boardstatus(rx,ry)=2;
        qishou = 1;
    end

    % if iswin(boardstatus,rx,ry)
    %     if qishou==1
    %         winmsg = 'Black Win!!';
    %     else
    %         winmsg =' Red Win!!';
    %     end
    %     msgbox(winmsg)
    %     return
    %     % ??????¡Á?????????????????????????
    % end
    % axis([0 17 0 17]);
    % axis equal
end
 
% figure(1)
% axis([0 16 0 15]);
% axis equal
 
function drawthego(x,y,flag)
    t = 0:pi/100:2*pi;
    rx = x+0.5*cos(t);
    ry = y+0.5*sin(t);
    if flag==1
        fill(rx,ry,'w');
    else
        fill(rx,ry,'k');
    end
 
% function w = iswin(board,x,y)
% % ??????¡¤?????
% w = 0;
 
% if isempty(find(board)==0)
%     w=2;%?????????¨²??????????????
%     return;
% end
 
% flag = board(x,y);% ????????
 
% %??????y??
% k = 0; % ??????????????????????
% for i = x:10
%     if board(i,y)~=flag
%         break
%     end
%     k = k+1;
% end
% if k>=5
%     w=1;
%     return
% end
% for i = x-1:-1:1
%     if board(i,y)~=flag
%         break;
%     end
%     k = k+1;
% end
% if k>=5
%     w=1;
%     return
% end
 
% % ??????x??
% k = 0;
% for i = y:10
%     if board(x,i)~=flag
%         break;
%     end
%     k = k+1;
% end
% if k>=5
%     w=1;
%     return
% end
% for i = y-1:-1:1
%     if board(x,i)~=flag
%         break;
%     end
%     k = k+1;
% end
% if k>=5
%     w=1;
%     return
% end
 
% % ?????¡Â??????
% k = 0;
% for i = 0:10
%     if x+i>10
%         break
%     end
%     if y+i>10
%         break;
%     end
%     if board(x+i,y+i)~=flag
%         break;
%     end
%     k = k+1;
% end
% if k>=5
%     w=1;
%     return
% end
% for i = 1:10
%     if x-i<0
%         break;
%     end
%     if y-i<0
%         break;
%     end
%     if board(x-i,y-i)~=flag
%         break;
%     end
%     k = k+1;
% end
% if k>=5
%     w=1;
%     return
% end
 
% % ?????¡À??????
% k = 0;
% for i = 0:10
%     if x-i<0
%         break;
%     end
%     if y+i>10
%         break;
%     end
%     if board(x-i,y+i)~=flag
%         break;
%     end
%     k = k+1;
% end
% if k>=5
%     w=1;
%     return
% end
% for i = 1:10
%     if x+i>10
%         break;
%     end
%     if y-i<0
%         break;
%     end
%     if board(x+i,y-i)~=flag
%         break;
%     end
%     k = k+1;
% end
% if k>=5
%     w=1;
%     return
% end