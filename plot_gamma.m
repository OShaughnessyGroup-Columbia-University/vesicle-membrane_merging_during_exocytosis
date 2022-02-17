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
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 4, 5], 'PaperUnits', 'Inches', 'PaperSize', [4, 5])
plot(2*Rsort(Rsort<200 & Rsort>28), gammasort(Rsort<200 & Rsort>28), 'Color',[129,128,130]/255,'LineWidth',5)
hold on
plot(2*Rsort(Rsort<=28.1), gammasort(Rsort<=28.1), 'Color',[56,126,34]/255,'LineWidth',5)
hold on
%plot([60,60], [-0.6,0.1], 'k--', 'LineWidth', 3)
xlim([40,400])
ylim([-0.12,0.01])
box on
set(gca, 'linewidth',2)
%xticklabels([])
xticks([100,200,300,400])
xticklabels([100,200,300,400])
%yticklabels([])
yticks([-0.12,-0.08,-0.04,0])
yticklabels([-12,-8,-4,0])
set(gca, 'Fontsize', 28)
saveas(gcf,'analysis-1.png')
savefig('analysis-1.fig')


figure(3)
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 2.5, 2.5], 'PaperUnits', 'Inches', 'PaperSize', [2.5, 2.5])
plot(2*Rsort(Rsort<28.1), gammasort(Rsort<28.1),'Color',[56,126,34]/255,'LineWidth',5)

xlim([42,56])
ylim([-0.6,0])
xticklabels([42,50,56])
xticks([42,50,56])
yticklabels([-60,-40,-20,0])
yticks([-0.6,-0.4,-0.2,0])
set(gca, 'linewidth',2)
set(gca, 'Fontsize', 24)
%ylabel({'Vesicle Tension'; '\gamma (pN nm^{-1})'}, 'FontSize', 32)
%xlabel('Vesicle Radius r_{ves} (nm)', 'FontSize', 32)
box on
saveas(gcf,'analysis-1-inset.png')
saveas(gcf,'analysis-1-inset.fig') 


conv_factor = 1.38*298/100;
figure(2)
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 4, 5], 'PaperUnits', 'Inches', 'PaperSize', [4, 5])
plot(2*Rsort(Rsort<200 & Rsort>28), FE_array(Rsort<200 & Rsort>28)/conv_factor,'Color',[129,128,130]/255,'LineWidth',5)
hold on
plot(2*Rsort(Rsort<28.1), FE_array(Rsort<28.1)/conv_factor,'Color',[56,126,34]/255,'LineWidth',5)
hold on
%plot([60,60], [0,10000], 'k--', 'LineWidth', 3)
hold off
xlim([40,400])
%ylim([0,4000])
%ylabel('Free Energy {\itF} (k_BT)', 'FontSize', fs, 'FontWeight', 'bold')
%xlabel('Vesicle Diameter {\itD}_{ves} (nm)', 'FontSize', fs, 'FontWeight', 'bold')
box on
xticklabels([100,200,300,400])
xticks([100,200,300,400])
yticklabels([0,2,4,6,8,10])
yticks([0,2000,4000,6000,8000,10000])
set(gca, 'linewidth',2)
set(gca, 'Fontsize', 28)
saveas(gcf,'analysis-2.png')
saveas(gcf,'analysis-2.fig')
%}
