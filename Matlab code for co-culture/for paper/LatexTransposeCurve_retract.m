% for i=1:N
% DataArrayTestTransposed(1,2*i-1)=DataArrayTest(i,1);
% end
% 
% for j=1:N
% DataArrayTestTransposed(1,2*j)=DataArrayTest(j,2);
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Defl. Invols in {nm/V}
DeflInvols = 70.18;
% Spring constant in {nN/nm}
k = 0.0738;

N=size(RetractData,1);
RetractDataF=zeros(size(RetractData,1),size(RetractData,2));

% Convert retract data in Ind-Volts {m-V} to Ind-Force {um-nN}
% (Ind. originally in m. We multiply by 10^6 to pass to um) 
% (Force originally in nN. We leave it like that - the multiplication by 10^-9 in main code was to go to N)
for i=1:N
RetractDataF(i,1) = RetractData(i,1).*10^6;   
RetractDataF(i,2) = RetractData(i,2).*DeflInvols.*k;
end

for j=1:N
    RetractDataF_Transposed(1,6*j-5)="(";
    RetractDataF_Transposed(1,6*j-4)=RetractDataF(j,1);
    RetractDataF_Transposed(1,6*j-3)=",";
    RetractDataF_Transposed(1,6*j-2)=RetractDataF(j,2);
    RetractDataF_Transposed(1,6*j-1)=")";
    RetractDataF_Transposed(1,6*j)=" ";
end

RetractDataF_LatexCoordinates = strjoin(RetractDataF_Transposed);