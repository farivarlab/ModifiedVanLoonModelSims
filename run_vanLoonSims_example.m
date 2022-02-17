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









%     figure('WindowStyle','docked'); hold on
%     subplot(2,1,1)
% %     plot(times,sigmoid(sigmoidParam,Var(:,1:2)))
%     plot(times,Var(:,1:2))
%     Xdiff = max(diff
