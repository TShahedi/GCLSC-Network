function Social = SocialInteraction(GHs,Params,model)

i = Params.i;
nPop = Params.nPop;
c = Params.c;

lbXXit=0;
ubXXit=1;
 
lbYYrt = 0;
ubYYrt = 1;

lbZZlt = 0;
ubZZlt = 1;

lbBBnt = 0;
ubBBnt = 1;

lbWWst = 0;
ubWWst = 1;

lbhIDjrt = 0;
ubhIDjrt = 1;

lbhTPPmjirt = 0;
ubhTPPmjirt = 1;

lbhTPKmjklt = 0;
ubhTPKmjklt = 1;

lbhTPNmjlnt = 0;
ubhTPNmjlnt = 1;

lbhTPCmjilt = 0;
ubhTPCmjilt= 1;

lbhTRSmsit = 0;
ubhTRSmsit = 1;

lbhTPDmjrkt = 0;
ubhTPDmjrkt= 1;

%%
% *BOLD TEXT*

XXiti=GHs(i).XXit;   
YYrti=GHs(i).YYrt;    
ZZlti=GHs(i).ZZlt;     
BBnti=GHs(i).BBnt;
WWsti=GHs(i).WWst;
hIDjrti=GHs(i).hIDjrt;         
hTPPmjirti=GHs(i).hTPPmjirt;   
hTPKmjklti=GHs(i).hTPKmjklt;     
hTPNmjlnti=GHs(i).hTPNmjlnt;
hTPCmjilti=GHs(i).hTPCmjilt;
hTRSmsiti=GHs(i).hTRSmsit;
hTPDmjrkti=GHs(i).hTPDmjrkt;
%%
% *BOLD TEXT*

distXXit = zeros(1,nPop); 
distYYrt = zeros(1,nPop);
distZZlt = zeros(1,nPop);
distBBnt = zeros(1,nPop);
distWWst = zeros(1,nPop);
disthIDjrt = zeros(1,nPop);
disthTPPmjirt = zeros(1,nPop);
disthTPKmjklt = zeros(1,nPop); 
disthTPNmjlnt = zeros(1,nPop);
disthTPCmjilt = zeros(1,nPop);
disthTRSmsit = zeros(1,nPop);
disthTPDmjrkt = zeros(1,nPop);

%%
% *BOLD TEXT*
for j=1:nPop
 mXXit(j).zr=(GHs(j).XXit-XXiti).^2;
 distXXit(j)=sqrt(sum(mXXit(j).zr(:)));
 
 mYYrt(j).zr=(GHs(j).YYrt-YYrti).^2;
 distYYrt(j)=sqrt(sum(mYYrt(j).zr(:)));
 
 mZZlt(j).zr=(GHs(j).ZZlt-ZZlti).^2;
 distZZlt(j)=sqrt(sum(mZZlt(j).zr(:)));
 
 mBBnt(j).zr=(GHs(j).BBnt-BBnti).^2;
 distBBnt(j)=sqrt(sum(mBBnt(j).zr(:)));
 
 mWWst(j).zr=(GHs(j).WWst-WWsti).^2;
 distWWst(j)=sqrt(sum(mWWst(j).zr(:)));
 
 mhIDjrt(j).zr=(GHs(j).hIDjrt-hIDjrti).^2;
 disthIDjrt(j)=sqrt(sum(mhIDjrt(j).zr(:)));
 
 mhTPPmjirt(j).zr=(GHs(j).hTPPmjirt-hTPPmjirti).^2;
 disthTPPmjirt(j)=sqrt(sum(mhTPPmjirt(j).zr(:)));
 
 mhTPKmjklt(j).zr=(GHs(j).hTPKmjklt-hTPKmjklti).^2;
 disthTPKmjklt(j)=sqrt(sum(mhTPKmjklt(j).zr(:)));
 
 mhTPNmjlnt(j).zr=(GHs(j).hTPNmjlnt-hTPNmjlnti).^2;
 disthTPNmjlnt(j)=sqrt(sum(mhTPNmjlnt(j).zr(:)));
 
 mhTPCmjilt(j).zr=(GHs(j).hTPCmjilt-hTPCmjilti).^2;
 disthTPCmjilt(j)=sqrt(sum(mhTPCmjilt(j).zr(:)));
 
 mhTRSmsit(j).zr=(GHs(j).hTRSmsit-hTRSmsiti).^2;
 disthTRSmsit(j)=sqrt(sum(mhTRSmsit(j).zr(:)));
 
 mhTPDmjrkt(j).zr=(GHs(j).hTPDmjrkt-hTPDmjrkti).^2;
 disthTPDmjrkt(j)=sqrt(sum(mhTPDmjrkt(j).zr(:)));
 
end
%%
% *BOLD TEXT*

distXXit(i) =[];
distYYrt(i) = [];
distZZlt(i)= [];
distBBnt(i) = [];
distWWst(i) = [];
disthIDjrt(i) = [];
disthTPPmjirt(i) = [];
disthTPKmjklt(i) = [];
disthTPNmjlnt(i) = [];
disthTPCmjilt(i) =[];
disthTRSmsit(i) =[];
disthTPDmjrkt(i) = [];
%%
% *BOLD TEXT*
ndistXXit = 2 + 2*distXXit/max(distXXit);
ndistYYrt = 2 + 2*distYYrt/max(distYYrt);
ndistZZlt = 2 + 2*distZZlt/max(distZZlt);
ndistBBnt = 2 + 2*distBBnt/max(distBBnt);
ndistWWst = 2 + 2*distWWst/max(distWWst);
ndisthIDjrt = 2 + 2*disthIDjrt/max(disthIDjrt);
ndisthTPPmjirt = 2 + 2*disthTPPmjirt/max(disthTPPmjirt);
ndisthTPKmjklt = 2 + 2*disthTPKmjklt/max(disthTPKmjklt);
ndisthTPNmjlnt = 2 + 2*disthTPNmjlnt/max(disthTPNmjlnt);
ndisthTPCmjilt = 2 + 2*disthTPCmjilt/max(disthTPCmjilt);
ndisthTRSmsit = 2 + 2*disthTRSmsit/max(disthTRSmsit);
ndisthTPDmjrkt = 2 + 2*disthTPDmjrkt/max(disthTPDmjrkt);

%ndist = 2 + rem(dist,2);

 %%
 % *BOLD TEXT*

sXXit = SFunction(ndistXXit);
sXXit = sXXit./distXXit;

sYYrt = SFunction(ndistYYrt);
sYYrt = sYYrt./distYYrt;

sZZlt = SFunction(ndistZZlt);
sZZlt = sZZlt./distZZlt;

sBBnt = SFunction(ndistBBnt);
sBBnt = sBBnt./distBBnt;

sWWst = SFunction(ndistWWst);
sWWst = sWWst./distWWst;

shIDjrt = SFunction(ndisthIDjrt);
shIDjrt = shIDjrt./disthIDjrt;

shTPPmjirt = SFunction(ndisthTPPmjirt);
shTPPmjirt = shTPPmjirt./disthTPPmjirt;

shTPKmjklt = SFunction(ndisthTPKmjklt);
shTPKmjklt = shTPKmjklt./disthTPKmjklt;

shTPNmjlnt = SFunction(ndisthTPNmjlnt);
shTPNmjlnt = shTPNmjlnt./disthTPNmjlnt;

shTPCmjilt = SFunction(ndisthTPCmjilt);
shTPCmjilt = shTPCmjilt./disthTPCmjilt;

shTRSmsit = SFunction(ndisthTRSmsit);
shTRSmsit = shTRSmsit./disthTRSmsit;

shTPDmjrkt = SFunction(ndisthTPDmjrkt);
shTPDmjrkt = shTPDmjrkt./disthTPDmjrkt;

%s = SFunction(ndist);
%s = s./dist;

%%
% *BOLD TEXT*
SXXit = 0;
for j = 1:nPop - 1
    
    SXXit = SXXit + 0.5*c*(ubXXit - lbXXit)*sXXit(j)*( XXiti -GHs(j).XXit); 

end
Social.SIxxIT = SXXit;


SYYrt = 0;
for j = 1:nPop - 1
     
    SYYrt = SYYrt + 0.5*c*(ubYYrt - lbYYrt)*sYYrt(j)*( YYrti - GHs(j).YYrt); 

end
Social.SIyyRT = SYYrt;

SZZlt = 0;
for j = 1:nPop - 1
    
    SZZlt = SZZlt + 0.5*c*(ubZZlt - lbZZlt)*sZZlt(j)*( ZZlti - GHs(j).ZZlt); 

end
Social.SIzzLT = SZZlt;

SBBnt = 0;
for j = 1:nPop - 1
    
    SBBnt = SBBnt + 0.5*c*(ubBBnt - lbBBnt)*sBBnt(j)*( BBnti - GHs(j).BBnt); 

end
Social.SIbbNT = SBBnt;


SWWst = 0;
for j = 1:nPop - 1
    
    SWWst = SWWst + 0.5*c*(ubWWst - lbWWst)*sWWst(j)*( WWsti -  GHs(j).WWst); 

end
Social.SIwwST = SWWst;

ShIDjrt = 0;
for j = 1:nPop - 1
    
    ShIDjrt = ShIDjrt + 0.5*c*(ubhIDjrt - lbhIDjrt)*shIDjrt(j)*( hIDjrti -  GHs(j).hIDjrt); 

end
Social.SIHidJRT = ShIDjrt;

ShTPPmjirt = 0;
for j = 1:nPop - 1
    
    ShTPPmjirt = ShTPPmjirt + 0.5*c*(ubhTPPmjirt - lbhTPPmjirt)*shTPPmjirt(j)*( hTPPmjirti -  GHs(j).hTPPmjirt); 

end
Social.SIHtppMJIRT = ShTPPmjirt;


ShTPKmjklt = 0;
for j = 1:nPop - 1
    
    ShTPKmjklt = ShTPKmjklt + 0.5*c*(ubhTPKmjklt - lbhTPKmjklt)*shTPKmjklt(j)*( hTPKmjklti - GHs(j).hTPKmjklt); 

end
Social.SIHtpkMJKLT = ShTPKmjklt;

ShTPNmjlnt = 0;
for j = 1:nPop - 1
    
    ShTPNmjlnt = ShTPNmjlnt + 0.5*c*(ubhTPNmjlnt - lbhTPNmjlnt)*shTPNmjlnt(j)*( hTPNmjlnti -  GHs(j).hTPNmjlnt); 

end
Social.SIHtpnMJLNT = ShTPNmjlnt;

ShTPCmjilt = 0;
for j = 1:nPop - 1
    
    ShTPCmjilt = ShTPCmjilt + 0.5*c*(ubhTPCmjilt - lbhTPCmjilt)*shTPCmjilt(j)*( hTPCmjilti -  GHs(j).hTPCmjilt); 

end
Social.SIHtpcMJILT = ShTPCmjilt;


ShTRSmsit = 0;
for j = 1:nPop - 1
    
    ShTRSmsit = ShTRSmsit + 0.5*c*(ubhTRSmsit - lbhTRSmsit)*shTRSmsit(j)*( hTRSmsiti -  GHs(j).hTRSmsit); 

end
Social.SIHtrsMSIT = ShTRSmsit;

ShTPDmjrkt = 0;
for j = 1:nPop - 1
    
    ShTPDmjrkt = ShTPDmjrkt + 0.5*c*(ubhTPDmjrkt - lbhTPDmjrkt)*shTPDmjrkt(j)*( hTPDmjrkti - GHs(j).hTPDmjrkt); 

end
Social.SIHtpdMJRKT = ShTPDmjrkt;


%S = 0;
%for j = 1:nPop - 1
    
%    S = S + 0.5*c*(ub - lb)*s(j).*( xi - GHs(j,:)); 

%end
%SI = S;
end

function s = SFunction(d)
f = 0.5;
l = 1.5;

s = f*exp(-d/l) - exp(-d);
end


