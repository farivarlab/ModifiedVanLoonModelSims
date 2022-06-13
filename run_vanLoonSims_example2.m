clear all
close all
%% Params default
p.I       = 1;
p.gamma   = 3;
p.sigma   = 0.010; %0.003
p.alpha   = 4;
p.tau     = 125;
p.sigmoidParam(1) = 0.5;
p.sigmoidParam(2) = 18;
p.sigmoidParam(3) = 1;
p.endTime = 1000;

p.startingI = [1 1];
p.startingA = [0.15 0.15];


%% Params ranges
curP = p;
%             curP.(char(param)) = pR.(char(param))(i);
curP.I      = [curP.I     curP.I    ];
curP.sigma  = [curP.sigma curP.sigma];
curP.tau    = [curP.tau   curP.tau  ];
curP.gamma  = [curP.gamma curP.gamma];
curP.alpha  = [4 curP.alpha];

tic
[times,Var] = vanLoonSim(curP);
plot_vanLoonSims(length(times)-1,1,times,Var)
f1 = gcf;
delete(f1.Children(1))
delete(f1.Children(1).Title);
f1.Children(1).Color = 'none';
f1.Color = 'none';
saveas(f1,fullfile('C:\Users\el_ba\McGill University\Farivar Lab - Sebastien\Defense\GABA',...
    ['ts__gamma_' num2str(curP.gamma(1)) '_' num2str(curP.gamma(2)) '__alpha_' num2str(curP.alpha(1)) '_' num2str(curP.alpha(2)) '.svg']))
return




toc

xMin = 0.4;
xMax = 1;
if 0
    x1 = Var(times>60,1);
    x2 = Var(times>60,2);
    d = 1000;
    gridx = linspace(min([xMin; x1; x2]),max([x1; x2; xMax]),d);
    gridi = 1:1:d;
    [x1,x2] = meshgrid(gridx, gridx);
    [i1,i2] = meshgrid(gridi, gridi);
    x1 = x1(:);
    x2 = x2(:);
    xi = [x1 x2];
    i1 = i1(:);
    i2 = i2(:);
    i = [i1 i2];
    v1 = Var(:,1);
    v2 = Var(:,2);
    v = [v1 v2];
    [v,xi] = ksdensity(v,xi);
    v = full( sparse(i(:,1), i(:,2), v, d, d) );
    i1 = full( sparse(i(:,1), i(:,2), i(:,1), d, d) );
    i2 = full( sparse(i(:,1), i(:,2), i(:,2), d, d) );
    i1 = i1(:,1);
    i2 = i2(1,:)';
    x1 = full( sparse(i(:,1), i(:,2), xi(:,1), d, d) );
    x2 = full( sparse(i(:,1), i(:,2), xi(:,2), d, d) );
    x1 = x1(:,1);
    x2 = x2(1,:)';
    save(mfilename,'x1','x2','v')
end
load(mfilename,'x1','x2','v')
f2 = figure('WindowStyle','docked');
hIm = imshow(repmat(uint8(zeros(size(v))),[1 1 3]));
v = v - min(v(:));
v = v./max(v(:));
hIm.AlphaData = v;
f2.Color = 'w';
ax = gca;
ax.Color = 'none';
ax.XAxis.Visible = 'on';
ax.YAxis.Visible = 'on';
ax.YDir = 'normal';


ax.YTick = interp1(x1,1:length(x1),xMin:0.1:xMax);
ax.YTickLabel = cellstr(num2str((xMin:0.1:xMax)'));
ax.XTick = ax.YTick;
ax.XTickLabel = ax.YTickLabel;
grid on

f3 = figure('WindowStyle','docked');
plot(Var(times>60,1:2))
ylim([xMin xMax])
grid on
ax = gca;
ax.XGrid = 'off';


return

x1 = Var(times>60,1);
    x2 = Var(times>60,2);
    

%% clean
figure(f1)
delete(f1.Children(1))
tmp = axes();
f1.Children(2).Position = tmp.Position;
delete(tmp)



return



%     figure('WindowStyle','docked'); hold on
%     subplot(2,1,1)
% %     plot(times,sigmoid(sigmoidParam,Var(:,1:2)))
%     plot(times,Var(:,1:2))
%     Xdiff = max(diff
