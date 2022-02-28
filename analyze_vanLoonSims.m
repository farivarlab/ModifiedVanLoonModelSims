for codeAll = {'symetric' 'assymetric'}

clearvars -except codeAll
close all

code = char(codeAll);

startTime = 250;

if 1
%% Compile durations
for param = {'gamma' 'I' 'sigma' 'alpha'}%{'gamma' 'alpha' 'sigma' 'I'}
    durAll.(char(param)).X1 = {};
    durAll.(char(param)).X2 = {};
end
for curIter = 1:10
    tic
    load(fullfile('simRes',['simRes_' code '_' num2str(curIter)]),'p','pR','times','Var')
    for param = {'gamma' 'I' 'sigma' 'alpha'};%{'gamma' 'alpha' 'sigma' 'I'}
        display(['Iter ' num2str(curIter)])
        display(['Param ' char(param)])
        
        for i = 1:length(pR.(char(param)))
            if curIter==1 && strcmp(char(param),'sigma') && i>=3
                plot_vanLoonSims(1000,1,times.(char(param)){i},Var.(char(param)){i},pR.(char(param))(i),p.I)
            end
            cur_times = times.(char(param)){i};
            cur_Var = Var.(char(param)){i};

            cur_times = cur_times(cur_times>startTime,:);
            cur_Var = cur_Var(cur_times>startTime,:);
            
            
            deltaX1X2 = cur_Var(:,1)-cur_Var(:,2);
            crossings = diff(deltaX1X2<0);
            crossings_ind = find(crossings);
            X1dur = []; X2dur = [];
            
            
            
            for ii = 1:length(crossings_ind)-1
                if crossings(crossings_ind(ii))<0 %X1 period
                    %Time start
                    curInd = crossings_ind(ii);
                    timeInter       = cur_times(curInd+1) - cur_times(curInd);
                    diffInter       = deltaX1X2(curInd+1) - deltaX1X2(curInd);
                    zeroInInter     = abs(deltaX1X2(curInd)/diffInter);
                    timeAtZeroStart = cur_times(curInd) + zeroInInter*timeInter;
                    %Time end
                    curInd = crossings_ind(ii+1);
                    timeInter       = cur_times(curInd+1) - cur_times(curInd);
                    diffInter       = deltaX1X2(curInd+1) - deltaX1X2(curInd);
                    zeroInInter     = abs(deltaX1X2(curInd)/diffInter);
                    timeAtZeroEnd   = cur_times(curInd) + zeroInInter*timeInter;
                    %Period duration
                    X1dur = [X1dur timeAtZeroEnd-timeAtZeroStart];
                else %X2 period
                    %Time start
                    curInd = crossings_ind(ii);
                    timeInter       = cur_times(curInd+1) - cur_times(curInd);
                    diffInter       = deltaX1X2(curInd+1) - deltaX1X2(curInd);
                    zeroInInter     = abs(deltaX1X2(curInd)/diffInter);
                    timeAtZeroStart = cur_times(curInd) + zeroInInter*timeInter;
                    %Time end
                    curInd = crossings_ind(ii+1);
                    timeInter       = cur_times(curInd+1) - cur_times(curInd);
                    diffInter       = deltaX1X2(curInd+1) - deltaX1X2(curInd);
                    zeroInInter     = abs(deltaX1X2(curInd)/diffInter);
                    timeAtZeroEnd   = cur_times(curInd) + zeroInInter*timeInter;
                    %Period duration
                    X2dur = [X2dur timeAtZeroEnd-timeAtZeroStart];
                end
            end
            durAll.(char(param)).X1{curIter,i} = X1dur;
            durAll.(char(param)).X2{curIter,i} = X2dur;
        end
    end
    toc
end
save(fullfile('simRes',['simRes_' code '_compiled']),'durAll','p','pR','code')
end

if 1
%% Analyze durations
clearvars -except code
load(fullfile('simRes',['simRes_' code '_compiled']),'durAll','p','pR','code')


for param = {'gamma' 'alpha' 'sigma' 'I'};%{'gamma' 'alpha' 'sigma' 'I'}
%     if strcmp(char(param),'alpha')
    for i = 1:length(pR.(char(param)))
        dur.(char(param)).X1{i} = [];
        dur.(char(param)).X2{i} = [];
    end
    
    %     param
    for curIter = 1:size(durAll.(char(param)).X1,1)
%         keyboard
        for i = 1:length(pR.(char(param)))
%             i
%         if i==1
%             dur.(char(param)).X1{i} = [dur.(char(param)).X1 durAll.(char(param)).X1{curIter,i}];
%             dur.(char(param)).X2{i} = [dur.(char(param)).X2 durAll.(char(param)).X2{curIter,i}];
%         else
            dur.(char(param)).X1{i} = [dur.(char(param)).X1{i} durAll.(char(param)).X1{curIter,i}];
            dur.(char(param)).X2{i} = [dur.(char(param)).X2{i} durAll.(char(param)).X2{curIter,i}];
%         end

            durMean.(char(param)).X1(curIter,i) = mean(durAll.(char(param)).X1{curIter,i});
            durMean.(char(param)).X2(curIter,i) = mean(durAll.(char(param)).X2{curIter,i});
            
            durMedian.(char(param)).X1(curIter,i) = median(durAll.(char(param)).X1{curIter,i});
            durMedian.(char(param)).X2(curIter,i) = median(durAll.(char(param)).X2{curIter,i});
        end
    end
    
    for i = 1:length(pR.(char(param)))
        figure('WindowStyle','docked')
        lengthDiff = length(dur.(char(param)).X1{i}) - length(dur.(char(param)).X2{i});
        if lengthDiff==0
            tmp1 = dur.(char(param)).X1{i}; tmp2 = dur.(char(param)).X2{i};
        elseif lengthDiff>0
            tmp1 = dur.(char(param)).X1{i};
            tmp2 = [dur.(char(param)).X2{i} nan(1,abs(lengthDiff))];
        else
            tmp1 = [dur.(char(param)).X1{i} nan(1,abs(lengthDiff))];
            tmp2 = dur.(char(param)).X2{i};
        end
        hist([tmp1; tmp2]',50);
        h = findobj(gca,'Type','patch');
        set(h(1),'FaceColor','r')
        set(h(2),'FaceColor','g')
        title([char(param) ' = ' num2str(pR.(char(param))(i))])
        legend(h,{'X1' 'X2'})
        if pR.(char(param))(i)==0.003
            tmp = [tmp1 tmp2];
            hold on
            [XGrid,YPlot] = fitGammaDist(tmp);
            h(3) = plot(XGrid,YPlot*(numel(find(~isnan(tmp))))./2,'k');
            [XGrid,YPlot] = fitNormalDist(tmp);
            h(4) = plot(XGrid,YPlot*(numel(find(~isnan(tmp))))./2,'--k');
            legend(h,{'X1' 'X2' 'Gamma distribution' 'Normal distribution'},'location','northwest')
            xlim([0 60])
            print(gcf,'-djpeg','-r150',fullfile('simRes',['hist.jpg']))
%             keyboard
        end
    end
%     end
end
save(fullfile('simRes',['simRes_' code '_processed']),'dur','durMean','durMedian','p','pR','code')
end


%% Plot summary
% close all
clearvars -except code
load(fullfile('simRes',['simRes_' code '_processed']),'durMean','durMedian','p','pR','code')

% figure('WindowStyle','docked'); hold on
% subPlotInd = 1;
for param = {'gamma' 'I' 'sigma' 'alpha'}%{'gamma' 'alpha' 'sigma' 'I'}
%     subplot(3,1,subPlotInd); hold on;
%     %X1
%     X1mean = mean(durMean.(char(param)).X1,1);
%     X1std  = std(durMean.(char(param)).X1,[],1);
%     offset = range(pR.(char(param)))/numel(pR.(char(param)))/10;
%     h = errorbar(pR.(char(param))-offset/2,X1mean,X1std,'ok');
%     set(h(1),'MarkerSize',5,'MarkerEdgeColor','k','MarkerFaceColor','none')
%     %X2
%     X2mean = mean(durMean.(char(param)).X2,1);
%     X2std  = std(durMean.(char(param)).X2,[],1);
%     h(2) = errorbar(pR.(char(param))+offset/2,X2mean,X2std,'ok');
%     set(h(2),'MarkerSize',5,'MarkerEdgeColor','none','MarkerFaceColor','k')
%     xlabel(char(param))
%     ylabel('Mean period duration (mean +- std)')
%     
%     xlim([min(pR.(char(param)))-offset*5 max(pR.(char(param)))+offset*5])
%     
%     if subPlotInd==1
%         title(['Relation between mean period duration and symetric simulation parameters; Compiled across ' num2str(size(durMean.(char(param)).X1,1)) ' simulations of 100000 unit time'])
%         legend(h,{'X1' 'X2'},'Location','NorthWest')
%     end
%     
%     subPlotInd = subPlotInd+1;
%     spaceplots



    figure('WindowStyle','docked'); hold on
    %X1
    X1mean = mean(durMean.(char(param)).X1,1);
    X1std  = std(durMean.(char(param)).X1,[],1);
    offset = range(pR.(char(param)))/numel(pR.(char(param)))/10;
    h = errorbar(pR.(char(param))-offset/2,X1mean,X1std,'ok');
    set(h(1),'MarkerSize',5,'MarkerEdgeColor','k','MarkerFaceColor','none')
    %X2
    X2mean = mean(durMean.(char(param)).X2,1);
    X2std  = std(durMean.(char(param)).X2,[],1);
    h(2) = errorbar(pR.(char(param))+offset/2,X2mean,X2std,'ok');
    set(h(2),'MarkerSize',5,'MarkerEdgeColor','none','MarkerFaceColor','k')
    xlabel(char(param))
    ylabel('Mean period duration (mean +- std)')
    
    xlim([min(pR.(char(param)))-offset*5 max(pR.(char(param)))+offset*5])
    
    title(['Relation between mean period duration and symetric simulation parameters; Compiled across ' num2str(size(durMean.(char(param)).X1,1)) ' simulations of 10000 unit time'])
    legend(h,{'X1 fixed' 'X2 variable'},'Location','NorthWest')
end




% 
% 
% ind = 1000:2000;
% for param = {'gamma'};%{'I' 'gamma' 'sigma' 'alpha'}
%     for i = 1;%:length(Var.(char(param)))
%         figure('WindowStyle','docked'); hold on
%         subplot(2,1,1)
%         plot(times.(char(param)){i}(ind),Var.(char(param)){i}(ind,1:2))
%         Xdiff = max(diff(Var.(char(param)){i}(:,1:2),[],2));
%         Xend = mean(Var.(char(param)){i}(end,1:2));
%         if Xdiff
%             ylim([Xend-Xdiff Xend+Xdiff])
%         end
% %         xlim([0 size(Var.(char(param)){i},1)]);
%         title('ode45')
%         subplot(2,1,2)
%         plot(times.(char(param)){i}(ind),Var.(char(param)){i}(ind,3:4))
%         Adiff = max(diff(Var.(char(param)){i}(:,3:4),[],2));
%         Aend = mean(Var.(char(param)){i}(end,3:4));
%         if Adiff
%             ylim([Aend-Adiff Aend+Adiff])
%         end
% %         xlim([0 size(Var.(char(param)){i},1)]);
%     end
% end


end
