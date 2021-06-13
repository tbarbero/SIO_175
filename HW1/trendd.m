% compute and output the trend variables for yearly-averaged (var) anomaly
function [b,bint] = trendd(time_array,ya_var_anom,o)
% inputs:
% time_array: differs with size of thermodynamic variable
% o: order of the problem, 1==linear, 2==quadratic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
years = unique(year(datetime(time_array,'convertfrom','datenum')));
% change x depending on order of polynomial
if o==1
    x = [years-nanmean(years) ones(length(years),1)];
elseif o==2
    x = [(years-nanmean(years)).^2 years-nanmean(years) ones(length(years),1)]; 
end
% solve normal equation    
[b,bint] = regress(ya_var_anom,x);
% plot
plot(years,ya_var_anom,'HandleVisibility','off');hold on
plot(years,x*b);hold off
ci = (bint(1,2)-bint(1,1))/2;
a = ['Trend: ',num2str(b(1),2),' +/- ',num2str(ci,2),' ^oC/yr'];
% I just realized that this will label the 
legend({a},'location','best')
end
% do labeling outside of function