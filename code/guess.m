function y = guess(x)
	%y = [1; 1; x; sin(x); cos(x); 1];
	
	% sphere
	y = [0; -1; pi/2-x; sin(x) + 0.05; -cos(x); 2];
	
	%y = [0; -1; pi/2-x; 0.3; -cos(x) + 0.05; 2.9];
end