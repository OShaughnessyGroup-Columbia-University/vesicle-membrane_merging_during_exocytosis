N = 800;
figure
hold on

T = readtable('width-height omega.xlsx');
exp_width = T.('width');
exp_height = T.('height');
scatter(exp_height,exp_height./exp_width, 200,'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'non', "LineWidth", 1.5)

plist = [20 40 100 200 400 800];
cmap = colormap(cool(length(plist)));
tc_w = []; tc_h = [];
for idx = 1:length(plist)
    widthArr = [];
    heightArr = [];
    p = plist(idx);
    for k=1:4
        for kk = 1:200
            fName = ['omega/refine', num2str(p),'/try',num2str(k),'_p_',num2str(p) ,'_w_80_' num2str(kk) '.mat'];
            if exist(fName)
                load(fName, 'width', 'height');
                if(width~=80)
                    widthArr = [widthArr width];
                    heightArr = [heightArr height];
                end
            end
        end
    end
    [height_sort,bb] = sort(heightArr);
    width_sort = widthArr(bb);
    [width_max, ind] = max(width_sort);
    height_max = height_sort(ind);
    tc_w = [tc_w, width_max]; tc_h = [tc_h, height_max];
    if(idx==2)
        plot(height_sort(height_sort<860),height_sort(height_sort<860)./width_sort(height_sort<860), 'linewidth', 4, 'color', cmap(idx, :));
    else
        plot(height_sort,height_sort./width_sort, 'linewidth', 4, 'color', cmap(idx, :));
    end
end
coeffs = polyfit(tc_h, tc_w, 1);
bound_h = linspace(100,1000,1001);
bound_w = coeffs(1)*bound_h+coeffs(2);
plot(bound_h, bound_h./bound_w, '--', 'Color', 'k', 'LineWidth', 3)
plot([47.03, 47.03], [1.118,5], '--', 'Color', 'k', 'LineWidth', 3)
plot([0, 47.03], [0,1.118], '--', 'Color', 'k', 'LineWidth', 3)
set(gca, 'FontSize', 30)
set(gca, 'Linewidth', 3)
set(gca, 'Position',[0.2 0.2 0.7 0.7]);
box on
xlabel('Height (nm)')
ylabel('Height/Width')
xticks([0,200,400,600,800,1000])
yticks([0,1,2,3])
xlim([0, 1e3])
ylim([0, 3.1])
axis square