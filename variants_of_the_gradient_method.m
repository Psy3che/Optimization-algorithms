%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%variants of the gradient method
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% The objective function. To plot the contour lines we need a 
% function defined with two variables
% COMPLETE THE CODE HERE 

f=@(x1,x2) x1.^2+20*x2.^2;

% figure; fmesh(f,[-3,3,-1,1])

% The contour lines. We specified the height values (LevelList), because 
% otherwise the lines wouldn't be dense enough around the minimizer 
% (the bottom of the valley is too flat)
figure; fcontour(f,[-3,3,-1,1],'LevelList',linspace(0,15,15))
axis equal; hold on

%%
% In the algorithms it is more convenient to use an objective and a
% gradient function having only one vector variable
% COMPLETE THE CODE HERE

F=@(x) x(1).^2+20*x(2).^2;
F=@(x) f(x(1),x(2));

G=@(x) [2*x(1);40*x(2)];

% the initial guess
% TAKE CARE: if you define the gradient as a column vector, then you need
% an initial vector given as a column vector. Otherwise the result of the
% steps similar to x=x-eta*G(x) will be a 2x2 matrix resulting in strange
% things. 
x0=[-3;0.75];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPLETE THE FUNCTIONS CORRESPONDING TO THE DIFFERENT ALGORITHMS 
% ONE BY ONE. IF YOU ARE READY WITH ONE OF THEM THEN REMOVE THE % SIGNS 
% FROM THE FUNCTION CALLING PART 
% run the different algorithms and plot the points generated during the
% algorithm in the figure of the contour lines
% Every function has three outputs: 
%           output1: the final approximation of the minimizer
%           output2: a 2-row matrix. The columns of this matrix correspond
%                    to the points visited during the algorithm
%           output3: the number of the performed steps
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[xg,Xg, stepg]=mygrad(G,x0,0.04,1e-3)
plot(Xg(1,:),Xg(2,:),'*-r')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[xm,Xm, stepm]=mymomentum(G,x0,0.5,0.03,1e-3)
plot(Xm(1,:),Xm(2,:),'*-b')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[xa,Xa, stepa]=adagrad(G,x0,0.4,1e-3)
plot(Xa(1,:),Xa(2,:),'*-m')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[xr,Xr, stepr]=rmsprop(G,x0,0.9,0.2,1e-3)
plot(Xr(1,:),Xr(2,:),'*-g')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[xad,Xad, stepad]=adam(G,x0,0.8,0.999,0.2,1e-3)
plot(Xad(1,:),Xad(2,:),'*-k')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 legend('contours of f','gradient method','momentum method',...
'adagrad','rmsprop','adam')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% COMPLETE THE FUNCTION 
%%%%%%%%% gradient method with fixed step-size

function [x,X,steps]=mygrad(G,x,eta,accuracy)
    steps=0;
    X=x;      
    while norm(G(x)) > accuracy
        x = x-eta*G(x); 
        steps=steps+1;
        X=[X,x];
    end
end

% COMPLETE THE FUNCTION 
%%%%% momentum method

function [x,X,steps]=mymomentum(G,x,alpha,eta,accuracy)
    steps=0;
    X=x;      
    v=0;
    while norm(G(x)) > accuracy
        v=alpha*v-eta*G(x);
        x = x+v; 
        steps=steps+1;
        X=[X,x];
    end
end

% COMPLETE THE FUNCTION 
%%%%%% adagrad method
function [x,X,steps]=adagrad(G,x,eta,accuracy)
    steps=0;
    X=x;      
    s=0;
    c=1e-5;
    while norm(G(x)) > accuracy
        s=s+G(x).^2;
        x = x-eta./(sqrt(s)+c).*G(x); 
        steps=steps+1;
        X=[X,x];
    end
end


% COMPLETE THE FUNCTION 
%%%%%% rmsprop method
function [x,X,steps]=rmsprop(G,x,alpha,eta,accuracy)
    steps=0;
    X=x;      
    s=0;
    c=1e-5;
    while norm(G(x)) > accuracy
        s=alpha.*s+(1-alpha).*G(x).^2;
        x = x-eta./(sqrt(s)+c).*G(x); 
        steps=steps+1;
        X=[X,x];
    end
end



% COMPLETE THE FUNCTION 
%%%%%% adam method
function [x,X,steps]=adam(G,x,beta1,beta2,eta,accuracy)
    steps=0;
    X=x;      
    s=0;
    v=0;
    c=1e-5;
    while norm(G(x)) > accuracy
        v=beta1.*v+(1-beta1).*G(x);
        s=beta2.*s+(1-beta2).*(G(x)).^2;

        steps=steps+1;

        vhat=v./(1-beta1.^steps);
        shat=s./(1-beta2.^steps);
      
    
        x = x-eta.*vhat./(sqrt(shat)+c); 
        steps=steps+1;
        X=[X,x];
    end
end