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
p.endTime = 5000;%5000
% p.endTime = 100;

p.startingI = [0 0];
p.startingA = [0 0];


%% Params ranges
% pR.I        = linspace(0.349,0.351,11);
% pR.gamma	= linspace(25.6,26.4,5);
% pR.sigma    = linspace(0.001,0.01,10);
% pR.alpha    = linspace(3,5,11);

pR.I        = linspace(0.95,1.05,7);
pR.gamma	= linspace(2.6,3.4,7);
pR.sigma    = [0.001 0.002 0.003 0.006 0.015];%linspace(0.001,0.015,10);
pR.alpha    = linspace(3.6,4.4,7);


for curIter = 1:10
    for param = {'gamma' 'I' 'sigma' 'alpha'}
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
    save(fullfile('simRes',['simRes_symetric_' num2str(curIter)]),'p','pR','times','Var')
    clear times Var
end









%     figure('WindowStyle','docked'); hold on
%     subplot(2,1,1)
% %     plot(times,sigmoid(sigmoidParam,Var(:,1:2)))
%     plot(times,Var(:,1:2))
%     Xdiff = max(diff
