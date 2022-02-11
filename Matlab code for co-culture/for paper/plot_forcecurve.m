%{
    Code written by Ya-Chen Chuang
    August 2021
%}

clear all

% import files from txt
retractcurve='C:\Users\ME System 3\Documents\projects\OL DRG coculture\manuscript figures\force curve data\day14_OPC_DRG_F1nN_v125Hz_non-1_ForceCurveIndex_439.txt';
importretractcurve = readtable(retractcurve);

extendcurve='C:\Users\ME System 3\Documents\projects\OL DRG coculture\manuscript figures\force curve data\day14_OPC_DRG_F1nN_v125Hz_non-1_ForceCurveIndex_439_extend.txt';
importextendcurve = readtable(extendcurve);

%plot figure
figure
d1 = importretractcurve{:,1};
f1 = importretractcurve{:,2};
d2 = importextendcurve{:,1};
f2 = importextendcurve{:,2};
plot(d2,f2)
hold on
plot(d1,f1)
    
xlabel('Indentation (nm)')
ylabel('Force (pN)')
ax.YLim = gca;
ax.XLim = [0 6];
ax.YAxis.Exponent = -12;
ax.FontSize = 12;
ax.TickDir = 'in';
ax.TickLength = [0.02 0.02];
% xlim([-1 round(t(end)+1)])
legend('extend','retract')
tittle.FontSize = 14;
title('Force curve')
    
    

