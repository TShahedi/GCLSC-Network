function [TotalCost , Sol] = CostFunction(model,solution)

    T=model.T;   
    J=model.J;
    R=model.R;                                              
    M=model.M;
    I=model.I;
    S=model.S;
    K =model.K;
    L=model.L;
    N=model.N;
    capDRT = model.capDRT;
    capPIT = model.capPIT;
    capCLT = model.capCLT;
    capNNT = model.capNNT;
    capSST = model.capSST;
    cPJIT = model.cPJIT;
    CSJT = model.CSJT;

    
    eSSI = model.eSSI;
    ePIR = model.ePIR;
    eDRK = model.eDRK;
    eKKL = model.eKKL;
    eNLN = model.eNLN;
    eCLI = model.eCLI;
    
    RCJNT = model.RCJNT;
    RR4J=model.RR4J;
    RR3J=model.RR3J;
    RR1J = model.RR1J;
    RR2J =  model.RR2J;
    RT1J = model.RT1J;
    RT2J = model.RT2J;
    RTdeJKT1 = model.RTdeJKT1;
    RTdeJKT2 = model.RTdeJKT2;
    vJ = model.vJ;
    urJT=model.urJT;
    IDzeroJR =model.IDzeroJR;
    capLMT=model.capLMT;
    vr=model.vr;
    deJKT1=model.deJKT1;
    deJKT2=model.deJKT2;
    SJIRT = model.SJIRT;
    HCJRT = model.HCJRT;
    SHCJKT = model.SHCJKT;
  
    fcSST = model.fcSST;
    fcPIT = model.fcPIT;
    fcDRT = model.fcDRT;
    fcCLT = model.fcCLT;
    fcNNT = model.fcNNT;
    
    ftSMSIT = model.ftSMSIT;
    ftPMIRT = model.ftPMIRT;
    ftDMRKT = model.ftDMRKT;
    ftKMKLT = model.ftKMKLT;
    ftNMLNT = model.ftNMLNT;
    ftCMLIT = model.ftCMLIT;
       
    tcSMSIT = model.tcSMSIT;
    tcPMJIRT = model.tcPMJIRT;
    tcDMJRKT = model.tcDMJRKT;
    tcKMJKLT = model.tcKMJKLT;
    tcNMJLNT = model.tcNMJLNT;
    tcCMJLIT = model.tcCMJLIT;

    hIDjrt=solution.hIDjrt;
    hTPPmjirt=solution.hTPPmjirt;
    hTPKmjklt=solution.hTPKmjklt;
    hTPNmjlnt=solution.hTPNmjlnt;
    hTPCmjilt=solution.hTPCmjilt;
    hTRSmsit=solution.hTRSmsit;
    hTPDmjrkt=solution.hTPDmjrkt;
    
    XXit=solution.XXit;
    YYrt=solution.YYrt;
    ZZlt=solution.ZZlt;
    BBnt=solution.BBnt;
    WWst=solution.WWst;
    
    Xit=round(XXit);
    Yrt=round(YYrt);
    Zlt=round(ZZlt);
    Bnt=round(BBnt);
    Wst=round(WWst);

    
%% *********************** Constrains ************************************************* 
    % co13  
    IDjrt=zeros(J,R,T);
    for r=1:R
        for t=1:T
            for j=1:J
                 IDjrt(j,r,t)= (hIDjrt(j,r,t)/sum(hIDjrt(:,r,t)))*capDRT(r,t)*(1/vJ(j))*(rand+.05);
            end
        end
    end
           
    % co22
    TPPmjirt=zeros(M,J,I,R,T);
    for m=1:M
        for j=1:J
            for i=1:I
                for r=1:R
                    for t=1:T
                        TPPmjirt(m,j,i,r,t)=(hTPPmjirt(m,j,i,r,t)/sum(sum(sum(hTPPmjirt(:,:,i,:,t)))))*capPIT(i,t)*(rand+.05)*Xit(i,t)*Yrt(r,t);
                    end
                end
            end
        end
    end
    
    %co23
    Vio1=zeros(R,T);
    for r=1:R
        for t=1:T
            Vio1(r,t)=max(sum(sum(sum(TPPmjirt(:,:,:,r,t))))-capDRT(r,t),0);
        end
    end
    
    % co24
    TPKmjklt=zeros(M,J,K,L,T);
    for m=1:M
        for j=1:J
            for k=1:K
                for l=1:L
                    for t=1:T
                        TPKmjklt(m,j,k,l,t)=(hTPKmjklt(m,j,k,l,t)/sum(sum(sum(hTPKmjklt(:,:,:,l,t)))))*capCLT(l,t)*(rand+.05)*Zlt(l,t);
                    end
                end
            end
        end
    end
      
    %co20
    TRSmsit=zeros(M,S,I,T);
    for m=1:M
        for s=1:S
            for i=1:I
                for t=1:T
                     TRSmsit(m,s,i,t)=(hTRSmsit(m,s,i,t)/sum(sum(sum(hTRSmsit(:,s,:,t)))))*capSST(s,t)*(rand+.05)*Wst(s,t)* Xit(i,t);
                end
            end
        end
     end
    
    % co10 & co11
    TPNmjlnt=zeros(M,J,L,N,T);  
    for m=1:M
        for j=1:J
            for l=1:L
                for n=1:N
                    for t=1:T
                           TPNmjlnt(m,j,l,n,t)= unifrnd((hTPNmjlnt(m,j,l,n,t)/(sum(sum(hTPNmjlnt(:,j,l,:,t))))) *RR3J(j)*sum(sum(TPKmjklt(:,j,:,l,t))),(hTPNmjlnt(m,j,l,n,t)/(sum(sum(hTPNmjlnt(:,j,l,:,t))))) *RR4J(j)*sum(sum(TPKmjklt(:,j,:,l,t))),[1 1]); 
                           TPNmjlnt(m,j,l,n,t)= TPNmjlnt(m,j,l,n,t)*Bnt(n,t);
                    end
                end
            end
        end
    end
     
    % co25
    Vio2=zeros(N,T);
    for m=1:M
        for j=1:J
            for l=1:L
                for n=1:N
                    for t=1:T
                           Vio2(n,t)= max(sum(sum(sum(TPNmjlnt(:,:,:,n,t))))-capNNT(n,t),0);
                    end
                end
            end
        end
    end
    
    % co3
    help=zeros(I,T);
     for i=1:I
        for t=1:T
            for m=1:M
                for j=1:J
                    for r=1:R
                       help(i,t)=help(i,t)+ TPPmjirt(m,j,i,r,t)*urJT(j,t);    
                    end
                end
            end
        end
    end 
    TPCmjlit=zeros(M,J,L,I,T); 
    for m=1:M
        for j=1:J
            for l=1:L
                for i=1:I
                    for t=1:T
                            TPCmjlit(m,j,l,i,t)=  (hTPCmjilt(m,j,l,i,t)/(sum(sum(sum((hTPCmjilt(:,:,:,i,t)))))))*(help(i,t)-sum(sum(TRSmsit(:,:,i,t))))*(1/urJT(j,t))* Xit(i,t) ;
                    end
                end
            end
        end
    end

    %co8 & co9
    Vio3=zeros(J,L,T);   
    Vio4=zeros(J,L,T); 
    for j=1:J
        for l=1:L
            for t=1:T
                Vio3(j,l,t)=max(sum(sum(TPCmjlit(:,j,l,:,t)))-RR2J(j)*sum(sum(TPKmjklt(:,j,:,l,t))),0);
                Vio4(j,l,t)=-min(sum(sum(TPCmjlit(:,j,l,:,t)))-RR1J(j)*sum(sum(TPKmjklt(:,j,:,l,t))),0);
            end
        end
    end
             
    %co1
    QRst=zeros(S,T);
    for s=1:S
        for t=1:T
            QRst(s,t)=sum(sum(TRSmsit(:,s,:,t)));
        end
    end

    %co2
    QPjit=zeros(J,I,T);
    for j=1:J
       for i=1:I
           for t=1:T
               QPjit(j,i,t)=sum(sum(TPPmjirt(:,j,i,:,t)));
           end 
       end   
    end
               
   %co12
   TPDmjrkt=zeros(M,J,R,K,T);
   for m=1:M
        for j=1:J
            for r=1:R
                for k=1:K
                    for t=1:T
                        if t==1
                            TPDmjrkt(m,j,r,k,T)=(hTPDmjrkt(m,j,r,k,t)/sum(sum(hTPDmjrkt(:,j,r,:,t))))*(sum(sum(TPPmjirt(:,j,:,r,t)))- IDjrt(j,r,t))+IDzeroJR(j,r);
                        else
                            TPDmjrkt(m,j,r,k,T)=(hTPDmjrkt(m,j,r,k,t)/sum(sum(hTPDmjrkt(:,j,r,:,t))))*(sum(sum(TPPmjirt(:,j,:,r,t)))- IDjrt(j,r,t)+ IDjrt(j,r,t-1)) ;
                        end
                       
                    end
                end
            end
        end
   end
   
   % co14
   NSmsit=zeros(M,S,I,T);
   for m=1:M
       for s=1:S
           for i=1:I
               for t=1:T
                 NSmsit(m,s,i,t)=ceil(TRSmsit(m,s,i,t)*vr/capLMT(m,t));
               end  
           end 
       end
   end
 
   help1=zeros(M,I,R,T);
   help2=zeros(M,R,K,T);
   help3=zeros(M,K,L,T);
   help4=zeros(M,L,I,T);
   help5=zeros(M,L,N,T);
   NPmirt=zeros(M,I,R,T);
   NDmrkt=zeros(M,R,K,T);
   NKmklt=zeros(M,K,L,T);
   NCmlit=zeros(M,L,I,T);
   NNmlnt=zeros(M,L,N,T);
   
    % co15
    for m=1:M
        for i=1:I
            for r=1:R
                for t=1:T
                    for j=1:J
                        help1(m,i,r,t)=help1(m,i,r,t)+TPPmjirt(m,j,i,r,t)*vJ(j);
                    end
                    NPmirt(m,i,r,t)=ceil(help1(m,i,r,t)/capLMT(m,t));
                end
            end
        end
    end
    
    % co16
    for m=1:M
        for r=1:R
            for k=1:K
                for t=1:T
                    for j=1:J
                        help2(m,r,k,t)=help2(m,r,k,t)+TPDmjrkt(m,j,r,k,T) *vJ(j);
                       
                    end
                    NDmrkt(m,r,k,t)= ceil(help2(m,r,k,t)/capLMT(m,t));
                end
            end
        end
    end
     
    % co17
    for m=1:M
        for k=1:K
            for l=1:L
                for t=1:T
                    for j=1:J
                        help3(m,k,l,t)= help3(m,k,l,t)+TPKmjklt(m,j,k,l,t)*vJ(j);
                    end
                     NKmklt(m,k,l,t)= ceil(help3(m,k,l,t)/capLMT(m,t));
                end
            end
        end
    end
   
   % co18
   for m=1:M
        for l=1:L
            for i=1:I
                for t=1:T
                    for j=1:J
                         help4(m,l,i,t)=help4(m,l,i,t)+ TPCmjlit(m,j,l,i,t)*vJ(j);
                    end
                    NCmlit(m,l,i,t)= ceil(help4(m,l,i,t)/capLMT(m,t));
                end
            end
        end
   end

   % co19
   for m=1:M
        for l=1:L
            for n=1:N
                for t=1:T
                    for j=1:J
                           help5(m,l,n,t)= help5(m,l,n,t)+ TPNmjlnt(m,j,l,n,t)*vJ(j);
                    end
                     NNmlnt(m,l,n,t)=ceil(help5(m,l,n,t)/capLMT(m,t));
                end
            end
        end
   end
    
   % co4 & co5
   help6=zeros(J,K,T);%%% upper bound for SH
   for j=1:J
       for k=1:K
           for t=2:T
               for h=1:T-1
                   help6(j,k,t)= help6(j,k,t)+deJKT1(j,k,h);
               end
           end
       end
    end
    SHjkt=zeros(J,K,T);
    for j=1:J
        for k=1:K
            for t=1:T
                SHjkt(j,k,t)=unifrnd(deJKT2(j,k,t)-sum(sum(TPDmjrkt(:,j,:,k,t))),deJKT1(j,k,t)-sum(sum(TPDmjrkt(:,j,:,k,t)))+help6(j,k,t));
            end
        end
    end
    
    
    % co6 & co7
      Vio5=zeros(J,K,T);
      Vio6=zeros(J,K,T);
      for j=1:J
          for k=1:K
              for t=2:T
                 Vio5(j,k,t)=max(sum(sum(TPKmjklt(:,j,k,:,t)))+RT1J(j,k,t).*SHjkt(j,k,t-1)- RTdeJKT1(j,k,t-1),0);
                 Vio6(j,k,t)=-min(sum(sum(TPKmjklt(:,j,k,:,t)))+RT2J(j,k,t).*SHjkt(j,k,t-1)- RTdeJKT2(j,k,t-1),0);
              end
          end
      end

%% *********************** Objective function ************************************************* 
  Z=0;
    for j=1:J
        for s=1:S
            for k=1:K
                for r=1:R
                    for i=1:I
                        for l=1:L
                            for n=1:N
                               for t=1:T
                                   for m=1:M
                                
                                        Z=Z+(TPPmjirt(m,j,i,r,t)*SJIRT(j,i,r,t))-((QPjit(j,i,t)*cPJIT(j,i,t))+(TRSmsit(m,s,i,t)*eSSI(s,i)*tcSMSIT(m,s,i,t))+(TPPmjirt(m,j,i,r,t)*ePIR(i,r)*tcPMJIRT(m,j,i,r,t))+(TPDmjrkt(m,j,r,k,t)*eDRK(r,k)*tcDMJRKT(m,j,r,k,t))+(TPKmjklt(m,j,k,l,t)*eKKL(k,l)*tcKMJKLT(m,j,k,l,t))+((-CSJT(j,t)+eCLI(l,i)*tcCMJLIT(m,j,l,i,t))*TPCmjlit(m,j,l,i,t))+((RCJNT(j,n,t)+eNLN(l,n)*tcNMJLNT(m,j,l,n,t))*TPNmjlnt(m,j,l,n,t))+(HCJRT(j,r,t)*IDjrt(j,r,t))+(SHCJKT(j,k,t)*SHjkt(j,k,t))+(ftSMSIT(m,s,i,t)*NSmsit(m,s,i,t))+(ftPMIRT(m,i,r,t)*NPmirt(m,i,r,t))+(ftDMRKT(m,r,k,t)*NDmrkt(m,r,k,t))+(ftKMKLT(m,k,l,t)*NKmklt(m,k,l,t))+(ftCMLIT(m,l,i,t)*NCmlit(m,l,i,t))+(ftNMLNT(m,l,n,t)*NNmlnt(m,l,n,t))+(fcPIT(i,t)*Xit(i,t))+(fcDRT(r,t)*Yrt(r,t))+(fcCLT(l,t)*Zlt(l,t))+(fcNNT(n,t)*Bnt(n,t))+(fcSST(s,t)*Wst(s,t)));
                                       
                                   end
                                end 
                            end
                        end
                    end             
                end
            end            
        end
    end
    
    if isnan(Z)
        disp('');
    end 

%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
    %%Deviation
 
    MeanVio=mean(Vio1(:))+ mean(Vio2(:))+mean(Vio3(:))+mean(Vio4(:))+mean(Vio5(:))+mean(Vio6(:)); %
   
    ALPHA=1000; 
    

    if (MeanVio==0)
         IsFeasible=0;
 
    else
         IsFeasible=1;
 
    end

    
    TotalCost=Z+ALPHA*MeanVio;
    
    Sol.Z=Z;
    Sol.IDjrt=IDjrt;
    Sol.TPPmjirt=TPPmjirt;
    Sol.TPKmjklt=TPKmjklt;
    Sol.TPNmjlnt=TPNmjlnt;
    Sol.TPCmjlit=TPCmjlit;
    Sol.QRst=QRst;
    Sol.QPjit=QPjit;
    Sol.NSmsit=NSmsit;
    Sol.NPmirt=NPmirt;
    Sol.NDmrkt=NDmrkt;
    Sol.NKmklt=NKmklt;
    Sol.NCmlit=NCmlit;
    Sol.NNmlnt=NNmlnt;
    Sol.SHjkt=SHjkt;
    Sol.IsFeasible=IsFeasible;
    Sol.MeanVio=MeanVio;
end

