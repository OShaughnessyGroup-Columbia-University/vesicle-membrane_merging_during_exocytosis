function ves_plot(fName)
figure
load(fName);
real_w = 80;
nm = real_w/wtildeVal;
x = linspace(0,sol.x(end),2e4);
y = deval(sol,x);
plot(y(4,:)*nm,-y(5,:)*nm, 'b',...
    -y(4,:)*nm,-y(5,:)*nm, 'b');
axis equal;
disp('width')
disp(max(y(4,:))*real_w/2/y(4,end)*2)
disp('height')
disp(-y(5,1)*real_w/2/y(4,end))
disp('ptildeVal')
disp(ptildeVal)
disp('R_ves')
disp(nm)
end