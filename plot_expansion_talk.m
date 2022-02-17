
lw = 4;
figure(11)
hold on
set(gcf,'units','points','position',[0,0,800,800])
fc1 = char(importdata('/Users/ruisu/omega/20190225-refine/refine/Final_config_run15.txt'));
y1 = jsondecode(fc1);
r1 = y1.('r'); z1 = y1.('z');

hold on
fc2 = char(importdata('/Users/ruisu/omega/20190225-refine/refine/Final_config_run30.txt'));
y2 = jsondecode(fc2);
r2 = y2.('r'); z2 = y2.('z');
fc3 = char(importdata('/Users/ruisu/omega/20190225-refine/refine/Final_config_run22.txt'));
y3 = jsondecode(fc3);
r3 = y3.('r'); z3 = y3.('z');
fc4 = char(importdata('/Users/ruisu/omega/20190225-refine/refine/Final_config_run2.txt'));
y4 = jsondecode(fc4);
r4 = y4.('r'); z4 = y4.('z');
fc5 = char(importdata('/Users/ruisu/omega/20190225-refine/refine/Final_config_run10.txt'));
y5 = jsondecode(fc5);
r5 = y5.('r'); z5 = y5.('z');
fc6 = char(importdata('/Users/ruisu/omega/20190225-refine/refine/Final_config_run6.txt'));
y6 = jsondecode(fc6);
r6 = y6.('r'); z6 = y6.('z');
c1 = [0, 0.4470, 0.7410];
plot(r2,z2,-r2,z2,'Color', c1, 'LineWidth', lw);
hold on
plot(r3,z3,-r3,z3,'Color', c1, 'LineWidth', lw);
hold on
plot(r4,z4,-r4,z4,'Color', c1, 'LineWidth', lw);
hold on
plot(r6,z6,-r6,z6,'Color', c1, 'LineWidth', lw);
hold on
plot(r5,z5,-r5,z5,'Color', c1, 'LineWidth', lw);
hold on
plot(r1,z1,'k',-r1,z1, 'Color', 'k', 'LineWidth', lw);
hold on
plot([-400,-40],[2,2],'Color', [0.6350, 0.0780, 0.1840],'LineWidth',8)
hold on
plot([40,400],[2,2],'Color', [0.6350, 0.0780, 0.1840],'LineWidth',8)


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
saveas(gcf,'plot_expansion_talk.png')

