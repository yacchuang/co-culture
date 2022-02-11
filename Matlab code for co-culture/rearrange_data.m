%{
    Code written by Ya-Chen Chuang
    December 2020
%}

% import files from txt
dirr='C:\Users\ME System 3\Documents\projects\OL DRG coculture\AFM\110420 day 16 myelin\Area1\export curve text-2';
txtpattern = fullfile(dirr, '*.txt');
dinfo = dir(txtpattern);
for i=1:size(dinfo,1)
    importdata = importfile(dinfo(i).name);

% rearrange data column

    T=[importdata(:,1) importdata(:,5) importdata(:,2) importdata(:,6)];
% export xlsx file
    name = "day16_OPC_DRG_F800pN_v500Hz_ForceCurveIndex_"+i;                   
    file_out = strcat(name,'.xlsx');
    writetable(T,file_out)
end
