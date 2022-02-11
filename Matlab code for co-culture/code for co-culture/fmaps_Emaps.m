%{
    Code written by Zeynep Melis SUAR
    February 2018
%}
function fmaps_Emaps(inputfile,folder,count)

figure(count*2-3)

[Num, Txt, Raw] = xlsread(inputfile);
% line = size(Num,1);
% point = size(Num,1);
% % line = Num(:,3);
% % point = Num(:,4);
% Ogden = Num(:,11);
% 
% Matrixsize = size(Num,1);
% % size = max(max(line),max(point));
% 
% Es = zeros(Matrixsize,Matrixsize);
% 
% for k = 1:length(line)
%    
%     i = line(k)+1;
%     j = point(k)+1;
%     Es(i,j) = Ogden(k)/10^3;
%     
% end
% 
% x = unique(line);
% y = unique(point);
% 
% surf(x,y,Es);
% Data = reshape(Num(:,11),[32,32]);
Data = zeros(32,32);
Counter = 1;
for i = 1:32
    for j = 1:32
        Data(i,j) = Num(Counter,13);
        Counter = Counter + 1;
    end
end
        
figure
surface(Data)
colormap(jet)
shading interp

axis tight
% set(gca,'YTick',1:1:5)
% set(gca,'XTick',1:1:5)
% xlabel('\mu m')
% ylabel('\mu m')
zlabel('Young modulus E_0 (kPa)')

figname = [folder '\Emap.fig'];
savefig(figname)

end