function [w,b,loss] = LRIgnoreMissing()

data=importdata('/Users/veenac/Downloads/voting1_train.data');
%disp(data);
D=data(:,2:17);
D2=data(:,1);

rows=size(D,1);
X=[];
Y=[];
p=0;
for i=1:rows
   for j=1:16
       if(D(i,j)==2)
           p=0;
           break;
       end
       p=1;
   end
   if(p==1)
       X=[X;D(i,:)];
       Y=[Y;D2(i,:)];
   end
   p=0;
end
%display(size(X,1));
rows=size(X,1);
sigma=0.01;
w=0.01*ones(16,1);
b=0.01;
loss=0;
for count = 1:100000
    
    sum=0;
    sum2=0;
     
    for j=1:16
        for i=1:rows
        line=w'*X(i,:)'+b;
        d=exp(line)/(1+exp(line));
        result=((Y(i,:)+1)/2) -d;
        sum=sum+(X(i,j)*result);
        sum2=sum2+(result);
        end
     w(j,1)=w(j,1)+sigma*sum;
     b=b+sigma*sum2;
     sum=0;
     sum2=0;
    end
    oldloss=loss;
    loss=losscalc(w,b,X,Y);
    
    if(oldloss-loss<0.0001)
        break;
    end
    
end
loss
end
function loss = losscalc(w,b,X,Y)
rows=size(X,1);
sum=0;
  for i=1:rows
      line=w'*X(i,:)'+b;
     sum=sum+((Y(i,:)+1)/2)*line-log(1+exp(line));
  end
  loss=sum;
 end