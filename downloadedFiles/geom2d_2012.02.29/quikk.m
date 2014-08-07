e1_centerX = 25+3;
e2_centerX = 73-3;

e1_centerY = 16.5;
e2_centerY = 16.5;

a = 24;
b = 16;



figure
[vertStruct]=hextile([1 1 96 32], 1)



for aa = 1:length(vertStruct)
    
    index = [nan nan];
    try
        vertStruct(aa).val = filter( floor(vertStruct(aa).xy(2)*100), floor(vertStruct(aa).xy(1)*100) );
    
        if  ( (vertStruct(aa).xy(1)-e1_centerX) /a)^2 + ( (vertStruct(aa).xy(2)-e1_centerY) /b)^2 < 1.2||  ( (vertStruct(aa).xy(1)-e2_centerX) /a)^2 + ( (vertStruct(aa).xy(2)-e2_centerY) /b)^2 < 1.2
        
            hold on
            fill(vertStruct(aa).xvals, vertStruct(aa).yvals, vertStruct(aa).val*ones(1,3))
        end
    catch
        
    end
end