function []=plot_tubule()
lw = 7;
c1 = [129,128,130]/255;
c2 = [255,147,0]/255;
figure(11)
set(gcf,'units','points','position',[0,0,600,1000])
R_array = [206,208,214,220];
for i = 1:length(R_array)
    fName = ['ms_plot_shapes/p_' num2str(100) '_w_' num2str(80) '_R' num2str(R_array(i)) '.mat'];
    load(fName);
    nm = 80/wtildeVal;
    x = linspace(0,sol.x(end),2e4);
    y = deval(sol,x);
    plot(y(4,:)*nm,-y(5,:)*nm, ...
                -y(4,:)*nm,-y(5,:)*nm, 'Color', c2, 'LineWidth', lw);
    hold on
end
plot([-200,-40],[0,0],'Color', c1,'LineWidth',lw)
hold on
plot([40,200],[0,0],'Color', c1,'LineWidth',lw)
axis equal
ylim([0,800])
axis manual
%plot([-210,-110],[20,20],'k','LineWidth',6)
hold off
%xlabel('x (nm)', 'FontSize', 40, 'FontWeight', 'bold')
%ylabel('z (nm)', 'FontSize', 40, 'FontWeight', 'bold')
xticks([])
yticks([]) 
set(gca,'Visible','off')
saveas(gcf,'ms_plot_figures/tubule-1_paper.png')
%}

figure(22)
set(gcf,'units','points','position',[0,0,600,1000])
R_array = [162,165,170,180];
for i = 1:length(R_array)
    fName = ['ms_plot_shapes/p_' num2str(200) '_w_' num2str(80) '_R' num2str(R_array(i)) '.mat'];
    load(fName);
    nm = 80/wtildeVal;
    x = linspace(0,sol.x(end),2e4);
    y = deval(sol,x);
    plot(y(4,:)*nm,-y(5,:)*nm, ...
                -y(4,:)*nm,-y(5,:)*nm, 'Color', c2, 'LineWidth', lw);
    hold on
end
plot([-160,-40],[0,0],'Color', c1,'LineWidth',lw)
hold on
plot([40,160],[0,0],'Color', c1,'LineWidth',lw)
axis equal
ylim([0,800])
axis manual
%plot([-210,-110],[20,20],'k','LineWidth',6)
hold off
%xlabel('x (nm)', 'FontSize', 40, 'FontWeight', 'bold')
%ylabel('z (nm)', 'FontSize', 40, 'FontWeight', 'bold')
xticks([])
yticks([]) 
set(gca,'Visible','off')
saveas(gcf,'ms_plot_figures/tubule-2_paper.png')
%}

figure(33)
set(gcf,'units','points','position',[0,0,600,1000])
R_array = [128,131,135,141];
for i = 1:length(R_array)
    fName = ['ms_plot_shapes/p_' num2str(400) '_w_' num2str(80) '_R' num2str(R_array(i)) '.mat'];
    load(fName);
    nm = 80/wtildeVal;
    x = linspace(0,sol.x(end),2e4);
    y = deval(sol,x);
    plot(y(4,:)*nm,-y(5,:)*nm, ...
                -y(4,:)*nm,-y(5,:)*nm, 'Color', c2, 'LineWidth', lw);
    hold on
end
plot([-140,-40],[0,0],'Color', c1,'LineWidth',lw)
hold on
plot([40,140],[0,0],'Color', c1,'LineWidth',lw)
axis equal
ylim([0,800])
axis manual
%plot([-210,-110],[20,20],'k','LineWidth',6)
hold off
%xlabel('x (nm)', 'FontSize', 40, 'FontWeight', 'bold')
%ylabel('z (nm)', 'FontSize', 40, 'FontWeight', 'bold')
xticks([])
yticks([]) 
set(gca,'Visible','off')
saveas(gcf,'ms_plot_figures/tubule-3_paper.png')
%}

end