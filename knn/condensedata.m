%To condense the training data set to the consistent data set
%Input:     trainX:: training data co-ordinates matrix (n X 16)
%           trainY:: training labels matrix (n X 16)
%Output:  	condensedIdx:: condesnsed indices of training set (variable rows X 1)
function [condensedIdx] = condensedata(trainX, trainY)

%init subset
subset=trainX(1,:);
subsetLabel=(1);

%preallocating data matrices
incorrectLabelIndices=zeros(size(trainY));
Distances=zeros(size(trainX));

%continue till no transfers occur or subset does not get full
while(~isempty(incorrectLabelIndices) &&  (size(subset,1)<=size(trainX,1)) )
    
    
    %consider only that training data which is not used earlier        
    [trainX,oldTrainXIndices] = setdiff(trainX,subset,'rows');
    
    %calculate distance from a training data sample with each point in
    %subset
    Distances=pdist2( subset, trainX(1,:));
    
    %find index of nearest point in subset
    [M,I] =min(Distances,[],1);
    
    %consider lablel of the index as predicted label
    labels=trainY(subsetLabel(I));    
    
    %find incorrectly classified samples
    incorrectLables=trainY(oldTrainXIndices)~=labels;  %returns 1 for each incorrect label and 0 for correct
    
    % get the indices of 1s from inCorrectLables
    incorrectLabelIndices=find(incorrectLables);
    
    %select one incorrect sample randomly
    if(~isempty(incorrectLabelIndices))
        
        randomIncorrectLabelIndex=datasample(incorrectLabelIndices, 1);        
        %fetch record for that label
        randomIncorrectSample=trainX(randomIncorrectLabelIndex,:);
        %paste it in subset
        subset=[subset;randomIncorrectSample];
        subsetLabel=[subsetLabel;randomIncorrectLabelIndex];
    end
    condensedIdx=subsetLabel;    
end