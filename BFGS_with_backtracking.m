%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BFGS with backtracking 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define the Rosenbrock function as a two-variable function to plot 
% the contour lines 
% COMPLETE THE CODE HERE
f=@(x1,x2) 100.*(x2-x1.^2).^2+(1-x1).^2;



% plot the contour lines
figure; fcontour(f,[-2,2,-1,3],'LevelList',linspace(0,700,20))
axis equal

% define the objective and the gradient functions having a single 
% vector variable 
% COMPLETE THE CODE HERE
F=@(x) f(x(1),x(2));
G = @(x) [
    -400.*x(1).*(x(2)-x(1).^2) - 2.*(1-x(1));  
    200.*(x(2)-x(1).^2)                       
];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% the backtraking, it returns the stepsize
% input vars: fun: function, 
%             x: current location, 
%             g: gradient evaluated at the current location (so, not the 
%                grad fun!!)
%             p: search direction
%             alpha: initial stepsize
%             c, rho: control pars
function alpha=backtrack(fun,x,g,p,alpha,c,rho)
    while fun(x+alpha*p) > fun(x) + alpha*c*dot(g,p)
        alpha = rho * alpha;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% BFGS with backtracking
% a possible parametrization of the backtracking: 
% alpha=0.5,c=1e-4,rho=0.5
% COMPLETE THE CODE HERE
 function [x,n,X]=mybfgs(f,x,g,tol,maxit)
 n=0;
 X=x; 
 I=eye(length(x));
 H=I;
 gv=g(x);
 p=-gv;
while norm(gv) > tol && n < maxit
    a=backtrack(f,x,gv,p,0.5,1e-4,0.5);
    s=a*p;
    x=x+s;
    y=g(x)-gv;  %new gradient- previous gard
    c=y'*s;
    H=(I-s*y'/c)*H*(I-y*s'/c)+s*s'/c;

    gv=g(x);
    p=-H*gv;
   
    
    n=n+1;
    X=[X,x];



end
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%test your function and plot the result
 [x,n,X]=mybfgs(F,[-1.2;1],G,1e-3,5000);
 disp('Approximation of the minimizer:')
 disp(x)
 disp(['Number of steps: ',num2str(n)])
 
 hold on; plot(X(1,:),X(2,:),'r*-')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%