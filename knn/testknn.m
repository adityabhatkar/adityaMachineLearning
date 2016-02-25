%To calculate KNN
%Input: trainX:: training data co-ordinates matrix (n X 16)
%		trainY:: training labels matrix (n X 1)
%		testX:: test data co-ordinates matrix (5000 X 16)
%		k:: number nearest neighbors to check integer
%Output:	testY:: predicted labels matrix (5000 X 16)
function [testY] = testknn(trainX, trainY, testX, k)

%calculate distance from each test point with each training data point
Distances=pdist2(trainX,testX);

if(k==1)
    %get nearest point
    [minDistes, minDistIndices]=min(Distances);
    testY=trainY(minDistIndices);
else
    %get most occuring pooint out of nearest k points
    %store the result in output
    [SortedMatrix,OriginalIndices]=sort(Distances,1);
    testY=mode(trainY(OriginalIndices([1:k],:))',2);
end