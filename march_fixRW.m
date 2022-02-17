function [] = march_fixRW
    kappa = 80;
    figure
    axis equal;
    hold on
    %load('ms_plot_shapes/p_100_w_80_R222.mat')
    load('omega/other_solutions_p100_w80/p_100_w_80_D444.mat');
    R0 = real_w/wtildeVal;
    x = linspace(0,sol.x(end),2e4);
    y = deval(sol,x);
    plot(y(4, :)*R0, y(5, :)*R0,'b');

    options = bvpset('NMax', 5e5 , 'AbsTol', 1e-4, 'RelTol', 1e-2);

    filename_RW = 'comparison_w_80_R_222/w_80_R_222_F2_p_';    
    while(real_pressure>0)
        real_pressure = real_pressure - 1;
        ptildeVal = real_pressure * 1e-6 * R0^3 / 2 / kappa;
        wtildeVal = real_w / R0;
        solinit = sol;
        
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
        plot(y(4, :)*R0, y(5, :)*R0,'r');
        axis equal;
        hold on
        BB = islocalmax(y(4, :));
        BBY = y(4, BB);
        width = real_w;
        if ~isempty(BBY)
            width = max(BBY)*R0*2;
        end
        % calculate width and height
        height = abs(min(y(5, :)))*R0;

        disp([height,width])

        % save data
        fName = [filename_RW, num2str(real_pressure),'.mat'];
        R = R0;
        save(fName, 'width', 'height', 'sol', ...
            'wtildeVal', 'ptildeVal', 'x', 'real_w', ...
            'real_pressure', 'R');
    end    
end
