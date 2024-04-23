% stars is ther index of the stars we want to show
function Plot_AngularACC(Table, plotName, Axis, StepStars, LableStars)
names = struct('InOut','in-out','UpDown','up-down','LeftRight',...
    'left-right','Walk','Walking','Jump','Jumping');
frame_rate = 1/100;
tot_time = size(Table,1) * frame_rate;
time_vec = frame_rate:frame_rate:tot_time;
starsize = 12;

maxy = max(max(max(Table.GYROSCOPE_X), max(Table.LINEAR_ACC_Y)),max(Table.LINEAR_ACC_Z));
    
pos = [0 0 0.5 1];        % [ _ _ right upper]
lgndFontsize = 12;
lineW = 0.5;
labelFont = 15;
fig = figure('name',plotName,'Units','normalized','Position',pos);
plot(time_vec', Table.GYROSCOPE_X, 'LineWidth', lineW*6)
hold on
plot(time_vec', Table.LINEAR_ACC_Y,'LineWidth', lineW*4)
for l = 1:length(StepStars)
    if mod(l,2) == 0
        scale = 0.9;
        colr = '#7E2F8E';
    else
        scale = 0.85;
        colr = '#A2142F';
    end
    xline(StepStars(l), '--','Color', colr, 'LineWidth', 1.5);
    text(StepStars(l), maxy*scale, ['\leftarrow',LableStars{l}]);
end


hold off
title(getfield(names,plotName), 'fontsize',labelFont*1.5);
ylabel('Accelaration', 'fontsize',labelFont);
xlabel('Time [s]', 'Interpreter','latex', 'fontsize',labelFont);
Lgnd1 = legend('X Angular Accelaration [$\frac{degree}{sec}$]', 'Y Accelaration [$\frac{m}{sec^2}$]');
Lgnd1.Interpreter = 'latex';
Lgnd1.Location = 'northeastoutside';
Lgnd1.FontSize = lgndFontsize;
figName = ['/figures/',plotName, '_Angular.fig'];
    saveas(fig, [pwd figName]);
 end

function [Zeros_Vec] = find_zeros(Vec,mask)
Zeros_Vec = [];
% Zeros_Vec = find(Vec<lim & Vec>-lim);
count = 1;
for k = 2:length(Vec)
    if sign(Vec(k)) ~= sign(Vec(k-1))
        Zeros_Vec(count) = k;
        count = count + 1;
    end
end
if mask ~= -1
    Zeros_Vec = Zeros_Vec(mask);
end
end