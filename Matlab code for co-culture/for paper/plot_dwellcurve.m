%{
    Code written by Ya-Chen Chuang
    August 2021
%}

clear all

% import files from txt
filename='C:\Users\ME System 3\Documents\projects\OL DRG coculture\manuscript figures\force curve data\day14_OPC_DRG_FV_v1Hz_mye-2_ForceCurveIndex_31.txt';
importforcecurve = readtable(filename);
% singlecurve = [importforcecurve(:,1), importforcecurve(:,2)];


%plot figure
% figure
t = importforcecurve{:,1};
f = importforcecurve{:,2};
plot(t,f)
% hold on
    
xlabel('Time (s)')
ylabel('Force (nN)')
ax.YLim = gca;
ax.XLim = [0 6];
ax.YAxis.Exponent = -9;
ax.FontSize = 12;
ax.TickDir = 'in';
ax.TickLength = [0.02 0.02];
% xlim([-1 round(t(end)+1)])
% legend('Dwell curve','Relaxation fit')
tittle.FontSize = 14;
title('Dwell curve')
    
    

