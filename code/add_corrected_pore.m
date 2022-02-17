kappa = 80; 
p_list = [100 200 400];
Rmax_list = [250,200,150];
w_list = [80,200,300];

width_array = cell(length(w_list),length(p_list));
height_array = cell(length(w_list),length(p_list));
R_array = cell(length(w_list),length(p_list));
pore_array = cell(length(w_list),length(p_list));
R_critical = zeros(3,3);
R_crit_exact = zeros(3,3);
crit_pore_height_array = zeros(3,3);
for i = 1:length(w_list)
    w = w_list(i);
    for j = 1:length(p_list)
        p = p_list(j);
        harr = []; warr = []; rarr = [];
        for k = w/4+1:Rmax_list(j)
            fName = ['ms_plot_shapes2/p_' num2str(p) '_w_' num2str(w) '_R' num2str(k) '.mat'];
            if exist(fName)
                load(fName, 'height', 'width', 'R')
                harr = [harr, height]; warr = [warr, width]; rarr = [rarr, R];
            end
        end
        height_array{i,j} = harr; width_array{i,j} = warr; R_array{i,j} = rarr;
        Rc = rarr(length(warr(warr==w))+1);
        R_critical(i,j) = Rc;
        fName = ['ms_plot_shapes2/p_' num2str(p) '_w_' num2str(w) '_R' num2str(Rc) '.mat'];
        load(fName);
        while(width<w)
            jenkins_solve2(Rc,w,p,Rc-0.1,w,p);
            Rc = Rc-0.1;
            fName = ['ms_plot_shapes2/p_' num2str(p) '_w_' num2str(w) '_R' num2str(Rc) '.mat'];
            load(fName, 'width');
        end
        R_crit_exact(i,j) = Rc+0.1;
        fName = ['ms_plot_shapes2/p_' num2str(p) '_w_' num2str(w) '_R' num2str(Rc+0.1) '.mat'];
        load(fName, 'real_pore_height');
        crit_pore_height_array(i,j) = abs(real_pore_height);
    end
end

for i = 1:length(w_list)
    w = w_list(i);
    for j = 1:length(p_list)
        p = p_list(j);
        for k = w/4+1:Rmax_list(j)
            fName = ['ms_plot_shapes2/p_' num2str(p) '_w_' num2str(w) '_R' num2str(k) '.mat'];
            if exist(fName)
                load(fName, 'sol', 'R', 'width', 'real_w','wtildeVal');
                x = linspace(0,sol.x(end),2e4);
                y = deval(sol,x);
                poretildeVal = wtildeVal;
                real_pore = real_w;
                poreheighttildaVal = 0;
                real_pore_height = 0;
                if(real_w ~= width)
                    BBB = islocalmin(y(4,:));
                    localmin = y(4,BBB);
                    hmin = y(5,BBB);
                    poretildeVal = localmin(end);
                    poreheighttildaVal = abs(hmin(end));
                    real_pore = poretildeVal*R*2;
                    real_pore_height = poreheighttildaVal*R;
                    pore_corrected = real_pore;
                else
                    [~,ind] = min(abs(abs(sol.y(5,:))*R-crit_pore_height_array(i,j)));
                    pore_corrected = sol.y(4,ind)*R*2;
                    disp(pore_corrected)
                end
                save(fName, 'poretildeVal', 'real_pore', ...
                    'poreheighttildaVal', 'real_pore_height', ...
                    'pore_corrected', '-append');
            end
        end
    end
end
%}


%{
x = linspace(0,sol.x(end),2e4);
y = deval(sol,x);
%plot(y(4, :)*R_sol, y(5, :)*R_sol,'r');
%axis equal;
%hold on
BB = islocalmax(y(4, :));
BBY = y(4, BB);
width = w_sol;
if ~isempty(BBY)
    width = max(BBY)*R_sol*2;
end

poretildeVal = wtildeVal;
real_pore = w_sol;
if(w_sol ~= width)
    BBB = islocalmin(y(4,:));
    localmin = y(4,BBB);
    poretildeVal = localmin(end);
    real_pore = poretildeVal*R_sol*2;
end
%}