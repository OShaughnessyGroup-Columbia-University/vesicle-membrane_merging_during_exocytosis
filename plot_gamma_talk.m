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

fs = 60; % fontsize
ss = 100; % scatter size

figure(1)
set(gcf,'units','points','position',[0,0,800,500])
plot(2*Rsort(Rsort<200), gammasort(Rsort<200), 'Color',[0, 0.4470, 0.7410],'LineWidth',4)
hold on
plot([2*20,2*200], [0.06,0.06], 'Color',[0.6350, 0.0780, 0.1840],'LineWidth',4)
hold on
plot([40,400],[0,0],'k--','LineWidth',4)
hold on 
xlim([40,400])
ylim([-0.2,0.1])
box on
set(gca, 'linewidth',2)
%xticklabels([])
xticks([40,100,200,300,400])
%yticklabels([])
%yticks([-0.6,-0.4,-0.2,0,0.2])
set(gca, 'Fontsize', 40)
saveas(gcf,'analysis-1_talk.png')
saveas(gcf,'analysis-1_talk.fig')
%}
%{

figure(3)
set(gcf,'units','points','position',[0,0,150,150])
plot(2*Rsort(Rsort<200&Rsort>30), gammasort(Rsort<200&Rsort>30),'Color',[0.6350, 0.0780, 0.1840],'LineWidth',5)

xlim([60,400])
ylim([-0.06,0])
xticklabels([])
xticks([100,200,300])
yticklabels([])
yticks([-0.06,-0.04,-0.02,0])
set(gca, 'linewidth',1)
%set(gca, 'Fontsize', 28)
%ylabel({'Vesicle Tension'; '\gamma (pN nm^{-1})'}, 'FontSize', 32)
%xlabel('Vesicle Radius r_{ves} (nm)', 'FontSize', 32)
box on
saveas(gcf,'analysis-1-inset.png')
saveas(gcf,'analysis-1-inset.fig') 
%}
%{
conv_factor = 1.38*298/100;
figure(2)
set(gcf,'units','points','position',[0,0,800,600])
plot(2*Rsort(Rsort<200), FE_array(Rsort<200)/conv_factor,'Color','r','LineWidth',5)
hold on
%plot([60,60], [0,4000], 'k--', 'LineWidth', 3)
%hold off
xlim([40,400])
ylim([0,9000])
%ylabel('Free Energy {\itF} (k_BT)', 'FontSize', fs, 'FontWeight', 'bold')
%xlabel('Vesicle Diameter {\itD}_{ves} (nm)', 'FontSize', fs, 'FontWeight', 'bold')
box on
%xticklabels([])
xticks([0,100,200,300,400])
%yticklabels([])
%yticks([0,1000,2000,3000,4000])
set(gca, 'linewidth',2)
set(gca, 'Fontsize', 40)
saveas(gcf,'analysis-2.png')
saveas(gcf,'analysis-2.fig')
%}
