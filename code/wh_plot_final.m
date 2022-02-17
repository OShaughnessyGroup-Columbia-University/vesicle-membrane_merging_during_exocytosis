N = 800;
figure
hold on
T = readtable('width-height omega.xlsx');
exp_width = T.('width');
exp_height = T.('height');
scatter(exp_height,exp_width, 200,'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'non', "LineWidth", 1.5)
plist = [20 40 100 200 400 800];
cmap = colormap(cool(length(plist)));
tc_w = []; tc_h = [];
for idx = 1:length(plist)
    widthArr = [];
    heightArr = [];
    rArr = [];
    p = plist(idx);
    for k=1:4
        for kk = 1:200
            fName = ['omega/refine', num2str(p),'/try',num2str(k),'_p_',num2str(p) ,'_w_80_' num2str(kk) '.mat'];
            if exist(fName)
                load(fName, 'width', 'height','wtildeVal');
                if(width~=80)
                    widthArr = [widthArr width];
                    heightArr = [heightArr height];
                    rArr = [rArr, 80/wtildeVal];
                end
            end
        end
    end
    [height_sort,bb] = sort(heightArr);
    width_sort = widthArr(bb);
    rsort = rArr(bb);
    [width_max, ind] = max(width_sort);
    height_max = height_sort(ind);
    tc_w = [tc_w, width_max]; tc_h = [tc_h, height_max];
    if(idx==3)
        plot(height_sort(height_sort<760),width_sort(height_sort<760), 'linewidth', 4, 'color', cmap(idx, :));
        disp(max(rsort(height_sort<760)))
    elseif(idx==4)
        plot(height_sort(height_sort<660),width_sort(height_sort<660), 'linewidth', 4, 'color', cmap(idx, :));
        disp(max(rsort(height_sort<660)))
    else    
        plot(height_sort,width_sort, 'linewidth', 4, 'color', cmap(idx, :));
        disp(max(rsort))
    end
end
coeffs = polyfit(tc_h, tc_w, 1);
bound_h = linspace(0,1000,11);
bound_w = coeffs(1)*bound_h+coeffs(2);
plot(bound_h, bound_w, '--', 'Color', 'k', 'LineWidth', 3)
plot([47.03, 47.03], [0,80], '--', 'Color', 'k', 'LineWidth', 3)
plot([0, 47.03], [80,80], '--', 'Color', 'k', 'LineWidth', 3)
set(gca, 'FontSize', 30)
set(gca, 'Linewidth', 3)
set(gca, 'Position',[0.2 0.2 0.7 0.7]);
box on
xlabel('Height (nm)')
ylabel('Width (nm)')
yticks([40,200,400,600,800,1000])
xticks([0,200,400,600,800,1000])
axis equal
axis manual
ylim([40, 1e3])
xlim([0, 1e3])