c = [129,128,130]/255;
lw = 12;
figure(11)
hold on
set(gcf,'units','points','position',[0,0,800,800])
fc1 = char(importdata('pore_expansion/Final_config_run3.txt'));
y1 = jsondecode(fc1);
r1 = y1.('r'); z1 = y1.('z');

plot(r1,z1,'k',-r1,z1, 'Color', c, 'LineWidth', lw);
hold on
plot([-100,-40],[0,0],'Color', c,'LineWidth',lw)
hold on
plot([40,100],[0,0],'Color', c,'LineWidth',lw)


axis equal
ylim([0,300])
axis manual
box on
%xlabel('x (nm)', 'FontSize', 40, 'FontWeight', 'bold')
%ylabel('z (nm)', 'FontSize', 40, 'FontWeight', 'bold')
set(gca, 'linewidth',2)
set(gca, 'Fontsize', 32)
xticks([])
yticks([])
set(gca,'visible', 'off')
saveas(gcf,'pore_expansion/example-1.png')

