NFimage = imread('day7_OPC_DRG_fix_NF_20x.tif');
figure; imshow(NFimage);
MBPimage = imread('day7_OPC_DRG_fix_MBP_20x.tif');
figure; imshow(MBPimage);

NFnewimage = rgb2gray(NFimage);
figure; imshow(NFnewimage);
NFnewimage2 = NFnewimage; 
NFnewimage2(NFnewimage2>100)=NaN;
NFnewimage2(NFnewimage2<20)=NaN;
figure; imshow(NFnewimage2);

MBPnewimage = rgb2gray(MBPimage);
figure; imshow(MBPnewimage);
MBPnewimage2 = MBPnewimage; 
MBPnewimage2(MBPnewimage2<10)=NaN;
figure; imshow(MBPnewimage2);
multiply = double(MBPnewimage2) .* double(NFnewimage2);
>> figure; imshow(multiply);