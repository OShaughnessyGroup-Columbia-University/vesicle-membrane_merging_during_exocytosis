N = 800;
figure
hold on
p = 100;
w_list = [200,300];
cmap = colormap(cool(length(w_list)));
for idx = 1:length(w_list)
    poreArr = [];
    heightArr = [];
    rArr = [];
    w = w_list(idx);
    for kk = 1:250
        fName = ['ms_plot_shapes/p_',num2str(p),'_w_',num2str(w),'_R',num2str(kk),'.mat'];
        if exist(fName)
            load(fName, 'real_pore', 'height','R','width');
            if(width~=w)
                poreArr = [poreArr real_pore];
                heightArr = [heightArr height];
                rArr = [rArr, R];
            end
        end
    end
    [height_sort,bb] = sort(heightArr);
    pore_sort = poreArr(bb);
    rsort = rArr(bb); 
    plot(height_sort,pore_sort, 'linewidth', 4, 'color', cmap(idx, :));
    hold on
end
set(gca, 'FontSize', 30)
set(gca, 'Linewidth', 3)
set(gca, 'Position',[0.2 0.2 0.7 0.7]);
box on
xlabel('Height (nm)')
ylabel('Pore (nm)')
yticks([0,10,20,30,40,50])
xticks([0,200,400,600,800,1000])
axis manual
%ylim([0, 50])
%xlim([0, 1e3])