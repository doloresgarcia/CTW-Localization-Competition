function values2=max_principal_path(ps_db_toas_shifted)

parameters2=ps_db_toas_shifted(:,:,:);
K=924;
step_sample = 0.01;
BW = 20;
index_carrier = 0:(K-1);
index_delay = -2:step_sample:(2-step_sample);
index_time = index_delay*(1/BW)*1e3;
values2=[];
index=0;
[a,b,c]=size(ps_db_toas_shifted);

for i=1:a
    for j=1:16
        ps_db_toa=parameters2(i,j,161:261);
        [m,p]= max(ps_db_toa);
        p=p+160;
        To1 = index_time(p);    
        values2(i,j)=To1;
        
    end

end
end