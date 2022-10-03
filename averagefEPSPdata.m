clear all
filename  = dir('*.xls');
filename =  {filename(:).name};
eventname = {'BESt'}; %,'Blar','LNoi','BESt'
measurename = {'MSlope'};
Types=length(measurename);

for ii = 1:length(eventname)
    figure
    
    for kk = 1:Types
    [eventmean(:,kk),eventstd(:,kk),p(:,kk),after_mean,n] = average_event(filename,eventname{ii},kk);
    pairtime = findpattern(eventmean,[0;0;0]);
    
      
    subplot(2,1,kk)
    hold on
    title([eventname{ii},', p=',num2str(p(:,kk)),', after mean=',num2str(after_mean)])
    errorbar((1:length(eventmean(:,kk)))-pairtime(1),eventmean(:,kk),eventstd(:,kk),'b--o')
    xlim([-15 42])
    ylim([0.8 1.5])
    hold off
    
    subplot(2,1,kk+1)
    hold on
    title([measurename{kk},', n = ',num2str(n)])
    plot((1:length(eventmean(:,kk)))-pairtime(1),eventmean(:,kk),'--ks','MarkerSize',3, 'MarkerFaceColor','k')
    xlim([-15 40])
    ylim([0.8 1.5])
    hold off
    end
    
end