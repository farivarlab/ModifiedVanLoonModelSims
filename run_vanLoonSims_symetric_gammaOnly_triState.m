clear all
close all
%% Params default
p.I       = 1;
p.gamma   = 3;
p.sigma   = 0.003;
p.alpha   = 4;
p.tau     = 125;
p.sigmoidParam(1) = 0.5;
p.sigmoidParam(2) = 18;
p.sigmoidParam(3) = 1;
% p.endTime = 1000;%5000
p.endTime = 10000;

p.startingI = [0 0];
p.startingA = [0 0];


%% Params ranges
pR.I     = 1;
nLevel = 8;
pR.gamma = [linspace(1.5,1.6,nLevel)];
pR.gamma = sort(unique(pR.gamma));
pR.gamma(1) = [];
% pR.gamma = [0.5 1 1.5 2 2.2 linspace(2.6,3.4,7) 3.8 4.5 5.5 10];
pR.sigma = 0.03;
pR.alpha = 4;

% pR.I        = linspace(0.95,1.05,7);
% pR.gamma	= linspace(2.6,3.4,7);
% pR.sigma    = [0.001 0.002 0.003 0.006 0.015];%linspace(0.001,0.015,10);
% pR.alpha    = linspace(3.6,4.4,7);


for curIter = 1
%     for param = {'gamma' 'I' 'sigma' 'alpha'}
    for param = {'gamma'}
        for i = 1:length(pR.(char(param)))
            display(['Iter ' num2str(curIter)])
            display(['Param ' char(param)])
            display(['i ' num2str(i)])
            curP = p;
            
            curP.(char(param)) = pR.(char(param))(i);
            curP.I      = [curP.I     curP.I    ];
            curP.gamma  = [curP.gamma curP.gamma];
            curP.sigma  = [curP.sigma curP.sigma];
            curP.alpha  = [curP.alpha curP.alpha];
            curP.tau    = [curP.tau   curP.tau  ];
            
            tic
            [times.(char(param)){i},Var.(char(param)){i}] = vanLoonSim(curP);
%             plot_vanLoonSims(length(times.(char(param)){i})-1,1,times.(char(param)){i},Var.(char(param)){i})
            toc
        end
    end
    save(fullfile('simRes',[mfilename '_' num2str(curIter)]),'p','pR','times','Var')
    clear times Var
end









%     figure('WindowStyle','docked'); hold on
%     subplot(2,1,1)
% %     plot(times,sigmoid(sigmoidParam,Var(:,1:2)))
%     plot(times,Var(:,1:2))
%     Xdiff = max(diff
