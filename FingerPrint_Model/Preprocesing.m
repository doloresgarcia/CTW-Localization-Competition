function [ps_toas]=Preprocesing(h_Estimated)


ps_toas=[];
[a,b,c]=size(h_Estimated);
% a =tic;
for i=1:a
%     b=tic;

    channel=h_Estimated(i,:,:);
    for j=1:16
        channel_1=squeeze(channel(1,j,:));
        channel_1=channel_1.';
        [ps_toas(i,j,:)]=Estimation_final(channel_1);
    end
%     b_t(i) = toc(b)
i
end
% a_t = toc(a)
% print('final prepocessing')
save('toas_test_1','ps_toas');
end