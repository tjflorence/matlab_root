% creates patterns of diag alternate orientation
% creates bi-diagonal pattern
bars    = repmat([ones(32,8),zeros(32,8)],1,4);
diagonal = [bars(1,:)];
for f   = 1:47
    diagonal    = [diagonal ; circshift(bars(1,:),[0,f])];
end

diagonal        = [diagonal fliplr(diagonal)];
diagonal = diagonal(1:32, 1:32)
stripes = repmat([ones(8,32); zeros(8,32)], 2,1)
bars = bars(1:32, 1:32);
PL_pat = [bars, diagonal, stripes]