function t0 = FLIMfit(decay,timeInterval)
% Fitting fluorescence lifetime from fluorescence decay
% ******************************************************************************
% decay:           fluorescence decay
% timeInterval:    time resolution of fluorescence decay

myfunc=@(beta,x) beta(1).*exp(-1/beta(2).*x);
TimeAxis = (0:(length(decay)-1))*timeInterval;
I0 = decay(1);
It = I0/exp(1);
[~,column] = find(decay<=It);
t0Ini=column(1).*timeInterval;
beta=nlinfit(TimeAxis,decay,myfunc,[I0,t0Ini]);
t0 = beta(2);

end