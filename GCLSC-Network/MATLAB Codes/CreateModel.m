function model = CreateModel()
%% *********************** CLSCND ************************************************* 
%*-*-*-*-*-*-*-*-*-*-*-* Set *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-     
%% Set
                                                                           % index for potential locations for distribution center 
   J=4;                                                                    % index of product
   S=5;                                                                    % index of supplier
   K=6;                                                                    % index of custoner location
   R=4;
   I=5;                                                                    % index for potential locations for manufacturing-remanufacturing plant
   L=5;                                                                    % index for potential locations for collection center
   N=4;                                                                    % index for potential locations for recycling center
   T=3;                                                                    % index of period time
   M=5;                                                                    % index of transportation system  provided by the supplier
%*-*-*-*-*-*-*-*-*-*-*-* scalar*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-  
%% scalar
   Beta=0.6;                                                               % the minimum degree of satisfying possibilistic constraints
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-      
   vrP=0.16;                                                               % Pessimistic Volume of raw material
   vrM=0.14;                                                               % The Most likely Volume of raw material 
   vrO=0.12;                                                               % Optimistic Volume of raw material
   vr=((1-Beta)*((vrM+vrP)/2))+((Beta)*((vrM+vrO)/2));                     % Volume of raw material
%*-*-*-*-*-*-*-*-*-*-*-* parameters *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*   
%% parameters
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
%% Amount of released CO2
   tetaPM=unifrnd(0.04,0.07,M,1);                                          % Pessimistic amount of released CO2 for the transportation system m     
   tetaMM=unifrnd(0.04,tetaPM,M,1);                                        % The Most likely amount of released CO2 for the transportation system m    
   tetaOM=unifrnd(0.04,tetaMM,M,1);                                        % Optimistic amount of released CO2 for the transportation system m       
   tetaM=((tetaOM+(2*tetaMM)+tetaPM)/4);                                   % Amount of released CO2 for the transportation system m 
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
%% Volume of each unit product
   vPJ=unifrnd(7,14,J,1);                                           % Pessimistic Volume of each unit product j  
   vMJ=unifrnd(7,vPJ,J,1);                                             % The Most likely Volume of each unit product j 
   vOJ=unifrnd(7,vMJ,J,1);                                             % Optimistic Volume of each unit product j
   vJ=((1-Beta)*((vMJ+vPJ)/2))+((Beta)*((vMJ+vOJ)/2));                     % Volume of each unit product j
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
%% Rate of Recoverable used product 
   RRPJ=unifrnd(0.6,0.65,J,1);                                             % Pessimistic Rate of Recoverable used product j
   RRMJ=unifrnd(RRPJ,0.65,J,1);                                            % The Most likely Rate of Recoverable used product j
   RROJ=unifrnd(RRMJ,0.65,J,1);                                            % Optimistic Rate of Recoverable used product j
   RR1J=((Beta/2)*((RRMJ+RROJ)/2))+((1-(Beta/2))*((RRMJ+RRPJ)/2));
   RR2J=((Beta/2)*((RRMJ+RRPJ)/2))+((1-(Beta/2))*((RRMJ+RROJ)/2));
   RR4J=((Beta/2)*(((1-RRMJ)+(1-RROJ))/2))+((1-(Beta/2))*(((1-RRMJ)+(1-RRPJ))/2));
   RR3J=((Beta/2)*(((1-RRMJ)+(1-RRPJ))/2))+((1-(Beta/2))*(((1-RRMJ)+(1-RROJ))/2));
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
%% Rate of Return used product
   RTPJ=unifrnd(0.7,0.8,J,K,T);                                              % Pessimistic Rate of Return used product j
   RTMJ=unifrnd(RTPJ,0.8,J,K,T);                                             % The Most likely Rate of Return used product j  
   RTOJ=unifrnd(RTMJ,0.8,J,K,T);                                             % Optimistic Rate of Return used product j 
   RT1J=((Beta/2)*((RTMJ+RTOJ)/2))+((1-(Beta/2))*((RTMJ+RTPJ)/2));
   RT2J=((Beta/2)*((RTMJ+RTPJ)/2))+((1-(Beta/2))*((RTMJ+RTOJ)/2));
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
%% initial inventory     
   IDzeroJR=round(unifrnd(290,400,J,R));                                          % initial inventory 
   %%I0=zeros(J,R)
%*-*-*-*-*-*-*-*-*-*-*-*-* Distance *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*    
%% Distance
   eSSI=unifrnd(10,13,S,I);                                                % The distance between locations of supplier s and plant i      
   ePIR=unifrnd(10,25,I,R);                                                % The distance between locations of manufacturing plant i and distribution center r               
   eDRK=unifrnd(10,24,R,K);                                                % The distance between locations of distribution center r and customer centers k     
   eKKL=unifrnd(10,19,K,L);                                                % The distance between locations of customer centers k and collection center l      
   eNLN=unifrnd(12,19,L,N);                                                % The distance between locations of collection center l and recycling center n    
   eCLI=unifrnd(12,22,L,I);                                                % The distance between locations of collection center l and remanufacturing plant i  
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-     
%% Rate of using the raw material
   urJT=unifrnd(0.7,0.9,J,T);                                              % The rate of using the raw material for product j in period t
   uruJT=unifrnd(0.6,0.7,J,T);                                             % The rate of using the raw material for used product j in period t 
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
%% Cost Saving of product
   CSPJT=unifrnd(490,497,J,T);                                             % Pessimistic Cost Saving of product j in period t 
   CSMJT=unifrnd(CSPJT,497,J,T);                                           % The Most likely Cost Saving of product j in period t     
   CSOJT=unifrnd(CSMJT,497,J,T);                                           % Optimistic Cost Saving of product j in period t  
   CSJT=((CSPJT+(2*CSMJT)+CSOJT)/4); 
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
%% Purchased Cost of raw material   
   cRPST=round(unifrnd(10,17,S,T));                                               % Pessimistic Purchased Cost of raw material from supplier s in period t 
   cRMST=round(unifrnd(10,cRPST,S,T));                                            % The Most likely Purchased Cost of raw material from supplier s in period t
   cROST=round(unifrnd(10,cRMST,S,T));                                            % Optimistic Purchased Cost of raw material from supplier s in period t
   cRST=((cROST+(2*cRMST)+cRPST)/4); 
%*-*-*-*-*-*-*-*-*-*-*-*-* Fixed-Cost *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*  
%% Fixed-Cost 
   fcSPST=round(unifrnd(65,70,S,T));                                              % Pessimistic Fixed-Cost associated with supplier s in period t 
   fcSMST=round(unifrnd(65,fcSPST,S,T));                                          % The Most likely Fixed-Cost associated with supplier s in period t
   fcSOST=round(unifrnd(65,fcSMST,S,T));                                          % Optimistic Fixed-Cost associated with supplier s in period t  
   fcSST=((fcSOST+(2*fcSMST)+fcSPST)/4); 
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
   fcPPIT=round(unifrnd(85,105,I,T));                                           % Pessimistic Fixed-Cost for opening plant i by the manufacturer in period t  
   fcPMIT=round(unifrnd(85,fcPPIT,I,T));                                         % The Most likely Fixed-Cost for opening plant i by the manufacturer in period t
   fcPOIT=round(unifrnd(85,fcPMIT,I,T));                                         % Optimistic Fixed-Cost for opening plant i by the manufacturer in period t    
   fcPIT=((fcPOIT+(2*fcPMIT)+fcPPIT)/4); 
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
   fcDPRT=round(unifrnd(85,105,R,T));                                           % Pessimistic Fixed-Cost for opening distribution center r in period t  
   fcDMRT=round(unifrnd(85,fcDPRT,R,T));                                         % The Most likely Fixed-Cost for opening distribution center r in period t 
   fcDORT=round(unifrnd(85,fcDMRT,R,T));                                         % Optimistic Fixed-Cost for opening distribution center r in period t  
   fcDRT=((fcDORT+(2*fcDMRT)+fcDPRT)/4); 
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
   fcCPLT=round(unifrnd(85,105,L,T));                                           % Pessimistic Fixed-Cost for opening the collection center l in period t    
   fcCMLT=round(unifrnd(85,fcCPLT,L,T));                                         % The Most likely Fixed-Cost for opening the collection center l in period t 
   fcCOLT=round(unifrnd(85,fcCMLT,L,T));                                         % Optimistic Fixed-Cost for opening the collection center l in period t          
   fcCLT=((fcCOLT+(2*fcCMLT)+fcCPLT)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
   fcNPNT=round(unifrnd(85,105,N,T));                                           % Pessimistic Fixed-Cost for opening the recycling center n in period t 
   fcNMNT=round(unifrnd(85,fcNPNT,N,T));                                         % The Most likely Fixed-Cost for opening the recycling center n in period t   
   fcNONT=round(unifrnd(85,fcNMNT,N,T));                                         % Optimistic Fixed-Cost for opening the recycling center n in period t        
   fcNNT=((fcNONT+(2*fcNMNT)+fcNPNT)/4);
%*-*-*-*-*-*-*-*-*-*-*-* Environmental impact *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*   
%% Environmental impact 
   EISPST=round(unifrnd(3,10,S,T));                                               % Pessimistic Environmental impact of raw materials purchased from supplier s in period t     
   EISMST=round(unifrnd(3,EISPST,S,T));                                           % The Most likely Environmental impact of raw materials purchased from supplier s in period t       
   EISOST=round(unifrnd(3,EISMST,S,T));                                           % Optimistic Environmental impact of raw materials purchased from supplier s in period t            
   EISST=((EISOST+(2*EISMST)+EISPST)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-  
   EIPPIT=round(unifrnd(8,15,I,T));                                               % Pessimistic Environmental impact of opening manufacturing-remanufacturing plant i in period t      
   EIPMIT=round(unifrnd(8,EIPPIT,I,T));                                           % The Most likely Environmental impact of opening manufacturing-remanufacturing plant i in period t         
   EIPOIT=round(unifrnd(8,EIPMIT,I,T));                                           % Optimistic Environmental impact of opening manufacturing-remanufacturing plant i in period t
   EIPIT=((EIPOIT+(2*EIPMIT)+EIPPIT)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
   EIDPRT=round(unifrnd(8,15,R,T));                                               % Pessimistic Environmental impact of opening distribution center r in period t 
   EIDMRT=round(unifrnd(8,EIDPRT,R,T));                                           % The Most likely Environmental impact of opening distribution center r in period t            
   EIDORT=round(unifrnd(8,EIDMRT,R,T));                                           % Optimistic Environmental impact of opening distribution center r in period t 
   EIDRT=((EIDORT+(2*EIDMRT)+EIDPRT)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
   EICPLT=round(unifrnd(8,15,L,T));                                               % Pessimistic Environmental impact of opening collection center l in period t  
   EICMLT=round(unifrnd(8,EICPLT,L,T));                                           % The Most likely Environmental impact of opening collection center l in period t 
   EICOLT=round(unifrnd(8,EICMLT,L,T));                                           % Optimistic Environmental impact of opening collection center l in period t  
   EICLT=((EICOLT+(2*EICMLT)+EICPLT)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
   EINPNT=round(unifrnd(8,15,N,T));                                               % Pessimistic Environmental impact of opening recycle center n in period t        
   EINMNT=round(unifrnd(8,EINPNT,N,T));                                           % The Most likely Environmental impact of opening recycle center n in period t        
   EINONT=round(unifrnd(8,EINMNT,N,T));                                           % Optimistic Environmental impact of opening recycle center n in period t                 
   EINNT=((EINONT+(2*EINMNT)+EINPNT)/4);
%*-*-*-*-*-*-*-*-*-*-*-* Capacity *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*    
%% Capacity
   capSPST=round(unifrnd(3836,3915,S,T));                                         % Pessimistic Capacity of supplier s in period t             
   capSMST=round(unifrnd(capSPST,3915,S,T));                                      % The Most likely Capacity of supplier s in period t    
   capSOST=round(unifrnd(capSMST,3915,S,T));                                      % Optimistic Capacity of supplier s in period t       
   capSST=((1-Beta)*((capSMST+capSOST)/2))+((Beta)*((capSMST+capSPST)/2));
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
   capPPIT=round(unifrnd(4850,4880,I,T));                                         % Pessimistic End Product Storage Capacity of manufacturing-remanufacturing plant i in period t 
   capPMIT=round(unifrnd(capPPIT,4880,I,T));                                      % The Most likely End Product Storage Capacity of manufacturing-remanufacturing plant i in period t     
   capPOIT=round(unifrnd(capPMIT,4880,I,T));                                      % Optimistic End Product Storage Capacity of manufacturing-remanufacturing plant i in period t    
   capPIT=((1-Beta)*((capPMIT+capPOIT)/2))+((Beta)*((capPMIT+capPPIT)/2));
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
   capPRPIT=round(unifrnd(3850,3880,I,T));                                        % Pessimistic Raw material Storage Capacity of manufacturing-remanufacturing plant i in period t    
   capPRMIT=round(unifrnd(capPRPIT,3880,I,T));                                    % The Most likely Raw material Storage Capacity of manufacturing-remanufacturing plant i in period t      
   capPROIT=round(unifrnd(capPRMIT,3880,I,T));                                    % Optimistic Raw material Storage Capacity of manufacturing-remanufacturing plant i in period t      
   capPRIT=((1-Beta)*((capPRMIT+capPRPIT)/2))+((Beta)*((capPRMIT+capPROIT)/2));
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
   capDPRT=round(unifrnd(9650,9695,R,T));                                         % Pessimistic Capacity of distribution center r in period t 
   capDMRT=round(unifrnd(capDPRT,9695,R,T));                                      % The Most likely Capacity of distribution center r in period t    
   capDORT=round(unifrnd(capDMRT,9695,R,T));                                      % Optimistic Capacity of distribution center r in period t          
   capDRT=((Beta)*((capDMRT+capDPRT)/2))+((1-Beta)*((capDMRT+capDORT)/2));
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
   capCPLT=round(unifrnd(4800,5815,L,T));                                         % Pessimistic Capacity of collection center l in period t            
   capCMLT=round(unifrnd(capCPLT,5815,L,T));                                      % The Most likely Capacity of collection center l in period t    
   capCOLT=round(unifrnd(capCMLT,5815,L,T));                                      % Optimistic Capacity of collection center l in period t         
   capCLT=((1-Beta)*((capCMLT+capCOLT)/2))+((Beta)*((capCMLT+capCPLT)/2));
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
   capNPNT=round(unifrnd(3800,4815,N,T));                                         % Pessimistic Capacity of recycle center n in period t  
   capNMNT=round(unifrnd(capNPNT,4815,N,T));                                      % The Most likely Capacity of recycle center n in period t    
   capNONT=round(unifrnd(capNMNT,4815,N,T));                                      % Optimistic Capacity of recycle center n in period t                 
   capNNT=((1-Beta)*((capNMNT+capNONT)/2))+((Beta)*((capNMNT+capNPNT)/2));
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
   capLPMT=round(unifrnd(220,250,M,T));                                             % Pessimistic Capacity of each of transportation tools m in period t
   capLMMT=round(unifrnd(capLPMT,250,M,T));                                        % The Most likely Capacity of each of transportation tools m in period t              
   capLOMT=round(unifrnd(capLMMT,250,M,T));                                        % Optimistic Capacity of each of transportation tools m in period t     
   capLMT=((1-Beta)*((capLMMT+capLOMT)/2))+((Beta)*((capLMMT+capLPMT)/2));
%*-*-*-*-*-*-*-*-*-*-*-* Production Cost *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-      
%% Production Cost 
   cPPJIT=round(unifrnd(22,37,J,I,T));                                            % Pessimistic Production Cost of product j in manufacturing plant i in period t   
   cPMJIT=round(unifrnd(22,cPPJIT,J,I,T));                                        % The Most likely Production Cost of product j in manufacturing plant i in period t     
   cPOJIT=round(unifrnd(22,cPMJIT,J,I,T));                                        % Optimistic Production Cost of product j in manufacturing plant i in period t      
   cPJIT=((cPOJIT+(2*cPMJIT)+cPPJIT)/4); 
%*-*-*-*-*-*-*-*-*-*-*-* Recycling Cost *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*    
%% Recycling Cost   
   RCPJNT=round(unifrnd(10,15,J,N,T));                                            % Pessimistic Recycling Cost of product j in recycling center n in period t     
   RCMJNT=round(unifrnd(10,RCPJNT,J,N,T));                                        % The Most likely Recycling Cost of product j in recycling center n in period t  
   RCOJNT=round(unifrnd(10,RCMJNT,J,N,T));                                        % Optimistic Recycling Cost of product j in recycling center n in period t   
   RCJNT=((RCPJNT+(2*RCMJNT)+RCOJNT)/4);
%*-*-*-*-*-*-*-*-*-*-*-* Holding Cost *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*    
%% Holding Cost
   HCPJRT=unifrnd(3.83,4.85,J,R,T);                                        % Pessimistic Holding Cost of the product j in distribution center r in period t       
   HCMJRT=unifrnd(3.83,HCPJRT,J,R,T);                                      % The Most likely Holding Cost of the product j in distribution center r in period t    
   HCOJRT=unifrnd(3.83,HCMJRT,J,R,T);                                      % Optimistic Holding Cost of the product j in distribution center r in period t       
   HCJRT=((HCOJRT+(2*HCMJRT)+HCPJRT)/4);
%*-*-*-*-*-*-*-*-*-*-*-* Shortage Cost *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
%% Shortage Cost 
   SHCPJKT=unifrnd(4.9,5.8,J,K,T);                                           % Pessimistic Cost of shortage the unit of product j for customer center k in period t  
   SHCMJKT=unifrnd(4.9,SHCPJKT,J,K,T);                                      % The Most likely Cost of shortage the unit of product j for customer center k in period t       
   SHCOJKT=unifrnd(4.9,SHCMJKT,J,K,T);                                      % Optimistic Cost of shortage the unit of product j for customer center k in period t         
   SHCJKT=((SHCOJKT+(2*SHCMJKT)+SHCPJKT)/4);
%*-*-*-*-*-*-*-*-*-*-*-* Demand *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*  
%% Demand
   dePJKT=unifrnd(4715,4720,J,K,T);                                        % Pessimistic Demand of customer centers k for product j in period t            
   deMJKT=unifrnd(dePJKT,4720,J,K,T);                                      % The Most likely Demand of customer centers k for product j in period t              
   deOJKT=unifrnd(deMJKT,4720,J,K,T);                                      % Optimistic Demand of customer centers k for product j in period t      
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-  
    dePJKT1=dePJKT(:,:,1:T-1);
    deMJKT1=deMJKT(:,:,1:T-1);
    deOJKT1=deOJKT(:,:,1:T-1);        
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
   deJKT1=((Beta/2)*((deMJKT+dePJKT)/2))+((1-(Beta/2))*((deMJKT+deOJKT)/2));
   deJKT2=((Beta/2)*((deMJKT+deOJKT)/2))+((1-(Beta/2))*((deMJKT+dePJKT)/2));
   RTdeJKT1=((Beta/2)*(((RTMJ(1:J,1:K,1:T-1).*deMJKT1)+(RTPJ(1:J,1:K,1:T-1).*dePJKT1))/2))+((1-(Beta/2))*(((RTMJ(1:J,1:K,1:T-1).*deMJKT1)+(RTOJ(1:J,1:K,1:T-1).*deOJKT1))/2));
   RTdeJKT2=((Beta/2)*(((RTMJ(1:J,1:K,1:T-1).*deMJKT1)+(RTOJ(1:J,1:K,1:T-1).*deOJKT1))/2))+((1-(Beta/2))*(((RTMJ(1:J,1:K,1:T-1).*deMJKT1)+(RTPJ(1:J,1:K,1:T-1).*dePJKT1))/2));
%*-*-*-*-*-*-*-*-*-*-*-* Selling price *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
%% Selling price
   SPJIRT=unifrnd(8805,8810,J,I,R,T);                                      % Pessimistic Selling price of product j from manufacturing plant i to distribution center r in period t    
   SMJIRT=unifrnd(SPJIRT,8810,J,I,R,T);                                    % The Most likely Selling price of product j from manufacturing plant i to distribution center r in period t       
   SOJIRT=unifrnd(SMJIRT,8810,J,I,R,T);                                    % Optimistic Selling price of product j from manufacturing plant i to distribution center r in period t       
   SJIRT=((SPJIRT+(2*SMJIRT)+SOJIRT)/4);
%*-*-*-*-*-*-*-*-*-*-*-* Fixed Transportation Cost *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
%% Fixed Transportation Cost   
   ftSPMSIT=unifrnd(1.1,2.1,M,S,I,T);                                        % Pessimistic Fixed-Cost of sending transportation system m from supplier s to manufacturing plant i in period t   
   ftSMMSIT=unifrnd(1.1,ftSPMSIT,M,S,I,T);                                  % The Most likely Fixed-Cost of sending transportation system m from supplier s to manufacturing plant i in period t        
   ftSOMSIT=unifrnd(1.1,ftSMMSIT,M,S,I,T);                                  % Optimistic Fixed-Cost of sending transportation system m from supplier s to manufacturing plant i in period t          
   ftSMSIT=((ftSOMSIT+(2*ftSMMSIT)+ftSPMSIT)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-   
   ftPPMIRT=unifrnd(1.5,2.1,M,I,R,T);                                        % Pessimistic Fixed-Cost of sending transportation system m from supplier s to manufacturing plant i in period t    
   ftPMMIRT=unifrnd(1.5,ftPPMIRT,M,I,R,T);                                  % The Most likely Fixed-Cost of sending transportation system m from supplier s to manufacturing plant i in period t        
   ftPOMIRT=unifrnd(1.5,ftPMMIRT,M,I,R,T);                                  % Optimistic Fixed-Cost of sending transportation system m from supplier s to manufacturing plant i in period t        
   ftPMIRT=((ftPOMIRT+(2*ftPMMIRT)+ftPPMIRT)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
   ftDPMRKT=unifrnd(1.5,2.1,M,R,K,T);                                        % Pessimistic Fixed-Cost of sending transportation system m from distribution center r to customer centers k in period t     
   ftDMMRKT=unifrnd(1.5,ftDPMRKT,M,R,K,T);                                  % The Most likely Fixed-Cost of sending transportation system m from distribution center r to customer centers k in period t               
   ftDOMRKT=unifrnd(1.5,ftDMMRKT,M,R,K,T);                                  % Optimistic Fixed-Cost of sending transportation system m from distribution center r to customer centers k in period t        
   ftDMRKT=((ftDOMRKT+(2*ftDMMRKT)+ftDPMRKT)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
   ftKPMKLT=unifrnd(1.5,2.1,M,K,L,T);                                        % Pessimistic Fixed-Cost of sending transportation system m from customer centers k to collection center l in period t      
   ftKMMKLT=unifrnd(1.5,ftKPMKLT,M,K,L,T);                                  % The Most likely Fixed-Cost of sending transportation system m from customer centers k to collection center l in period t        
   ftKOMKLT=unifrnd(1.5,ftKMMKLT,M,K,L,T);                                  % Optimistic Fixed-Cost of sending transportation system m from customer centers k to collection center l in period t         
   ftKMKLT=((ftKOMKLT+(2*ftKMMKLT)+ftKPMKLT)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
   ftNPMLNT=unifrnd(1.5,2.1,M,L,N,T);                                        % Pessimistic Fixed-Cost of sending transportation system m from collection center l to recycling center n in period t        
   ftNMMLNT=unifrnd(1.5,ftNPMLNT,M,L,N,T);                                  % The Most likely Fixed-Cost of sending transportation system m from collection center l to recycling center n in period t           
   ftNOMLNT=unifrnd(1.5,ftNMMLNT,M,L,N,T);                                  % Optimistic Fixed-Cost of sending transportation system m from collection center l to recycling center n in period t              
   ftNMLNT=((ftNOMLNT+(2*ftNMMLNT)+ftNPMLNT)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
   ftCPMLIT=unifrnd(1.5,2.1,M,L,I,T);                                        % Pessimistic Fixed-Cost of sending transportation system m from collection center l to remanufacturing plant i in period t    
   ftCMMLIT=unifrnd(1.5,ftCPMLIT,M,L,I,T);                                  % The Most likely Fixed-Cost of sending transportation system m from collection center l to remanufacturing plant i in period t              
   ftCOMLIT=unifrnd(1.5,ftCMMLIT,M,L,I,T);                                  % Optimistic Fixed-Cost of sending transportation system m from collection center l to remanufacturing plant i in period t l in period t        
   ftCMLIT=((ftCOMLIT+(2*ftCMMLIT)+ftCPMLIT)/4);
%*-*-*-*-*-*-*-*-*-*-*-* Variable Transportation Cost *-*-*-*-*-*-*-*-*-*-*-*-*-*    
%% Variable Transportation Cost   
   tcSPMSIT=unifrnd(0.08,0.097,M,S,I,T);                                        % Pessimistic Transportation Cost of raw material per km from supplier s to manufacturing plant i with transportation system m in period t       
   tcSMMSIT=unifrnd(0.08,tcSPMSIT,M,S,I,T);                                 % The Most likely Transportation Cost of raw material per km from supplier s to manufacturing plant i with transportation system m in period t         
   tcSOMSIT=unifrnd(0.08,tcSMMSIT,M,S,I,T);                                 % Optimistic Transportation Cost of raw material per km from supplier s to manufacturing plant i with transportation system m in period t          
   tcSMSIT=((tcSOMSIT+(2*tcSMMSIT)+tcSPMSIT)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-       
   tcPPMJIRT=unifrnd(0.08,0.097,M,J,I,R,T);                                  % Pessimistic Transportation Cost of product j per km from manufacturing plant i to distribution center r with transportation system m in period t          
   tcPMMJIRT=unifrnd(0.08,tcPPMJIRT,M,J,I,R,T);                             % The Most likely Transportation Cost of product j per km from manufacturing plant i to distribution center r with transportation system m in period t             
   tcPOMJIRT=unifrnd(0.08,tcPMMJIRT,M,J,I,R,T);                             % Optimistic Transportation Cost of product j per km from manufacturing plant i to distribution center r with transportation system m in period t              
   tcPMJIRT=((tcPOMJIRT+(2*tcPMMJIRT)+tcPPMJIRT)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-       
   tcDPMJRKT=unifrnd(0.08,0.097,M,J,R,K,T);                                  % Pessimistic Transportation Cost of product j per km from distribution center r to customer centers k with transportation system m in period t         
   tcDMMJRKT=unifrnd(0.08,tcDPMJRKT,M,J,R,K,T);                             % The Most likely Transportation Cost of product j per km from distribution center r to customer centers k with transportation system m in period t              
   tcDOMJRKT=unifrnd(0.08,tcDMMJRKT,M,J,R,K,T);                             % Optimistic Transportation Cost of product j per km from distribution center r to customer centers k with transportation system m in period t             
   tcDMJRKT=((tcDOMJRKT+(2*tcDMMJRKT)+tcDPMJRKT)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-       
   tcKPMJKLT=unifrnd(0.08,0.097,M,J,K,L,T);                                  % Pessimistic Transportation Cost of used product j per km from customer centers k to collection center l with transportation system m in period t         
   tcKMMJKLT=unifrnd(0.08,tcKPMJKLT,M,J,K,L,T);                             % The Most likely Transportation Cost of used product j per km from customer centers k to collection center l with transportation system m in period t             
   tcKOMJKLT=unifrnd(0.08,tcKMMJKLT,M,J,K,L,T);                             % Optimistic Transportation Cost of used product j per km from customer centers k to collection center l with transportation system m in period t                 
   tcKMJKLT=((tcKOMJKLT+(2*tcKMMJKLT)+tcKPMJKLT)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
   tcNPMJLNT=unifrnd(0.08,0.097,M,J,L,N,T);                                  % Pessimistic Transportation Cost of used product j per km from collection center l to recycling center n with transportation system m in period t        
   tcNMMJLNT=unifrnd(0.08,tcNPMJLNT,M,J,L,N,T);                             % The Most likely Transportation Cost of used product j per km from collection center l to recycling center n with transportation system m in period t             
   tcNOMJLNT=unifrnd(0.08,tcNMMJLNT,M,J,L,N,T);                             % Optimistic Transportation Cost of used product j per km from collection center l to recycling center n with transportation system m in period t                      
   tcNMJLNT=((tcNOMJLNT+(2*tcNMMJLNT)+tcNPMJLNT)/4);
%*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-    
   tcCPMJLIT=unifrnd(0.08,0.097,M,J,L,I,T);                                  % Pessimistic Transportation Cost of used product j per km from collection center l to remanufacturing plant i with transportation system m in period t         
   tcCMMJLIT=unifrnd(0.08,tcCPMJLIT,M,J,L,I,T);                             % The Most likely Transportation Cost of used product j per km from collection center l to remanufacturing plant i with transportation system m in period t             
   tcCOMJLIT=unifrnd(0.08,tcCMMJLIT,M,J,L,I,T);                             % Optimistic Transportation Cost of used product j per km from collection center l to remanufacturing plant i with transportation system m in period t              
   tcCMJLIT=((tcCOMJLIT+(2*tcCMMJLIT)+tcCPMJLIT)/4);
%% *********************** Model *************************************************    

   model.J = J;                                                             
   model.S = S;                                                            
   model.K = K;                                                              
   model.R = R;                                              
   model.I = I;                                                  
   model.L = L;                                                             
   model.N = N;                                                         
   model.T = T;                
   model.M = M;  
   model.Beta = Beta;           
   model.vrP = vrP;            
   model.vrM = vrM;            
   model.vrO = vrO;             
   model.vr = vr;
   model.tetaPM = tetaPM;
   model.tetaMM = tetaMM;
   model.tetaOM = tetaOM;
   model.tetaM = tetaM;
   model.vPJ = vPJ;
   model.vMJ = vMJ;
   model.vOJ = vOJ;
   model.vJ = vJ;
   model.RRPJ = RRPJ;
   model.RRMJ = RRMJ;
   model.RROJ = RROJ;
   model.RR1J = RR1J;
   model.RR2J = RR2J;
   model.RR3J = RR3J;
   model.RR4J = RR4J;
   model.RTPJ = RTPJ;
   model.RTMJ = RTMJ;
   model.RTOJ = RTOJ;
   model.RT1J = RT1J;
   model.RT2J = RT2J;
   model.IDzeroJR = IDzeroJR;
   model.eSSI = eSSI;
   model.ePIR = ePIR;
   model.eDRK = eDRK;
   model.eKKL = eKKL;
   model.eNLN = eNLN;
   model.eCLI = eCLI;
   model.urJT = urJT;
   model.uruJT = uruJT;
   model.CSPJT = CSPJT;
   model.CSMJT = CSMJT;
   model.CSOJT = CSOJT;
   model.CSJT = CSJT;
   model.cRPST = cRPST;
   model.cRMST = cRMST;
   model.cROST = cROST;
   model.cRST = cRST;
   model.fcSPST = fcSPST;
   model.fcSMST = fcSMST;
   model.fcSOST = fcSOST;
   model.fcSST = fcSST;
   model.fcPPIT = fcPPIT;
   model.fcPMIT = fcPMIT;
   model.fcPOIT = fcPOIT;
   model.fcPIT = fcPIT;
   model.fcDPRT = fcDPRT;
   model.fcDMRT = fcDMRT;
   model.fcDORT = fcDORT;
   model.fcDRT = fcDRT;
   model.fcCPLT = fcCPLT;
   model.fcCMLT = fcCMLT;
   model.fcCOLT = fcCOLT;
   model.fcCLT = fcCLT;
   model.fcNPNT = fcNPNT;
   model.fcNMNT = fcNMNT;
   model.fcNONT = fcNONT;
   model.fcNNT = fcNNT;
   model.EISPST = EISPST;
   model.EISMST = EISMST;
   model.EISOST = EISOST;
   model.EISST = EISST;
   model.EIPPIT = EIPPIT;
   model.EIPMIT = EIPMIT;
   model.EIPOIT = EIPOIT;
   model.EIPIT = EIPIT;
   model.EIDPRT = EIDPRT;
   model.EIDMRT = EIDMRT;
   model.EIDORT = EIDORT;
   model.EIDRT = EIDRT;
   model.EICPLT = EICPLT;
   model.EICMLT = EICMLT;
   model.EICOLT = EICOLT;
   model.EICLT = EICLT;
   model.EINPNT = EINPNT;
   model.EINMNT = EINMNT;
   model.EINONT = EINONT;
   model.EINNT = EINNT;
   model.capSPST = capSPST;
   model.capSMST = capSMST;
   model.capSOST = capSOST;
   model.capSST = capSST;
   model.capPPIT = capPPIT;
   model.capPMIT = capPMIT;
   model.capPOIT = capPOIT;
   model.capPIT = capPIT;
   model.capPRPIT = capPRPIT;
   model.capPRMIT = capPRMIT;
   model.capPROIT = capPROIT;
   model.capPRIT = capPRIT;
   model.capDPRT = capDPRT;
   model.capDMRT = capDMRT;
   model.capDORT = capDORT;
   model.capDRT = capDRT;
   model.capCPLT = capCPLT;
   model.capCMLT = capCMLT;
   model.capCOLT = capCOLT;
   model.capCLT = capCLT;
   model.capNPNT = capNPNT;
   model.capNMNT = capNMNT;
   model.capNONT = capNONT;
   model.capNNT = capNNT;
   model.capLPMT = capLPMT;
   model.capLMMT = capLMMT;
   model.capLOMT = capLOMT;
   model.capLMT = capLMT; 
   model.cPPJIT = cPPJIT;
   model.cPMJIT = cPMJIT;
   model.cPOJIT  = cPOJIT;
   model.cPJIT = cPJIT;
   model.RCPJNT = RCPJNT;
   model.RCMJNT = RCMJNT;
   model.RCOJNT = RCOJNT;
   model.RCJNT = RCJNT;
   model.HCPJRT = HCPJRT;
   model.HCMJRT = HCMJRT;
   model.HCOJRT = HCOJRT;
   model.HCJRT = HCJRT;
   model.SHCPJKT = SHCPJKT;
   model.SHCMJKT = SHCMJKT;
   model.SHCOJKT = SHCOJKT;
   model.SHCJKT = SHCJKT;
   model.dePJKT = dePJKT;
   model.deMJKT = deMJKT;
   model.deOJKT = deOJKT;
   model.dePJKT1 =  dePJKT1;
   model.deMJKT1 = deMJKT1;
   model.deOJKT1 = deOJKT1;
   model.deJKT1 = deJKT1;
   model.deJKT2 = deJKT2;
   model.RTdeJKT1 = RTdeJKT1;
   model.RTdeJKT2 = RTdeJKT2;
   model.SPJIRT = SPJIRT;
   model.SMJIRT = SMJIRT;
   model.SOJIRT = SOJIRT;
   model.SJIRT = SJIRT;
   model.ftSPMSIT = ftSPMSIT; 
   model.ftSMMSIT = ftSMMSIT;
   model.ftSOMSIT = ftSOMSIT;
   model.ftSMSIT = ftSMSIT;
   model.ftPPMIRT = ftPPMIRT;
   model.ftPMMIRT = ftPMMIRT;
   model.ftPOMIRT = ftPOMIRT;
   model.ftPMIRT = ftPMIRT;
   model.ftDPMRKT = ftDPMRKT;
   model.ftDMMRKT = ftDMMRKT;
   model.ftDOMRKT = ftDOMRKT;
   model.ftDMRKT = ftDMRKT;
   model.ftKPMKLT = ftKPMKLT;
   model.ftKMMKLT = ftKMMKLT;
   model.ftKOMKLT = ftKOMKLT;
   model.ftKMKLT = ftKMKLT;
   model.ftNPMLNT = ftNPMLNT;
   model.ftNMMLNT = ftNMMLNT;
   model.ftNOMLNT = ftNOMLNT;
   model.ftNMLNT = ftNMLNT;
   model.ftCPMLIT = ftCPMLIT;
   model.ftCMMLIT = ftCMMLIT;
   model.ftCOMLIT = ftCOMLIT;
   model.ftCMLIT = ftCMLIT;
   model.tcSPMSIT = tcSPMSIT;
   model.tcSMMSIT = tcSMMSIT;
   model.tcSOMSIT = tcSOMSIT;
   model.tcSMSIT = tcSMSIT;
   model.tcPPMJIRT = tcPPMJIRT;
   model.tcPMMJIRT = tcPMMJIRT;
   model.tcPOMJIRT = tcPOMJIRT;
   model.tcPMJIRT = tcPMJIRT;
   model.tcDPMJRKT = tcDPMJRKT;
   model.tcDMMJRKT = tcDMMJRKT;
   model.tcDOMJRKT = tcDOMJRKT;
   model.tcDMJRKT = tcDMJRKT;
   model.tcKPMJKLT = tcKPMJKLT;
   model.tcKMMJKLT = tcKMMJKLT;
   model.tcKOMJKLT = tcKOMJKLT;
   model.tcKMJKLT = tcKMJKLT;
   model.tcNPMJLNT = tcNPMJLNT;
   model.tcNMMJLNT = tcNMMJLNT;
   model.tcNOMJLNT = tcNOMJLNT;
   model.tcNMJLNT = tcNMJLNT;
   model.tcCPMJLIT = tcCPMJLIT;
   model.tcCMMJLIT = tcCMMJLIT;
   model.tcCOMJLIT = tcCOMJLIT;
   model.tcCMJLIT = tcCMJLIT;
end

