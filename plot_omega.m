function []=plot_omega(real_w, real_pressure)
lw = 2;
r_array = [200,180,160,140,120,100,80,60,40,30,25,21];
figure(11)
hold on
set(gcf,'units','points','position',[0,0,800,800])
for j = 1:length(r_array)
    fName = ['ms_plot_shapes/p_' num2str(real_pressure) '_w_' num2str(real_w) '_R' num2str(round(r_array(j))) '.mat'];
    load(fName);
    nm = 80/wtildeVal;
    x = linspace(0,sol.x(end),2e4);
    y = deval(sol,x);
    if(r_array(j)>=30)
        plot(y(4,:)*nm,-y(5,:)*nm, ...
            -y(4,:)*nm,-y(5,:)*nm, 'Color', [0.9290, 0.6940, 0.1250], 'LineWidth', lw);
    else
        plot(y(4,:)*nm,-y(5,:)*nm, ...
            -y(4,:)*nm,-y(5,:)*nm, 'Color', [0, 0.5, 0], 'LineWidth', lw); 
    end
end
ylim([0,550])
axis equal
axis manual
plot([-200,-150],[20,20],'k','LineWidth',4)
box on
%xlabel('x (nm)', 'FontSize', 40, 'FontWeight', 'bold')
%ylabel('z (nm)', 'FontSize', 40, 'FontWeight', 'bold')
set(gca, 'linewidth',2)
set(gca, 'Fontsize', 32)
xticks([])
yticks([])
saveas(gcf,'ms_plot_figures/plot_omega.png')

end

