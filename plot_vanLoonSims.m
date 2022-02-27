function plot_vanLoonSims(nDataPts,offSet,cur_times,cur_Var,titleStr,I)

% nDataPts = 20000;
% offSet = 50000;
figure('WindowStyle','docked'); hold on
subplot(2,2,1); hold on
plot(cur_times(offSet:offSet+nDataPts),cur_Var(offSet:offSet+nDataPts,1),'-r','linewidth',2)
plot(cur_times(offSet:offSet+nDataPts),cur_Var(offSet:offSet+nDataPts,2),'-g','linewidth',2)
if exist('titleStr','var')
    title(['Dynamic evolution of the system  ' num2str(titleStr)])
else
    title('Dynamic evolution of the system')
end
% legend({'X1' 'X2'})
% set(gca,'yTickLabel','')
% set(gca,'xTickLabel','')
xlim(cur_times([offSet offSet+nDataPts])+[-10 0]')
ylim([0 1])
set(gca,'xTickLabel','')

subplot(2,2,2); hold on
plot(cur_times(end-nDataPts:end),cur_Var(end-nDataPts:end,1),'-r','linewidth',2)
plot(cur_times(end-nDataPts:end),cur_Var(end-nDataPts:end,2),'-g','linewidth',2)
xlim(cur_times([end-nDataPts end]))
ylim([0.79 0.86])

subplot(2,2,3); hold on
plot(cur_times(offSet:offSet+nDataPts),cur_Var(offSet:offSet+nDataPts,3),'-r','linewidth',3)
plot(cur_times(offSet:offSet+nDataPts),cur_Var(offSet:offSet+nDataPts,4),'-g','linewidth',3)
% legend({'A1' 'A2'})
% set(gca,'yTickLabel','')
xlim(cur_times([offSet offSet+nDataPts])+[-10 0]')
% ylim([0 0.05])
xlabel('time (unitless)')
% spaceplots

subplot(2,2,4); hold on
plot(cur_times(end-nDataPts:end),cur_Var(end-nDataPts:end,3),'-r','linewidth',3)
plot(cur_times(end-nDataPts:end),cur_Var(end-nDataPts:end,4),'-g','linewidth',3)
xlim(cur_times([end-nDataPts end]))