function []=plot_lambda(real_w, real_pressure)
lw = 2;
r_array = [45,40,35,30,27,25,23,21];
figure(22)
hold on
set(gcf,'units','points','position',[0,0,800,600])
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

ylim([0,130])
axis equal
%axis manual
plot([-90,-40],[10,10],'LineWidth',4,'Color','k')
box on
%xlabel('x (nm)', 'FontSize', 40, 'FontWeight', 'bold')
%ylabel('z (nm)', 'FontSize', 40, 'FontWeight', 'bold')
set(gca, 'linewidth',2)
set(gca, 'Fontsize', 32)
xticks([])
yticks([])
saveas(gcf,'ms_plot_figures/plot_lambda.png')

end

