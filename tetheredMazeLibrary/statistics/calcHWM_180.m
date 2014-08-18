function hw = calcHWM_180(n)

numSamples = sum(n);
numDivs = length(n);

middleInt = median(1:length(n));
sampleFromMid = 0;
fracTheta = 0;

while fracTheta < .5
    
    sampleFromMid = sampleFromMid+1;
   
    nVals = sum(n((middleInt-sampleFromMid):(middleInt+sampleFromMid)));
    fracTheta = nVals/numSamples;
    
end

fracOfCircle = (2*sampleFromMid)/length(n);

hw = fracOfCircle*(pi);