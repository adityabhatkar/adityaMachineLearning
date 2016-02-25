function [result, actualLabels]=abhatkarHW1()
%configuration
%data sample size and K
n=15000;
k=3;
cond=1; %1: enable condesing, 0:disable codesnsing

%read from file
numericData=csvread('letter-recognition.dat', 0,1,[0,1,19999,16]);

%init data matrices
trainX=zeros(n,16);
trainX=numericData(1:n, 1:16);

testX=zeros(5000,16);
testX=numericData(15001:20000, 1:16);

fileID = fopen('letter-recognition.dat');
C = textscan(fileID,'%s %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d', 'Delimiter',',');
fclose(fileID);
mytrainY=C{1};
trainY=cell2mat(mytrainY(1:n));
actualLabels=cell2mat(mytrainY(15001:20000));


if(cond==1)
    tic
    %start condesing
    condensedIdx=condensedata(trainX, trainY);
    toc
    
    tic
    %test knn with condensing
    testY=testknn(trainX(condensedIdx,:), trainY(condensedIdx), testX, k);
    toc
    testAccu(testY, actualLabels);    
    
else
    tic
    %test knn without condesing
    testY=testknn(trainX, trainY, testX, k);
    toc        
    testAccu(testY, actualLabels);
    
end

%To test accuracy
function [t] =testAccu(testY, actualLabels)

resullt=testY==actualLabels(1:size(testY,1),:);
sum(resullt)/50
