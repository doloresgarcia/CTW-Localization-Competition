function [ rpred]=fingerPrint_no_true(toastest,toastrain,rtrain)

rpred=[];
mm=[];
[a,b]=size(toastest);
[c,d]=size(rtrain);
for i=1:a
    r=toastest(i,:);
    rr=repmat(r,c,1);
    which=abs(toastrain-rr);
    whichsum=sum(which,2);
    [m,in]=min(whichsum);
    mm(i)=m;
    rpred(i,:)=rtrain(in,:);
end



function z=true_dist1(y_true, y_pred)
    z=(sqrt((abs(y_pred(1)-y_true(1))).^2+(abs(y_pred(2)-y_true(2))).^2+(abs(y_pred(3)-y_true(3))).^2));

end

function z=true_dist(y_true, y_pred)
    z=(sqrt((abs(y_pred(:,1)-y_true(:,1))).^2+(abs(y_pred(:,2)-y_true(:,2))).^2+(abs(y_pred(:,3)-y_true(:,3))).^2));

end

end