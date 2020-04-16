function [values_shuffled,index]=suffle(values2)

%shuffle data 
[l,m]=size(values2);
index=randperm(l);
index=sort(index);
values_shuffled=[];
 for i=1:length(index)
    indexx=index(i);
    values_shuffled(i,:)=values2(indexx,:);
 end
end
