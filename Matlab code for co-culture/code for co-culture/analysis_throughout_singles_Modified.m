%{
    Code written by Ya-Chen Chuang
    November 2020
%}

% input directory & output Excel file directory
folder = 'C:\Users\ME System 3\Documents\projects\OL_DRG_coculture\AFM\2nd_round\2021-03-24\pos1-3\export_curve_xlsx_ordered_2';
OutputFolder = 'C:\Users\ME System 3\Documents\projects\OL_DRG_coculture\AFM\2nd_round\2021-03-24\pos1-3\export_curvefitting_2\';
outputfile = [OutputFolder 'output2.xlsx'];
force = 1;
speed = 125;
matname = 'OPC DRG';
% create output Excel file
xlswrite(outputfile,{'FileName','Material','Force (nN)/Speed (Hz)',...
    'Mooney Rivlin B1','Mooney Rivlin B2','Mooney Rivlin E (Pa)'...
    'Hertz b','Hertz E (Pa)','Ogden B','Ogden a','Ogden E (Pa)','Mooney Rivlin R','Hertz R','Ogden R'},1,'A1');


folderinfo = dir(folder);
count=2;
%{
for i = 1:length(folderinfo)
    fname = sprintf('day14_OPC_DRG_F1nN_v125Hz_pos1-3_%1d.xlsx',i-1);
    
    
    [num,txt,raw] = xlsread(fullfile(folder,fname));
    
    fdcurve = [num(:,1)*10^-9,num(:,2)*10^-12,num(:,3)*10^-9,num(:,4)*10^-12];
    %plot_names=['day # : ' num2str(spotnum) ', Force : ' num2str(force) ' nN, Velocity : ' num2str(speed) ' um/s'];
    plot_names=['Force : ' num2str(1) ' nN, Velocity : ' num2str(speed) ' Hz'];
    OutputFinal = fullfile(OutputFolder,sprintf('Figure_%d',i));
    [contact,fitvals,Es,Ball,Correlations]=fits5(fdcurve,(count-1)*2,plot_names,OutputFinal);
    %towrite={fname matname spotnum force speed Ball(1) Ball(2) Es(1) Ball(3) Ball(4) Es(2) Ball(5) Ball(6) Es(3)};
    %towrite={fname matname force Ball(1) Ball(2) Es(1) Ball(3) Ball(4) Es(2) Ball(5) Ball(6) Es(3)};
    towrite={fname matname force Ball(1) Ball(2) Es(1) Ball(3) Es(2) Ball(4) Ball(5) Es(3) Correlations(1) Correlations(2) Correlations(3)};
    line=['A' num2str(count)];
    xlswrite(outputfile,towrite,1,line);
    count=count+1;
    
end
%}
fmaps_Emaps(outputfile,folder,count);
