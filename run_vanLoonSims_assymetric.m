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
p.endTime = 1000;%5000
% p.endTime = 10;

p.startingI = [0 0];
p.startingA = [0 0];


%% Params ranges
pR.I        = linspace(0.95,1.05,7);
pR.gamma	= linspace(2.6,3.4,7);
pR.sigma    = [0.001 0.002 0.003 0.006 0.015];%linspace(0.001,0.015,10);
pR.alpha    = linspace(3.6,4.4,7);

for curIter = 1:2
    for param = {'gamma' 'I' 'sigma' 'alpha'}
        for i = 1:length(pR.(char(param)))
            display(['Iter ' num2str(curIter)])
            display(['Param ' char(param)])
            display(['i ' num2str(i)])
            curP = p;
            
            switch char(param)
                case 'I'
                    curP.I      = [curP.I     pR.(char(param))(i)];
                    curP.gamma  = [curP.gamma curP.gamma         ];
                    curP.sigma  = [curP.sigma curP.sigma         ];
                    curP.alpha  = [curP.alpha curP.alpha         ];
                    curP.tau    = [curP.tau   curP.tau           ];
                case 'gamma'
                    curP.I      = [curP.I     curP.I             ];
                    curP.gamma  = [curP.gamma pR.(char(param))(i)];
                    curP.sigma  = [curP.sigma curP.sigma         ];
                    curP.alpha  = [curP.alpha curP.alpha         ];
                    curP.tau    = [curP.tau   curP.tau           ];
                case 'sigma'
                    curP.I      = [curP.I     curP.I             ];
                    curP.gamma  = [curP.gamma curP.gamma         ];
                    curP.sigma  = [curP.sigma pR.(char(param))(i)];
                    curP.alpha  = [curP.alpha curP.alpha         ];
                    curP.tau    = [curP.tau   curP.tau           ];
                case 'alpha'
                    curP.I      = [curP.I     curP.I             ];
                    curP.gamma  = [curP.gamma curP.gamma         ];
                    curP.sigma  = [curP.sigma curP.sigma         ];
                    curP.alpha  = [curP.alpha pR.(char(param))(i)];
                    curP.tau    = [curP.tau   curP.tau           ];
            end
            
            tic
            [times.(char(param)){i},Var.(char(param)){i}] = vanLoonSim(curP);
%             plot_vanLoonSims(1000,1,times.(char(param)){i},Var.(char(param)){i})
            toc
        end
    end
    if ~exist('simRes','dir')
        mkdir('simRes')
    end
    save(fullfile('simRes',['simRes_assymetric_' num2str(curIter)]),'p','pR','times','Var')
    clear times Var
end



