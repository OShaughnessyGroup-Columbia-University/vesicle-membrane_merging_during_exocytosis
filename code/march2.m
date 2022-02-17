N = 800; kappa = 80; w_sol = 80;
plist = [100 200 400];
R_array = cell(length(plist), 1);
filename_array = cell(length(plist), 1000);
filename = cell(1,1000);
for idx = 1:length(plist)
    RArr = [];
    p = plist(idx);
    shape_count = 0;
    for k=1:4
        for kk = 1:300
            fName = ['omega/refine', num2str(p),'/try',num2str(k),'_p_',num2str(p) ,'_w_80_' num2str(kk) '.mat'];
            if exist(fName)
                shape_count = shape_count + 1;
                load(fName, 'R');
                filename_array{idx,shape_count} = fName;
                RArr = [RArr R];
            end
        end
    end
    [R_sort,bb] = sort(RArr);
    R_array{idx,1} = R_sort;
    
    for j = 21:round(R_sort(end)/100,1)*100
        [~, ind] = min(abs(RArr-j));
        fName = filename_array{idx,ind};
        load(fName);
        solinit = sol;
        R_sol = j;
        ptildeVal = p * 1e-6 * R_sol^3 / 2 / kappa;
        wtildeVal = w_sol / R_sol;
        options = bvpset('NMax', 5e6 , 'AbsTol', 1e-4, 'RelTol', 1e-2);
        try
            sol = bvp4c(@(x, y)sixode(x, y, ptildeVal), ...
            @(ya, yb)sixbc(ya, yb, wtildeVal/2), solinit, options);
        catch ME
            disp('mistake in picture number');
        end
        msg = lastwarn;
        if contains(msg, 'Unable')
            lastwarn('');
            continue;
            jenkins_solve2(R_sol-10,w_sol,p,R_sol,w_sol,p);
        else
            fName = ['ms_plot_shapes2/p_' num2str(p) '_w_' num2str(w_sol) '_R' num2str(round(R_sol,1)) '.mat'];
            x = linspace(0,sol.x(end),2e4);
            y = deval(sol,x);
            plot(y(4, :)*R_sol, y(5, :)*R_sol,'r');
            axis equal;
            hold on
            BB = islocalmax(y(4, :));
            BBY = y(4, BB);
            width = w_sol;
            if ~isempty(BBY)
                width = max(BBY)*R_sol*2;
            end
            % calculate width and height
            height = abs(min(y(5, :)))*R_sol;
            R = R_sol; real_w = w_sol; real_pressure = p;
            save(fName, 'width', 'height', 'sol', ...
                'wtildeVal', 'ptildeVal', 'x', 'real_w', ...
                'real_pressure', 'R');
        end
    end
end

