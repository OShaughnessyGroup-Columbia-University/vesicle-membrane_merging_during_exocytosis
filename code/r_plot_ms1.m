%figure
%hold on
p_real = 100; w_real = 80;
RArr = [];
shape_count = 0;
gammaArr = [];
for k = 1:4
    for i = 1:300
        fName = ['omega/refine',num2str(p_real),'/try',num2str(k),'_p_',num2str(p_real),'_w_',num2str(w_real),'_',num2str(i),'.mat'];
        if exist(fName)
            load(fName,'sol','wtildeVal');
            RArr = [RArr w_real/wtildeVal];
            gammaArr = [gammaArr, sol.('y')(6,1)];
            shape_count = shape_count + 1;
        end
    end
end

gammaArr = -2*80./RArr.^2 .* gammaArr;
[Rsort, bb] = sort(RArr);
gammasort = gammaArr(bb);


%plot(heightArr,widthArr, 'linewidth', 2, 'color', 'b');
scatter(heightArr,widthArr,'filled')
set(gca, 'FontSize', 30)
set(gca, 'Linewidth', 3)
set(gca, 'Position',[0.2 0.2 0.7 0.7]);
box on
xlabel('Height (nm)')
ylabel('Width (nm)')
%xlim([0 1e3])
%ylim([0, 1e3])
