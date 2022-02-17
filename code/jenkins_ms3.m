function [] = jenkins_ms1(real_w, real_pressure, R_set)
    
    RArr = [];
    filename_array = cell(1,1200);
    shape_count = 0;
    for k = 1:1
        for i = 1:300
            fName = ['si/try',num2str(k),'_p_',num2str(real_pressure),'_w_',num2str(real_w),'_',num2str(i),'.mat'];
            if exist(fName)
                load(fName,'wtildeVal');
                RArr = [RArr real_w/wtildeVal];
                shape_count = shape_count + 1;
                filename_array{1,shape_count} = fName;
            end
        end
    end
    
    [mindr, ind] = min(abs(RArr-R_set));
    fName = filename_array{1,ind};
    load(fName)
    const1 = ptildeVal*wtildeVal^3;
    wtildeVal = real_w / R_set;
    ptildeVal = const1 / wtildeVal^3;
    solinit = sol;
    options = bvpset('NMax', 5e5 , 'AbsTol', 1e-4, 'RelTol', 1e-2);

    disp(RArr)
    cnt = 0;
    maxWARN = 20;

    for sdd=1:maxWARN
        rng(sdd);
        sol = bvp4c(@(x, y)sixode(x, y, ptildeVal), ...
            @(ya, yb)sixbc(ya, yb, wtildeVal/2), solinit, options);
        msg = lastwarn;
        if contains(msg, 'Unable')
            lastwarn('');
            cnt = cnt + 1;
            continue;
        else
            lastwarn('');
            break;
        end
    end

    if cnt == maxWARN
        return;
    end

    x = linspace(0,sol.x(end),2e4);
    y = deval(sol,x);
    R = real_w/wtildeVal;
    figure
    plot(y(4, :)*R, y(5, :)*R,'r');
    axis equal;
    hold on
    BB = islocalmax(y(4, :));
    BBY = y(4, BB);
    width = real_w;
    if ~isempty(BBY)
        width = max(BBY)*real_w/wtildeVal*2;
        %width = BBY(end)*real_w/wtildeVal*2;
    end
    % calculate width and height
    height = abs(min(y(5, :)))*real_w/wtildeVal;

    disp([height,width])

    % save data
    fName = ['ms_plot_shapes/p_' num2str(real_pressure) '_w_' num2str(real_w) '_R' num2str(round(R_set)) '.mat'];

    save(fName, 'width', 'height', 'sol', ...
        'wtildeVal', 'ptildeVal', 'x', 'real_w', ...
        'real_pressure', 'R');
    
end
