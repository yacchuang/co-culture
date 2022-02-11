fileDir = 'C:\Users\ME System 3\Documents\projects\OL DRG coculture\AFM\2nd round\2021-04-12\FV-1Hz\axon1-mye\relaxation';
folder = 'C:\Users\ME System 3\Documents\projects\OL DRG coculture\AFM\dwell\files';
outputfile = [folder '\20210412_day14_axon1_mye.xlsx'];
addpath(fileDir);
fileNames = dir(fileDir);
fileNames = {fileNames.name};
fileNames = fileNames(cellfun(...
    @(f)~isempty(strfind(f,'.txt')),fileNames));
for f = 1:numel(fileNames),
    fTable = readtable(fileNames{f});
    line=['A' num2str(count)];

    writetable(fTable,outputfile,'sheet',line);
end