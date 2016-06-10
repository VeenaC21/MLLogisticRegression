function acc= LRAccuracy()
[w,b,loss] = LR2();
data=importdata('/Users/veenac/Downloads/voting1_test.data');

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
disp(size(Y,1));
rows=size(X,1);
result=ones(rows,1);

for i=1:rows
    line = w'*X(i,:)'+b;
    if(line>=0)
        result(i,1)=1;
    else
        result(i,1)=-1;
    end
end

count=0;
for i=1:rows
    if(result(i,1)==Y(i,1))
       count=count+1; 
    end
end
count
acc=count/rows;

