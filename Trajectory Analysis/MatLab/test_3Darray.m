 clc

wing = zeros(125,3);
iWing = 0;
AR = 1:5;             
sweep = 0:8:32;
cRoot = .1:0.1:0.5;

for iAR = 1:length(AR)
     
    for iSweep = 1:length(sweep)
        for icRoot = 1:length(cRoot)
            
             iWing = iWing +1;
             wing(iWing, 1)= AR(iAR);
             wing(iWing, 2)= sweep(iSweep);
             wing(iWing, 3)= cRoot(icRoot);


        end
    end
end

for i = 1:iWing
   
    AR(i) = wing(i,1);
    sweep(i) = wing(i,2);
    cRoot(i) = wing(i,3);
end
% end
% for ind = 1:10;
% A(ind) = ind;
% end
% for ind2 = 1:4;
% B(1:10, ind2) = A*ind2;
% end
