clc
clear
close all

%% Problem Definition
model=CreateModel();
%% GOA Parameters

MaxIt = 100;     % Maximum Nomber of Iterations

nPop = 50;         % Population Size
Params.nPop = nPop;
% Constriction Coefeicient
cMax = 1;
cMin = 1e-4;


%% Initialization
empty_GrassHopper.Position = [];
empty_GrassHopper.Cost = [];
empty_GrassHopper.Sol = [];

GrassHopper = repmat(empty_GrassHopper,nPop,1);

for i = 1:nPop
    % Initialize Position
    GrassHopper(i).Position = CreateRandomSolution( model );
    
    
    % Evaluate
    [GrassHopper(i).Cost ,GrassHopper(i).Sol]=CostFunction(model,GrassHopper(i).Position);
end
NFE = nPop;
[~,indx] = max([GrassHopper.Cost]);

TargetGH = GrassHopper(indx);   % Target Grass Hopper

BestCost = zeros(1,MaxIt);
MeanCost = zeros(1,MaxIt);
WorstCost = zeros(1,MaxIt);
nfe = zeros(1,MaxIt);

%% GOA Main Loop
for it = 1:MaxIt
    c = cMax - it*((cMax - cMin)/MaxIt);   % Update C Parameter
    Params.c = c;
    for i = 1:nPop
        Params.i = i;
        GrassHoppers = cat(1,GrassHopper.Position);
        %SI = SocialInteraction(GrassHoppers,Params,model);
        Social=SocialInteraction(GrassHoppers,Params,model);
        
        
        GrassHopper(i).Position.XXit = c*Social.SIxxIT + TargetGH.Position.XXit;
        GrassHopper(i).Position.YYrt = c*Social.SIyyRT + TargetGH.Position.YYrt;        
        GrassHopper(i).Position.ZZlt = c*Social.SIzzLT + TargetGH.Position.ZZlt;
        GrassHopper(i).Position.BBnt = c*Social.SIbbNT + TargetGH.Position.BBnt;
        GrassHopper(i).Position.WWst = c*Social.SIwwST + TargetGH.Position.WWst;
        
        GrassHopper(i).Position.hIDjrt    = c*Social.SIHidJRT + TargetGH.Position.hIDjrt;
        GrassHopper(i).Position.hTPPmjirt = c*Social.SIHtppMJIRT + TargetGH.Position.hTPPmjirt;
        GrassHopper(i).Position.hTPKmjklt = c*Social.SIHtpkMJKLT + TargetGH.Position.hTPKmjklt;        
        GrassHopper(i).Position.hTPNmjlnt = c*Social.SIHtpnMJLNT + TargetGH.Position.hTPNmjlnt;
        GrassHopper(i).Position.hTPCmjilt = c*Social.SIHtpcMJILT + TargetGH.Position.hTPCmjilt;
        GrassHopper(i).Position.hTRSmsit  = c*Social.SIHtrsMSIT + TargetGH.Position.hTRSmsit;
        GrassHopper(i).Position.hTPDmjrkt = c*Social.SIHtpdMJRKT + TargetGH.Position.hTPDmjrkt;
        
        
    
        
        
        %% correct XXit,YYrt,ZZlt,BBnt,WWst,hIDjrt,hTPPmjirt,hTPKmjklt,hTPNmjlnt,hTPCmjilt,hTRSmsit,hTPDmjrkt based on binary,upper or lower bound and some feasible const! 
        
        % XXit
        VarMax=1;
        VarMin=0;
        IsOutside=(GrassHopper(i).Position.XXit<VarMin | GrassHopper(i).Position.XXit>VarMax);    
        GrassHopper(i).Position.XXit(IsOutside)=-GrassHopper(i).Position.XXit(IsOutside);
        GrassHopper(i).Position.XXit=max(GrassHopper(i).Position.XXit,VarMin);
        GrassHopper(i).Position.XXit=min(GrassHopper(i).Position.XXit,VarMax);
        % YYrt
        VarMax=1;
        VarMin=0;
        IsOutside=(GrassHopper(i).Position.YYrt<VarMin | GrassHopper(i).Position.YYrt>VarMax);    
        GrassHopper(i).Position.YYrt(IsOutside)=-GrassHopper(i).Position.YYrt(IsOutside);
        GrassHopper(i).Position.YYrt=max(GrassHopper(i).Position.YYrt,VarMin);
        GrassHopper(i).Position.YYrt=min(GrassHopper(i).Position.YYrt,VarMax);        
        % ZZlt        
        VarMax=1;
        VarMin=0;
        IsOutside=(GrassHopper(i).Position.ZZlt<VarMin | GrassHopper(i).Position.ZZlt>VarMax);    
        GrassHopper(i).Position.ZZlt(IsOutside)=-GrassHopper(i).Position.ZZlt(IsOutside);
        GrassHopper(i).Position.ZZlt=max(GrassHopper(i).Position.ZZlt,VarMin);
        GrassHopper(i).Position.ZZlt=min(GrassHopper(i).Position.ZZlt,VarMax);        
        % BBnt
        VarMax=1;
        VarMin=0;
        IsOutside=(GrassHopper(i).Position.BBnt<VarMin | GrassHopper(i).Position.BBnt>VarMax);    
        GrassHopper(i).Position.BBnt(IsOutside)=-GrassHopper(i).Position.BBnt(IsOutside);
        GrassHopper(i).Position.BBnt=max(GrassHopper(i).Position.BBnt,VarMin);
        GrassHopper(i).Position.BBnt=min(GrassHopper(i).Position.BBnt,VarMax);
        % WWst
        VarMax=1;
        VarMin=0;
        IsOutside=(GrassHopper(i).Position.WWst<VarMin | GrassHopper(i).Position.WWst>VarMax);    
        GrassHopper(i).Position.WWst(IsOutside)=-GrassHopper(i).Position.WWst(IsOutside);
        GrassHopper(i).Position.WWst=max(GrassHopper(i).Position.WWst,VarMin);
        GrassHopper(i).Position.WWst=min(GrassHopper(i).Position.WWst,VarMax);
        % hIDjrt
        VarMax=1;
        VarMin=0;
        IsOutside=(GrassHopper(i).Position.hIDjrt<VarMin | GrassHopper(i).Position.hIDjrt>VarMax);    
        GrassHopper(i).Position.hIDjrt(IsOutside)=-GrassHopper(i).Position.hIDjrt(IsOutside);
        GrassHopper(i).Position.hIDjrt=max(GrassHopper(i).Position.hIDjrt,VarMin);
        GrassHopper(i).Position.hIDjrt=min(GrassHopper(i).Position.hIDjrt,VarMax);
        % hTPPmjirt
        VarMax=1;
        VarMin=0;
        IsOutside=(GrassHopper(i).Position.hTPPmjirt<VarMin | GrassHopper(i).Position.hTPPmjirt>VarMax);    
        GrassHopper(i).Position.hTPPmjirt(IsOutside)=-GrassHopper(i).Position.hTPPmjirt(IsOutside);
        GrassHopper(i).Position.hTPPmjirt=max(GrassHopper(i).Position.hTPPmjirt,VarMin);
        GrassHopper(i).Position.hTPPmjirt=min(GrassHopper(i).Position.hTPPmjirt,VarMax);        
        % hTPKmjklt        
        VarMax=1;
        VarMin=0;
        IsOutside=(GrassHopper(i).Position.hTPKmjklt<VarMin | GrassHopper(i).Position.hTPKmjklt>VarMax);    
        GrassHopper(i).Position.hTPKmjklt(IsOutside)=-GrassHopper(i).Position.hTPKmjklt(IsOutside);
        GrassHopper(i).Position.hTPKmjklt=max(GrassHopper(i).Position.hTPKmjklt,VarMin);
        GrassHopper(i).Position.hTPKmjklt=min(GrassHopper(i).Position.hTPKmjklt,VarMax);        
        % hTPNmjlnt
        VarMax=1;
        VarMin=0;
        IsOutside=(GrassHopper(i).Position.hTPNmjlnt<VarMin | GrassHopper(i).Position.hTPNmjlnt>VarMax);    
        GrassHopper(i).Position.hTPNmjlnt(IsOutside)=-GrassHopper(i).Position.hTPNmjlnt(IsOutside);
        GrassHopper(i).Position.hTPNmjlnt=max(GrassHopper(i).Position.hTPNmjlnt,VarMin);
        GrassHopper(i).Position.hTPNmjlnt=min(GrassHopper(i).Position.hTPNmjlnt,VarMax);
        % hTPCmjilt
        VarMax=1;
        VarMin=0;
        IsOutside=(GrassHopper(i).Position.hTPCmjilt<VarMin | GrassHopper(i).Position.hTPCmjilt>VarMax);    
        GrassHopper(i).Position.hTPCmjilt(IsOutside)=-GrassHopper(i).Position.hTPCmjilt(IsOutside);
        GrassHopper(i).Position.hTPCmjilt=max(GrassHopper(i).Position.hTPCmjilt,VarMin);
        GrassHopper(i).Position.hTPCmjilt=min(GrassHopper(i).Position.hTPCmjilt,VarMax);
        % hTRSmsit        
        VarMax=1;
        VarMin=0;
        IsOutside=(GrassHopper(i).Position.hTRSmsit<VarMin | GrassHopper(i).Position.hTRSmsit>VarMax);    
        GrassHopper(i).Position.hTRSmsit(IsOutside)=-GrassHopper(i).Position.hTRSmsit(IsOutside);
        GrassHopper(i).Position.hTRSmsit=max(GrassHopper(i).Position.hTRSmsit,VarMin);
        GrassHopper(i).Position.hTRSmsit=min(GrassHopper(i).Position.hTRSmsit,VarMax);        
        % hTPDmjrkt
        VarMax=1;
        VarMin=0;
        IsOutside=(GrassHopper(i).Position.hTPDmjrkt<VarMin | GrassHopper(i).Position.hTPDmjrkt>VarMax);    
        GrassHopper(i).Position.hTPDmjrkt(IsOutside)=-GrassHopper(i).Position.hTPDmjrkt(IsOutside);
        GrassHopper(i).Position.hTPDmjrkt=max(GrassHopper(i).Position.hTPDmjrkt,VarMin);
        GrassHopper(i).Position.hTPDmjrkt=min(GrassHopper(i).Position.hTPDmjrkt,VarMax);
        
        % Evaluation
        [GrassHopper(i).Cost,GrassHopper(i).Sol] = CostFunction(model,GrassHopper(i).Position);      
        % Update Target
        
        if GrassHopper(i).Cost>TargetGH.Cost
            TargetGH = GrassHopper(i);
        end
    end
    
    BestCost(it) = TargetGH.Cost;
    MeanCost(it) = mean([GrassHopper.Cost]);
    WorstCost(it) = max([GrassHopper.Cost]);
    NFE = NFE + nPop;
    nfe(it) = NFE;
    disp(['Iteration= ' num2str(it) ' Best Profit= ' num2str(BestCost(it)) ' Is Feasible? ' num2str( TargetGH.Sol.IsFeasible)])
    disp(['Iteration: ',num2str(it),' , NFE = ',num2str(nfe(it)),' BestProfit = ',num2str(BestCost(it))]);
    
end


%% Plot
figure
plot(1:MaxIt,BestCost,'LineWidth',2)
semilogy(1:MaxIt,BestCost,'LineWidth',2)
hold on
semilogy(1:MaxIt,MeanCost,'LineWidth',2)
hold on
semilogy(1:MaxIt,WorstCost,'LineWidth',2)
legend('Best Profit','Mean Profit','Worst Profit');
xlabel('Iteration')
ylabel('Best Profit')
title('Trend GOA for Function')

figure
plot(1:MaxIt,BestCost,'LineWidth',2)
semilogy(nfe,BestCost,'LineWidth',2)
xlabel('NFE')
ylabel('Best Profit')
title('Trend GOA for Function')

figure
plot(1:MaxIt,WorstCost,'LineWidth',2)
semilogy(nfe,WorstCost,'LineWidth',2)
xlabel('NFE')
ylabel('Worst Profit')
title('Trend GOA for Function')

figure
plot(1:MaxIt,MeanCost,'LineWidth',2)
semilogy(nfe,MeanCost,'LineWidth',2)
xlabel('NFE')
ylabel('Mean Profit')
title('Trend GOA for Function')