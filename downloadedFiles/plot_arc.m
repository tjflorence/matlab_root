function plot_arc(a,b,h,k,r,L,g)
% Plot a circular arc as a pie wedge.
% a is start of arc in radians, 
% b is end of arc in radians, 
% (h,k) is the center of the circle.
% L is linewidth
% r is the radius.
% Try this:   plot_arc(pi/4,3*pi/4,9,-4,3)
% Author:  Matt Fig
t = linspace(a,b);
x = r*cos(t) + h;
y = r*sin(t) + k;
plot(x,y, 'LineWidth', L, 'color', g)
%x = [x h x(1)];
%y = [y k y(1)];
%P = fill(x,y,'r');
%axis([h-r-1 h+r+1 k-r-1 k+r+1]) 
%axis square;
%if ~nargout
%    clear P
%end


%Now from the command line:
%P = plot_arc(pi/4,3*pi/3,9,-4,3);
%set(P,'edgecolor','b','linewidth',4)