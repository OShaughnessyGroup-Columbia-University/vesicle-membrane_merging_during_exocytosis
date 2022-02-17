w_ini = 300; w_sol = 300;
p_ini = 100; p_sol = 100;
R_ini = 76;
fName_ini = ['ms_plot_shapes/p_' num2str(p_ini) '_w_' num2str(w_ini) '_R' num2str(R_ini) '.mat'];
load(fName_ini, 'sol', 'wtildeVal')
%plot(sol.('y')(4, :)*R_ini, sol.('y')(5, :)*R_ini,'b');
%jenkins_solve2(R_ini, w_ini, p_ini, 75.1, w_sol, p_sol)
