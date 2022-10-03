function data_r = br_outlier( data, pairtime, threshold )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
baseline_m = nanmean(data(1:pairtime-1));
baseline_sd = nanstd(data(1:pairtime-1));
data_r = data;
outlier = find((data_r(1:pairtime-1)>baseline_m+threshold*baseline_sd)|(data_r(1:pairtime-1)<baseline_m-threshold*baseline_sd));
for ii = 1:length(outlier)
    if outlier(ii) == 1
        data_r(outlier(ii)) = data_r(2);
    elseif outlier(ii) == pairtime - 1
        data_r(outlier(ii)) = data_r(outlier(ii)-1);
    else
        data_r(outlier(ii)) = (data_r(outlier(ii)-1)+data_r(outlier(ii)+1))/2;
    end
end

end

