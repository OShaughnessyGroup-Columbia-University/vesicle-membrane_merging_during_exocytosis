N = 800;
figure
hold on
R = 100;
w = 80;
kappa = 80;

poreArr = [];
pArr = [];
rArr = [];
gammaArr = [];

for kk = 1:100
    p = kk*-100;
    fName = ['ms_plot_shapes/p_' num2str(p) '_w_' num2str(w) '_R' num2str(round(R)) '.mat'];
    if exist(fName)
        load(fName, 'real_pore','R', 'sol');
        if(width~=80)
            poreArr = [poreArr real_pore];
            pArr = [pArr p];
            rArr = [rArr, R];
            gammaArr = [gammaArr, sol.y(6,1)*2*kappa/R^2];
        end
    end
end

[p_sort,bb] = sort(pArr);
pore_sort = poreArr(bb);
gamma_sort = gammaArr(bb);
rsort = rArr(bb); 
plot(-gamma_sort,pore_sort, 'linewidth', 4, 'color','b');
disp(max(rsort))

set(gca, 'FontSize', 30)
set(gca, 'Linewidth', 3)
set(gca, 'Position',[0.2 0.2 0.7 0.7]);
box on
xlabel('Gamma (pN/nm)')
ylabel('Pore (nm)')
yticks([0,10,20,30,40,50,60,70])
xticks([0,0.1,0.2,0.3,0.4,0.5])
axis manual
ylim([0, 70])
xlim([0, 0.5])