%{
    Code written by Zeynep Melis SUAR
    Janaury 2018
%}
function [contact,fitvals,Es,B_all]=fits4_limit(fdcurve,count,name,folder)
% fits = {[mooney rivlin] [fung] [hertz]}
% Es = [mrE fE hE]
%
% close all
% clear all

%load('exported_curves.mat')
%name='data_spot1_single_F60nN_2.mat';
%fdcurve=data.spot1.single.F60nN{3};
[d,f] = contpointRoVda(fdcurve,count,name,folder);

R = 3.5e-05;

dlimit = d(1) + 0.4e-6 ;
flaglimit = true;
countlim = 1;
if d(1)+dlimit<max(d)
    while flaglimit
        if d(countlim)>dlimit
            flaglimit = false;
        else
            countlim=countlim+1;
        end
    end
    
    dlimit = d(1:1:countlim);
    flimit = f(1:1:countlim);
else
    dlimit = d;
    flimit = f;
end
%% Mooney_Rivlin
mrmyfun = @(B,d)(B(3)+B(2)*pi*(((contrad(R,d)).^5-15*R*(contrad(R,d)).^4+75*R^2*(contrad(R,d)).^3)./(-(contrad(R,d)).^3 + 15*R*(contrad(R,d)).^2 - 75*R^2*(contrad(R,d))+ 125*R^3))...
    + B(1)*pi*((contrad(R,d)).^5-15*R*(contrad(R,d)).^4+75*R^2*(contrad(R,d)).^3)./(5*R*(contrad(R,d)).^2-50*R^2*(contrad(R,d))+125*R^3) );
pars = [40,200,0];
lb = [0 0 0];
ub = [40000 200000 100];

options = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt','TolX',1e-20,'TolFun',1e-20,...
    'MaxFunEvals',1000000000,'MaxIter',1000000000,'Display','off','OptimalityTolerance',1e-20);

[Bs] = lsqcurvefit(mrmyfun,pars,dlimit,flimit,lb,ub,options);

mrfitValues = mrmyfun(Bs,d);

figure(count)
subplot(2,2,1)
plot(d,f)
hold on
plot(d,mrfitValues)
xlabel('Indentation depth (\mum)')
ylabel('Force (nN)')
ax = gca;
ax.XAxis.Exponent = -6;
ax.YAxis.Exponent = -9;
legend('Contact curve','Mooney-Rivlin fit')

mrE = 9*pi*(1-0.49^2)*(Bs(1)+Bs(2))/20;
B_all = [Bs(1) Bs(2)];

%% Fung

fmyfun = @(B,d)(B(3)+exp(B(2)*(((contrad(R,d)).^3-15*R*(contrad(R,d)).^2)./(25*R^2*(contrad(R,d))-125*R^3)))...
    * B(1)*pi.*(((contrad(R,d)).^5-15*R*(contrad(R,d)).^4+75*R^2*(contrad(R,d)).^3)./(5*R*(contrad(R,d)).^2-50*R^2*(contrad(R,d))+ 125*R^3) ));

options = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt','TolX',1e-20,'TolFun',1e-20,...
    'MaxFunEvals',1000000000,'MaxIter',1000000000,'Display','off','OptimalityTolerance',1e-20);

[Bs] = lsqcurvefit(fmyfun,pars,d,f,lb,ub,options);

ffitValues = fmyfun(Bs,d);

subplot(2,2,2)
plot(d,f)
hold on
plot(d,ffitValues)
xlabel('Indentation depth (\mum)')
ylabel('Force (nN)')
ax = gca;
ax.XAxis.Exponent = -6;
ax.YAxis.Exponent = -9;
legend('Contact curve','Fung fit')

fE = 9*pi*(1-0.49^2)*(Bs(1))/20;
B_all = [B_all Bs(1)];

%% Hertz

hmyfun = @(E,d)(E/(1-0.49^2)*sqrt(R)*4/3*d.^(3/2));
pars = [100];
lb = [0];
up = [100000];

options = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt','TolX',1e-20,'TolFun',1e-20,...
    'MaxFunEvals',1000000000,'MaxIter',1000000000,'Display','off','OptimalityTolerance',1e-20);

[Bs] = lsqcurvefit(hmyfun,pars,d,f,lb,ub,options);

hfitValues = hmyfun(Bs,d);

subplot(2,2,3)
plot(d,f)
hold on
plot(d,hfitValues)
xlabel('Indentation depth (\mum)')
ylabel('Force (nN)')
ax = gca;
ax.XAxis.Exponent = -6;
ax.YAxis.Exponent = -9;
legend('Contact curve','Hertz fit')

hE = 9*pi*(1-0.49^2)*(Bs(1))/20;
B_all = [B_all Bs];

%% all

subplot(2,2,4)
plot(d,f)
hold on
plot(d,mrfitValues)
hold on
plot(d,ffitValues)
hold on
plot(d,hfitValues)
xlabel('Indentation depth (\mum)')
ylabel('Force (nN)')
ax = gca;


ax.XAxis.Exponent = -6;
ax.YAxis.Exponent = -9;
legend('Contact curve','Mooney-Rivlin fit','Fung fit','Hertz fit')
suptitle(name)

%% output
contact = [d f];
fitvals = {[d mrfitValues] [d ffitValues] [d hfitValues]};
Es = [mrE fE hE];
figname = [folder '_fit.fig'];
savefig(figname)

% %% display
% disp(['E from Mooney-Rivlin: ' num2str(mrE) ' Pa'])
% disp(['E from Fung: ' num2str(fE) ' Pa'])
% disp(['E from Hertz: ' num2str(hE) ' Pa'])
end