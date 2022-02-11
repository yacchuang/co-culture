%{
    Code written by Ya-Chen Chuang
    April 2021
%}

% import files from txt
dirr='C:\Users\ME System 3\Documents\projects\OL DRG coculture\AFM\3rd round\2021-07-20\dwell\non-4\export curve';
txtpattern = fullfile(dirr, '*.txt');
dinfo = dir(txtpattern);


for i=1:size(dinfo,1)
    dwelldata = importdwell(dinfo(i).name);
    singlecurve = [dwelldata(1:end,1), dwelldata(1:end,2)]


% export xlsx file
    name = "day3_OPC_DRG_dwell_1Hz_5s_"+i;                   
    file_out = strcat(name,'.xlsx');
    writetable(singlecurve,file_out)
       
  
   
end
