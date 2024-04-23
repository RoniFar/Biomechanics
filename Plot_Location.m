function Plot_Location(Table, plotName,Axis, Lim)
names = struct('InOut','in-out','UpDown','up-down','LeftRight',...
    'left-right','Walk','Walking','Jump','Jumping');
frame_rate = 1/100;
tot_time = size(Table,1) * frame_rate;
time_vec = frame_rate:frame_rate:tot_time;
% time_vec = frame_rate+Lim(1):frame_rate:Lim(2);
if nargin == 4
    ind1 = find(time_vec <= Lim(1));
    ind1 = ind1(end);
    ind2 = find(time_vec <= Lim(2));
    ind2 = ind2(end);
    window = ind1:ind2;
else
    window = 1:size(Table,1);
end
pos = [0 0 0.5 1];        % [ _ _ right upper]
lgndFontsize = 12;
lineW = 1;
labelFont = 15;
count = 1;
legtxt = {};
fig = figure('name',plotName,'Units','normalized','Position',pos);
if contains(Axis,'x')
    plot(time_vec(window)', Table.LINEAR_ACC_LOC_X(window), 'LineWidth', lineW)
    legtxt{count} = 'X';
    count = count +1;
end
hold on
if contains(Axis,'y')
    plot(time_vec(window)', Table.LINEAR_ACC_LOC_Y(window), 'LineWidth', lineW)
    legtxt{count} = 'Y';
    count = count +1;
end
if contains(Axis,'z')
    plot(time_vec(window)', Table.LINEAR_ACC_LOC_Z(window), 'LineWidth', lineW)
    legtxt{count} = 'Z';
    count = count +1;
end
hold off
dist = Table.LINEAR_ACC_LOC_X(ind2) - Table.LINEAR_ACC_LOC_X(ind1);
title([getfield(names,plotName), ', Step Size = ', num2str(dist)], ...
    'fontsize',labelFont*1.5);
ylabel('Location [m]', 'fontsize',labelFont);
xlabel('Time [s]', 'Interpreter','latex', 'fontsize',labelFont);
Lgnd1 = legend(legtxt);
Lgnd1.Interpreter = 'latex';
Lgnd1.Location = 'northeastoutside';
Lgnd1.FontSize = lgndFontsize;
figName = ['/figures/',plotName,'_location.fig'];
    saveas(fig, [pwd figName]);
end