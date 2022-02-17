function []=plot_lambda_talk(real_w, real_pressure)
lw = 12;
if(real_w==80)
    r_array = [28,25,23,21]; %w=80
elseif(real_w==40)
    r_array = [14,13,12,11]; %w=40
elseif(real_w==20)
    r_array = [7,6.5,6,5.5]; %w=20
end
figure(22)
hold on
set(gcf,'units','points','position',[0,0,800,900])
for j = 1:length(r_array)
    fName = ['ms_plot_shapes/p_' num2str(real_pressure) '_w_' num2str(real_w) '_R' num2str(r_array(j)) '.mat'];
    load(fName);
    nm = 80/wtildeVal;
    x = linspace(0,sol.x(end),2e4);
    y = deval(sol,x);
    if(r_array(j)>=30)
        plot(y(4,:)*nm,-y(5,:)*nm, ...
            -y(4,:)*nm,-y(5,:)*nm, 'Color', [0, 0.5, 0], 'LineWidth', lw);
    else
        plot(y(4,:)*nm,-y(5,:)*nm, ...
            -y(4,:)*nm,-y(5,:)*nm, 'Color', [0, 0.5, 0], 'LineWidth', lw); 
    end
end

xlim([-real_w/2,real_w/2])
axis equal
%axis manual
%plot([-37,-27],[10,10],'LineWidth',16,'Color','k')
box on
%xlabel('x (nm)', 'FontSize', 40, 'FontWeight', 'bold')
%ylabel('z (nm)', 'FontSize', 40, 'FontWeight', 'bold')
set(gca, 'linewidth',8)
set(gca, 'Fontsize', 32)
set(gca, 'visible', 'off')
xticks([])
yticks([])
saveas(gcf,['ms_plot_figures/plot_lambda_si_',num2str(real_w),'.png'])

end

