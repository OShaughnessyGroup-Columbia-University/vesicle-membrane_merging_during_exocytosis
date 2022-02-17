function []=plot_tubule()
lw = 5;
figure(11)
set(gcf,'units','points','position',[0,0,400,1000])
fName = ['ms_plot_shapes/p_' num2str(100) '_w_' num2str(80) '_R' num2str(210) '.mat'];
load(fName);
nm = 80/wtildeVal;
x = linspace(0,sol.x(end),2e4);
y = deval(sol,x);
plot(y(4,:)*nm,-y(5,:)*nm, ...
            -y(4,:)*nm,-y(5,:)*nm, 'Color', [0, 0.4470, 0.7410], 'LineWidth', lw);
hold on
axis equal
ylim([0,1000])
axis manual
plot([-170,-120],[20,20],'k','LineWidth',6)
hold off
%xlabel('x (nm)', 'FontSize', 40, 'FontWeight', 'bold')
%ylabel('z (nm)', 'FontSize', 40, 'FontWeight', 'bold')
xticks([])
yticks([]) 
set(gca, 'linewidth',2)
set(gca, 'Fontsize', 32)
saveas(gcf,'ms_plot_figures/tubule-1.png')

figure(22)
set(gcf,'units','points','position',[0,0,400,1000])
fName = ['ms_plot_shapes/p_' num2str(100) '_w_' num2str(80) '_R' num2str(220) '.mat'];
load(fName);
nm = 80/wtildeVal;
x = linspace(0,sol.x(end),2e4);
y = deval(sol,x);
plot(y(4,:)*nm,-y(5,:)*nm, ...
            -y(4,:)*nm,-y(5,:)*nm, 'Color', [0, 0.4470, 0.7410], 'LineWidth', lw);
axis equal
ylim([0,1000])
%xlabel('x (nm)', 'FontSize', 40, 'FontWeight', 'bold')
%ylabel('z (nm)', 'FontSize', 40, 'FontWeight', 'bold')
%xticks([])
%yticks([]) 
set(gca, 'linewidth',2)
set(gca, 'Fontsize', 32)
xticks([])
yticks([]) 
saveas(gcf,'ms_plot_figures/tubule-2.png')

figure(33)
set(gcf,'units','points','position',[0,0,300,1000])
fName = ['ms_plot_shapes/p_' num2str(200) '_w_' num2str(80) '_R' num2str(180) '.mat'];
load(fName);
nm = 80/wtildeVal;
x = linspace(0,sol.x(end),2e4);
y = deval(sol,x);
plot(y(4,:)*nm,-y(5,:)*nm, ...
            -y(4,:)*nm,-y(5,:)*nm, 'Color', [0, 0.4470, 0.7410], 'LineWidth', lw);
axis equal
ylim([0,1000])
%xlabel('x (nm)', 'FontSize', 40, 'FontWeight', 'bold')
%ylabel('z (nm)', 'FontSize', 40, 'FontWeight', 'bold')
%xticks([])
%yticks([])
xticks([])
yticks([]) 
set(gca, 'linewidth',2)
set(gca, 'Fontsize', 32)
saveas(gcf,'ms_plot_figures/tubule-3.png')

end