clear ;     %clear all variables
close all;  %close all figuTimeOn
clc;        %clear command window

dir data;
InOut = readtable('data/inout.xls');
LeftRight = readtable('data/leftright.xls');
UpDown = readtable('data/updown.xls');
Walk = readtable('data/walk.xls');
Jump = readtable('data/jump.xls');

%%
stars2keep_walk = [4,5,6,16,17,18,19,20,21,22,23,24,25,26,31,32,33,34,35];
stras2lineup = [4,6,8,10,12];
label2lineup = {'Heel Strike', 'Toe Off', 'Heel Strike','Toe Off', 'Heel Strike'};

new_stars = [5.01, 5.79, 6.55, 7.19, 8.1];

%%
All_InOut = get_all_data(InOut);
All_LeftRight = get_all_data(LeftRight);
All_UpDown = get_all_data(UpDown);
All_Walk = get_all_data(Walk);
All_Jump = get_all_data(Jump);

%%
Plot_Table_by_Time(All_InOut, 'InOut');
Plot_Table_by_Time(All_LeftRight, 'LeftRight');
Plot_Table_by_Time(All_UpDown, 'UpDown');

%%
Plot_Table_by_Time(All_Jump, 'Jump',2);
%%
Plot_HeelStrike(All_Walk, 'Walk', 'y',false, stars2keep_walk, stras2lineup, label2lineup);
%%
Plot_AngularACC(All_Walk, 'Walk', 'y',new_stars, label2lineup);
%%
Plot_Location(All_Walk, 'Walk','x',new_stars([1,3]));
%% filtering
ALL_DATA = applyButterworthFilterTable({All_InOut,All_LeftRight,All_UpDown,All_Walk,All_Jump}, 2, 10);
[All_InOut_F,All_LeftRight_F,All_UpDown_F,All_Walk_F,All_Jump_F] = ALL_DATA{:};

Loc_Vel_All = get_Vel_Loc_data(All_Walk_F);

