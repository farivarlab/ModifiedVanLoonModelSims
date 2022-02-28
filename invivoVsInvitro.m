clear all
close all

%% in vivo
% [van Loon, A. M., et al. (2013). "GABA Shapes the Dynamics of Bistable
% Perception." Current Biology 23(9): 823-827.]


xy = [0.17755809124095567, 0.9373230335138736
0.18645484949832775, 1.6527855881453384
0.2086967451417579, 1.8426021842720566
0.2298063260978862, 2.572666015528654
0.22972544647736465, 3.8575783585402643
0.23781340852952104, 2.6730497923264345
0.25762891555730427, 1.5700450206029224
0.2640992851990294, 3.156717080533932
0.2649080814042451, 2.671630223765659
0.2729960434564015, 1.5051504578245627
0.27946641309812664, 6.297613919006761
0.28027520930334227, 4.3085955698498974
0.28027520930334227, 1.9999714990095896
0.2859367827398518, 3.8299981693594596];

gaba.vo = xy(:,1);
br.vo = xy(:,2);
clear xy

%% invitro
load(fullfile('simRes',['analyze_vanLoonSims_gammaOnly_simRes_symetric_processed']),'durMean','durMedian','p','pR','code')
param = 'gamma';
figure('WindowStyle','docked'); hold on
Xmean = mean([durMean.(char(param)).X1; durMean.(char(param)).X2],1);
Xstd  = std([durMean.(char(param)).X1; durMean.(char(param)).X2],[],1);
offset = 0; %range(pR.(char(param)))/numel(pR.(char(param)))/10;
h = errorbar(pR.(char(param))-offset/2,Xmean,Xstd,'ok');
set(h(1),'MarkerSize',5,'MarkerEdgeColor','k','MarkerFaceColor','none')
xlabel(char(param))
ylabel('Mean period duration (mean +- std)')
title(['Relation between mean period duration and symetric simulation parameters; Compiled across ' num2str(size(durMean.(char(param)).X1,1)) ' simulations of 10000 unit time'])
%     legend(h,{'X1 fixed' 'X2 variable'},'Location','NorthWest')

gaba.tro = pR.(char(param));
br.tro = Xmean;
ind = gaba.tro>1.6 & gaba.tro<7 & ~isnan(br.tro);
br.tro = br.tro(ind);
gaba.tro = gaba.tro(ind);



% gaba.tro = ( gaba.tro - mean(gaba.tro) ) ./ std(gaba.tro);
% gaba.tro = gaba.tro .* std(gaba.vo) + mean(gaba.vo);
gaba.tro = gaba.tro -  min(gaba.tro);
gaba.tro = gaba.tro ./ max(gaba.tro);
gaba.tro = gaba.tro .* range(gaba.vo);
gaba.tro = gaba.tro +  min(gaba.vo);

br.tro = br.tro -  min(br.tro);
br.tro = br.tro ./ max(br.tro);
br.tro = br.tro .* range(br.vo);
br.tro = br.tro +  min(br.vo);


f = figure('WindowStyle','docked');
hPlot = plot(gaba.vo,br.vo,'.'); hold on
hPlot.MarkerSize = hPlot.MarkerSize*2;
% hPlot.MarkerFaceColor = hPlot.Color;
plot(gaba.tro,br.tro)
ax = gca;
xlim auto
ax.PlotBoxAspectRatio = [1 1 1];
ax.Color='none';
f.Color = 'none';
saveas(f,mfilename,'svg')
f.Color = 'w';
xlabel('GABA ratio')
ylabel('percept mean duration')

[RHO,PVAL] = corr(gaba.vo,br.vo);


