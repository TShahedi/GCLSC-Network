*********************** CLSCND *************************************************

*-*-*-*-*-*-*-*-*-*-*-* Set *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
sets
    j index of product /1*3/
    s index of supplier /1*3/
    k index of custoner location /1*4/
    r index for potential locations for distribution center /1*4/
    i index for potential locations for manufacturing-remanufacturing plant /1*4/
    l index for potential locations for collection center /1*4/
    n index for potential locations for recycling center /1*4/
    t index of period time  /1*3/
    m index of transportation system  provided by the supplier /1*4/
    ;
*-*-*-*-*-*-*-*-*-*-*-* scalar*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
scalars
    Beta the minimum degree of satisfying possibilistic constraints /0.9/
    vrP Pessimistic Volume of raw material /0.016/
    vrM The Most likely Volume of raw material /0.014/
    vrO Optimistic Volume of raw material /0.01/
    ;
scalars
    C1   production costs
    C2   cost of purchased raw material
    C3   Variable transportation costs
    C4   fixed cost of transportation
    C5   holding cost
    C6   lack of inventory at customer centers cost
    C7   cost of opening facilities
    ;
*-*-*-*-*-*-*-*-*-*-*-* parameters *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
parameters
    tetaP(m) Pessimistic amount of released CO2 for the transportation system m
    tetaM(m) The Most likely amount of released CO2 for the transportation system m
    tetaO(m) Optimistic amount of released CO2 for the transportation system m
    ;

    loop((m),
    tetaP(m)=uniform(0.02,0.05);
    tetaM(m)=uniform(0.02,tetaP(m));
    tetaO(m)=uniform(0.02,tetaM(m));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    vP(j)   Pessimistic Volume of each unit product j
    vM(j)   The Most likely Volume of each unit product j
    vO(j)   Optimistic Volume of each unit product j
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    RRP(j)  Pessimistic Rate of Recoverable used product j
    RRM(j)  The Most likely Rate of Recoverable used product j
    RRO(j)  Optimistic Rate of Recoverable used product j
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    RTP(j)  Pessimistic Rate of Return used product j
    RTM(j)  The Most likely Rate of Return used product j
    RTO(j)  Optimistic Rate of Return used product j
    ;

    loop((j),
    vP(j)=uniform(0.007,0.014);
    vM(j)=uniform(0.007,vP(j));
    vO(j)=uniform(0.007,vM(j));
    RRP(j)=uniform(0.2,0.35);
    RRM(j)=uniform(RRP(j),0.35);
    RRO(j)=uniform(RRM(j),0.35);
    RTP(j)=uniform(0.1,0.4);
    RTM(j)=uniform(RTP(j),0.4);
    RTO(j)=uniform(RTM(j),0.4);
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    IDzero(j,r)  initial inventory
    ;

    loop((j,r),
    IDzero(j,r)=round(uniform(290,400));
    );
*-*-*-*-*-*-*-*-*-*-*-*-* Distance *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
parameters
    eS(s,i) The distance between locations of supplier s and plant i
    eP(i,r) The distance between locations of manufacturing plant i and distribution center r
    eD(r,k) The distance between locations of distribution center r and customer centers k
    eK(k,l) The distance between locations of customer centers k and collection center l
    eN(l,n) The distance between locations of collection center l and recycling center n
    eC(l,i) The distance between locations of collection center l and remanufacturing plant i
    ;

    loop((s,i,r,k,l,n),
    eS(s,i)=uniform(10,23);
    eP(i,r)=uniform(10,25);
    eD(r,k)=uniform(10,34);
    eK(k,l)=uniform(10,29);
    eN(l,n)=uniform(12,19);
    eC(l,i)=uniform(12,22);
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    ur(j,t) The rate of using the raw material for product j in period t
    uru(j,t) The rate of using the raw material for used product j in period t
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    CSP(j,t) Pessimistic Cost Saving of product j in period t
    CSM(j,t) The Most likely Cost Saving of product j in period t
    CSO(j,t) Optimistic Cost Saving of product j in period t
    ;

    loop((j,t),
    ur(j,t)=uniform(0.2,0.9);
    uru(j,t)=uniform(0.1,0.8);
    CSP(j,t)=uniform(50,57);
    CSM(j,t)=uniform(CSP(j,t),77);
    CSO(j,t)=uniform(CSM(j,t),80);
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    cRP(s,t) Pessimistic Purchased Cost of raw material from supplier s in period t
    cRM(s,t) The Most likely Purchased Cost of raw material from supplier s in period t
    cRO(s,t) Optimistic Purchased Cost of raw material from supplier s in period t
*-*-*-*-*-*-*-*-*-*-*-*-* Fixed-Cost *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
    fcSP(s,t) Pessimistic Fixed-Cost associated with supplier s in period t
    fcSM(s,t) The Most likely Fixed-Cost associated with supplier s in period t
    fcSO(s,t) Optimistic Fixed-Cost associated with supplier s in period t
    ;

    loop((s,t),
    cRP(s,t)=round(uniform(20,37));
    cRM(s,t)=round(uniform(20,cRP(s,t)));
    cRO(s,t)=round(uniform(20,cRM(s,t)));
    fcSP(s,t)=round(uniform(6500,20000));
    fcSM(s,t)=round(uniform(6500,fcSP(s,t)));
    fcSO(s,t)=round(uniform(6500,fcSM(s,t)));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    fcPP(i,t) Pessimistic Fixed-Cost for opening plant i by the manufacturer in period t
    fcPM(i,t) The Most likely Fixed-Cost for opening plant i by the manufacturer in period t
    fcPO(i,t) Optimistic Fixed-Cost for opening plant i by the manufacturer in period t
    ;

    loop((i,t),
    fcPP(i,t)=round(uniform(8500,15500));
    fcPM(i,t)=round(uniform(8500,fcPP(i,t)));
    fcPO(i,t)=round(uniform(8500,fcPM(i,t)));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    fcDP(r,t) Pessimistic Fixed-Cost for opening distribution center r in period t
    fcDM(r,t) The Most likely Fixed-Cost for opening distribution center r in period t
    fcDO(r,t) Optimistic Fixed-Cost for opening distribution center r in period t
    ;

    loop((r,t),
    fcDP(r,t)=round(uniform(8500,15500));
    fcDM(r,t)=round(uniform(8500,fcDP(r,t)));
    fcDO(r,t)=round(uniform(8500,fcDM(r,t)));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    fcCP(l,t) Pessimistic Fixed-Cost for opening the collection center l in period t
    fcCM(l,t) The Most likely Fixed-Cost for opening the collection center l in period t
    fcCO(l,t) Optimistic Fixed-Cost for opening the collection center l in period t
    ;

    loop((l,t),
    fcCP(l,t)=round(uniform(8500,15500));
    fcCM(l,t)=round(uniform(8500,fcCP(l,t)));
    fcCO(l,t)=round(uniform(8500,fcCM(l,t)));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    fcNP(n,t) Pessimistic Fixed-Cost for opening the recycling center n in period t
    fcNM(n,t) The Most likely Fixed-Cost for opening the recycling center n in period t
    fcNO(n,t) Optimistic Fixed-Cost for opening the recycling center n in period t
    ;

    loop((n,t),
    fcNP(n,t)=round(uniform(8500,15500));
    fcNM(n,t)=round(uniform(8500,fcNP(n,t)));
    fcNO(n,t)=round(uniform(8500,fcNM(n,t)));
    );
*-*-*-*-*-*-*-*-*-*-*-* Environmental impact *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
parameters
    EISP(s,t) Pessimistic Environmental impact of raw materials purchased from supplier s in period t
    EISM(s,t) The Most likely Environmental impact of raw materials purchased from supplier s in period t
    EISO(s,t) Optimistic Environmental impact of raw materials purchased from supplier s in period t
    ;

    loop((s,t),
    EISP(s,t)=round(uniform(40-cRP(s,t),40-cRO(s,t)));
    EISM(s,t)=round(uniform(40-cRP(s,t),EISP(s,t)));
    EISO(s,t)=round(uniform(40-cRP(s,t),EISM(s,t)));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    EIPP(i,t) Pessimistic Environmental impact of opening manufacturing-remanufacturing plant i in period t
    EIPM(i,t) The Most likely Environmental impact of opening manufacturing-remanufacturing plant i in period t
    EIPO(i,t) Optimistic Environmental impact of opening manufacturing-remanufacturing plant i in period t
    ;

    loop((i,t),
    EIPP(i,t)=round(uniform(8,15));
    EIPM(i,t)=round(uniform(8,EIPP(i,t)));
    EIPO(i,t)=round(uniform(8,EIPM(i,t)));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    EIDP(r,t) Pessimistic Environmental impact of opening distribution center r in period t
    EIDM(r,t) The Most likely Environmental impact of opening distribution center r in period t
    EIDO(r,t) Optimistic Environmental impact of opening distribution center r in period t
    ;

    loop((r,t),
    EIDP(r,t)=round(uniform(8,15));
    EIDM(r,t)=round(uniform(8,EIDP(r,t)));
    EIDO(r,t)=round(uniform(8,EIDM(r,t)));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    EICP(l,t) Pessimistic Environmental impact of opening collection center l in period t
    EICM(l,t) The Most likely Environmental impact of opening collection center l in period t
    EICO(l,t) Optimistic Environmental impact of opening collection center l in period t
    ;

    loop((l,t),
    EICP(l,t)=round(uniform(8,15));
    EICM(l,t)=round(uniform(8,EICP(l,t)));
    EICO(l,t)=round(uniform(8,EICM(l,t)));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    EINP(n,t) Pessimistic Environmental impact of opening recycle center n in period t
    EINM(n,t) The Most likely Environmental impact of opening recycle center n in period t
    EINO(n,t) Optimistic Environmental impact of opening recycle center n in period t
    ;

    loop((n,t),
    EINP(n,t)=round(uniform(8,15));
    EINM(n,t)=round(uniform(8,EINP(n,t)));
    EINO(n,t)=round(uniform(8,EINM(n,t)));
    );
*-*-*-*-*-*-*-*-*-*-*-* Capacity *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
parameters
    capSP(s,t) Pessimistic Capacity of supplier s in period t
    capSM(s,t) The Most likely Capacity of supplier s in period t
    capSO(s,t) Optimistic Capacity of supplier s in period t
    ;

    loop((s,t),
    capSP(s,t)=round(uniform(1836,1915));
    capSM(s,t)=round(uniform(capSP(s,t),1915));
    capSO(s,t)=round(uniform(capSM(s,t),1915));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    capPP(i,t) Pessimistic End Product Storage Capacity of manufacturing-remanufacturing plant i in period t
    capPM(i,t) The Most likely End Product Storage Capacity of manufacturing-remanufacturing plant i in period t
    capPO(i,t) Optimistic End Product Storage Capacity of manufacturing-remanufacturing plant i in period t
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    capPRP(i,t) Pessimistic Raw material Storage Capacity of manufacturing-remanufacturing plant i in period t
    capPRM(i,t) The Most likely Raw material Storage Capacity of manufacturing-remanufacturing plant i in period t
    capPRO(i,t) Optimistic Raw material Storage Capacity of manufacturing-remanufacturing plant i in period t
    ;

    loop((i,t),
    capPP(i,t)=round(uniform(4850,4880));
    capPM(i,t)=round(uniform(capPP(i,t),4880));
    capPO(i,t)=round(uniform(capPM(i,t),4880));
    capPRP(i,t)=round(uniform(3850,3880));
    capPRM(i,t)=round(uniform(capPRP(i,t),3880));
    capPRO(i,t)=round(uniform(capPRM(i,t),3880));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    capDP(r,t) Pessimistic Capacity of distribution center r in period t
    capDM(r,t) The Most likely Capacity of distribution center r in period t
    capDO(r,t) Optimistic Capacity of distribution center r in period t
    ;

    loop((r,t),
    capDP(r,t)=round(uniform(2000,3045));
    capDM(r,t)=round(uniform(capDP(r,t),3045));
    capDO(r,t)=round(uniform(capDM(r,t),3045));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    capCP(l,t) Pessimistic Capacity of collection center l in period t
    capCM(l,t) The Most likely Capacity of collection center l in period t
    capCO(l,t) Optimistic Capacity of collection center l in period t
    ;

    loop((l,t),
    capCP(l,t)=round(uniform(1800,3815));
    capCM(l,t)=round(uniform(capCP(l,t),3815));
    capCO(l,t)=round(uniform(capCM(l,t),3815));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    capNP(n,t) Pessimistic Capacity of recycle center n in period t
    capNM(n,t) The Most likely Capacity of recycle center n in period t
    capNO(n,t) Optimistic Capacity of recycle center n in period t
    ;

    loop((n,t),
    capNP(n,t)=round(uniform(1800,3815));
    capNM(n,t)=round(uniform(capNP(n,t),3815));
    capNO(n,t)=round(uniform(capNM(n,t),3815));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    capLP(m,t) Pessimistic Capacity of each of transportation tools m in period t
    capLM(m,t) The Most likely Capacity of each of transportation tools m in period t
    capLO(m,t) Optimistic Capacity of each of transportation tools m in period t
    ;

    loop((m,t),
    capLP(m,t)=round(uniform(10,15));
    capLM(m,t)=round(uniform(capLP(m,t),15));
    capLO(m,t)=round(uniform(capLM(m,t),15));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameter
    alpha(j,k,t) Percentage of unsatisfied demand in each customer center k
    ;

    loop((j,k,t),
    alpha(j,k,t)=uniform(0.04,0.09);
    );
*-*-*-*-*-*-*-*-*-*-*-* Production Cost *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    cPP(j,i,t) Pessimistic Production Cost of product j in manufacturing plant i in period t
    cPM(j,i,t) The Most likely Production Cost of product j in manufacturing plant i in period t
    cPO(j,i,t) Optimistic Production Cost of product j in manufacturing plant i in period t
    ;

    loop((j,i,t),
    cPP(j,i,t)=round(uniform(22,47));
    cPM(j,i,t)=round(uniform(22,cPP(j,i,t)));
    cPO(j,i,t)=round(uniform(22,cPM(j,i,t)));
    );
*-*-*-*-*-*-*-*-*-*-*-* Recycling Cost *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
parameters
    RCP(j,n,t) Pessimistic Recycling Cost of product j in recycling center n in period t
    RCM(j,n,t) The Most likely Recycling Cost of product j in recycling center n in period t
    RCO(j,n,t) Optimistic Recycling Cost of product j in recycling center n in period t
    ;

    loop((j,n,t),
    RCP(j,n,t)=round(uniform(20,35));
    RCM(j,n,t)=round(uniform(20,RCP(j,n,t)));
    RCO(j,n,t)=round(uniform(20,RCM(j,n,t)));
    );
*-*-*-*-*-*-*-*-*-*-*-* Holding Cost *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
parameters
    HCP(j,r,t) Pessimistic Holding Cost of the product j in distribution center r in period t
    HCM(j,r,t) The Most likely Holding Cost of the product j in distribution center r in period t
    HCO(j,r,t) Optimistic Holding Cost of the product j in distribution center r in period t
    ;

    loop((j,r,t),
    HCP(j,r,t)=uniform(8.3,8.5);
    HCM(j,r,t)=uniform(8.3,HCP(j,r,t));
    HCO(j,r,t)=uniform(8.3,HCM(j,r,t));
    );
*-*-*-*-*-*-*-*-*-*-*-* Shortage Cost *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    SHCP(j,k,t) Pessimistic Cost of shortage the unit of product j for customer center k in period t
    SHCM(j,k,t) The Most likely Cost of shortage the unit of product j for customer center k in period t
    SHCO(j,k,t) Optimistic Cost of shortage the unit of product j for customer center k in period t
*-*-*-*-*-*-*-*-*-*-*-* Demand *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
    deP(j,k,t) Pessimistic Demand of customer centers k for product j in period t
    deM(j,k,t) The Most likely Demand of customer centers k for product j in period t
    deO(j,k,t) Optimistic Demand of customer centers k for product j in period t
    ;

    loop((j,k,t),
    SHCP(j,k,t)=uniform(9,20.5);
    SHCM(j,k,t)=uniform(9,SHCP(j,k,t));
    SHCO(j,k,t)=uniform(9,SHCM(j,k,t));
    deP(j,k,t)=round(uniform(1400,1820));
    deM(j,k,t)=round(uniform(deP(j,k,t),1820));
    deO(j,k,t)=round(uniform(deM(j,k,t),1820));
    );
*-*-*-*-*-*-*-*-*-*-*-* Selling price *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    SP(j,i,r,t) Pessimistic Selling price of product j from manufacturing plant i to distribution center r in period t
    SM(j,i,r,t) The Most likely Selling price of product j from manufacturing plant i to distribution center r in period t
    SO(j,i,r,t) Optimistic Selling price of product j from manufacturing plant i to distribution center r in period t
    ;

    loop((j,i,r,t),
    SP(j,i,r,t)=round(uniform(103,167));
    SM(j,i,r,t)=round(uniform(SP(j,i,r,t),167));
    SO(j,i,r,t)=round(uniform(SM(j,i,r,t),167));
    );
*-*-*-*-*-*-*-*-*-*-*-* Fixed Transportation Cost *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    ftSP(m,s,i,t) Pessimistic Fixed-Cost of sending transportation system m from supplier s to manufacturing plant i in period t
    ftSM(m,s,i,t) The Most likely Fixed-Cost of sending transportation system m from supplier s to manufacturing plant i in period t
    ftSO(m,s,i,t) Optimistic Fixed-Cost of sending transportation system m from supplier s to manufacturing plant i in period t
    ;

    loop((m,s,i,t),
    ftSP(m,s,i,t)=round(uniform(11,21));
    ftSM(m,s,i,t)=round(uniform(11,ftSP(m,s,i,t)));
    ftSO(m,s,i,t)=round(uniform(11,ftSM(m,s,i,t)));
    );
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
parameters
    ftPP(m,i,r,t) Pessimistic Fixed-Cost of sending transportation system m from supplier s to manufacturing plant i in period t
    ftPM(m,i,r,t) The Most likely Fixed-Cost of sending transportation system m from supplier s to manufacturing plant i in period t
    ftPO(m,i,r,t) Optimistic Fixed-Cost of sending transportation system m from supplier s to manufacturing plant i in period t
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    ftDP(m,r,k,t) Pessimistic Fixed-Cost of sending transportation system m from distribution center r to customer centers k in period t
    ftDM(m,r,k,t) The Most likely Fixed-Cost of sending transportation system m from distribution center r to customer centers k in period t
    ftDO(m,r,k,t) Optimistic Fixed-Cost of sending transportation system m from distribution center r to customer centers k in period t
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    ftKP(m,k,l,t) Pessimistic Fixed-Cost of sending transportation system m from customer centers k to collection center l in period t
    ftKM(m,k,l,t) The Most likely Fixed-Cost of sending transportation system m from customer centers k to collection center l in period t
    ftKO(m,k,l,t) Optimistic Fixed-Cost of sending transportation system m from customer centers k to collection center l in period t
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    ftNP(m,l,n,t) Pessimistic Fixed-Cost of sending transportation system m from collection center l to recycling center n in period t
    ftNM(m,l,n,t) The Most likely Fixed-Cost of sending transportation system m from collection center l to recycling center n in period t
    ftNO(m,l,n,t) Optimistic Fixed-Cost of sending transportation system m from collection center l to recycling center n in period t
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    ftCP(m,l,i,t) Pessimistic Fixed-Cost of sending transportation system m from collection center l to remanufacturing plant i in period t
    ftCM(m,l,i,t) The Most likely Fixed-Cost of sending transportation system m from collection center l to remanufacturing plant i in period t
    ftCO(m,l,i,t) Optimistic Fixed-Cost of sending transportation system m from collection center l to remanufacturing plant i in period t l in period t
    ;

    loop((m,i,r,k,l,n,t),
    ftPP(m,i,r,t)=round(uniform(15,21));
    ftPM(m,i,r,t)=round(uniform(15,ftPP(m,i,r,t)));
    ftPO(m,i,r,t)=round(uniform(15,ftPM(m,i,r,t)));
    ftDP(m,r,k,t)=round(uniform(15,21));
    ftDM(m,r,k,t)=round(uniform(15,ftDP(m,r,k,t)));
    ftDO(m,r,k,t)=round(uniform(15,ftDM(m,r,k,t)));
    ftKP(m,k,l,t)=round(uniform(15,21));
    ftKM(m,k,l,t)=round(uniform(15,ftKP(m,k,l,t)));
    ftKO(m,k,l,t)=round(uniform(15,ftKM(m,k,l,t)));
    ftNP(m,l,n,t)=round(uniform(15,21));
    ftNM(m,l,n,t)=round(uniform(15,ftNP(m,l,n,t)));
    ftNO(m,l,n,t)=round(uniform(15,ftNM(m,l,n,t)));
    ftCP(m,l,i,t)=round(uniform(15,21));
    ftCM(m,l,i,t)=round(uniform(15,ftCP(m,l,i,t)));
    ftCO(m,l,i,t)=round(uniform(15,ftCM(m,l,i,t)));
    );
*-*-*-*-*-*-*-*-*-*-*-* Variable Transportation Cost *-*-*-*-*-*-*-*-*-*-*-*-*-*
parameters
    tcSP(m,s,i,t) Pessimistic Transportation Cost of raw material per km from supplier s to manufacturing plant i with transportation system m in period t
    tcSM(m,s,i,t) The Most likely Transportation Cost of raw material per km from supplier s to manufacturing plant i with transportation system m in period t
    tcSO(m,s,i,t) Optimistic Transportation Cost of raw material per km from supplier s to manufacturing plant i with transportation system m in period t
    ;

    loop((m,s,i,t),
    tcSP(m,s,i,t)=uniform(0.08,0.17);
    tcSM(m,s,i,t)=uniform(0.08,tcSP(m,s,i,t));
    tcSO(m,s,i,t)=uniform(0.08,tcSM(m,s,i,t));
    );

parameters
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    tcPP(m,j,i,r,t) Pessimistic Transportation Cost of product j per km from manufacturing plant i to distribution center r with transportation system m in period t
    tcPM(m,j,i,r,t) The Most likely Transportation Cost of product j per km from manufacturing plant i to distribution center r with transportation system m in period t
    tcPO(m,j,i,r,t) Optimistic Transportation Cost of product j per km from manufacturing plant i to distribution center r with transportation system m in period t
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    tcDP(m,j,r,k,t) Pessimistic Transportation Cost of product j per km from distribution center r to customer centers k with transportation system m in period t
    tcDM(m,j,r,k,t) The Most likely Transportation Cost of product j per km from distribution center r to customer centers k with transportation system m in period t
    tcDO(m,j,r,k,t) Optimistic Transportation Cost of product j per km from distribution center r to customer centers k with transportation system m in period t
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    tcKP(m,j,k,l,t) Pessimistic Transportation Cost of used product j per km from customer centers k to collection center l with transportation system m in period t
    tcKM(m,j,k,l,t) The Most likely Transportation Cost of used product j per km from customer centers k to collection center l with transportation system m in period t
    tcKO(m,j,k,l,t) Optimistic Transportation Cost of used product j per km from customer centers k to collection center l with transportation system m in period t
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    tcNP(m,j,l,n,t) Pessimistic Transportation Cost of used product j per km from collection center l to recycling center n with transportation system m in period t
    tcNM(m,j,l,n,t) The Most likely Transportation Cost of used product j per km from collection center l to recycling center n with transportation system m in period t
    tcNO(m,j,l,n,t) Optimistic Transportation Cost of used product j per km from collection center l to recycling center n with transportation system m in period t
*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
    tcCP(m,j,l,i,t) Pessimistic Transportation Cost of used product j per km from collection center l to remanufacturing plant i with transportation system m in period t
    tcCM(m,j,l,i,t) The Most likely Transportation Cost of used product j per km from collection center l to remanufacturing plant i with transportation system m in period t
    tcCO(m,j,l,i,t) Optimistic Transportation Cost of used product j per km from collection center l to remanufacturing plant i with transportation system m in period t
    ;

    loop((m,j,i,r,k,l,n,t),
    tcPP(m,j,i,r,t)=uniform(0.08,0.17);
    tcPM(m,j,i,r,t)=uniform(0.08,tcPP(m,j,i,r,t));
    tcPO(m,j,i,r,t)=uniform(0.08,tcPM(m,j,i,r,t));
    tcDP(m,j,r,k,t)=uniform(0.08,0.17);
    tcDM(m,j,r,k,t)=uniform(0.08,tcDP(m,j,r,k,t));
    tcDO(m,j,r,k,t)=uniform(0.08,tcDM(m,j,r,k,t));
    tcKP(m,j,k,l,t)=uniform(0.08,0.17);
    tcKM(m,j,k,l,t)=uniform(0.08,tcKP(m,j,k,l,t));
    tcKO(m,j,k,l,t)=uniform(0.08,tcKM(m,j,k,l,t));
    tcNP(m,j,l,n,t)=uniform(0.08,0.17);
    tcNM(m,j,l,n,t)=uniform(0.08,tcNP(m,j,l,n,t));
    tcNO(m,j,l,n,t)=uniform(0.08,tcNM(m,j,l,n,t));
    tcCP(m,j,l,i,t)=uniform(0.08,0.17);
    tcCM(m,j,l,i,t)=uniform(0.08,tcCP(m,j,l,i,t));
    tcCO(m,j,l,i,t)=uniform(0.08,tcCM(m,j,l,i,t));
    );
*-*-*-*-*-*-*-*-*-*-*-* Variables *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

  variables
           Z2
       positive variables
           QR(s,t)         Quantity of purchased raw material
           QP(j,i,t)       Quantity of product j
           ID(j,r,t)       Inventory of product j
           SH(j,k,t)       Quantity of product j unsatisfied
           TRS(m,s,i,t)    Quantity of raw material shipped
           TPP(m,j,i,r,t)  Quantity of product j shipped
           TPD(m,j,r,k,t)  Quantity of product j shipped
           TPK(m,j,k,l,t)  Quantity of product j shipped
           TPC(m,j,l,i,t)  Quantity of product j shipped
           TPN(m,j,l,n,t)  Quantity of product j shipped
           NS(m,s,i,t)     Number of transportation system
           NP(m,i,r,t)     Number of transportation system
           ND(m,r,k,t)     Number of transportation system
           NK(m,k,l,t)     Number of transportation system
           NC(m,l,i,t)     Number of transportation system
           NN(m,l,n,t)     Number of transportation system
       Binary variables
           X(i,t)          manufacturing-remanufacturing plant is located
           Y(r,t)          distribution center is located
           Z(l,t)          collection center is located
           B(n,t)          recycling center is located
           W(s,t)          supplier s is selected  ;
       Equations
         objective
         eq1(s,t)
         eq2(j,i,t)
         eq3(i,t)
         eq4(j,k,t)
         eq5(j,k,t)
         eq6(j,k,t)
         eq7(j,k,t)
         eq8(j,l,t)
         eq9(j,l,t)
         eq10(j,l,t)
         eq11(j,r)
         eq12(r,t)
         eq13(m,s,i,t)
         eq14(m,i,r,t)
         eq15(m,r,k,t)
         eq16(m,k,l,t)
         eq17(m,l,i,t)
         eq18(m,l,n,t)
         eq19(s,t)
         eq20(i,t)
         eq21(i,t)
         eq22(r,t)
         eq24(l,t)
         eq26(n,t)
         eq27(j,r,k,t)
         eq28(k)
         eq29(k);
*-*-*-*-*-*-*-*-*-*-*-* Objective functions *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
 objective.. Z2 =e= sum((m,s,i,t),TRS(m,s,i,t)*((tetaO(m)+2*tetaM(m)+tetaP(m))/4)*eS(s,i))+
                    sum((m,j,i,r,t),TPP(m,j,i,r,t)*((tetaO(m)+2*tetaM(m)+tetaP(m))/4)*eP(i,r))+
                    sum((m,j,r,k,t),TPD(m,j,r,k,t)*((tetaO(m)+2*tetaM(m)+tetaP(m))/4)*eD(r,k))+
                    sum((m,j,k,l,t),TPK(m,j,k,l,t)*((tetaO(m)+2*tetaM(m)+tetaP(m))/4)*eK(k,l))+
                    sum((m,j,l,i,t),TPC(m,j,l,i,t)*((tetaO(m)+2*tetaM(m)+tetaP(m))/4)*eC(l,i))+
                    sum((m,j,l,n,t),TPN(m,j,l,n,t)*((tetaO(m)+2*tetaM(m)+tetaP(m))/4)*eN(l,n))+
                    sum((s,t),W(s,t)*((EISO(s,t)+2*EISM(s,t)+EISP(s,t))/4))+
                    sum((i,t),X(i,t)*((EIPO(i,t)+2*EIPM(i,t)+EIPP(i,t))/4))+
                    sum((r,t),Y(r,t)*((EIDO(r,t)+2*EIDM(r,t)+EIDP(r,t))/4))+
                    sum((l,t),Z(l,t)*((EICO(l,t)+2*EICM(l,t)+EICP(l,t))/4))+
                    sum((n,t),B(n,t)*((EINO(n,t)+2*EINM(n,t)+EINP(n,t))/4));

*-*-*-*-*-*-*-*-*-*-*-* Constraints *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

 eq1(s,t)..                       QR(s,t)=e= sum((m,i),TRS(m,s,i,t));
 eq2(j,i,t)..                     QP(j,i,t)=e= sum((m,r),TPP(m,j,i,r,t));
 eq3(i,t)..                       sum((m,j,r),TPP(m,j,i,r,t)*ur(j,t))=e= sum((m,s),TRS(m,s,i,t))+sum((m,j,l),TPC(m,j,l,i,t)*uru(j,t));
 eq4(j,k,t) $ (ord(t) ge 2)..     (Beta/2)*((deM(j,k,t)+deP(j,k,t))/2)+(1-(Beta/2))*((deM(j,k,t)+deO(j,k,t))/2)=g= sum((m,r),TPD(m,j,r,k,t))+SH(j,k,t)-SH(j,k,t-1);
 eq5(j,k,t) $ (ord(t) ge 2)..     (Beta/2)*((deM(j,k,t)+deO(j,k,t))/2)+(1-(Beta/2))*((deM(j,k,t)+deP(j,k,t))/2)=l= sum((m,r),TPD(m,j,r,k,t))+SH(j,k,t)-SH(j,k,t-1);
 eq6(j,k,t) $ (ord(t) ge 2)..     (Beta/2)*((RTM(j)*deM(j,k,t-1)+RTP(j)*deP(j,k,t-1))/2)+(1-(Beta/2))*((RTM(j)*deM(j,k,t-1)+RTO(j)*deO(j,k,t-1))/2)=g= sum((m,l),TPK(m,j,k,l,t))+((Beta/2)*((RTM(j)+RTO(j))/2)+(1-(Beta/2))*((RTM(j)+RTP(j))/2))*SH(j,k,t-1);
 eq7(j,k,t) $ (ord(t) ge 2)..     (Beta/2)*((RTM(j)*deM(j,k,t-1)+RTO(j)*deO(j,k,t-1))/2)+(1-(Beta/2))*((RTM(j)*deM(j,k,t-1)+RTP(j)*deP(j,k,t-1))/2)=l= sum((m,l),TPK(m,j,k,l,t))+((Beta/2)*((RTM(j)+RTP(j))/2)+(1-(Beta/2))*((RTM(j)+RTO(j))/2))*SH(j,k,t-1);
 eq8(j,l,t)..                     sum((m,i),TPC(m,j,l,i,t))=g=((Beta/2)*((RRM(j)+RRO(j))/2)+(1-(Beta/2))*((RRM(j)+RRP(j))/2))*sum((m,k),TPK(m,j,k,l,t));
 eq9(j,l,t)..                     sum((m,i),TPC(m,j,l,i,t))=l=((Beta/2)*((RRM(j)+RRP(j))/2)+(1-(Beta/2))*((RRM(j)+RRO(j))/2))*sum((m,k),TPK(m,j,k,l,t));
 eq10(j,l,t)..                    sum((m,n),TPN(m,j,l,n,t))=g=((Beta/2)*(((1-RRM(j))+(1-RRO(j)))/2)+(1-(Beta/2))*(((1-RRM(j))+(1-RRP(j)))/2))*sum((m,k),TPK(m,j,k,l,t));
 eq11(j,r)..                      sum((m,k),TPD(m,j,r,k,'1'))=e= sum((m,i),TPP(m,j,i,r,'1'))-ID(j,r,'1')+IDzero(j,r);
 eq12(r,t)  $ (ord(t) ge 2)..     sum(j, ID(j,r,t)*(Beta*((vM(j)+vP(j))/2)+(1-Beta)*((vM(j)+vO(j))/2)))=l=(Beta*((capDM(r,t)+capDP(r,t))/2)+(1-Beta)*((capDM(r,t)+capDO(r,t))/2));
 eq13(m,s,i,t)..                  (Beta*((vrM+vrP)/2)+(1-Beta)*((vrM+vrO)/2))*TRS(m,s,i,t)=l=(Beta*((capLM(m,t)+capLO(m,t))/2)+(1-Beta)*((capLM(m,t)+capLP(m,t))/2))*NS(m,s,i,t);
 eq14(m,i,r,t)..                  sum(j,TPP(m,j,i,r,t)*(Beta*((vM(j)+vP(j))/2)+(1-Beta)*((vM(j)+vO(j))/2)))=l=(Beta*((capLM(m,t)+capLO(m,t))/2)+(1-Beta)*((capLM(m,t)+capLP(m,t))/2))*NP(m,i,r,t);
 eq15(m,r,k,t)..                  sum(j,TPD(m,j,r,k,t)*(Beta*((vM(j)+vP(j))/2)+(1-Beta)*((vM(j)+vO(j))/2)))=l=(Beta*((capLM(m,t)+capLO(m,t))/2)+(1-Beta)*((capLM(m,t)+capLP(m,t))/2))*ND(m,r,k,t);
 eq16(m,k,l,t)..                  sum(j,TPK(m,j,k,l,t)*(Beta*((vM(j)+vP(j))/2)+(1-Beta)*((vM(j)+vO(j))/2)))=l=(Beta*((capLM(m,t)+capLO(m,t))/2)+(1-Beta)*((capLM(m,t)+capLP(m,t))/2))*NK(m,k,l,t);
 eq17(m,l,i,t)..                  sum(j,TPC(m,j,l,i,t)*(Beta*((vM(j)+vP(j))/2)+(1-Beta)*((vM(j)+vO(j))/2)))=l=(Beta*((capLM(m,t)+capLO(m,t))/2)+(1-Beta)*((capLM(m,t)+capLP(m,t))/2))*NC(m,l,i,t);
 eq18(m,l,n,t)..                  sum(j,TPN(m,j,l,n,t)*(Beta*((vM(j)+vP(j))/2)+(1-Beta)*((vM(j)+vO(j))/2)))=l=(Beta*((capLM(m,t)+capLO(m,t))/2)+(1-Beta)*((capLM(m,t)+capLP(m,t))/2))*NN(m,l,n,t);
 eq19(s,t)..                      sum((m,i),TRS(m,s,i,t))=l=(Beta*((capSM(s,t)+capSO(s,t))/2)+(1-Beta)*((capSM(s,t)+capSP(s,t))/2))*W(s,t);
 eq20(i,t)..                      sum((m,s),TRS(m,s,i,t))+sum((m,j,l),TPC(m,j,l,i,t))=l=(Beta*((capPRM(i,t)+capPRO(i,t))/2)+(1-Beta)*((capPRM(i,t)+capPRP(i,t))/2))*X(i,t);
 eq21(i,t)..                      sum((m,j,r),TPP(m,j,i,r,t))=l=(Beta*((capPM(i,t)+capPO(i,t))/2)+(1-Beta)*((capPM(i,t)+capPP(i,t))/2))*X(i,t);
 eq22(r,t)..                      sum((m,j,i),TPP(m,j,i,r,t))=l=(Beta*((capDM(r,t)+capDO(r,t))/2)+(1-Beta)*((capDM(r,t)+capDP(r,t))/2))*Y(r,t);
 eq24(l,t)..                      sum((m,j,k),TPK(m,j,k,l,t))=l=(Beta*((capCM(l,t)+capCO(l,t))/2)+(1-Beta)*((capCM(l,t)+capCP(l,t))/2))*Z(l,t);
 eq26(n,t)..                      sum((m,j,l),TPN(m,j,l,n,t))=l=(Beta*((capNM(n,t)+capNO(n,t))/2)+(1-Beta)*((capNM(n,t)+capNP(n,t))/2))*B(n,t);
 eq27(j,r,k,t)$ (ord(t) ge 2)..   sum(m,TPD(m,j,r,k,t))=e= sum((m,i),TPP(m,j,i,r,t))-ID(j,r,t)+ID(j,r,t-1);
 eq28(k)..                        sum((j,t),SH(j,k,t))=l=sum((j,t),alpha(j,k,t)*(Beta/2)*((deM(j,k,t)+deP(j,k,t))/2)+alpha(j,k,t)*(1-(Beta/2))*((deM(j,k,t)+deO(j,k,t))/2));
 eq29(k)..                        sum((j,t),SH(j,k,t))=g=sum((j,t),alpha(j,k,t)*(Beta/2)*((deM(j,k,t)+deO(j,k,t))/2)+alpha(j,k,t)*(1-(Beta/2))*((deM(j,k,t)+deP(j,k,t))/2));

 Model CLSCND /ALL/ ;
 Option reslim=40000;
 option optcr=0;
 solve CLSCND using MINLP minimizing Z2;
 display  Z2.l,QR.l,QP.l,ID.l,SH.l,TRS.l,TPP.l,TPD.l,TPK.l,TPC.l,TPN.l,NS.l,NP.l,ND.l,NK.l,NC.l,NN.l,X.l,Y.l,Z.l,B.l,W.l;


















