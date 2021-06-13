function [mean_t, mean_var] = monthly_avg(time,var,N)
% time - time array
% var - variable of interest
% N - minimum number of points required for an average

[y,m,d] = datevec(time);
uy = unique(y);
nuy = numel(uy);
% define variables
mean_t=NaN(nuy*12,1); % months 
mean_var=NaN(nuy*12,1);
jj=1;%counter
for i=1:nuy % years
    for j=1:12 % months
        g = find(y==uy(i) & m==j); % goes through every month
        flag = find(~isnan(var(g)));
        if numel(flag) > N % N - min number of points in average
            mean_var(jj) = nanmean(var(g));
        end
        % set time as the 15th of the month
        mean_t(jj) = mean(time(g));
        jj=jj+1; %index through every month of all years
    end
end
%clip nans
kn = find(~isnan(mean_var));
mean_t = mean_t(kn(1):kn(end));
mean_var = mean_var(kn(1):kn(end));
% mean_t = datetime(mean_t,'ConvertFrom','datenum');
end