% stars is ther index of the stars we want to show
function Plot_HeelStrike(Table, plotName, Axis, Norm, stars, StepStars, LableStars)
names = struct('InOut','in-out','UpDown','up-down','LeftRight',...
    'left-right','Walk','Walking','Jump','Jumping');
frame_rate = 1/100;
tot_time = size(Table,1) * frame_rate;
time_vec = frame_rate:frame_rate:tot_time;
starsize = 12;
if nargin == 4
    stars = -1;
end
if Norm
    Table.LINEAR_ACC_X = Table.LINEAR_ACC_X/ max(Table.LINEAR_ACC_X);
    Table.LINEAR_ACC_Y = Table.LINEAR_ACC_Y/ max(Table.LINEAR_ACC_Y);
    Table.LINEAR_ACC_Z = Table.LINEAR_ACC_Z/ max(Table.LINEAR_ACC_Z);
end
maxy = max(max(max(Table.LINEAR_ACC_X), max(Table.LINEAR_ACC_Y)),max(Table.LINEAR_ACC_Z));
    
pos = [0 0 0.5 1];        % [ _ _ right upper]
lgndFontsize = 12;
lineW = 1;
labelFont = 15;
fig = figure('name',plotName,'Units','normalized','Position',pos);
plot(time_vec', Table.LINEAR_ACC_X, 'LineWidth', lineW)
hold on
plot(time_vec', Table.LINEAR_ACC_Y, 'LineWidth', lineW*2)
plot(time_vec', Table.LINEAR_ACC_Z, 'LineWidth', lineW)
if contains(Axis, 'x')
    Zeros_X = find_zeros(Table.LINEAR_ACC_X, stars);
    plot(time_vec(Zeros_X)', zeros(size(Zeros_X)),'pentagram', ...
        'MarkerFaceColor','blue','MarkerSize',starsize)
    for l = 1:length(StepStars)
        xx = time_vec(Zeros_X(StepStars(l)));
        if mod(l,2) == 0
            scale = 0.9;
            colr = '#7E2F8E';
        else
            scale = 0.85;
            colr = '#A2142F';
        end
        xline(xx, '--','Color', colr, 'LineWidth', 2);
        text(xx, maxy*scale, ['\leftarrow',LableStars{l}]);
    end
end
if contains(Axis, 'y')
    Zeros_Y = find_zeros(Table.LINEAR_ACC_Y, stars);
    plot(time_vec(Zeros_Y)', zeros(size(Zeros_Y)),'pentagram', ...
        'MarkerFaceColor','red','MarkerSize',starsize)
    for l = 1:length(StepStars)
        xx = time_vec(Zeros_Y(StepStars(l)));
        if mod(l,2) == 0
            scale = 0.9;
            colr = '#7E2F8E';
        else
            scale = 0.85;
            colr = '#A2142F';
        end
        xline(xx, '--','Color', colr, 'LineWidth', 2);
        text(xx, maxy*scale, ['\leftarrow',LableStars{l}]);
    end
end
if contains(Axis, 'z')
    Zeros_Z = find_zeros(Table.LINEAR_ACC_Z, stars);
    plot(time_vec(Zeros_Z)', zeros(size(Zeros_Z)),'pentagram', ...
        'MarkerFaceColor','yellow','MarkerSize',starsize)
    for l = 1:length(StepStars)
        xx = time_vec(Zeros_Z(StepStars(l)));
        if mod(l,2) == 0
            scale = 0.9;
            colr = '#7E2F8E';
        else
            scale = 0.85;
            colr = '#A2142F';
        end
        xline(xx, '--','Color', colr, 'LineWidth', 2);
        text(xx, maxy*scale, ['\leftarrow',LableStars{l}]);
    end
end
% jump
begingJumps = [1.2, 10.6];
endJumps = [3.2, 12.6];
for j = 1:2
    xline(begingJumps(j), ':','Color', '#EDB120', 'LineWidth', 2.3);
    text(begingJumps(j), maxy*0.9, {'\leftarrow beging of jump',...
        [' t = ',num2str(begingJumps(j)), '[s]']});
    xline(endJumps(j), ':','Color', '#EDB120', 'LineWidth', 2.3);
    text(endJumps(j), maxy*0.9, {'\leftarrow end of jump',...
        [' t = ',num2str(endJumps(j)),'[s]']});
end

hold off
title(getfield(names,plotName), 'fontsize',labelFont*1.5);
ylabel('Accelaration [$\frac{m}{sec^2}$]', 'Interpreter','latex',... 
    'fontsize',labelFont);
xlabel('Time [s]', 'Interpreter','latex', 'fontsize',labelFont);
Lgnd1 = legend('$X$', '$Y$', '$Z$', [Axis,'=0']);
Lgnd1.Interpreter = 'latex';
Lgnd1.Location = 'northeastoutside';
Lgnd1.FontSize = lgndFontsize;
figName = ['/figures/',plotName,'.fig'];
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