function [Asys,Bsys,Cs_surf,Cs_avg] = Generate_Amat(nr)
%GENERATE_AMAT Summary of this function goes here
%   Detailed explanation goes here
   inr=1:nr;
   Asys=diag(-2*ones(1,nr+1))+diag((inr-1)./inr,-1)+diag(inr./(inr-1),1);
   Asys(1,1)=-6;
   Asys(1,2)=6;
   Asys(nr+1,nr)=2;
   Asys(nr+1,nr+1)=-2;
   Bsys=zeros(nr+1,1);
   Bsys(nr+1,1)=-2*(nr+1)/nr;
   Cs_surf=zeros(1,nr+1);
   Cs_surf(1,nr+1)=1;
   Cs_avg=ones(1,nr+1);
end

