function Plot_Table_by_Time(Table, plotName, marky)
names = struct('InOut','in-out','UpDown','up-down','LeftRight',...
    'left-right','Walk','Walking','Jump','Jumping');
frame_rate = 1/100;
tot_time = size(Table,1) * frame_rate;
time_vec = frame_rate:frame_rate:tot_time;
if nargin == 2
    marky = 1;
end
pos = [0 0 0.5 1];        % [ _ _ right upper]
lgndFontsize = 12;
lineW = 1;
labelFont = 15;
fig = figure('name',plotName,'Units','normalized','Position',pos);
plot(time_vec', Table.LINEAR_ACC_X, 'LineWidth', lineW)
hold on
plot(time_vec', Table.LINEAR_ACC_Y, 'LineWidth', lineW*marky)
plot(time_vec', Table.LINEAR_ACC_Z, 'LineWidth', lineW)
hold off
title(getfield(names,plotName), 'fontsize',labelFont*1.5);
ylabel('Accelaration [$\frac{m}{sec^2}$]', 'Interpreter','latex',... 
    'fontsize',labelFont);
xlabel('Time [s]', 'Interpreter','latex', 'fontsize',labelFont);
Lgnd1 = legend('$X$', '$Y$', '$Z$');
Lgnd1.Interpreter = 'latex';
Lgnd1.Location = 'northeastoutside';
Lgnd1.FontSize = lgndFontsize;
figName = ['/figures/',plotName,'.fig'];
    saveas(fig, [pwd figName]);
end
