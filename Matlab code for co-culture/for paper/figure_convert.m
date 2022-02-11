function[]=figure_convert(folder)
% input directory
folder = 'X:\Meninges - Gloria&Zeynep\AFM\180907_cant15_fluo\AFM\Exported curves\Plots\FMap1\old';

% directory of ForceMap Excel files
folderinfo = dir(folder);
count=2;
mkdir ([folder,'\jpegImages-',date]);
for i = 1:length(folderinfo)
    % get the file name
    fname = folderinfo(i).name;
    filewhole = split(folderinfo(i).name,'.');
    % check the extension - (to only get the .csv files)
    if size(filewhole) == [1 1]
        extension = 'NaN';
    else
        extension = filewhole{2};
    end
    %% if the extension is .csv : proceed
    if isequal(extension,'fig')
        % remove the directory to only get the name of FMap file
        fileinfo = filewhole{1};
        fileinfo2 = [folder '\' filewhole{1}];
        % acquire the FMap info from its name
        fileinfo = split(fileinfo,'_');
        fig = openfig([folder '\' fname],'new','visible'); %% USE THIS TO OPEN UNOPENING FIGURES IM SORRY -ZEYNEP
        saveas(fig,[folder '\jpegImages-' date '\' fname '.png']);
        close all
    end
end
end