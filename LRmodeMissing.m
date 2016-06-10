function [w,b,loss] = LRmodeMissing()
data=importdata('/Users/veenac/Downloads/voting1_train.data');
%disp(data);
X=data(:,2:17);
Y=data(:,1);

rows=size(X,1);

county=0;
countn=0;

for i=1:rows
   for j=1:16
       if(X(i,j)==1)
          county=county+1; 
       end
       if(X(i,j)==-1)
          countn=countn+1; 
       end
   end
   if(county>=countn)
       r=1;
   end
   if(county<countn)
       r=-1;
   end
       
   for j=1:16
       if(X(i,j)==2)
           X(i,j)=r;
       end
   end
end

rows=size(X,1);
sigma=0.1;
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
    end
    oldloss=loss;
    loss=losscalc(w,b,X,Y);
    sum=0;
    sum2=0;
    
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




