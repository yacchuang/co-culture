%{
    Code written by Zeynep Melis SUAR
    June 2019
    Last Updated : 06/13/2019
%}
function [Bs1d,Err1d,Bs2d,Err2d]=relax(fdcurve,name,folder)
    t = fdcurve(:,1);
    f = fdcurve(:,2);

    % remove nan elements from array
    t = t(~isnan(t));
    f = f(~isnan(f));

    %% Relaxation Fit

    % B(1) = B = 2C Ogden model
    % B(2) = alpha exponent Ogden model
    % B(3) = offset
    
    % a0 = B(3) a1 = B(2) tau1 = B(1)
    relaxmyfun1d = @(B1d,t)(B1d(3) + B1d(2)*exp(-t/B1d(1)) );
    options1d = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt','TolX',1e-20,'TolFun',1e-20,...
        'MaxFunEvals',100000,'MaxIter',100000,'Display','off','OptimalityTolerance',1e-20);
    pars1d = [5,5,5];
    lb1d = [0,-5,-5];
    ub1d = [20 5 5];

    try
        [Bs1d,Res] = lsqcurvefit(relaxmyfun1d,pars1d,t,f,lb1d,ub1d,options1d);
        Err1d = 1-Res/(length(f)*var(f));
        relaxfitValues1d = relaxmyfun1d(Bs1d,t);
        
        figure
        subplot(1,2,1)
        plot(t,f)
        hold on
        plot(t,relaxfitValues1d)
        xlabel('Time (s)')
        ylabel('Force (nN)')
        ax = gca;
        ax.YAxis.Exponent = -9;
        xlim([-1 round(t(end)+1)])
        legend('Dwell curve','Relaxation fit')
        title('1 Degree Fit')

    catch
        figure
        subplot(1,2,1)
        title('1 Degree Fit Failed')

        Err1d = 0;
        Bs1d = [0 0 0];
        disp('The 1D fit failed to run.')
    end
    
    % a0 = B(5) a1 = B(3) a2 = B(4) tau1 = B(1) tau2 = B(2)
    relaxmyfun2d = @(B2d,t)(B2d(5) + B2d(3)*exp(-t/B2d(1)) + B2d(4)*exp(-t/B2d(2)));
    options2d = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt','TolX',1e-25,'TolFun',1e-25,...
        'MaxFunEvals',100000,'MaxIter',100000,'Display','off','OptimalityTolerance',1e-30);
    pars2d = [5,1,5,5,5];
    lb2d = [0,0,-5,-5,-5];
    ub2d = [20 20 5 5 5];

    try
        [Bs2d,Res] = lsqcurvefit(relaxmyfun2d,pars2d,t,f,lb2d,ub2d,options2d);
        Err2d = 1-Res/(length(f)*var(f));
        relaxfitValues2d = relaxmyfun2d(Bs2d,t);
        
        taus = [Bs2d(1),Bs2d(2)];
        tau1 = taus(find(taus==max(taus)));
        tau2 = taus(find(taus==min(taus)));
        As = [Bs2d(3),Bs2d(4)];
        a1 = As(find(taus==max(taus)));
        a2 = As(find(taus==min(taus)));
        Bs2d = [tau1 tau2 a1 a2 Bs2d(5)];
        
        subplot(1,2,2)
        plot(t,f)
        hold on
        plot(t,relaxfitValues2d)
        xlabel('Time (s)')
        ylabel('Force (nN)')
        ax = gca;
        ax.YAxis.Exponent = -9;
        xlim([-1 round(t(end)+1)])
        legend('Dwell curve','Relaxation fit')
        title('2 Degree Fit')

    catch
        figure
        subplot(1,2,1)
        title('2 Degree Fit Failed')

        Err2d = 0;
        Bs2d = [0 0 0 0 0];
        disp('The 2d fit failed to run.')
    end
    %{
    sgtitle(name)
    snam='varargin';
    sdf(gcf,snam)
    %}
    annotation('textbox',[.307 .728 .149 .058],'String',{['Tau1 = ',num2str(Bs1d(1))];['R2    = ',num2str(Err1d)]},'FontSize',18,'FontName','cmr10')
    annotation('textbox',[.747 .70 .149 .085],'String',{['Tau1 = ',num2str(Bs2d(1))];['Tau2 = ' num2str(Bs2d(2))];['R2    = ',num2str(Err2d)]},'FontSize',18,'FontName','cmr10')
    
    disp({'' '1d' '2d';'Tau1',Bs1d(1),Bs2d(1);'Tau2','DNE',Bs2d(2);'R2',Err1d,Err2d})
%% output
    figname = [folder '\' name '_fit.fig'];
    savefig(figname)
    saveas(gcf,[folder '\png\' name '_fit.png']);
end