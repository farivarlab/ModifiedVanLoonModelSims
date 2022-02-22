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

p.startingI = [0 0];
p.startingA = [0 0];


%% Params ranges
curP = p;
%             curP.(char(param)) = pR.(char(param))(i);
curP.I      = [curP.I     curP.I    ];
curP.gamma  = [curP.gamma curP.gamma];
curP.sigma  = [curP.sigma curP.sigma];
curP.alpha  = [curP.alpha curP.alpha];
curP.tau    = [curP.tau   curP.tau  ];

tic
[times,Var] = vanLoonSim(curP);
plot_vanLoonSims(length(times)-1,1,times,Var)
toc

if 0
    x1 = Var(:,1);
    x2 = Var(:,2);
    d = 500;
    gridx = linspace(min([x1; x2]),max([x1; x2; 1]),d);
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
figure('WindowStyle','docked')
imagesc(x1,x2,v)
ax = gca;
ax.YDir = 'normal';
ax.PlotBoxAspectRatio = [1 1 1];
ax.DataAspectRatio  = [1 1 1];
xlim([0.4 1])
ylim([0.4 1])
color = colormap(gray);
color = color(end:-1:1,:);
colormap(ax,color)
grid on




%     figure('WindowStyle','docked'); hold on
%     subplot(2,1,1)
% %     plot(times,sigmoid(sigmoidParam,Var(:,1:2)))
%     plot(times,Var(:,1:2))
%     Xdiff = max(diff
