N = 800; kappa = 80; w_sol = 80;
plist = [100 200 400];
Rmax_list = [250,200,150];
w_list = [80,200,300];

w = w_list(2);
p = plist(1);
jenkins_solve2(w_list(1)/4+1,w_list(1),p,w/4+1,w,p);
for R_sol = w/4+2:63
    jenkins_solve2(R_sol-1,w,p,R_sol,w,p);
end
jenkins_solve1(64,w,p);
for R_sol = 65:161
    jenkins_solve2(R_sol-1,w,p,R_sol,w,p);
end               
jenkins_solve1(162,w,p);
for R_sol = 163:223
    jenkins_solve2(R_sol-1,w,p,R_sol,w,p);
end
jenkins_solve1(224,w,p);
for R_sol = 225:250
    jenkins_solve2(R_sol-1,w,p,R_sol,w,p);
end

w = w_list(2);
p = plist(2);
jenkins_solve2(w_list(1)/4+1,w_list(1),p,w/4+1,w,p);
for R_sol = w/4+2:121
    jenkins_solve2(R_sol-1,w,p,R_sol,w,p);
end
jenkins_solve1(122,w,p);
for R_sol = 123:181
    jenkins_solve2(R_sol-1,w,p,R_sol,w,p);
end
jenkins_solve1(182,w,p);
for R_sol = 183:200
    jenkins_solve2(R_sol-1,w,p,R_sol,w,p);
end

w = w_list(2);
p = plist(3);
jenkins_solve2(w_list(1)/4+1,w_list(1),p,w/4+1,w,p);
R_sol = w/4+2;
while(R_sol<=Rmax_list(3))
    try
        jenkins_solve2(R_sol-1,w,p,R_sol,w,p);
    catch ME
        jenkins_solve1(R_sol,w,p);
    end
    R_sol = R_sol + 1;
end
        
w = w_list(3);
for i = 3:length(plist)
    p = plist(i);
    jenkins_solve2(w/4+2,w,plist(2),w/4+2,w,p);
    R_sol = w/4+3;
    while(R_sol<=Rmax_list(i))
        try
            jenkins_solve2(R_sol-1,w,p,R_sol,w,p);
        catch ME
            try
                jenkins_solve1(R_sol,w,p);
            catch ME
                try
                    jenkins_solve2(R_sol-5,w,p,R_sol,w,p);
                catch ME
                    try
                        jenkins_solve2(R_sol-10,w,p,R_sol,w,p);
                    catch Me
                    end
                end
                
            end
        end
        R_sol = R_sol + 1;
    end
end
    