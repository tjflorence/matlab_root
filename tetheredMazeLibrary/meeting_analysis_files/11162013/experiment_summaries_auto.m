leftGo_hitPercent  = [];
rightGo_hitPercent = [];
randoGo_hitPercent = [];
gcampLgo_hitPercent  = [];

leftGo_fracCool  = [];
rightGo_fracCool = [];
randoGo_fracCool = [];
gcampLgo_fracCool = [];


%% left go
leftGo(1).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-28/20132810194715_stimulusTest';
leftGo(1).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-28/20132810201136_stimulusTest';

leftGo(2).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-29/20132910154254_stimulusTest';
leftGo(2).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-29/20132910161323_stimulusTest';

leftGo(3).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-03/20130311130722_stimulusTest';
leftGo(3).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-03/20130311135745_stimulusTest';

leftGo(4).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-03/20130311160224_stimulusTest';
leftGo(4).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-03/20130311164134_stimulusTest';

leftGo(5).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-04/20130411154539_stimulusTest';
leftGo(5).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-04/20130411161122_stimulusTest';

leftGo(6).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-04/20130411174053_stimulusTest';
leftGo(6).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-04/20130411181037_stimulusTest';

leftGo(7).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-04/20130411193057_stimulusTest';
leftGo(7).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-04/20130411200634_stimulusTest';

leftGo(8).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-04/20130411204659_stimulusTest';
leftGo(8).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-04/20130411212221_stimulusTest';

leftGo(9).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-05/20130511101710_stimulusTest';
leftGo(9).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-05/20130511104735_stimulusTest';

leftGo(10).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-05/20130511125158_stimulusTest';
leftGo(10).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-05/20130511132859_stimulusTest';

leftGo(11).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-05/20130511171145_stimulusTest';
leftGo(11).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-05/20130511174203_stimulusTest';

leftGo(12).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-08/20130811162423_stimulusTest';
leftGo(12).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-08/20130811164606_stimulusTest';

leftGo(13).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-08/20130811173315_stimulusTest';
leftGo(13).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-08/20130811175421_stimulusTest';

leftGo(14).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-08/20130811182315_stimulusTest';
leftGo(14).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-08/20130811184912_stimulusTest';

leftGo(15).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-08/20130811193850_stimulusTest';
leftGo(15).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-08/20130811200320_stimulusTest';

leftGo(16).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-08/20130811204325_stimulusTest';
leftGo(16).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-08/20130811212051_stimulusTest';

leftGo(17).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-14/20131410130504_stimulusTest';
leftGo(17).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-14/20131410134944_stimulusTest';

leftGo(18).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-14/20131410143753_stimulusTest';
leftGo(18).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-14/20131410150813_stimulusTest';

leftGo(19).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-14/20131410161247_stimulusTest/';
leftGo(19).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-14/20131410165257_stimulusTest/';

leftGo(20).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-15/20131510101225_stimulusTest/';
leftGo(20).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-15/20131510110517_stimulusTest/';

leftGo(21).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-15/20131510145208_stimulusTest/';
leftGo(21).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-15/20131510153114_stimulusTest/';

leftGo(22).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-16/20131610204018_stimulusTest/';
leftGo(22).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-16/20131610212518_stimulusTest/';

leftGo(23).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-16/20131610225626_stimulusTest/';
leftGo(23).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-16/20131610233853_stimulusTest/';



%% right go
rightGo(1).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-28/20132810154727_stimulusTest';
rightGo(1).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-28/20132810161625_stimulusTest';

rightGo(2).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-31/20133110105939_stimulusTest';
rightGo(2).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-31/20133110113049_stimulusTest';

rightGo(3).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-01/20130111140023_stimulusTest';
rightGo(3).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-01/20130111145325_stimulusTest';

rightGo(4).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-01/20130111153815_stimulusTest';
rightGo(4).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-01/20130111162415_stimulusTest';

rightGo(5).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111111539_stimulusTest';
rightGo(5).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111114536_stimulusTest';

rightGo(6).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111123720_stimulusTest';
rightGo(6).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111130503_stimulusTest';

rightGo(7).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111153332_stimulusTest';
rightGo(7).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111155247_stimulusTest';

rightGo(8).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111162019_stimulusTest';
rightGo(8).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111164342_stimulusTest';

rightGo(9).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111171057_stimulusTest';
rightGo(9).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111173344_stimulusTest';

rightGo(10).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111180828_stimulusTest';
rightGo(10).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111182835_stimulusTest';

rightGo(11).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111203329_stimulusTest';
rightGo(11).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111205822_stimulusTest';

rightGo(12).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111212321_stimulusTest';
rightGo(12).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111214609_stimulusTest';

rightGo(13).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111221225_stimulusTest';
rightGo(13).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111223738_stimulusTest';

rightGo(14).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-09-12/20131209173123_stimulusTest/';
rightGo(14).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-09-12/20131209175118_stimulusTest/';

rightGo(15).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-09-12/20131209191116_stimulusTest/';
rightGo(15).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-09-12/20131209193229_stimulusTest/';

rightGo(16).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-09-12/20131209200253_stimulusTest/';
rightGo(16).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-09-12/20131209202137_stimulusTest/';

rightGo(17).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-09-13/20131309110921_stimulusTest/';
rightGo(17).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-09-13/20131309113258_stimulusTest/';

rightGo(18).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-09-13/20131309132432_stimulusTest/';
rightGo(18).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-09-13/20131309134546_stimulusTest/';

rightGo(19).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-09-13/20131309155809_stimulusTest/';
rightGo(19).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-09-13/20131309161956_stimulusTest/';

rightGo(20).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-09-13/20131309164330_stimulusTest/';
rightGo(20).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-09-13/20131309171027_stimulusTest/';


%% rando
randoGo(1).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-29/20132910135201_stimulusTest';
randoGo(1).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-29/20132910143423_stimulusTest';

randoGo(2).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-31/20133110160210_stimulusTest';
randoGo(2).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-31/20133110164410_stimulusTest';

randoGo(3).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-03/20130311100149_stimulusTest';
randoGo(3).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-03/20130311111318_stimulusTest';

randoGo(4).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-12/20131211123810_stimulusTest';
randoGo(4).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-12/20131211132629_stimulusTest';

randoGo(5).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-12/20131211141207_stimulusTest';
randoGo(5).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-12/20131211144715_stimulusTest';

randoGo(6).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-12/20131211151820_stimulusTest';
randoGo(6).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-12/20131211155708_stimulusTest';

randoGo(7).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-12/20131211202646_stimulusTest';
randoGo(7).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-12/20131211211155_stimulusTest';

randoGo(8).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-12/20131211225440_stimulusTest';
randoGo(8).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-12/20131211234816_stimulusTest';

randoGo(9).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-14/20131411205207_stimulusTest';
randoGo(9).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-14/20131411211934_stimulusTest';

randoGo(10).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-14/20131411215022_stimulusTest';
randoGo(10).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-14/20131411221926_stimulusTest';

randoGo(11).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-14/20131411230957_stimulusTest';
randoGo(11).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-14/20131411235237_stimulusTest';

randoGo(12).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-15/20131511132934_stimulusTest';
randoGo(12).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-15/20131511142228_stimulusTest';

randoGo(13).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-15/20131511191512_stimulusTest';
randoGo(13).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-15/20131511200706_stimulusTest';

randoGo(14).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-17/20131710105700_stimulusTest';
randoGo(14).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-17/20131710112737_stimulusTest';

randoGo(15).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-17/20131710115816_stimulusTest';
randoGo(15).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-17/20131710122857_stimulusTest';

randoGo(16).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-17/20131710131440_stimulusTest';
randoGo(16).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-17/20131710134644_stimulusTest';

randoGo(17).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-20/20132010125507_stimulusTest';
randoGo(17).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-20/20132010133613_stimulusTest';

randoGo(18).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-20/20132010170509_stimulusTest';
randoGo(18).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-20/20132010174349_stimulusTest';

randoGo(19).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-20/20132010144630_stimulusTest';
randoGo(19).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-20/20132010154102_stimulusTest';

randoGo(20).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-20/20132010182946_stimulusTest';
randoGo(20).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-10-20/20132010190812_stimulusTest';

%% gcamp flies
gcampLgo(1).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-05/20130511202747_stimulusTest';
gcampLgo(1).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-05/20130511210114_stimulusTest';

gcampLgo(2).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-05/20130511213652_stimulusTest';
gcampLgo(2).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-05/20130511220805_stimulusTest';

gcampLgo(3).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-05/20130511223422_stimulusTest';
gcampLgo(3).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-05/20130511230851_stimulusTest';

gcampLgo(4).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-06/20130611125012_stimulusTest';
gcampLgo(4).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-06/20130611132149_stimulusTest';

gcampLgo(5).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-06/20130611135905_stimulusTest';
gcampLgo(5).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-06/20130611143550_stimulusTest';

gcampLgo(6).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-06/20130611154553_stimulusTest';
gcampLgo(6).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-06/20130611160937_stimulusTest';

gcampLgo(7).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-06/20130611210710_stimulusTest';
gcampLgo(7).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-06/20130611213109_stimulusTest';

gcampLgo(8).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-07/20130711152132_stimulusTest';
gcampLgo(8).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-07/20130711154928_stimulusTest';

gcampLgo(9).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-07/20130711171000_stimulusTest';
gcampLgo(9).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-07/20130711175513_stimulusTest';

%% symmetric pat
symPat(1).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-15/20131511214648_stimulusTest';
symPat(1).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-15/20131511222508_stimulusTest';

symPat(2).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-15/20131511225344_stimulusTest';
symPat(2).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-15/20131511232654_stimulusTest';

symPat(3).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-16/20131611141106_stimulusTest';
symPat(3).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-16/20131611144433_stimulusTest';

symPat(4).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-16/20131611152728_stimulusTest';
symPat(4).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-16/20131611162345_stimulusTest';

symPat(5).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711005656_stimulusTest';
symPat(5).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711013843_stimulusTest';

symPat(6).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711020853_stimulusTest';
symPat(6).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711024531_stimulusTest';

symPat(7).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711032840_stimulusTest';
symPat(7).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711040901_stimulusTest';

%% noise pat
noisePat(1).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711053530_stimulusTest';
noisePat(1).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711063039_stimulusTest';

noisePat(2).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711074010_stimulusTest';
noisePat(2).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711082222_stimulusTest';

noisePat(3).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711090507_stimulusTest';
noisePat(3).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711095531_stimulusTest';

noisePat(4).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711110825_stimulusTest';
noisePat(4).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711122955_stimulusTest';

for aa = 1:20;

    cd(rightGo(aa).tr1)
    load('summaryData.mat')
    
    hit_tr1         = summaryData.outcomeVec;
    fracCold_tr1    = summaryData.fracTimeCold;
    
    train_tr1       = hit_tr1(1:10);
    test_tr1        = hit_tr1(11:14);
    
    fracHit         = length(find(train_tr1 == 1))/10;
    frac_goRight    = length(find(test_tr1 == 3))/4;
    
    tr1_hitVec      = [fracHit frac_goRight];
    
    cd(rightGo(aa).tr2)
    load('summaryData.mat')
    
    hit_tr2         = summaryData.outcomeVec;
    fracCold_tr2    = summaryData.fracTimeCold;
    
    train_tr2       = hit_tr2(1:10);
    test_tr2        = hit_tr2(11:14);
    
    fracHit         = length(find(train_tr2 == 1))/10;
    frac_goRight    = length(find(test_tr2 == 3))/4;
    
    tr2_hitVec      = [fracHit frac_goRight];    
    
    
    experimentSum_hit   = [tr1_hitVec tr2_hitVec];
    experimentSum_frac  = [fracCold_tr1 fracCold_tr2];
    
    rightGo_hitPercent = [rightGo_hitPercent; experimentSum_hit];
    rightGo_fracCool   = [rightGo_fracCool; experimentSum_frac];
    
    
end



for aa = 1:20;

    cd(randoGo(aa).tr1)
    load('summaryData.mat')
    
    hit_tr1         = summaryData.outcomeVec;
    fracCold_tr1    = summaryData.fracTimeCold;
    
    train_tr1       = hit_tr1(1:10);
    test_tr1        = hit_tr1(11:14);
    
    fracHit         = length(find(train_tr1 == 1))/10;
    frac_goRight    = length(find(test_tr1 == 3))/4;
    
    tr1_hitVec      = [fracHit frac_goRight];
    
    cd(randoGo(aa).tr2)
    load('summaryData.mat')
    
    hit_tr2         = summaryData.outcomeVec;
    fracCold_tr2    = summaryData.fracTimeCold;
    
    train_tr2       = hit_tr2(1:10);
    test_tr2        = hit_tr2(11:14);
    
    fracHit         = length(find(train_tr2 == 1))/10;
    frac_goRight    = length(find(test_tr2 == 3))/4;
    
    tr2_hitVec      = [fracHit frac_goRight];    
    
    
    experimentSum_hit   = [tr1_hitVec tr2_hitVec];
    experimentSum_frac  = [fracCold_tr1 fracCold_tr2];
    
    randoGo_hitPercent = [randoGo_hitPercent; experimentSum_hit];
    randoGo_fracCool   = [randoGo_fracCool; experimentSum_frac];
    
    
end


for aa = 2:23;

    cd(leftGo(aa).tr1)
    load('summaryData.mat')
    
    hit_tr1         = summaryData.outcomeVec;
    fracCold_tr1    = summaryData.fracTimeCold;
    
    train_tr1       = hit_tr1(1:10);
    test_tr1        = hit_tr1(11:14);
    
    fracHit         = length(find(train_tr1 == 1))/10;
    frac_goLeft    = length(find(test_tr1 == 2))/4;
    
    tr1_hitVec      = [fracHit frac_goRight];
    
    cd(leftGo(aa).tr2)
    load('summaryData.mat')
    
    hit_tr2         = summaryData.outcomeVec;
    fracCold_tr2    = summaryData.fracTimeCold;
    
    train_tr2       = hit_tr2(1:10);
    test_tr2        = hit_tr2(11:14);
    
    fracHit         = length(find(train_tr2 == 1))/10;
    frac_goLeft    = length(find(test_tr2 == 2))/4;
    
    tr2_hitVec      = [fracHit frac_goLeft];    
    
    
    experimentSum_hit   = [tr1_hitVec tr2_hitVec];
    experimentSum_frac  = [fracCold_tr1 fracCold_tr2];
    
    leftGo_hitPercent = [leftGo_hitPercent; experimentSum_hit];
    leftGo_fracCool   = [leftGo_fracCool; experimentSum_frac];
    
    
end

for aa = 1:9;

    cd(gcampLgo(aa).tr1)
    load('summaryData.mat')
    
    hit_tr1         = summaryData.outcomeVec;
    fracCold_tr1    = summaryData.fracTimeCold;
    
    train_tr1       = hit_tr1(1:10);
    test_tr1        = hit_tr1(11:14);
    
    fracHit         = length(find(train_tr1 == 1))/10;
    frac_goLeft    = length(find(test_tr1 == 2))/4;
    
    tr1_hitVec      = [fracHit frac_goRight];
    
    cd(gcampLgo(aa).tr2)
    load('summaryData.mat')
    
    hit_tr2         = summaryData.outcomeVec;
    fracCold_tr2    = summaryData.fracTimeCold;
    
    train_tr2       = hit_tr2(1:10);
    test_tr2        = hit_tr2(11:14);
    
    fracHit         = length(find(train_tr2 == 1))/10;
    frac_goLeft    = length(find(test_tr2 == 2))/4;
    
    tr2_hitVec      = [fracHit frac_goLeft];    
    
    
    experimentSum_hit   = [tr1_hitVec tr2_hitVec];
    experimentSum_frac  = [fracCold_tr1 fracCold_tr2];
    
    gcampLgo_hitPercent = [gcampLgo_hitPercent; experimentSum_hit];
    gcampLgo_fracCool   = [gcampLgo_fracCool; experimentSum_frac];
    
    
end

f1 = figure('Color', 'w', 'units', 'normalized', 'Position', [.1 .1 .4 .6]);
rightGo_hitStd = nanstd(rightGo_hitPercent)/sqrt(20);
randoGo_hitStd = nanstd(randoGo_hitPercent)/sqrt(20);

plot([-100 100], [.5 .5], 'Color', 'k')
xlim([.75 4.25])
ylim([0 1.1])

hold on

z1 = scatter(1:4, nanmean(rightGo_hitPercent), 200)
set(z1, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'r', 'LineWidth', 4)
hold on
errorbar( nanmean(rightGo_hitPercent), rightGo_hitStd, 'r', 'LineWidth', 4)

z2 = scatter(1:4, nanmean(randoGo_hitPercent), 200)
set(z2, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k', 'LineWidth', 4)
hold on
errorbar( nanmean(randoGo_hitPercent), randoGo_hitStd, 'k', 'LineWidth', 4)

set(gca, 'XTick', [1 2 3 4], 'XTickLabel', {'train block 1' 'test block 1' 'train block 2' 'test block 2'}, 'YTick', [.25 .5 .75 1])
ylabel('found cool zone / chose right')

box off
