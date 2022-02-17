p_real = 100; w_real = 80;
RArr = []; volumeArr = []; widthArr = []; heightArr = [];
shape_count = 0;

for k = 1:4
    for i = 1:300
        fName = ['omega/refine',num2str(p_real),'/try',num2str(k),'_p_',num2str(p_real),'_w_',num2str(w_real),'_',num2str(i),'.mat'];
        if exist(fName)
            load(fName,'real_volume','R', 'width', 'height', 'width');
            RArr = [RArr R];
            volumeArr = [volumeArr, real_volume];
            widthArr = [widthArr, width];
            heightArr = [heightArr, height];
            shape_count = shape_count + 1;
        end
    end
end

[Rsort, bb] = sort(RArr);
volumesort = volumeArr(bb);
heightsort = heightArr(bb);
widthsort = widthArr(bb);

plot(Rsort, (3*volumesort/4/pi).^(1/3), 'LineWidth',2)
xlabel('Radius(area) (nm)')
ylabel('Radius(volume) (nm)')
set(gca, 'linewidth',2)
set(gca, 'Fontsize', 28)
xlim([180,240])
saveas(gcf,'area-volume.png')


