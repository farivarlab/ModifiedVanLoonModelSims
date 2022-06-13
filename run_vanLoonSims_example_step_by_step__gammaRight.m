clear all
close all

%% Params default
p.I       = 1; % 1
p.gamma   = 3; % 3
p.sigma   = 0.010; %0.003
p.alpha   = 4; % 4
p.tau     = 125;
p.sigmoidParam(1) = 0.5;
p.sigmoidParam(2) = 18;
p.sigmoidParam(3) = 1;
p.endTime = [500 500];

p.startingI = [1 1];
p.startingA = [0.15 0.15];


curP = p;
curP.I      = [curP.I     curP.I    ];
curP.gamma  = [curP.gamma curP.gamma];
curP.sigma  = [curP.sigma curP.sigma];
curP.alpha  = [curP.alpha curP.alpha];
curP.tau    = [curP.tau   curP.tau  ];

times2 = {};
Var2   = {};
i = 0;
%% Start with default
i = i+1; curP.endTime = p.endTime(i);

[curTimes,curVar] = vanLoonSim(curP);
times = curTimes;
Var = curVar;

curP2 = curP;
curP2.startingI = Var(end,[1 2]);
curP2.startingA = Var(end,[3 4]);
curP2.endTime = sum(p.endTime(i+1:end));
[curTimes,curVar] = vanLoonSim(curP2);
times2{end+1} = cat(1,times,curTimes+times(end));
Var2{end+1}   = cat(1,Var,curVar);


%% increase gamma on the right side
i = i+1; curP.endTime = p.endTime(i);
curP.gamma         = [3 4.3];
curP.startingI = Var(end,[1 2]);
curP.startingA = Var(end,[3 4]);

[curTimes,curVar] = vanLoonSim(curP);
times = cat(1,times,curTimes+times(end));
Var = cat(1,Var,curVar);


%% Plot
tmp = cat(1,Var2{:},Var); tmp = tmp(:,[1 2]);
yLim = [0 max(tmp(:))]; clear tmp
plot_vanLoonSims(length(times)-1,1,times,Var)
f = gcf;
delete(f.Children(1))
f.Children.YLim = yLim;
for i = 1:length(p.endTime)-1
    figure(f);
    line(sum(p.endTime(1:i)).*[1 1],ylim);
    plot_vanLoonSims(length(times)-1,1,times2{i},Var2{i})
    f2{i} = gcf;
    delete(f2{i}.Children(1))
    f2{i}.Children.YLim = yLim;
end
f = [f f2{:}];
for i = 1:length(f)
    filename = [mfilename '__' num2str(i)];
    saveas(f(i),[filename '.fig']);
    saveas(f(i),[filename '.svg']);
end
