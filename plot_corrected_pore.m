kappa = 80; 
p_list = [100 200 400];
Rmax_list = [250,200,150];
w_list = [80,200,300];
width_array = cell(length(w_list),length(p_list));
height_array = cell(length(w_list),length(p_list));
R_array = cell(length(w_list),length(p_list));
pore_array = cell(length(w_list),length(p_list));

for i = 1:length(w_list)
    w = w_list(i);
    for j = 1:length(p_list)
        p = p_list(j);
        harr = []; warr = []; rarr = []; parr = [];
        for k = w/4+1:Rmax_list(j)
            fName = ['ms_plot_shapes2/p_' num2str(p) '_w_' num2str(w) '_R' num2str(k) '.mat'];
            if exist(fName)
                load(fName, 'height', 'width', 'R', 'pore_corrected');
                harr = [harr, height]; warr = [warr, width]; rarr = [rarr, R]; parr = [parr, pore_corrected];
            end
        end
        height_array{i,j} = harr; width_array{i,j} = warr; 
        R_array{i,j} = rarr; pore_array{i,j} = parr;
        figure(i*3+j-3)
        plot(height_array{i,j}, pore_array{i,j}, 'LineWidth',2)
        hold on
        annotation('textbox',[.5 .7 .4 .2],'String',['\Delta P = ', num2str(p), ', w = ', num2str(w), ' nm'], 'EdgeColor','none', 'FontSize', 20);
        xlim([0,1000])
        ylim([0,150])
        set(gca, 'FontSize', 20)
        set(gca, 'Linewidth', 2)
        box on
        xlabel('Height (nm)')
        ylabel('Pore (nm)')
        saveas(gcf, ['w_',num2str(w),'_p_',num2str(p),'_Corrected_pore''.png'])
    end
end


