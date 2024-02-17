 function Sol = CreateRandomSolution( model )

     R=model.R;                                              
     T=model.T;   
     J=model.J;
     I=model.I;
     L=model.L;                                                             
     N=model.N; 
     S=model.S; 
     M=model.M;
     K=model.K;
    %lbXXit=model.lbXXit;
    %ubXXit=model.ubXXit;
     

    XXit=unifrnd(0,1,[I,T]);

    %XXit=zeros(I,T);
    %for i=1:I
    %   for t=1:T   
    %         XXit(i,t) = unifrnd(lbXXit(i,t),ubXXit(i,t));
    %   end
    %end

    YYrt=unifrnd(0,1,[R,T]);
    ZZlt=unifrnd(0,1,[L,T]);  
    BBnt=unifrnd(0,1,[N,T]); 
    WWst=unifrnd(0,1,[S,T]);

    hIDjrt=unifrnd(0,1,[J,R,T]);
    
    hTPPmjirt= unifrnd(0,1,[M,J,I,R,T]);
    hTPKmjklt= unifrnd(0,1,[M,J,K,L,T]);
    hTPNmjlnt =unifrnd(0,1,[M,J,L,N,T]);
    hTPCmjilt =unifrnd(0,1,[M,J,I,L,T]);
    hTRSmsit  =unifrnd(0,1,[M,S,I,T]);  
    hTPDmjrkt =unifrnd(0,1,[M,J,R,K,T]);
    
    Sol.hIDjrt=hIDjrt;
   
    Sol.XXit=XXit;
    Sol.YYrt=YYrt;
    Sol.ZZlt=ZZlt;
    Sol.BBnt=BBnt;
    Sol.WWst=WWst;
    
    Sol.hTPPmjirt=hTPPmjirt;
    Sol.hTPKmjklt=hTPKmjklt;
    Sol.hTPNmjlnt=hTPNmjlnt;
    Sol.hTPCmjilt=hTPCmjilt;
    Sol.hTRSmsit=hTRSmsit;
    Sol.hTPDmjrkt=hTPDmjrkt;
end

