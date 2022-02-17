kappa = 80;
w = 300; p = 100; Rmax = 200;
harr1 = []; warr1 = []; rarr1 = []; parr1 = [];
for k = w/4+1:Rmax
    fName = ['ms_plot_shapes2/p_' num2str(p) '_w_' num2str(w) '_R' num2str(k) '.mat'];
    if exist(fName)
        load(fName, 'height', 'width', 'R', 'pore_corrected');
        harr1 = [harr1, height]; warr1 = [warr1, width]; rarr1 = [rarr1, R]; parr1 = [parr1, pore_corrected];
    end
end

w = 80; p = 100; Rmax = 200;
harr2 = []; warr2 = []; rarr2 = []; parr2 = [];
for k = w/4+1:Rmax
    fName = ['ms_plot_shapes2/p_' num2str(p) '_w_' num2str(w) '_R' num2str(k) '.mat'];
    if exist(fName)
        load(fName, 'height', 'width', 'R', 'pore_corrected');
        harr2 = [harr2, height]; warr2 = [warr2, width]; rarr2 = [rarr2, R]; parr2 = [parr2, pore_corrected];
    end
end

[~, ind1] = max(parr2(1:40));
[~, ind2] = max(parr1(1:40));
lw = 6;
figure(1)
set(gcf, 'Units', 'Inches', 'Position', [0, 0, 8, 6], 'PaperUnits', 'Inches', 'PaperSize', [6, 5])
plot(harr2(sum(parr2<0.1):ind1), parr2(sum(parr2<0.1):ind1), 'LineWidth',lw, 'Color',[56,126,34]/255)
hold on
plot(harr2(ind1:end), parr2(ind1:end), 'LineWidth',lw, 'Color',[129,128,130]/255)
hold on
plot(harr1(sum(parr1<0.1):ind2), parr1(sum(parr1<0.1):ind2), 'LineWidth',lw, 'Color',[56,126,34]/255,'LineStyle','--')
hold on
plot(harr1(ind2:end), parr1(ind2:end), 'LineWidth',lw, 'Color',[129,128,130]/255,'LineStyle','--')
hold on

set(gca, 'FontSize', 32)
set(gca, 'Linewidth', 2)
box on
saveas(gcf, 'Corrected_pore_10oct19.png')

%{
figure(2)
plot(rarr1, parr1, 'LineWidth',2, 'Color','r')
hold on
plot(rarr2, parr2, 'LineWidth',2, 'Color','b')
hold on
set(gca, 'FontSize', 20)
set(gca, 'Linewidth', 2)
box on
xlabel('Radius (nm)')
ylabel('Pore (nm)')
%}
