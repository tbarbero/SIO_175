function [S,f,ubound,lbound] = autospec(x,dt,Navg,alpha)
% autospec computes the autospectrum, S, with upper and lower bounds for
% the confidence interval (1-alpha)*100

N = length(x);

% take fourier transform and pos freq from f1 to f2
if(rem(N,2))
   x = x(1:end-1);
   N = N-1;
end
X = fft(x);
f = (1:N/2)'/(N*dt);

% form the autospectrum and average
S = abs(X(2:N/2+1)).^2/N*dt;  %index 2 corresponds to 1/(N*dt), index N/2+1 to 1/(2*dt)
S(1:end-1) = 2*S(1:end-1);
S = movmean(S,Navg,'Endpoints','shrink'); 

% upper and lower bounds 
nu = 2*Navg;            %degrees of freedom increases with band averaging
ubound = nu/chi2inv(alpha/2,nu);
lbound = nu/chi2inv(1-alpha/2,nu);
end