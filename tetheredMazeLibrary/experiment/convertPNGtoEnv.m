function converted_env = convertPNGtoEnv(PNGname)
%% converts PNG file created in illustrator to fly VR env 
% requires 


%PNGname = 'train_to_7pm.png'
% load file into memory
[img] = imread([PNGname],  'BackgroundColor', [1 1 1]);


% find first x,y ~= 0 (because importer pads with black)
r_vals = (img(:,:, 1));
g_vals = (img(:,:, 2));
b_vals = (img(:,:, 3));

[y_pix, x_pix] = size(r_vals);

%% find first non-border pixel
found_pix = 0;
non_bg_x = [];
non_bg_y = [];
for xx = 1:x_pix
    for yy = floor(y_pix/2);
        if (r_vals(yy,xx) ~= 255 && ...
                g_vals(yy,xx) ~= 255 && ...
                b_vals(yy,xx) ~= 255 && ...
                found_pix == 0) 
            
            non_bg_x = [non_bg_x xx];
        end
    end 
end
 
for xx = floor(x_pix/2);
    for yy = 1:y_pix
        if (r_vals(yy,xx) ~= 255 && ...
                g_vals(yy,xx) ~= 255 && ...
                b_vals(yy,xx) ~= 255 && ...
                found_pix == 0) 
            
            non_bg_y = [non_bg_y yy];
        end
    end 
 end
corner_x = non_bg_x(1);
end_x = non_bg_x(end);
corner_y = non_bg_y(1);
end_y = non_bg_y(end);


r_vals = r_vals(corner_y:end_y, corner_x:end_x);
g_vals = g_vals(corner_y:end_y, corner_x:end_x);
b_vals = b_vals(corner_y:end_y, corner_x:end_x);

trim_img = nan(end_y-corner_y+1, end_x-corner_x+1, 3);
trim_img(:,:,1) = r_vals;
trim_img(:,:,2) = g_vals;
trim_img(:,:,3) = b_vals;

resized_mat = imresize(trim_img, [1800 1800], 'nearest');
resized_mat = round(resized_mat/255);
resized_r = resized_mat(:,:,1);
resized_g = resized_mat(:,:,2);
resized_b = resized_mat(:,:,3);

blank_mat = 5*ones(1800,1800);
for yy = 1:1800
    for xx = 1:1800
        r_val = resized_r(yy,xx);
        g_val = resized_g(yy,xx);
        b_val = resized_b(yy,xx);
    
        if r_val == 0 && g_val == 0 && b_val == 0
           blank_mat(yy,xx) = 1;
        elseif r_val == 0 && g_val == 0 && b_val == 1
            blank_mat(yy,xx) = 2;
        elseif r_val == 0 && g_val == 1 && b_val == 0
            blank_mat(yy,xx) = 3;
        elseif r_val == 1 && g_val == 0 && b_val == 0
            blank_mat(yy, xx) = 4;
        elseif r_val == 0 && g_val == 1 && b_val == 1
            blank_mat(yy, xx) = 5;
        elseif r_val == 1 && g_val == 0 && b_val == 1
            blank_mat(yy, xx) = 6;
        elseif r_val == 1 && g_val == 1 && b_val == 0
            blank_mat(yy, xx) = 7;
        end
    end
end


for yy = 1:1800
    for xx = 1:1800

        x_val = xx-900;
        y_val = yy-900;
        
        if sqrt( (x_val^2)+(y_val^2)) > 875
            if blank_mat(yy,xx)>2
                blank_mat(yy,xx) = 7;
            end
        end
    end
end
converted_env = flipud(blank_mat);
