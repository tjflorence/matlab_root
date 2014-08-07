function drawArena(centerX, centerY,radius, pattern)
%% this function takes a 32x96 array of pixel intensity values
% and renders a mock-up of the arena display

radius = 900;
centerX = 900;
centerY = 900;

rowVec = linspace(1.1, 1.3, 32);
columnVec = linspace((2*pi)/96, 2*pi, 96);


for yy = 1:32
    circle([centerX centerY],radius*rowVec(yy),1000,'g',5)
    hold on
end


for yy = 1:32
    for xx = 1:96
        if pattern(yy,xx) == 0
            plot_arc(columnVec(xx),columnVec(xx),centerX,centerY,radius*rowVec(yy),9,'k')
        else
            plot_arc(columnVec(xx),columnVec(xx),centerX,centerY,radius*rowVec(yy),9,'g')            
        end
    end
end

hold off