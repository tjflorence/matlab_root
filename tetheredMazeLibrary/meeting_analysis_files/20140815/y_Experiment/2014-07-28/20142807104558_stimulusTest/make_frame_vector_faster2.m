function pat_vector = make_frame_vector_faster2(pattern, BitMapIndex,NumPanels,frame_pat)
% modified from make_pattern_vector...MBR (11.15.2010)
% modified make_frame_vector assuming gs_val3 and no row compression.  TAO
% (12.7.2010)
% modified to get rid of extraneous calculations. Many things can be
% initialized beforehand. Still a few changes to be made, ie i =
% 1:NumPanels can be made into a vector TJF (12.19.2011)
%
% relevant fields of pattern are - Pats, BitMapIndex, gs_val
% converts a Pats file of size (L,M,N,O), where L is the number of rows, 8
% per panel, M is the number of columns, 8 per panel, N is the number of
% frames in the 'x' dimmension, and O is the number of frames in the 'y' dimmension
% to an array of size L/8, M/8, N*O stored as: Pannel, Frame, PatternData 
% here we flatten the 2D pattern array to a 1 D array using the formula 
% Pattern_number = (index_y - 1)*N + index_x;
global binvals

% do the actual work of turning into a pattern

for i = 1:NumPanels
    % capture the panel bitmap for frame Pattern_number and panel i
    PanMat = pattern(BitMapIndex(i).row_range, BitMapIndex(i).column_range);
    
        for k = 1:8
            % code below is perfectly general - just treat gs = 1, separately to speed up.
                
                vec = PanMat(:,k)'; 
                out = gs2vec2dec_fast3(vec, binvals.bin_val, binvals.bin2dec_mat);
                
                for num_g = 1:3 % 1:gs_val
                   frame_pat(i,k + (8*(num_g-1))) = out(num_g);
                end % for
           
        end % for
    
end

% rearrange the data so we can read this as columnwise vector data - 
temp_matrix = frame_pat';
pat_vector = temp_matrix(:);
