function ps_db_toas_shifted =shifting(K,toas)
K=924;
step_sample = 0.01;
BW = 20;
index_carrier = 0:(K-1);
index_delay = -2:step_sample:(2-step_sample);
index_time = index_delay*(1/BW)*1e3;
values2=[]
parameters2=toas(:,:,:);
[a,b,c]=size(toas);
index=   1:a;
count=0;
ps_db_toas_shifted = zeros(length(index), 16,400);
ps_db_toas = toas(index,:,:);
for i=1:length(index)
    i
    in=index(i);
    ps_db_toas_shifted(i,:,:) = toas(in,:,:);
    for j=1:16
        ps_db_toa=parameters2(in,j,:);
        [TF,P] = islocalmax(ps_db_toa,'MinProminence',0.1);
        ma=ps_db_toa(TF);
        
        ta=index_time(TF);
        v=size(ta);
        if(v(2)==0)
            count=count+1;
            break
        end
        m1=ma(1,1,1);
        v=size(ta);
        if v(2)==2 | v(2)==3
             m2=ma(1,1,2);
             t2=ta(1,2);
        else
            m2=-30;
            t2=-80;
        end
        
        if v(2)==3
             m3=ma(1,1,3);
             t3=ta(1,3);
        else 
            m3=-30;
            t3=80;
        end
        t1=ta(1,1);
        if (v(2)==2 & t2>40)
             m3=m2;
             m2=m1;
             t3=t2;
             t2=t1;   
        end  
        %
        if (v(2)==2 & m3>-30)  & ((m3>m2) | ((0.01< abs(m2-m3))& abs(m2-m3)<K) )
                 d=(t2+66)*2;
                 aux=parameters2(in,j,:);
                 ps_db_toas_shifted(i,j,:) = circshift(aux,-round(d)); 
        end
    end

end
end