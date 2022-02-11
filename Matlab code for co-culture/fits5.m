%{
    Code written by Ya-Chen Chuang
    December 2020
%}
function [contact,fitvals,Es,B_all,Correlations]=fits5(fdcurve,count,name,folder)
% fits = {[mooney rivlin] [fung] [hertz]}
% Es = [mrE fE hE]
% 
% close all
% clear all

%load('exported_curves.mat')
%name='data_spot1_single_F60nN_2.mat';
%fdcurve=data.spot1.single.F60nN{3};
[d,f] = contpointRoVda(fdcurve,count,name,folder);

R = 70e-09;


%% Mooney_Rivlin
mrmyfun = @(B,d)(B(3)+B(2)*pi*(((contrad(R,d)).^5-15*R*(contrad(R,d)).^4+75*R^2*(contrad(R,d)).^3)./(-(contrad(R,d)).^3 + 15*R*(contrad(R,d)).^2 - 75*R^2*(contrad(R,d))+ 125*R^3))...
    + B(1)*pi*((contrad(R,d)).^5-15*R*(contrad(R,d)).^4+75*R^2*(contrad(R,d)).^3)./(5*R*(contrad(R,d)).^2-50*R^2*(contrad(R,d))+125*R^3) );
pars = [40,100,0];
lb = [0 0 0];
ub = [1000000 20000 0];

options = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt','TolX',1e-16,'TolFun',1e-16,...
    'MaxFunEvals',10000000,'MaxIter',10000000,'Display','off','OptimalityTolerance',1e-16);

[Bs] = lsqcurvefit(mrmyfun,pars,d,f,lb,ub,options);

mrfitValues = mrmyfun(Bs,d);

figure(count)
subplot(2,2,1)
plot(d,f)
hold on
plot(d,mrfitValues)
xlabel('Indentation depth (nm)')
ylabel('Force (nN)')
ax = gca;
ax.XAxis.Exponent = -9;
ax.YAxis.Exponent = -9;
legend('Contact curve','Mooney-Rivlin fit')

mrE = 9*pi*(1-0.49^2)*(Bs(1)+Bs(2))/20;
B_all = [Bs(1) Bs(2)];

%% Hertz

hmyfun = @(E,d)(E/(1-0.49^2)*sqrt(R)*4/3*d.^(3/2));
pars = [100];
lb = [0];
up = [100000];

options = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt','TolX',1e-20,'TolFun',1e-20,...
    'MaxFunEvals',1000000000,'MaxIter',1000000000,'Display','off','OptimalityTolerance',1e-20);

[Bs] = lsqcurvefit(hmyfun,pars,d,f,lb,ub,options);

hfitValues = hmyfun(Bs,d);

subplot(2,2,2)
plot(d,f)
hold on
plot(d,hfitValues)
xlabel('Indentation depth (nm)')
ylabel('Force (nN)')
ax = gca;
ax.XAxis.Exponent = -9;
ax.YAxis.Exponent = -9;
legend('Contact curve','Hertz fit')

hE = 9*pi*(1-0.49^2)*(Bs(1))/20;
B_all = [B_all Bs(1)];

%% Fung
%{
fmyfun = @(B,d)(B(3)+exp(B(2)*(((contrad(R,d)).^3-15*R*(contrad(R,d)).^2)./(25*R^2*(contrad(R,d))-125*R^3)))...
    * B(1)*pi.*(((contrad(R,d)).^5-15*R*(contrad(R,d)).^4+75*R^2*(contrad(R,d)).^3)./(5*R*(contrad(R,d)).^2-50*R^2*(contrad(R,d))+ 125*R^3) ));
pars = [1,10,0];
lb = [0 0 0];
ub = [2000000 2000 0];

options = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt','TolX',1e-15,'TolFun',1e-15,...
    'MaxFunEvals',1000000,'MaxIter',1000000,'Display','off','OptimalityTolerance',1e-16);

[Bs] = lsqcurvefit(fmyfun,pars,d,f,lb,ub,options);

ffitValues = fmyfun(Bs,d);

subplot(2,2,2)
plot(d,f)
hold on
plot(d,ffitValues)
xlabel('Indentation depth (nm)')
ylabel('Force (nN)')
ax = gca;
ax.XAxis.Exponent = -9;
ax.YAxis.Exponent = -9;
legend('Contact curve','Fung fit')

fE = 9*pi*(1-0.49^2)*(Bs(1))/20;
B_all = [B_all Bs(1) Bs(2)];

%}

%% Ogden Fit

omyfun = @(B,d)(B(3) + B(1)/B(2)*pi.*(contrad(R,d)).^2 .* ((1-0.2.*contrad(R,d)/R).^(-B(2)/2-1) - (1-0.2.*contrad(R,d)/R).^(B(2)-1)));

options = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt','TolX',1e-15,'TolFun',1e-15,...
    'MaxFunEvals',1000000,'MaxIter',1000000,'Display','off','OptimalityTolerance',1e-16);

pars = [10,0.1,0];
lb = [0 0 0];
ub = [3000000 200000 0];
%{
pars = [40,0.5,0];
lb = [0 0 0];
ub = [40000 5 100];
%}
[Bs] = lsqcurvefit(omyfun,pars,d,f,lb,ub,options);

ofitValues = omyfun(Bs,d);

subplot(2,2,3)
plot(d,f)
hold on
plot(d,ofitValues)
xlabel('Indentation depth (nm)')
ylabel('Force (nN)')
ax = gca;
ax.XAxis.Exponent = -9;
ax.YAxis.Exponent = -9;
legend('Contact curve','Ogden fit')

oE = 9*pi*(1-0.49^2)*(Bs(1))/40;
B_all = [B_all Bs(1) Bs(2)];

%% all

subplot(2,2,4)
plot(d,f)
hold on
plot(d,mrfitValues)
hold on
plot(d,hfitValues)
hold on
plot(d,ofitValues)
xlabel('Indentation depth (nm)')
ylabel('Force (nN)')
ax = gca;


ax.XAxis.Exponent = -9;
ax.YAxis.Exponent = -9;
legend('Contact curve','Mooney-Rivlin fit','Hertz fit','Ogden fit')
%legend('Contact curve','Mooney-Rivlin fit','Ogden fit')
sgtitle(name)
close all
%% output
contact = [d f];
fitvals = {[d mrfitValues] [d hfitValues] [d ofitValues]};
%fitvals = {[d mrfitValues] [d ofitValues]};
Es = [mrE hE oE];
%Es = [mrE oE];

figname = [folder '_fit.fig'];
savefig(figname)
yfit = mrfitValues; y=f;
SStot = sum((y-mean(y)).^2);                            % Total Sum-Of-Squares
SSres = sum((y(:)-yfit(:)).^2);                         % Residual Sum-Of-Squares
RsqMr = 1-SSres/SStot;                                    % R^2
yfit = hfitValues; y=f;
SStot = sum((y-mean(y)).^2);                            % Total Sum-Of-Squares
SSres = sum((y(:)-yfit(:)).^2);                         % Residual Sum-Of-Squares
RsqH = 1-SSres/SStot;
yfit = ofitValues; y=f;
SStot = sum((y-mean(y)).^2);                            % Total Sum-Of-Squares
SSres = sum((y(:)-yfit(:)).^2);                         % Residual Sum-Of-Squares
RsqO = 1-SSres/SStot;
Correlations = [RsqMr RsqH RsqO];

%Correlations = [corr2(f,mrfitValues) corr2(f,hfitValues) corr2(f,ofitValues)];
disp(['E from Mooney-Rivlin: ' num2str(mrE) ' Pa'])
disp(['E from Hertz: ' num2str(hE) ' Pa'])
disp(['E from Ogden: ' num2str(oE) ' Pa'])
end