%{
    Code written by Ya-Chen Chuang
    November 2020
%}

% input directory & output Excel file directory
folder = 'C:\Users\ME System 3\Documents\projects\OL DRG coculture\AFM\2nd round\2021-05-27\non-4\export curve xlsx';
outputfile = [folder '\output.xlsx']

% create output Excel file
xlswrite(outputfile,{'FileName','Material','Force (nN)/Speed (Hz)',...
    'Mooney Rivlin B1','Mooney Rivlin B2','Mooney Rivlin E (Pa)'...
    'Hertz b','Hertz E (Pa)','Ogden B','Ogden a','Ogden E (Pa)','Mooney Rivlin R','Hertz R','Ogden R'},1,'A1');


folderinfo = dir(folder);
count=2;

for i = 1:length(folderinfo)
    fname = folderinfo(i).name;
    filewhole = split(folderinfo(i).name,'.');
    extension = filewhole{2};
    fileinfo = filewhole{1};
    fileinfo2 = [folder '\' filewhole{1}];
    
    if isequal(extension,'xlsx')
        fileinfo = split(fileinfo,'_');
        
        if find(~cellfun('isempty',strfind(fileinfo,'OPC')))>0
            matname = 'OPC';
        elseif find(~cellfun('isempty',strfind(fileinfo,'DRG')))>0
            matname = 'DRG';
        else
            matname = 'not specified';
        end
        
        %spotinfo = fileinfo{find(~cellfun('isempty',strfind(fileinfo,'day')))};
        %spotnum = split(spotinfo,'day');
        %spotnum = str2num(spotnum{2});
        
        
        trig = fileinfo{find(~cellfun('isempty',strfind(fileinfo,'F')))};
        
        %% get the single force curves
        %if isequal(fileinfo{find(~cellfun('isempty',strfind(fileinfo,'day')))+1},'single')
            
            scanvel = fileinfo{find(~cellfun('isempty',strfind(fileinfo,'Hz')))};
            speed = split(scanvel,'v');
            speed = speed{2};
            speed = split(speed,'Hz');
            speed = speed{1};
            speed = str2num(speed);
            
            force = split(trig,'F');
            force = force{2};
            force = split(force,'nN');
            force = force{1};
            force = str2num(force);
            
            [num,txt,raw] = xlsread([folder '\' folderinfo(i).name]);
            fdcurve = [num(:,1)*10^-9,num(:,2)*10^-12,num(:,3)*10^-9,num(:,4)*10^-12];
            %plot_names=['day # : ' num2str(spotnum) ', Force : ' num2str(force) ' nN, Velocity : ' num2str(speed) ' um/s'];
            plot_names=['Force : ' num2str(force) ' nN, Velocity : ' num2str(speed) ' Hz'];
            [contact,fitvals,Es,Ball,Correlations]=fits5(fdcurve,(count-1)*2,plot_names,fileinfo2);
            %towrite={fname matname spotnum force speed Ball(1) Ball(2) Es(1) Ball(3) Ball(4) Es(2) Ball(5) Ball(6) Es(3)};
            %towrite={fname matname force Ball(1) Ball(2) Es(1) Ball(3) Ball(4) Es(2) Ball(5) Ball(6) Es(3)};
            towrite={fname matname force Ball(1) Ball(2) Es(1) Ball(3) Es(2) Ball(4) Ball(5) Es(3) Correlations(1) Correlations(2) Correlations(3)};
            line=['A' num2str(count)];
            xlswrite(outputfile,towrite,1,line);
            count=count+1;
            
        end
        
    end
