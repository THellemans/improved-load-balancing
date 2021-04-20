function [u, ER] = SQ_PH(lam, d, qbound, SCV, f, k_PH, tol)
% Based on Markov chain at service completion times
EX=1;
[alpha, A, ~, ~] = hyper_erlang_init(EX, SCV, f, k_PH);

sumA=sum(A,2);
nph=size(A,1);
AtimesI=kron(A,eye(qbound));
msumAtimesI=kron(-sumA,eye(qbound));
alphaI=kron(alpha,eye(qbound));


%Qrand(i) gives law of environment, Qrandbar(i) = sum_j>=i Qrand(i)
%Jdist(i+1) gives probability that cavity gets arrival given its queue = i
Qrand=[1 zeros(1,qbound)];
% all queues empty
u=[cumsum(Qrand,'reverse') 0];
if lam == 0
    ER=1;
    return
end
Jdist=zeros(1,qbound+1);
counter=0;
while true
    counter=counter+1;
    if counter > 10^4
        break
    end
    for i=0:qbound
        if Qrand(i+1) == 0
            break
        end
        Jdist(i+1)=0;
        for k=0:d-1
            Jdist(i+1)=Jdist(i+1)+nchoosek(d-1,k)*Qrand(i+1)^k*u(i+2)^(d-1-k)/(k+1);
        end
    end
    Jdist=max(Jdist,0);
    lams=lam*d*Jdist;
    
    
    % determine state Qcompl at service completion times
    M=-diag(lams(2:end))+diag(lams(2:qbound),1); % lambda_0 not needed 
    Y=-alphaI*(kron(eye(nph),M)+AtimesI)^(-1);
    Qmat=Y*msumAtimesI;
    Qmat(2:qbound+1,1:qbound+1)=[Qmat zeros(qbound,1)];
    Qmat(1,:)=Qmat(2,:);
    Qmat=Qmat./sum(Qmat,2);
    temp=Qmat^2;
    while true
        temp2=temp^2;
        if max(abs(temp-temp2))<10^(-8)
            break
        end
        temp=temp2;
    end
    Qcompl=temp2(1,:);
     
    
    % determine state Qrand at random point in time
    % X(i+1,j+1) contains mean time with queue length j during a 
    % service period that started with queue length i
    X=Y*kron(ones(nph,1),eye(qbound));
    X=[0 X(1,:); zeros(qbound, 1) X]; % state 0 is same as state 1
    
    Qrand(1)=Qcompl(1)/lams(1)/(EX+Qcompl(1)/lams(1));
    % EX+Qcompl(1)/lams(1) is mean time between two service completions
    Qrand(2:qbound+1)=zeros(1,qbound);
    for i=1:qbound
        for j=0:i %state at previous serv. completion
            Qrand(i+1)=Qrand(i+1)+Qcompl(j+1)*X(j+1,i+1)/(EX+Qcompl(1)/lams(1));
        end
    end
    if (abs(Qrand(1)-(1-lam)) < tol)
        Qrand(1)=1-lam;
        u=[cumsum(Qrand,'reverse') 0];
        break
    end
    Qrand(1)=1-lam;
    Qrand(2:end)=lam*Qrand(2:end)/sum(Qrand(2:end));
    u=[cumsum(Qrand,'reverse') 0];
end

ER=sum(u(2:end))/lam;

end