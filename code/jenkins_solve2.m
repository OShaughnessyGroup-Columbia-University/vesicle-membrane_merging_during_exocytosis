function [] = jenkins_solve2(R_ini, w_ini, p_ini, R_sol, w_sol, p_sol)
    kappa = 80;
    %figure
    fName_ini = ['ms_plot_shapes2/p_' num2str(p_ini) '_w_' num2str(w_ini) '_R' num2str(R_ini) '.mat'];
    load(fName_ini, 'sol', 'wtildeVal')
    %R_ini = w_ini / wtildeVal;
    %plot(sol.('y')(4, :)*R_ini, sol.('y')(5, :)*R_ini,'b');
	%axis equal;
    %hold on
    
    solinit = sol;
    
    ptildeVal = p_sol * 1e-6 * R_sol^3 / 2 / kappa;
    wtildeVal = w_sol / R_sol;
    options = bvpset('NMax', 5e6 , 'AbsTol', 1e-4, 'RelTol', 1e-2);

    cnt = 0;
    maxWARN = 2;

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
    plot(y(4, :)*R_sol, y(5, :)*R_sol,'r');
    axis equal;
    hold on
    BB = islocalmax(y(4, :));
    BBY = y(4, BB);
    width = w_sol;
    if ~isempty(BBY)
        width = max(BBY)*R_sol*2;
    end
    poretildeVal = wtildeVal;
    real_pore = w_sol;
    poreheighttildaVal = 0;
    real_pore_height = 0;
    if(w_sol ~= width)
        BBB = islocalmin(y(4,:));
        localmin = y(4,BBB);
        hmin = y(5,BBB);
        poretildeVal = localmin(end);
        poreheighttildaVal = hmin(end);
        real_pore = poretildeVal*R_sol*2;
        real_pore_height = poreheighttildaVal*R_sol;
    end
    % calculate width and height
    height = abs(min(y(5, :)))*R_sol;
    A_cal = trapz(x*R_sol, y(4, :)*R_sol)*2*pi;
    A_cal = sum(pi*(y(4,1:end-1)+y(4,2:end)).*sqrt((y(4,1:end-1)-y(4,2:end)).^2+(y(5,1:end-1)-y(5,2:end)).^2))*R_sol^2;
    R_cal = sqrt(A_cal/4/pi);
    disp(R_cal)
    disp([height,width])

    % save data
    fName = ['ms_plot_shapes2/p_' num2str(p_sol) '_w_' num2str(w_sol) '_R' num2str(round(R_sol,1)) '.mat'];
    
    real_w = w_sol;
    real_pressure = p_sol;
    R = R_sol;
    save(fName, 'width', 'height', 'sol', ...
        'wtildeVal', 'ptildeVal', 'x', 'real_w', ...
        'real_pressure', 'R', 'poretildeVal', 'real_pore', ...
        'poreheighttildaVal', 'real_pore_height');
end
