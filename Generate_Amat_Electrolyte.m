function [Ael,Bel,Cel,n_nodes] = Generate_Amat_Electrolyte(epsilon_e_s,epsilon_e_p,epsilon_e_n,del_n,del_s,del_p,nn,ns,np,brugg,D_e,t_plus)
%GENERATE_AMAT Summary of this function goes here
%   Detailed explanation goes here

% epsilon_e_s = CC.epsilon_e_s;
% epsilon_e_p = CC.epsilon_e_p;
% epsilon_e_n = CC.epsilon_e_n;

dx_n = del_n/nn;
dx_s = del_s/ns;
dx_p = del_p/np;
F = 96485;

% dx_n = CC.dx_n;
% dx_s = CC.dx_s;
% dx_p = CC.dx_p;
% np = CC.np;
% ns = CC.ns;
% nn = CC.nn;

del_t = del_n+del_s+del_p;
x_neg = 0:dx_n:del_n;
x_sep = del_n:dx_s:del_n+del_s;
x_pos = del_n+del_s:dx_p:del_n+del_s+del_p;
x_bat = [x_neg(1:end-1) x_sep(1:end-1) x_pos]/del_t;

De_s=D_e*epsilon_e_s^brugg;
De_p=D_e*epsilon_e_p^brugg;
De_n=D_e*epsilon_e_n^brugg;


% Positive | Seperator | Negative
A=diag([De_p/epsilon_e_p/dx_p/dx_p*(-2)*ones(1,np+1),De_s/epsilon_e_s/dx_s/dx_s*(-2)*ones(1,ns),De_n/epsilon_e_n/dx_n/dx_n*(-2)*ones(1,nn)])+...
    diag([De_p/epsilon_e_p/dx_p/dx_p*ones(1,np),De_s/epsilon_e_s/dx_s/dx_s*ones(1,ns),De_n/epsilon_e_n/dx_n/dx_n*ones(1,nn)],1)+...
    diag([De_p/epsilon_e_p/dx_p/dx_p*ones(1,np),De_s/epsilon_e_s/dx_s/dx_s*ones(1,ns),De_n/epsilon_e_n/dx_n/dx_n*ones(1,nn)],-1);

A(1,2)=2*De_p/epsilon_e_p/dx_p/dx_p;

A(np+1,np+1-1)=(2*De_p*dx_s )/(dx_p*dx_s*(dx_p*epsilon_e_p + dx_s*epsilon_e_s));% Cep[N-1]
A(np+1,np+1)=(-2*De_p*dx_s-2*De_s*dx_p    )/(dx_p*dx_s*(dx_p*epsilon_e_p + dx_s*epsilon_e_s));% Cep[N}= Ces[0]
A(np+1,np+1+1)=(2*De_s*dx_p  )/(dx_p*dx_s*(dx_p*epsilon_e_p + dx_s*epsilon_e_s)); % Ces[1]

A(np+ns+1,np+ns+1-1)=(2*De_s)/(dx_s*(dx_n*epsilon_e_n + dx_s*epsilon_e_s));% Cep[N-1]
A(np+ns+1,np+ns+1)=-(2*(De_n*dx_s + De_s*dx_n))/(dx_n*dx_s*(dx_n*epsilon_e_n + dx_s*epsilon_e_s));% Cep[N}= Ces[0]
A(np+ns+1,np+ns+1+1)=(2*De_n)/(epsilon_e_n*dx_n^2 + dx_s*epsilon_e_s*dx_n); % Ces[1]

A(np+ns+nn+1,np+ns+nn+1)=-2*De_n/epsilon_e_n/dx_n/dx_n;
A(np+ns+nn+1,np+ns+nn)=2*De_n/epsilon_e_n/dx_n/dx_n;

B=zeros(np+ns+nn+1,1);

II=1:(np+1);
kkp=(1-t_plus)/epsilon_e_p/F/del_p;
B(II)=-kkp;% % const J
B(np+1)= -(dx_p^2*dx_s*epsilon_e_p*kkp)/(dx_p*dx_s*(dx_p*epsilon_e_p + dx_s*epsilon_e_s));

IL = np+ns+1:np+ns+nn+1;
kkn=(1-t_plus)/epsilon_e_n/F/del_n;
B(IL)=kkn;% % const J
B(np+ns+1)= (dx_n^2*dx_s*epsilon_e_n*kkn)/(dx_n*dx_s*(dx_n*epsilon_e_n + dx_s*epsilon_e_s));

%C=eye(np+ns+nn+1)
C=[ones(1,np+1)*dx_p,ones(1,ns)*dx_s,ones(1,nn)*dx_n];
C(1)=dx_p/2;
C(np+1)=dx_p/2+dx_s/2;
C(np+ns+1)=dx_n/2+dx_s/2;
C(np+ns+nn+1)=dx_n/2;

Ael = A;
Bel = B;
Cel = C;

n_nodes = nn+ns+np+1;
end