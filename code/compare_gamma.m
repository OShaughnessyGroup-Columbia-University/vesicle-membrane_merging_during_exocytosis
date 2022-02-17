%figure
%hold on
p_real = 100; w_real = 80;
RArr = [];
shape_count = 0;
gammaArr = [];
for k = 1:4
    for i = 1:300
        fName = ['omega/refine',num2str(p_real),'/try',num2str(k),'_p_',num2str(p_real),'_w_',num2str(w_real),'_',num2str(i),'.mat'];
        if exist(fName)
            load(fName,'sol','wtildeVal');
            RArr = [RArr w_real/wtildeVal];
            gammaArr = [gammaArr, sol.('y')(6,1)];
            shape_count = shape_count + 1;
        end
    end
end
gamma_c = 0.06;
gammaArr = -2*80./RArr.^2 .* gammaArr;
[Rsort, bb] = sort(RArr);
gammasort = gammaArr(bb);
FE_array = zeros(1,length(gammaArr));
for j = 2:length(gammasort)
    FE_array(j) = FE_array(j-1) - (Rsort(j)^2*4*pi-Rsort(j-1)^2*4*pi)* (gammasort(j)+gammasort(j-1)-gamma_c*2)/2;
end

RArr2 = []; gammaArr2 = [];
for i = 326:506
    fName = ['/Users/ruisu/omega/20190502/refine100/Final_config_run',num2str(i),'.txt'];
    if exist(fName)
        y = char(importdata(fName));
        rst = jsondecode(y);
        RArr2 = [RArr2, rst.('ro')];
        gammaArr2 = [gammaArr2, rst.('gamma_v')];
    end
end

fs = 60; % fontsize
ss = 100; % scatter size

figure(1)
set(gcf,'units','points','position',[0,0,800,500])
plot(2*Rsort(Rsort<200), gammasort(Rsort<200), 'Color',[0, 0.4470, 0.7410],'LineWidth',4)
hold on
plot(2*RArr2, gammaArr2,'Color','r','LineWidth',4)
hold on
xlim([40,400])
ylim([-0.05,0])
box on
set(gca, 'linewidth',2)
%xticklabels([])
xticks([40,100,200,300,400])
%yticklabels([])
%yticks([-0.6,-0.4,-0.2,0,0.2])
set(gca, 'Fontsize', 40)
%}
RArr1_int = Rsort(Rsort>=40);
gammaArr1_int = gammasort(Rsort>=40);
[RArr1_int,ind] = unique(RArr1_int);
gammaArr1_int = gammaArr1_int(ind);
gamma1_intp = interp1(RArr1_int,gammaArr1_int,linspace(40,220,1001));
gamma2_intp = interp1(RArr2,gammaArr2,linspace(40,220,1001));
ratio_max = max(abs(1-gamma1_intp ./ gamma2_intp));



