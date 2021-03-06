function f = plot_vanLoonSims(end_time,start_time,cur_times,cur_Var,titleStr,I)

ind = cur_times>start_time & cur_times<end_time;
cur_Var = cur_Var(ind,:);
cur_times = cur_times(ind,:);

% if offSet+end_time > length(cur_times)
%     end_time = length(cur_times) - offSet;
% end


% nDataPts = 20000;
% offSet = 50000;
f = figure('WindowStyle','docked'); hold on
subplot(2,1,1); hold on
plot(cur_times,cur_Var(:,1),'-r')
plot(cur_times,cur_Var(:,2),'-g')
axis tight
% plot(cur_times(offSet:offSet+end_time),cur_Var(offSet:offSet+end_time,1),'-r','linewidth',2)
% plot(cur_times(offSet:offSet+end_time),cur_Var(offSet:offSet+end_time,2),'-g','linewidth',2)
if exist('titleStr','var')
    title(['Dynamic evolution of the system  ' num2str(titleStr)])
else
    title('Dynamic evolution of the system')
end
% legend({'X1' 'X2'})
% set(gca,'yTickLabel','')
% set(gca,'xTickLabel','')
% xlim(cur_times([offSet offSet+end_time])+[-10 0]')
% ylim([0 1])
set(gca,'xTickLabel','')

% subplot(2,2,2); hold on
% plot(cur_times,cur_Var(:,1),'-r','linewidth',2)
% plot(cur_times,cur_Var(:,2),'-g','linewidth',2)
% % plot(cur_times(end-end_time:end),cur_Var(end-end_time:end,1),'-r','linewidth',2)
% % plot(cur_times(end-end_time:end),cur_Var(end-end_time:end,2),'-g','linewidth',2)
% % xlim(cur_times([end-end_time end]))
% ylim([0.79 0.86])

subplot(2,1,2); hold on
plot(cur_times,cur_Var(:,3),'-r')
plot(cur_times,cur_Var(:,4),'-g')
axis tight
% plot(cur_times(offSet:offSet+end_time),cur_Var(offSet:offSet+end_time,3),'-r','linewidth',3)
% plot(cur_times(offSet:offSet+end_time),cur_Var(offSet:offSet+end_time,4),'-g','linewidth',3)
% legend({'A1' 'A2'})
% set(gca,'yTickLabel','')
% xlim(cur_times([offSet offSet+end_time])+[-10 0]')
% ylim([0 0.05])
xlabel('time (unitless)')
% spaceplots

% subplot(2,2,4); hold on
% plot(cur_times(end-end_time:end),cur_Var(end-end_time:end,3),'-r','linewidth',3)
% plot(cur_times(end-end_time:end),cur_Var(end-end_time:end,4),'-g','linewidth',3)
% xlim(cur_times([end-end_time end]))