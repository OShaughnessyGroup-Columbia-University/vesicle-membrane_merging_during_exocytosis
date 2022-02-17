N = 800;
figure
hold on
plist = [20 40 100 200 400 800];
cmap = colormap(cool(length(plist)));
height_array = cell(length(plist), 1); width_array = cell(length(plist),1);
filename_array = cell(length(plist), 1000);
filename = cell(length(plist), 1);
for idx = 1:length(plist)
    widthArr = [];
    heightArr = [];
    p = plist(idx);
    shape_count = 1;
    for k=1:4
        for kk = 1:300
            fName = ['omega/refine', num2str(p),'/try',num2str(k),'_p_',num2str(p) ,'_w_80_' num2str(kk) '.mat'];
            if exist(fName)
                load(fName, 'width', 'height');
                filename_array{idx,shape_count} = fName;
                shape_count = shape_count + 1;
                if(width~=80)
                    widthArr = [widthArr width];
                    heightArr = [heightArr height];
                end
            end
        end
    end
    [height_sort,bb] = sort(heightArr);
    width_sort = widthArr(bb);
    height_array{idx,1} = height_sort; width_array{idx,1} = width_sort;
    %plot(height_sort,[0, diff(width_sort)./diff(height_sort)], 'linewidth', 2, 'color', cmap(idx, :));
    dwdh_smooth = smooth(height_sort,[0, diff(width_sort)./diff(height_sort)],0.1,'rloess');
    [fp, ind] = min(dwdh_smooth);
    fName = filename_array{idx,bb(ind)};
    filename{idx,1} = fName;
    ves_plot(fName);
    %plot(height_sort,dwdh_smooth, 'linewidth', 2, 'color', 'g');
end
set(gca, 'FontSize', 30)
set(gca, 'Linewidth', 3)
set(gca, 'Position',[0.2 0.2 0.7 0.7]);
box on

%xlabel('Height (nm)')
%ylabel('dH/dW')