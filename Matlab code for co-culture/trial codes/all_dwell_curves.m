%{
    Code written by Ya-Chen Chuang
    December 2020
%}

% import files from txt
dirr='C:\Users\ME System 3\Documents\projects\OL DRG coculture\AFM\2nd round\2021-04-12\FV-1Hz\axon1-mye\relaxation';
txtpattern = fullfile(dirr, '*.txt');
dinfo = dir(txtpattern);

folder = 'C:\Users\ME System 3\Documents\projects\OL DRG coculture\AFM\dwell\files';
outputfile = [folder '\20210412_day14_axon1_mye.xlsx'];
count = 1
for i=1:size(dinfo,1)
    dwelldata = importdwell(dinfo(i).name);
    singlecurve = [dwelldata(1:end,1), dwelldata(1:end,2)]


% export xlsx file
    % column=[(:,num2str(count+2*i))];
    % line=['A' num2str(count)];
    % a = textread(txtpattern); 
    if isempty(dinfo) == 1
       c = 'A1';
    else
       ncolunms = (size(dinfo,1)) +2; % last row with data + 2 to write in the next empty row
       b = num2str(ncolunms); % convert number to string
       c = strcat('A', b);
       % c = strcat(b,1); % make concat strings
       writetable(singlecurve,outputfile,'sheet',c);
       
    end
   
end
