function [circle_pos,circPls, ray_dist] = sample_wall_positions_circ_elev_V4(X_position, Y_position, cur_Th, num_ang_samples,  displayWidth, init)
% based on code that simulated flying through fly-o-rama, under name of
% sample_wall_positions_flyorama_circ
% X_position, Y_position are locations within the virtual environemnt, a
% cicrle. By convention the circle has radius =1, so these are [-1:1]. 
% function shifts the image using cur_Th;


for j = 1:length(init.theta)
    %[num_int, p] = circle_imp_line_par_int_2d ( arena_radius, [0 0], X_position, Y_position, cos(theta(j)), sin(theta(j)) );
    %[num_int, p] = circle_imp_line_par_int_2d_ZC ( arena_radius, X_position, Y_position, cos(theta(j)), sin(theta(j)) );
    %[num_int, p] = circle_imp_line_par_int_2d_ZCUnit (X_position, Y_position, cos(theta(j)), sin(theta(j)) );
    
    % embed the calculation of the line\circle intersection here, same as
    % calling function CIRCLE_IMP_LINE_PAR_INT_2D: ( implicit circle, parametric line ) intersection in 2D.
  %circle_imp_line_par_int_2d_ZCUnit (x0, y0, f, g)  
  f = cos(init.theta(j)); g = sin(init.theta(j));
  root = ( f^2 + g^2 ) - ( f * ( - Y_position ) - g * ( - X_position ) ).^2;

  if ( root < 0.0 ) % means point is outside of circle!



  elseif ( root == 0.0 ) % means point is on the circle!

    t = ( f * ( - X_position ) + g * ( - Y_position ) ) / ( f * f + g * g );
    init.x_circle_pos(j) = X_position + f * t;
    init.y_circle_pos(j) = Y_position + g * t;
    init.ray_dist(j)= (((X_position-init.x_circle_pos(j))^2)+((Y_position-init.y_circle_pos(j))^2))^.5;

  elseif ( 0.0 < root )


    t1 = ( ( f * ( - X_position ) + g * ( - Y_position ) ) ...
      - sqrt ( root ) ) / ( f * f + g * g );

    %p = [x0; y0] + [f;g]*t1; % somehow this version is slower!!
    init.x_circle_pos(j) = X_position + f * t1;
    init.y_circle_pos(j) = Y_position + g * t1;
    init.ray_dist(j)= (((X_position-init.x_circle_pos(j))^2)+((Y_position-init.y_circle_pos(j))^2))^.5;
  end
    

end

circle_positions = (atan2(init.y_circle_pos, init.x_circle_pos)); % relative to origin
circle_pos = mod((circle_positions)*180/pi, 360)*pi/180; %% all angles are zero to 2*pi
circle_pos(circle_pos == 2*pi) = 0;

cur_Th = pi/2 - mod(cur_Th, 2*pi); % keep it between 0 and 2*pi;
num_shifts = -round(init.num_angle_samples*cur_Th./(2*pi));
%circle_pos = circshift(circle_pos, [0 num_shifts]);
circle_pos=floor(((circshift(circle_pos, [0 num_shifts]))/(2*pi))*displayWidth*7);
circPls = circle_pos+1;
ray_dist = single(circshift(init.ray_dist, [0 num_shifts]));
