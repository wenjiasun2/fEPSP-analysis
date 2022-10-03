function [eventmean,eventstd,p,after_mean,n] = average_event( filename, event, colnum )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
jj = 0;
for ii = 1:length(filename)
    if ~isempty(strfind(filename{ii},event))
        jj = jj + 1;
        data = xlsread(filename{ii});
        data = data(:,colnum);
        
        % use [0;0;0] to find the pairing time
        pairtime = findpattern(data,[0;0;0]);
        pairtime = pairtime(1);
        
        for kk = 1:3
           data = br_outlier(data,pairtime,1.5);
        end
        

        for kk = 1:3
           data = ar_outlier(data,pairtime,1.5);
        end
        
        baseline_m = nanmean(data(1:pairtime-1));
        data = data/baseline_m;
        
        shift = 0;
        if jj > 1
            a = findpattern(dataall(:,1),[0;0;0]);
            b = findpattern(data,[0;0;0]);
            shift = a(1) - b(1);
          
        end
 
        
        if shift >= 0
            dataall(1+shift:length(data)+shift,jj) = data;
        else
            dataall(1:length(data)+shift(1),jj) = data(-shift+1:length(data));
        end
    end
end

n = jj;

eventmean = nanmean(dataall,2);
eventstd =  nanstd(dataall,0,2)/sqrt(size(dataall,2)-1);

pairtime = findpattern(dataall(:,1),[0;0;0]);
pairtime = pairtime(1);
writematrix(dataall(pairtime-15:pairtime+42,:),"Column" + string(colnum)+"allRecSites.csv");
writematrix(eventmean(pairtime-15:pairtime+42,:),"eventmean.csv");
writematrix(eventstd(pairtime-15:pairtime+42,:),"eventsem.csv");

before =  mean(dataall(pairtime-10:pairtime-1,:),1)
writematrix(before',"Column" + string(colnum)+"before.csv");
after = mean(dataall(pairtime+33:pairtime+42,:),1)
writematrix(after',"Column" + string(colnum)+"after.csv");
after_mean = mean(after);
[h,p] = ttest(before,after);

end

