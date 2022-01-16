function [XGrid,YPlot] = fitGammaDist(tmp)
%CREATEFIT    Create plot of datasets and fits
%   PD1 = CREATEFIT(TMP)
%   Creates a plot, similar to the plot in the main distribution fitting
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with dfittool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  1
%   Number of fits:  1
%
%   See also FITDIST.

% This function was automatically generated on 14-Apr-2015 23:24:45

% Output fitted probablility distribution: PD1

% Data from dataset "tmp data":
%    Y = tmp

% Force all inputs to be column vectors
tmp = tmp(:);

% Prepare figure
h = figure('WindowStyle','docked')
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "tmp data"
[CdfF,CdfX] = ecdf(tmp,'Function','cdf');  % compute empirical cdf
BinInfo.rule = 1;
[~,BinEdge] = internal.stats.histbins(tmp,[],[],BinInfo,CdfF,CdfX);
[BinHeight,BinCenter] = ecdfhist(CdfF,CdfX,'edges',BinEdge);
hLine = bar(BinCenter,BinHeight,'hist');
set(hLine,'FaceColor','none','EdgeColor',[0 0 0],...
    'LineStyle','-', 'LineWidth',1);
xlabel('Data');
ylabel('Density')
LegHandles(end+1) = hLine;
LegText{end+1} = 'tmp data';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);
close(h)

% --- Create fit "fit"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('gamma',[ 40.53671715787, 0.9796810134794])
pd1 = fitdist(tmp, 'gamma');
YPlot = pdf(pd1,XGrid);
% hLine = plot(XGrid,YPlot,'Color',[0 0 1],...
%     'LineStyle','-', 'LineWidth',2,...
%     'Marker','none', 'MarkerSize',6);
% LegHandles(end+1) = hLine;
% LegText{end+1} = 'fit';
% 
% % Adjust figure
% box on;
% hold off;
% 
% % Create legend from accumulated handles and labels
% hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'Location', 'NorthEast');
% set(hLegend,'Interpreter','none');
