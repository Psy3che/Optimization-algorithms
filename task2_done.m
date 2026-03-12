%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%
%  Task 2  %
%%%%%%%%%%%%

% the data
A=load('pontok200E.txt');

figure; plot3(A(:,1),A(:,2),A(:,3),'*')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the model

p=@(w,x,y) w(1)*sin(pi*x).*exp(-w(2)*x.^2-w(3)*y.^2);

% the objective and the gradient of the objective
F=@(w,X,Y,Z)  mean((p(w,X,Y)-Z).^2);
G=@(w,X,Y,Z) 2*[mean((p(w,X,Y)-Z).*sin(pi*X).*exp(-w(2)*X.^2-w(3)*Y.^2));
    mean(-(p(w,X,Y)-Z).*p(w,X,Y).*X.^2);
    mean(-(p(w,X,Y)-Z).*p(w,X,Y).*Y.^2)];
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w=[0;0;0];    % initial point
eta=0.1;      % fix learning rate (constant step length)
bs=1;         % batch size, now 1

F2=@(w,d) F(w,d(:,1),d(:,2),d(:,3));    % 2-variable version of F
G2=@(w,d) G(w,d(:,1),d(:,2),d(:,3));    % 2-variable version of G

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% write the function for stochastic gradient descent:
% gradient descent with fixed learning rate eta
% before each epoch, shuffle the data: 
% M: number of points
% randperm(10) : a permutation of the numbers 1,2,3,...,10

function [w,epoch,Fval]=sgd(data,fun,gradfun,w,eta,tol,maxit)
    M=length(data);
    epoch=0;
    Fval=[];
    while norm(gradfun(w,data))>tol && epoch < maxit 
        % randomize the indices, put them in a vector 'ind'
        ind=randperm(M);
        for i=ind       % we go through the shuffled data...
            p=-gradfun(w,data(i,:));       % calculate the direction: -grad 
                        % (here gradfun has 2 arguments: w,d)
            w=w+eta*p;                    % we take the step
            Fval=[Fval,fun(w,data)];      % we collect the new value 
        end
        epoch=epoch+1;
    end
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [wopt,epoch,Fval]=sgd(A,F2,G2,w,eta,1e-3,5000);

% pp=@(x,y) p(wopt,x,y);
% hold on; fmesh(pp,[-3,3])
% figure; plot(Fval)
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% write the function for mini-batch SGD:
% before each epoch, shuffle the data: 
% M: number of points
% randperm(10) : a permutation of the numbers 1,2,3,...,10
% first choose bs (batch size) such that it divides M (number of points)

function [w,epoch,Fval]=minibatchsgd(data,fun,gradfun,w,eta,bs,tol,maxit)
    M=length(data);
    epoch=0;
    Fval=[];
    bs = 20;  % choose a batch size that divides M

    while norm(gradfun(w,data))>tol && epoch < maxit 
        % randomize the indices, put them in a vector 'ind'
        ind=randperm(M);
        for i=1:M/bs       % we go through the shuffled data...
            ind_batch=ind((i-1)*bs+1:i*bs);
            p=-gradfun(w,data(ind_batch,:));       % calculate the direction: -grad 
                        % (here gradfun has 2 arguments: w,d)
            w=w+eta*p;                    % we take the step
            Fval=[Fval,fun(w,data)];      % we collect the new value 
        end
        epoch=epoch+1;
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


bs=20;             % choose a batch size
w=[0,0,0];
eta=0.5;
[wopt,epoch,Fval]=minibatchsgd(A,F2,G2,w,eta,bs,1e-3,5000);
pp=@(x,y) p(wopt,x,y);
hold on; fmesh(pp,[-3,3])
figure; plot(Fval)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
