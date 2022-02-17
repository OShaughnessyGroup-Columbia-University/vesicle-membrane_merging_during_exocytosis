N = 800;
figure
hold on
p = 100;
position = [10,20,30,40,50,60,70,80,90,100];
w_list = [80,200,300];
cross_radius = cell(10,3);
cmap = colormap(cool(length(position)));
ylim_array = [350,200,300];
xlim_array = [800,600,1000];

for idx = 1:length(w_list)
    figure(idx)
    poreArr = [];
    heightArr = [];
    rArr = [];
    w = w_list(idx);
    for kk = 1:250
        fName = ['ms_plot_shapes/p_',num2str(p),'_w_',num2str(w),'_R',num2str(kk),'.mat'];
        if exist(fName)
            load(fName, 'real_pore', 'height','R','width','cross_section');
            heightArr = [heightArr height];
            poreArr = [poreArr real_pore];
            rArr = [rArr, R];
            if(width==w)
                poreArr(end) = nan;
            end
            for k = 1:length(position)
                cross_radius{k,idx} = [cross_radius{k,idx}, cross_section(k)];
            end
        end
    end
    disp(rArr(37))
    [height_sort,bb] = sort(heightArr);
    pore_sort = poreArr(bb);
    rsort = rArr(bb); 
    plot(height_sort,pore_sort, 'linewidth', 4, 'color', 'g');
    hold on
    for k = 1:length(position)
        plot(height_sort,cross_radius{k,idx}, 'linewidth', 4, 'color', cmap(k, :))
        hold on
        annotation('textbox',[.25+k*0.05 .6 .4 .2],'String',num2str(position(k)), 'EdgeColor','none', 'FontSize', 15, 'Color', cmap(k,:));
    end
    plot(height_sort,pore_sort, 'linewidth', 4, 'color', 'g');
    hold on
    annotation('textbox',[.2 .7 .4 .2],'String',['\Delta P = ', num2str(p), ', w = ', num2str(w), ' nm'], 'EdgeColor','none', 'FontSize', 15);
    set(gca, 'FontSize', 20)
    set(gca, 'Linewidth', 2)
    box on
    xlabel('Height (nm)')
    ylabel('Radius (nm)')
    xlim([0, xlim_array(idx)])
    ylim([0, ylim_array(idx)])
end

%xlim([0, 1e3])