low_comparison = [];
high_comparison = [];

%% 180614
% 4 and 3 - low
for i = 1:size(low_v50,1)
    if low_v10(i,:).Date==20180614 && low_v10(i,:).ForceMap==4
        for j = 1:size(low_v50,1)
            if low_v50(j,:).Date==20180614 && low_v50(j,:).ForceMap==3
                if low_v10(i,:).Line==low_v50(j,:).Line && ...
                        low_v10(i,:).Point==low_v50(j,:).Point
                    low_comparison = [low_comparison;low_v10(i,:).OgdenEPa low_v50(j,:).OgdenEPa];
                end
            end
        end
    end
end
% 6 and 7 - high
for i = 1:size(high_v10,1)
    if high_v10(i,:).Date==20180614 && high_v10(i,:).ForceMap==6
        for j = 1:size(high_v50,1)
            if high_v50(j,:).Date==20180614 && high_v50(j,:).ForceMap==7
                if high_v10(i,:).Line==high_v50(j,:).Line && ...
                        high_v10(i,:).Point==high_v50(j,:).Point
                    high_comparison = [high_comparison;high_v10(i,:).OgdenEPa high_v50(j,:).OgdenEPa];
                end
            end
        end
    end
end
% 8 and 9 - high
for i = 1:size(high_v10,1)
    if high_v10(i,:).Date==20180614 && high_v10(i,:).ForceMap==8
        for j = 1:size(high_v50,1)
            if high_v50(j,:).Date==20180614 && high_v50(j,:).ForceMap==9
                if high_v10(i,:).Line==high_v50(j,:).Line && ...
                        high_v10(i,:).Point==high_v50(j,:).Point
                    high_comparison = [high_comparison;high_v10(i,:).OgdenEPa high_v50(j,:).OgdenEPa];
                end
            end
        end
    end
end
% 11 and 10 - high
for i = 1:size(high_v10,1)
    if high_v10(i,:).Date==20180614 && high_v10(i,:).ForceMap==11
        for j = 1:size(high_v50,1)
            if high_v50(j,:).Date==20180614 && high_v50(j,:).ForceMap==10
                if high_v10(i,:).Line==high_v50(j,:).Line && ...
                        high_v10(i,:).Point==high_v50(j,:).Point
                    high_comparison = [high_comparison;high_v10(i,:).OgdenEPa high_v50(j,:).OgdenEPa];
                end
            end
        end
    end
end
%% 180621
% 16 and 14 - high
for i = 1:size(high_v10,1)
    if high_v10(i,:).Date==20180621 && high_v10(i,:).ForceMap==16
        for j = 1:size(high_v50,1)
            if high_v50(j,:).Date==20180621 && high_v50(j,:).ForceMap==14
                if high_v10(i,:).Line==high_v50(j,:).Line && ...
                        high_v10(i,:).Point==high_v50(j,:).Point
                    high_comparison = [high_comparison;high_v10(i,:).OgdenEPa high_v50(j,:).OgdenEPa];
                end
            end
        end
    end
end
% 19 and 20 - low
for i = 1:size(low_v50,1)
    if low_v10(i,:).Date==20180621 && low_v10(i,:).ForceMap==19
        for j = 1:size(low_v50,1)
            if low_v50(j,:).Date==20180621 && low_v50(j,:).ForceMap==20
                if low_v10(i,:).Line==low_v50(j,:).Line && ...
                        low_v10(i,:).Point==low_v50(j,:).Point
                    low_comparison = [low_comparison;low_v10(i,:).OgdenEPa low_v50(j,:).OgdenEPa];
                end
            end
        end
    end
end
%% 180718
% 0 and 1 - high
for i = 1:size(high_v10,1)
    if high_v10(i,:).Date==20180718 && high_v10(i,:).ForceMap==0
        for j = 1:size(high_v50,1)
            if high_v50(j,:).Date==20180718 && high_v50(j,:).ForceMap==1
                if high_v10(i,:).Line==high_v50(j,:).Line && ...
                        high_v10(i,:).Point==high_v50(j,:).Point
                    high_comparison = [high_comparison;high_v10(i,:).OgdenEPa high_v50(j,:).OgdenEPa];
                end
            end
        end
    end
end
% 6 and 7 - low
for i = 1:size(low_v50,1)
    if low_v10(i,:).Date==20180718 && low_v10(i,:).ForceMap==6
        for j = 1:size(low_v50,1)
            if low_v50(j,:).Date==20180718 && low_v50(j,:).ForceMap==7
                if low_v10(i,:).Line==low_v50(j,:).Line && ...
                        low_v10(i,:).Point==low_v50(j,:).Point
                    low_comparison = [low_comparison;low_v10(i,:).OgdenEPa low_v50(j,:).OgdenEPa];
                end
            end
        end
    end
end

boxplot([low_comparison(:,1)./low_comparison(:,2);high_comparison(:,1)./high_comparison(:,2)],[zeros(size(low_comparison,1),1);ones(size(high_comparison,1),1)])