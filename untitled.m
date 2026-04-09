%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Here we have a single nonlinear equality constraint
%
% the objective (f) and the constraint (g) function 
% (for the plotting part)
% COMPLETE THE CODE HERE
f=@(x1,x2) 4.*x1.^2+x2.^2-x1-3.*x2-2;
g=@(x1,x2) (x1+1).^2+(x2+2).^2-3;

% contour lines, feasible domain
figure; fcontour(f)
axis equal; hold on
fimplicit(g,'r','LineWidth',2)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the objective for the optimization 
% COMPLETE THE CODE HERE
F=@(x) f(x(1),x(2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% to define the nonlinear constraint
% we are lazy to type the formula for g again :-) 
function [c,ceq]=cfnc(x,g) %local function
    c=[];  %no inequality
    ceq=g(x(1),x(2)); %only one equality
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the function defining the nonlinear constraints
consf=@(x) cfnc(x,g); %define contraints as a function handle

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% call the built-in fmincon (read the doc page!!)
% and plot the minimizer in the contour line figure
xopt=fmincon(F,[0,0],[],[],[],[],[],[],consf)

%%
plot(xopt(1),xopt(2),"ko",'MarkerFaceColor','k')


