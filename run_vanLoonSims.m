clear all
close all
%% Params default
p.I       = 1;%0.73684
p.gamma   = 3;
p.sigma   = 0.015;%0.3
p.alpha   = 0;
p.tau     = 125;
% p.sigmoidParam(1) = p.I;
% p.sigmoidParam(2) = 18;
% p.sigmoidParam(3) = p.I*2;
p.endTime = 5000; % 500

p.startingI = [0 0];
p.startingA = [0 0];

%% Params ranges
pR.I        = linspace(p.I,p.I+0,1); %0.349:0.001:1.351;% linspace(24,28,11);
% tmp = pR.I;
% pR.I(3:3:length(tmp)*3) = tmp;
% pR.I(2:3:end) = tmp;
% pR.I(1:3:end) = tmp;

pR.gamma	= linspace(p.gamma,p.gamma,1);
pR.sigma    = linspace(p.sigma,p.sigma,1);
% tmp = pR.sigma;
% nRepeat = 20;
% for i = nRepeat:-1:1
%     pR.sigma(i:nRepeat:length(tmp)*nRepeat) = tmp;
% end
pR.alpha    = linspace(p.alpha,p.alpha+0,1);

for curIter = 1%:10
    for param = {'sigma'}%{'I' 'gamma' 'sigma' 'alpha'}
        for i = 1:length(pR.(char(param)))
            display(['Iter ' num2str(curIter)])
            display(['Param ' char(param)])
            display(['i ' num2str(i)])
            curP = p;
            
            curP.(char(param)) = pR.(char(param))(i);
            curP.I      = [curP.I    curP.I    ];
            curP.gamma  = [curP.gamma curP.gamma];
            curP.sigma  = [curP.sigma curP.sigma];
            curP.alpha  = [curP.alpha curP.alpha];
            curP.tau    = [curP.tau   curP.tau  ];
            
            curP.sigmoidParam(1) = 0.5; %curP.I(1);
            curP.sigmoidParam(2) = 18;
            curP.sigmoidParam(3) = 1; %curP.I(1)*2;
            

%             figure('WindowStyle','docked'); hold on
%             plot(0:0.01:1,sigmoid(p.sigmoidParam,0:0.01:1))

            
%             switch char(param)
%                 case 'I'
%                     curP.I      = [curP.I     pR.(char(param))(i)];
%                     curP.gamma  = [curP.gamma curP.gamma         ];
%                     curP.sigma  = [curP.sigma curP.sigma         ];
%                     curP.alpha  = [curP.alpha curP.alpha         ];
%                     curP.tau    = [curP.tau   curP.tau           ];
%                 case 'gamma'
%                     curP.I      = [curP.I     curP.I             ];
%                     curP.gamma  = [curP.gamma pR.(char(param))(i)];
%                     curP.sigma  = [curP.sigma curP.sigma         ];
%                     curP.alpha  = [curP.alpha curP.alpha         ];
%                     curP.tau    = [curP.tau   curP.tau           ];
%                 case 'sigma'
%                     curP.I      = [curP.I     curP.I             ];
%                     curP.gamma  = [curP.gamma curP.gamma         ];
%                     curP.sigma  = [curP.sigma pR.(char(param))(i)];
%                     curP.alpha  = [curP.alpha curP.alpha         ];
%                     curP.tau    = [curP.tau   curP.tau           ];
%                 case 'alpha'
%                     curP.I      = [curP.I     curP.I             ];
%                     curP.gamma  = [curP.gamma curP.gamma         ];
%                     curP.sigma  = [curP.sigma curP.sigma         ];
%                     curP.alpha  = [curP.alpha pR.(char(param))(i)];
%                     curP.tau    = [curP.tau   curP.tau           ];
%             end
            
            tic
            [times.(char(param)){i},Var.(char(param)){i}] = vanLoonSim(curP);
            plot_vanLoonSims(length(times.(char(param)){i})-1,1,times.(char(param)){i},Var.(char(param)){i},pR.(char(param))(i),curP.I)
            toc
        end
    end
    save(fullfile('simRes',['simRes__' num2str(curIter)]),'p','pR','times','Var')
    clear times Var
end






