%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here we have two linear inequality constraints
%
% the objective (f) and the constraint functions 
% (for the plotting part) (REARRANGE THE CONSTRAINTS!!!)
% COMPLETE THE CODE HERE

f=@(x1,x2) 4.*x1.^2+x2.^2-x1-3.*x2-2;
g1=@(x1,x2) x1+x2-1;
g2=@(x1,x2) 4.*x1+x2-2;


% contour lines, feasible domain
figure; fcontour(f)
axis equal; hold on
fimplicit(g1,'r','LineWidth',2)
fimplicit(g2,'b','LineWidth',2)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the objective for the optimization 
F=@(x) f(x(1),x(2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Now we have linear inequality constraints
% COMPLETE THE CODE HERE

A=[1,1;4,1];%A*x<=b;
b=[1;2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% call the fmincon, save not only the minimizer but the 
% minimum and the Lagrange multipliers too

[xopt,fopt,~,~,lambda]=fmincon(F,[0,0],A,b); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(xopt(1),xopt(2),'ko','MarkerFaceColor','k')
% plot the level curve which crosses the minimizer
% you can see it is the 'smallest' contour line having 
% common point with the feasible region
fcontour(f,'LevelList',fopt)

% the minimizer
disp('the minimizer:')
disp(xopt)
% to check the Lagrange multipliers: 
% Which constraint is active??? 
disp('the Lagrange multipliers:')
disp(lambda.ineqlin)