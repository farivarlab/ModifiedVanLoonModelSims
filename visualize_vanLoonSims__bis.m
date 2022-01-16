%% Plot summary
close all
clear all
load(fullfile('simRes',['simRes_symetric_processed']),'durMean','durMedian','p','pR','code')

fInd = 1;
for param = {'gamma' 'I' 'sigma' 'alpha'} %{'gamma' 'alpha' 'sigma' 'I'}


    f(fInd) = figure('WindowStyle','docked');
    hold on;
    %X
    X = mean(cat(3,durMean.(char(param)).X1,durMean.(char(param)).X2),3);
    Xmean = mean(X,1);
    Xstd = std(X,[],1);
%     h{fInd}(1) = errorbar(pR.(char(param)),Xmean,Xstd,'ok');
%     set(h{fInd}(1),'MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','none')
    
    [~,tmpInd] = min(abs(p.(char(param))-pR.(char(param))));
    refParam(fInd) = pR.(char(param))(tmpInd);
    refVal(fInd) = Xmean(tmpInd);    
    
    
%     
%     
%     xlabel(char(param))
%     ylabel('Mean period duration (mean +- std)')
%     plot(pR.(char(param)),ones(size(pR.(char(param)))).*refVal(fInd),':k')
%     offset = range(pR.(char(param)))/numel(pR.(char(param)))/10;
%     xlim([min(pR.(char(param)))-offset*5 max(pR.(char(param)))+offset*5])
%     title(['Relation between mean period duration and symetric simulation parameters; Compiled across ' num2str(size(durMean.(char(param)).X1,1)) ' simulations'])
%     legend(h{fInd},{'X1X2 balanced'},'Location','NorthWest')
% %     ylim([2 5])
%     
% 
% 







%X1
%     if ~strcmp('gamma',param)
        X1mean = mean(durMean.(char(param)).X1,1);
        X1std  = std(durMean.(char(param)).X1,[],1);
%     else
%         X1mean = mean(durMean.(char(param)).X2,1);
%         X1std  = std(durMean.(char(param)).X2,[],1);
%     end
    offset = range(pR.(char(param)))/numel(pR.(char(param)))/10;
    h1{fInd}(1) = errorbar(pR.(char(param))-offset,X1mean,X1std,'or');
    set(h1{fInd}(1),'Marker','o','MarkerSize',10,'MarkerEdgeColor','r','MarkerFaceColor','w')
    %X2
%     if ~strcmp('gamma',param)
        X2mean = mean(durMean.(char(param)).X2,1);
        X2std  = std(durMean.(char(param)).X2,[],1);
%     else
%         X2mean = mean(durMean.(char(param)).X1,1);
%         X2std  = std(durMean.(char(param)).X1,[],1);
%     end
    h1{fInd}(2) = errorbar(pR.(char(param))-offset/2,X2mean,X2std,'og');
    set(h1{fInd}(2),'Marker','o','MarkerSize',10,'MarkerEdgeColor','g','MarkerFaceColor','w')
    plot(pR.(char(param)),ones(size(pR.(char(param)))).*refVal(fInd),':k')

    xlabel(char(param))
    ylabel('Mean period duration (mean +- std)')
    offset = range(pR.(char(param)))/numel(pR.(char(param)))/10;
    xlim([min(pR.(char(param)))-offset*5 max(pR.(char(param)))+offset*5])
%     title(['Relation between mean period duration and symetric simulation parameters; Compiled across ' num2str(size(durMean.(char(param)).X1,1)) ' simulations'])
%     legend(h{fInd},{'X1 balanced' 'X2 balanced'},'Location','NorthWest')
%     ylim([0 40])
    fInd = fInd+1;
    
%     saveas(gcf,fullfile('simRes',['simRes_symetricFig_' char(param) '.jpg']),'jpg')
end

% keyboard


load(fullfile('simRes',['simRes_assymetric_processed']),'durMean','durMedian','p','pR','code')

fInd = 1;
for param = {'gamma' 'I' 'sigma' 'alpha'} %{'gamma' 'alpha' 'sigma' 'I'}
    
    figure(f(fInd))
    %X1
%     if ~strcmp('gamma',param)
        X1mean = mean(durMean.(char(param)).X1,1);
        X1std  = std(durMean.(char(param)).X1,[],1);
%     else
%         X1mean = mean(durMean.(char(param)).X2,1);
%         X1std  = std(durMean.(char(param)).X2,[],1);
%     end
    offset = range(pR.(char(param)))/numel(pR.(char(param)))/10;
    h{fInd}(1) = errorbar(pR.(char(param))+offset/2,X1mean,X1std,'or');
    set(h{fInd}(1),'Marker','o','MarkerSize',10,'MarkerEdgeColor','r','MarkerFaceColor','r')
    %X2
%     if ~strcmp('gamma',param)
        X2mean = mean(durMean.(char(param)).X2,1);
        X2std  = std(durMean.(char(param)).X2,[],1);
%     else
%         X2mean = mean(durMean.(char(param)).X1,1);
%         X2std  = std(durMean.(char(param)).X1,[],1);
%     end
    h{fInd}(2) = errorbar(pR.(char(param))+offset,X2mean,X2std,'og');
    set(h{fInd}(2),'Marker','o','MarkerSize',10,'MarkerEdgeColor','g','MarkerFaceColor','g')
    plot(pR.(char(param)),ones(size(pR.(char(param)))).*refVal(fInd),':k')

    xlabel(char(param))
    ylabel('Mean period duration (mean +- std)')
    offset = range(pR.(char(param)))/numel(pR.(char(param)))/10;
    xlim([min(pR.(char(param)))-offset*5 max(pR.(char(param)))+offset*5])
%     title(['Relation between mean period duration and symetric simulation parameters; Compiled across ' num2str(size(durMean.(char(param)).X1,1)) ' simulations'])
    legendStr = {['X1 durations (balanced: ' char(param) '1=' char(param) '2=' char(param) ')']
    ['X2 durations (balanced: ' char(param) '1=' char(param) '2=' char(param) ')']
    ['X1 durations (unbalanced: ' char(param) '1=' num2str(refParam(fInd)) ' and ' char(param) '2=' char(param) ')']
    ['X2 durations (unbalanced: ' char(param) '1=' num2str(refParam(fInd)) ' and ' char(param) '2=' char(param) ')']};
    legend([h1{fInd} h{fInd}],legendStr,'Location','North')
%     ylim([0 40])
    
%     saveas(gcf,fullfile('simRes',['simRes_symetricAndAssymetricFig_' char(param) '.jpg']),'jpg','-r300')
%     print(gcf,'-djpeg','-r150',fullfile('simRes',['simRes_symetricAndAssymetricFig_' char(param) '.jpg']))
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


