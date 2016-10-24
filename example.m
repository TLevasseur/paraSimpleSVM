%% Read Data


data = load('petro_1000000.dat');
[u,v]=size(data);
X = data(:,1:v-1);

y =data(:,v);
X(find(y==-9999),:)=[];
y(find(y==-9999))=[];
clear data;
y = (y-0.5)*2;

[n,p] = size(X);

%% Cleaning and Expending the data for better results

X = X - ones(n,1)*mean(X);


for i=1:5
   X(:,p+i)=X(:,i)./X(:,i+5);
end

[xapp, yapp, xtest, ytest] = splitdata(X, y, .01);
clear X y;
%%%%%%%%%%

% Init Value
c = 100;
lambda = 10^-12;
kernel = 'gaussian'; 
kerneloption = 0.4;
verbose = 1;


%%%% Shuffle data
perm=randperm(size(yapp,1));
yapp(perm)=yapp;
xapp(perm,:)=xapp;

%%%%


tic
[xsup,w,b,pos,timeps,alpha,obj]=parasvmclass(xapp,yapp,c,lambda,kernel,kerneloption,verbose);
toc
[yp]=svmval(xtest,xsup,w,b,kernel,kerneloption);
yp = sign(yp);


%Confusion Matrix
Mc(1,1) = sum((ytest==1) & (yp==1));
Mc(1,2) = sum((ytest==1) & (yp==-1));
Mc(2,1) = sum((ytest==-1) & (yp==1));
Mc(2,2) = sum((ytest==-1) & (yp==-1));

Mc % brute results

Mc/sum(sum(Mc))*100 % percentage

