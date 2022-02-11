%{
    Code written by Ya-Chen Chuang
    December 2020
%}
function [d,f] = contpointRoVda(data,count,name,folder)

%% whole curve
dold = [data(:,1)];
dold = dold((isnan(dold))==0);
fold = [data(:,2)];
fold = fold((isnan(dold))==0);
figure(count-1)
subplot(1,2,1)
plot(dold,fold);
xlabel('Indentation depth (nm)')
ylabel('Force (nN)')
ax = gca;
ax.XAxis.Exponent = -9;
ax.YAxis.Exponent = -9;

%% find contact point
RoV = [];
count = 1;
if length(dold)>500
    limit=260;
else
    % limit=30 %FV
    limit = 60; % normal
end
for i = limit+1:limit:length(dold)-limit
    before = fold(i-limit:i-1);
    after = fold(i+1:i+limit);
    RoV(count) = var(after)/var(before);
    count = count+1;
end

range = (find(max(RoV)==RoV))*limit-limit:(find(max(RoV)==RoV))*limit+limit;
hold on
if (range(1)==0)
    range(1)=[];
end

plot(dold(range),fold(range))


if length(dold)>500
    count = 1;
    limit=260;
    dtempp = dold(range);
    ftempp = fold(range);
    RoV=[];
    for i = limit+1:limit:length(dtempp)-limit
        before = ftempp(i-limit:i-1);
        after = ftempp(i+1:i+limit);
        RoV(count) = var(after)/var(before);
        count = count+1;
    end
    rangen = (find(max(RoV)==RoV))*limit-limit:(find(max(RoV)==RoV))*limit+limit;
    hold on
    if (rangen(1)==0)
        rangen(1)=[];
    end
    range = rangen+range(1);
end

plot(dold(range),fold(range))

alarm1 = mean(fold(range))-std(fold(range));
alarm2 = mean(fold(range));
hold on
plot(dold,ones(1,length(dold))*alarm1,':')
hold on
plot(dold,ones(1,length(dold))*alarm2,':')

flag1 = false;
flag2 = false;

i=range(1);
while (flag1==false && flag2==false) || flag2==false
    if fold(i) >= alarm1
        flag1 = true;
        j = i+1;
        while flag1==true && flag2==false
            if fold(j) <= alarm1
                flag1 = false;
            elseif fold(j) >= alarm2
                dpstart = i;
                flag2 = true;
            end
            j = j+1;
        end
    end
    i = i+1;
end

hold on
plot(dold(dpstart),fold(dpstart),'r*')

coeffs = polyfit(dold(1:dpstart),fold(1:dpstart),1);
fittedX = linspace(min(dold),max(dold),length(dold));
fittedY = polyval(coeffs,fittedX);
hold on
plot(dold,fittedY,'--')
legend('Original curve','Region chosen after RoV','1st Alarm','2nd Alarm','Contact Point','Best Fit of Non Contact Regime')

subplot(1,2,2)
fnew = fold-transpose(fittedY);
plot(dold,fnew)
coeffs = polyfit(dold(1:dpstart),fnew(1:dpstart),1);
fittedX1 = linspace(min(dold),max(dold),length(dold));
fittedY1 = polyval(coeffs,fittedX1);
hold on
plot(dold,fittedY1,'--')
legend('Tilted curve','Best Fit of Non Contact Regime')
sgtitle(name)

%% insert dpstart
ddif = dold(dpstart);
fdif = fnew(dpstart);
dtemp = dold-ddif;
ftemp = fnew-fdif;
dpend = length(dold);
d = dtemp(dpstart:dpend);
f = ftemp(dpstart:dpend);

figname = [folder '_contpoint.fig'];
savefig(figname)

end