p_real = 100;
w_real = 80;
kappa = 80;
position = [10,20,30,40,50,60,70,80,90,100];
cross_section = zeros(1,length(position));
cross_position = position;

for i = 1:250
    fName = ['ms_plot_shapes/p_',num2str(p_real),'_w_',num2str(w_real),'_R',num2str(i),'.mat'];
    if exist(fName)
        load(fName);
        R = real_w / wtildeVal;
        gammatildeVal = sol.y(6,1);
        real_gamma = gammatildeVal * 2 * kappa / R^2;
        x = linspace(0,sol.x(end),2e4);
        y = deval(sol,x);
        BBB = islocalmax(y(4, :));
        localmax = y(4, BBB);
        width = real_w;
        if ~isempty(localmax)
            width = max(localmax)*R*2;
        end
        poretildeVal = wtildeVal;
        real_pore = real_w;
        if(real_w ~= width)
            BB = islocalmin(y(4,:));
            localmin = y(4,BB);
            poretildeVal = localmin(end);
            real_pore = poretildeVal*R*2;
        end
        volumetildeVal = pi/3*sum((y(5,2:end)-y(5,1:end-1)).*(y(4,2:end).^2 + y(4,2:end).*y(4,1:end-1) + y(4,1:end-1).^2));
        real_volume = volumetildeVal * R^3;
        for j = 1:length(position)
            if(height<position(j))
                cross_section(j) = nan;
            else
                [min_dh, ind] = min(abs(abs(y(5,:))*R-position(j)));
                cross_section(j) = y(4,ind)*R*2;
            end
        end

        save(fName, 'width', 'height', 'sol', ...
            'wtildeVal', 'ptildeVal', 'x', 'real_w', ...
            'real_pressure', 'R', 'gammatildeVal', 'real_gamma', ...
            'volumetildeVal','real_volume','poretildeVal','real_pore',...
            'cross_position','cross_section');

    end
end
