%% Plot summary
close all
clear all
load(fullfile('simRes',['simRes_symetric_processed']),'durMean','durMedian','p','pR','code')

fInd = 1;
for param = {'gamma' 'alpha' 'I'} %{'gamma' 'alpha' 'sigma' 'I'}


    f(fInd) = figure('WindowStyle','docked');
    hold on;
    %X
    X = mean(cat(3,durMean.(char(param)).X1,durMean.(char(param)).X2),3);
    Xmean = mean(X,1);
    Xstd = std(X,[],1);
    h{fInd}(1) = errorbar(pR.(char(param)),Xmean,Xstd,'ok');
    set(h{fInd}(1),'MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','none')
    
    [~,tmpInd] = min(abs(p.(char(param))-pR.(char(param))));
    refVal(fInd) = Xmean(tmpInd);    
    
    
    
    
    xlabel(char(param))
    ylabel('Mean period duration (mean +- std)')
    plot(pR.(char(param)),ones(size(pR.(char(param)))).*refVal(fInd),':k')
    offset = range(pR.(char(param)))/numel(pR.(char(param)))/10;
    xlim([min(pR.(char(param)))-offset*5 max(pR.(char(param)))+offset*5])
    title(['Relation between mean period duration and symetric simulation parameters; Compiled across ' num2str(size(durMean.(char(param)).X1,1)) ' simulations'])
    legend(h{fInd},{'X1X2 balanced'},'Location','NorthWest')
%     ylim([2 5])
    
    fInd = fInd+1;
    
    saveas(gcf,fullfile('simRes',['simRes_symetricFig_' char(param) '.jpg']),'jpg')
end

keyboard


load(fullfile('simRes',['simRes_assymetric_processed']),'durMean','durMedian','p','pR','code')

fInd = 1;
for param = {'gamma' 'alpha' 'I'} %{'gamma' 'alpha' 'sigma' 'I'}
    
    figure(f(fInd))
    %X1
    if ~strcmp('gamma',param)
        X1mean = mean(durMean.(char(param)).X1,1);
        X1std  = std(durMean.(char(param)).X1,[],1);
    else
        X1mean = mean(durMean.(char(param)).X2,1);
        X1std  = std(durMean.(char(param)).X2,[],1);
    end
    offset = range(pR.(char(param)))/numel(pR.(char(param)))/10;
    h{fInd}(2) = errorbar(pR.(char(param))-offset/2,X1mean,X1std,'ok');
    set(h{fInd}(2),'MarkerSize',5,'MarkerEdgeColor','k','MarkerFaceColor','k')
    %X2
    if ~strcmp('gamma',param)
        X2mean = mean(durMean.(char(param)).X2,1);
        X2std  = std(durMean.(char(param)).X2,[],1);
    else
        X2mean = mean(durMean.(char(param)).X1,1);
        X2std  = std(durMean.(char(param)).X1,[],1);
    end
    h{fInd}(3) = errorbar(pR.(char(param))+offset/2,X2mean,X2std,'or');
    set(h{fInd}(3),'MarkerSize',5,'MarkerEdgeColor','none','MarkerFaceColor','r')
    plot(pR.(char(param)),ones(size(pR.(char(param)))).*refVal(fInd),':k')

    xlabel(char(param))
    ylabel('Mean period duration (mean +- std)')
    offset = range(pR.(char(param)))/numel(pR.(char(param)))/10;
    xlim([min(pR.(char(param)))-offset*5 max(pR.(char(param)))+offset*5])
    title(['Relation between mean period duration and symetric simulation parameters; Compiled across ' num2str(size(durMean.(char(param)).X1,1)) ' simulations'])
    legend(h{fInd},{'X1X2 balanced' 'X1 fixed' 'X2 variable'},'Location','NorthWest')
%     ylim([0 40])
    
    saveas(gcf,fullfile('simRes',['simRes_symetricAndAssymetricFig_' char(param) '.jpg']),'jpg')
    fInd = fInd+1;
end






% load(fullfile('simRes','others',['simRes_processed_old']),'durMean','durMedian','p','pR')
% 
% fInd = 1;
% for param = {'gamma' 'alpha' 'sigma'}
% 
%     
%     figure(f(fInd))
%     hold on;
%     %X
%     X = mean(cat(3,durMean.(char(param)).X1,durMean.(char(param)).X2),3);
%     Xmean = mean(X,1);
%     Xstd = std(X,[],1);
%     h{fInd}(1) = errorbar(pR.(char(param)),Xmean,Xstd,'ok');
%     set(h{fInd}(1),'MarkerSize',5,'MarkerEdgeColor','k','MarkerFaceColor','none')
%     
%     plot(pR.(char(param)),ones(size(pR.(char(param)))).*refVal(fInd),':k')
%     
%     fInd = fInd+1;
% end


