function plot_vanLoonSims(nDataPts,offSet,cur_times,cur_Var,titleStr,I)

% nDataPts = 20000;
% offSet = 50000;
figure('WindowStyle','docked'); hold on
subplot(2,1,1); hold on
plot(cur_times(offSet:offSet+nDataPts),cur_Var(offSet:offSet+nDataPts,1),'-r','linewidth',3)
plot(cur_times(offSet:offSet+nDataPts),cur_Var(offSet:offSet+nDataPts,2),'-g','linewidth',3)
if exist('titleStr','var')
    title(['Dynamic evolution of the system  ' num2str(titleStr)])
else
    title('Dynamic evolution of the system')
end
% legend({'X1' 'X2'})
% set(gca,'yTickLabel','')
% set(gca,'xTickLabel','')
xlim(cur_times([offSet offSet+nDataPts])+[-10 0]')
ylim([-0.1 2])
set(gca,'xTickLabel','')
subplot(2,1,2); hold on
plot(cur_times(offSet:offSet+nDataPts),cur_Var(offSet:offSet+nDataPts,3),'-r','linewidth',3)
plot(cur_times(offSet:offSet+nDataPts),cur_Var(offSet:offSet+nDataPts,4),'-g','linewidth',3)
% legend({'A1' 'A2'})
% set(gca,'yTickLabel','')
xlim(cur_times([offSet offSet+nDataPts])+[-10 0]')
% ylim([0 0.05])
xlabel('time (unitless)')
% spaceplots