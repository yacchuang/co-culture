%{
    Code written by Ya-Chen Chuang
    April 2021
%}

clear;clc;close all
warning('off','all')

folder = 'C:\Users\ME System 3\Documents\projects\OL DRG coculture\AFM\3rd round\2021-07-22\dwell\non-3\export curve xlsx';


% create output Excel file

outputfile = [folder '\dwell_output.xlsx']
towrite = {'Date','FMap','Type','1D a0','1D a1','1D Tau1','1D R2 Err','2D a0','2D a1','2D a2','2D Tau1','2D Tau2','2D R2 Err'};
xlswrite(outputfile,towrite,1,'A1');

direct = dir(folder);
count=2;

for i = 1:length(direct)
    fname = direct(i).name;
    filewhole = split(direct(i).name,'.');
    extension = filewhole{2};
    fileinfo = filewhole{1};
    fileinfo2 = [folder '\' filewhole{1}];
    mkdir(folder)
    mkdir([folder '\png'])
    
    if isequal(extension,'xlsx')
        fileinfo = split(fileinfo,'_');
        
        if find(~cellfun('isempty',strfind(fileinfo,'OPC')))>0
            matname = 'OPC';
        elseif find(~cellfun('isempty',strfind(fileinfo,'DRG')))>0
            matname = 'DRG';
        else
            matname = 'not specified';
        end
        
       
        trig = fileinfo{find(~cellfun('isempty',strfind(fileinfo,'dwell')))};
        
        %% get the single dwell curves
       
        [num,txt,raw] = xlsread([folder '\' direct(i).name]);
        fdcurve = [num(:,1),num(:,2)*10^-12];
        filename = [fname];
        disp('-----------------------------------')
        disp(['Results for ' filename ':'])
        [Bs1d,Err1d,Bs2d,Err2d] = relax(fdcurve,filename,folder);
        % a0 = B(3) a1 = B(2) tau1 = B(1)
        % a0 = B(5) a1 = B(3) a2 = B(4) tau1 = B(1) tau2 = B(2)
        
        
        towrite = {fileinfo{1},fileinfo{2},fileinfo{3},Bs1d(3),Bs1d(2),Bs1d(1),Err1d,Bs2d(5),Bs2d(3),Bs2d(4),Bs2d(1),Bs2d(2),Err2d};
        line=['A' num2str(count)];
        xlswrite(outputfile,towrite,1,line);    
        count=count+1;
    end
    % xlswrite(excfname,towrite,1)
    close all
end
warning('on','all')