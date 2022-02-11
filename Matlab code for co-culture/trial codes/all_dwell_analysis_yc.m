clear;clc;close all
warning('off','all')

folderall = 'C:\Users\ME System 3\Documents\projects\OL DRG coculture\AFM\dwell';

folder_toread = [folderall '\files'];
direct = dir(folder_toread);
count=2;


for j = 3:length(direct)
    fname = [folder_toread '\' direct(j).name];
    fileinfo = split(direct(j).name,{'_','.'});
    folder = [folderall '\' fileinfo{1} '_' fileinfo{2}];
    mkdir(folder)
    mkdir([folder '\png'])
    [num,txt] = xlsread(fname);
   
    excfname = [folder '\outputs.xlsx'];
    towrite = {'Date','FMap','Type','1D a0','1D a1','1D Tau1','1D R2 Err','2D a0','2D a1','2D a2','2D Tau1','2D Tau2','2D R2 Err'};
    xlswrite(excfname,towrite,1,'A1')
    % count=2;
    
    
    for i=1:2:length(txt)
        lpinfo = txt(1,i);
        lpnums = split(lpinfo,'Line');
        linenum = split(lpnums{2},'Point');
        pointnum = split(linenum{2},'Time_Towd_Ret');
        linenum = str2num(linenum{1});
        pointnum = str2num(pointnum{1});
        
        fdcurve = num(:,i:i+1);
        filename = ['Line' num2str(linenum) ' Point' num2str(pointnum)];
        disp('-----------------------------------')
        disp(['Results for ' filename ':'])
        [Bs1d,Err1d,Bs2d,Err2d] = relax(fdcurve,filename,folder);
        % a0 = B(3) a1 = B(2) tau1 = B(1)
        % a0 = B(5) a1 = B(3) a2 = B(4) tau1 = B(1) tau2 = B(2)
        
        
        towrite = [towrite;{fileinfo{1},fileinfo{2},fileinfo{3},Bs1d(3),Bs1d(2),Bs1d(1),Err1d,Bs2d(5),Bs2d(3),Bs2d(4),Bs2d(1),Bs2d(2),Err2d}];
        line=['A' num2str(count)];
        xlswrite(excfname,towrite,1,line);    
        count=count+1;
    end
    % xlswrite(excfname,towrite,1)
    close all
end
warning('on','all')