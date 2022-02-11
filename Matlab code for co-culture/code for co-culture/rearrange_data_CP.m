%{
    Code written by Ya-Chen Chuang
    December 2020
%}

% import files from txt
dirr='C:\Users\ME System 3\Documents\projects\OL DRG coculture\AFM\2nd round\2021-05-27\non-4\export curve';
txtpattern = fullfile(dirr, '*.txt');
dinfo = dir(txtpattern);
for i=1:size(dinfo,1)
    CPdata = importfile(dinfo(i).name);
    

% rearrange data column
    % normal data
    T=[CPdata(200:end,1) CPdata(200:end,5) CPdata(1:313,2) CPdata(1:313,6)];
    % 1kHz
    % T=[CPdata(100:end,1) CPdata(100:end,5) CPdata(1:157,2) CPdata(1:157,6)];
    %FV
    % T=[CPdata(170:end,1) CPdata(170:end,5) CPdata(1:87,2) CPdata(1:87,6)];
    % T=[CPdata(300:end,1) CPdata(300:end,5) CPdata(1:213,2) CPdata(1:213,6)];
    % irregular data
    % T=[CPdata(150:end,1) CPdata(150:end,5) CPdata(1:363,2) CPdata(1:363,6)]; 
    % T=[CPdata(157:end,1) CPdata(157:end,5) CPdata(1:100,2) CPdata(1:100,6)];
% export xlsx file
    name = "day3_OPC_DRG_F1nN_v125Hz_non-4_"+i;                   
    file_out = strcat(name,'.xlsx');
    writetable(T,file_out)
end
