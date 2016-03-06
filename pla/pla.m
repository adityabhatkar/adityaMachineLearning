%Aditya Bhatkar
%implements Perceptron Learning Algorithm
%input: data matrix X (N X 3) 
%input: label matrix Y (N X 1) 
%input: weight matrix W (1 X 3) 
%output: learned weight matrix W (1 X 3) 
%output: number of iterations required for learning
function [W, iters]=pla(X, Y, W)
	
    iters=0;    
    %Continue till all points are not correctly classified
	while(true)        
        %dot product of X and W
		dotResult=sign(X*W');  
        %compare result with given labels
		comparisonResult = dotResult==Y;        
		missClassified=find(~comparisonResult);
        %if no missclassified point then exit
		if(isempty(missClassified)==1)
			break;
        end
        
		iters=iters+1;
		
        %select a random miss classified point
		chosenWrongOne=missClassified(randi(numel(missClassified)));
        %update weights 
		W=W+Y(chosenWrongOne,:)*X(chosenWrongOne,:); 
        
	end
