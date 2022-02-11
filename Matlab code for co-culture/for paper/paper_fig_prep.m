FD = readtable('Y:\Meninges - Gloria&Zeynep\Data_Paper\paperdata07-Dec-2018.xlsx');
dwell = readtable('Y:\Meninges - Gloria&Zeynep\Data_Paper\dwelldata05-Nov-2018.xlsx');

FDhight = (strcmp(FD.T_Density,'high')==1);
FDlowt = (strcmp(FD.T_Density,'low')==1);
FDcortical = (strcmp(FD.Material,'cortical')==1);
FDbasal = (strcmp(FD.Material,'basal')==1);
FDcerebellar = (strcmp(FD.Material,'cerebellar')==1);
FDvein = (strcmp(FD.Material,'vein')==1);
FDnovein = (strcmp(FD.Material,'vein')==0);
FD10 = ((FD.Speed_um_s_ == 10)==1);
FD50 = ((FD.Speed_um_s_ == 50)==1);

dwellhight = (strcmp(dwell.T_Density,'high')==1);
dwelllowt = (strcmp(dwell.T_Density,'low')==1);

%% High density vs low density trabeculae
figure
subplot(1,2,1)
h1 = histogram(FD.OgdenE_Pa_(FDlowt & FD.OgdenE_Pa_<10000 & FD.OgdenE_Pa_>100 & FD10));
%((FD.OgdenE_Pa_<350 & FD.OgdenE_Pa_>300)| FD.OgdenE_Pa_>400)
hold on
h2 = histogram(FD.OgdenE_Pa_(FDhight & FD.OgdenE_Pa_<10000 & FD.OgdenE_Pa_>100 & FD10));

xlabel('E (Pa)');
ylabel('Normal CDF');
legend('Low trabeculae','High trabeculae');

h1.Normalization = 'cdf';
h2.Normalization = 'cdf';

h1.BinEdges = linspace(00,10000,150);
h2.BinEdges = linspace(00,10000,150);

ylim([0 1.2])

subplot(1,2,2)
FDlow10 = FD.OgdenE_Pa_(FDlowt & FD.OgdenE_Pa_<5000 & FD.OgdenE_Pa_>00 & FD10);
FDhigh10 = FD.OgdenE_Pa_(FDhight & FD.OgdenE_Pa_<5000 & FD.OgdenE_Pa_>00 & FD10);
boxplot([FDlow10;FDhigh10],[(ones(length(FDlow10),1)*-1);ones(length(FDhigh10),1)]);

%% Vascularized vs non-vascularized
figure
h3 = histogram(FD.OgdenE_Pa_(FDnovein & FD.OgdenE_Pa_<4700 & FD.OgdenE_Pa_>150 & FD10));
hold on
h4 = histogram(FD.OgdenE_Pa_(FDvein & FD.OgdenE_Pa_<15000 & FD.OgdenE_Pa_>150 & FD10));

xlabel('E (Pa)');
ylabel('Normal CDF');
legend('Non-vascularized','Vascularized');

h3.Normalization = 'cdf';
h4.Normalization = 'cdf';

h3.BinEdges = linspace(75,15000,100);
h4.BinEdges = linspace(75,15000,100);

%% Anatomical
figure
subplot(3,3,1)
h5 = histogram(FD.OgdenE_Pa_(FDlowt & FD.OgdenE_Pa_<4000 & FD.OgdenE_Pa_>100 & FD10));
title('Low Density trabeculae')
subplot(3,3,2)
h6 = histogram(FD.OgdenE_Pa_(FDhight & FD.OgdenE_Pa_<4000 & FD.OgdenE_Pa_>100 & FD10));
title('High Density trabeculae')
subplot(3,3,3)
h7 = histogram(FD.OgdenE_Pa_(FD.OgdenE_Pa_<4000 & FD.OgdenE_Pa_>100 & FD10));
title('All')
subplot(3,3,4)
h8 = histogram(FD.OgdenE_Pa_(FDlowt & FD.OgdenE_Pa_<4000 & FD.OgdenE_Pa_>100 & FDcortical & FD10));
legend('cortical low')
subplot(3,3,5)
h9 = histogram(FD.OgdenE_Pa_(FDhight & FD.OgdenE_Pa_<4000 & FD.OgdenE_Pa_>100 & FDcortical & FD10));
legend('cortical high')
subplot(3,3,6)
h10 = histogram(FD.OgdenE_Pa_(FD.OgdenE_Pa_<4000 & FD.OgdenE_Pa_>100 & FDcortical & FD10));
legend('cortical all')
subplot(3,3,7)
h11 = histogram(FD.OgdenE_Pa_(FDlowt & FD.OgdenE_Pa_<4000 & FD.OgdenE_Pa_>100 & FDbasal & FD10));
legend('basal low')
subplot(3,3,8)
h12 = histogram(FD.OgdenE_Pa_(FDhight & FD.OgdenE_Pa_<4000 & FD.OgdenE_Pa_>100 & FDbasal & FD10));
legend('basal high')
subplot(3,3,9)
h13 = histogram(FD.OgdenE_Pa_(FD.OgdenE_Pa_<4000 & FD.OgdenE_Pa_>100 & FDbasal & FD10));
legend('basal all')

xlabel('E (Pa)');
ylabel('Normal CDF');
%legend('High trabeculae','High cerebellar','High cortical','High basal');

h5.Normalization = 'cdf';
h6.Normalization = 'cdf';
h7.Normalization = 'cdf';
h8.Normalization = 'cdf';
h9.Normalization = 'cdf';
h10.Normalization = 'cdf';
h11.Normalization = 'cdf';
h12.Normalization = 'cdf';
h13.Normalization = 'cdf';

h5.BinEdges = linspace(75,5000,50);
h6.BinEdges = linspace(75,5000,50);
h7.BinEdges = linspace(75,5000,50);
h8.BinEdges = linspace(75,5000,50);
h9.BinEdges = linspace(75,5000,50);
h10.BinEdges = linspace(75,5000,50);
h11.BinEdges = linspace(75,5000,50);
h12.BinEdges = linspace(75,5000,50);
h13.BinEdges = linspace(75,5000,50);

%% Anatomical II
figure
h14 = histogram(FD.OgdenE_Pa_(FD.OgdenE_Pa_<4800 & FD.OgdenE_Pa_>100 & FDcerebellar & FD10));
hold on
h15 = histogram(FD.OgdenE_Pa_(FD.OgdenE_Pa_<4800 & FD.OgdenE_Pa_>100 & FDcortical & FD10));
hold on
h16 = histogram(FD.OgdenE_Pa_(FD.OgdenE_Pa_<4800 & FD.OgdenE_Pa_>100 & FDbasal & FD10));
legend('cerebellar','cortical','basal')

xlabel('E (Pa)');
ylabel('Normal CDF');

%ylim([0 1.2])

h14.Normalization = 'cdf';
h15.Normalization = 'cdf';
h16.Normalization = 'cdf';

h14.BinEdges = linspace(75,5000,50);
h15.BinEdges = linspace(75,5000,50);
h16.BinEdges = linspace(75,5000,50);

figure
FDcereb= FD.OgdenE_Pa_(FD.OgdenE_Pa_<4800 & FD.OgdenE_Pa_>100 & FDcerebellar & FD10);
FDcort = FD.OgdenE_Pa_(FD.OgdenE_Pa_<4800 & FD.OgdenE_Pa_>100 & FDcortical & FD10);
FDbas = FD.OgdenE_Pa_(FD.OgdenE_Pa_<4800 & FD.OgdenE_Pa_>100 & FDbasal & FD10);
boxplot([FDcereb;FDcort;FDbas],[(ones(length(FDcereb),1));ones(length(FDcort),1)*2;ones(length(FDbas),1)*3]);

ylabel('E (Pa)');

%% Slow vs Fast Indentation
figure
h17 = histogram(FD.OgdenE_Pa_(FD.OgdenE_Pa_<100000 & FD.OgdenE_Pa_>200 & FD10));
%((FD.OgdenE_Pa_<350 & FD.OgdenE_Pa_>300)| FD.OgdenE_Pa_>400)
hold on
h18 = histogram(FD.OgdenE_Pa_(FD.OgdenE_Pa_<100000 & FD.OgdenE_Pa_>200 & FD50));

xlabel('E (Pa)');
ylabel('Normal CDF');
legend('Slow','Fast');

h17.Normalization = 'pdf';
h18.Normalization = 'pdf';

h17.BinEdges = linspace(100,15000,200);
h18.BinEdges = linspace(100,15000,200);

%% Relaxation tau1-tau2 high vs low density
figure
subplot(1,2,1)
h19 = histogram(dwell.tau1(dwelllowt));
hold on
h20 = histogram(dwell.tau1(dwellhight));

xlabel('E (Pa)');
ylabel('Normal CDF');
legend('Low trabeculae','High trabeculae');
title('Tau1')

subplot(1,2,2)
h21 = histogram(dwell.tau2(dwelllowt));
hold on
h22 = histogram(dwell.tau2(dwellhight));

xlabel('E (Pa)');
ylabel('Normal CDF');
legend('Low trabeculae','High trabeculae');
title('Tau2')

h19.Normalization = 'cdf';
h20.Normalization = 'cdf';
h21.Normalization = 'cdf';
h22.Normalization = 'cdf';

h19.BinEdges = linspace(0,3,50);
h20.BinEdges = linspace(0,3,50);
h21.BinEdges = linspace(0,3,50);
h22.BinEdges = linspace(0,3,50);