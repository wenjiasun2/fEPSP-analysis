function data_r = ar_outlier( data, pairtime, threshold )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
pairtime = pairtime+3;
after_m = nanmean(data(pairtime:end));
after_sd = nanstd(data(pairtime:end));
data_r = data;
outlier = find((data_r(pairtime:end)>after_m+threshold*after_sd)|(data_r(pairtime:end)<after_m-threshold*after_sd))+pairtime-1;
for ii = 1:length(outlier)
    if outlier(ii) == pairtime
        data_r(outlier(ii)) = data_r(outlier(ii)+1);
    elseif outlier(ii) == length(data_r)
        data_r(outlier(ii)) = data_r(outlier(ii)-1);
    else
        data_r(outlier(ii)) = (data_r(outlier(ii)-1)+data_r(outlier(ii)+1))/2;
    end
end


end

