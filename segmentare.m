function imagGray = segmentare(imagIncarcata)
%% 2.	K-means clustering
[linii,coloane] = size (imagIncarcata);

c0_curent = min(min(imagIncarcata));
c1_curent = max(max(imagIncarcata));

c0_anterior = 0;
c1_anterior = 0;
k = 0;
imagGray = imagIncarcata;
while c0_curent ~= c0_anterior || c1_curent ~= c1_anterior
k = k+1;
    for i = 1:linii
        for j = 1:coloane
            
            if abs(imagIncarcata(i,j)- c0_curent) <= abs(imagIncarcata(i,j)- c1_curent)
                imagGray (i,j) = 0;
            else
                imagGray (i,j) = 1;
            end
            
        end
    end
    
    C0 = imagIncarcata((imagGray==0));
    C1 = imagIncarcata((imagGray==1));
    
    c0_anterior = c0_curent;
    c1_anterior = c1_curent;
    
    c0_curent = mean(C0);
    c1_curent = mean(C1);
    
end