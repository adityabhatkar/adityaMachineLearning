%Aditya Bhatkar
%calculates weights for given data and labels
%input: data matrix X (N X 3) 
%input: label matrix Y (N X 1) 
%output: weight matrix W (1 X 3) 
function [W]=pseudoinverse(X,Y)
    A=X'*X;    
    T=A\X';    
    W=(T*Y)';
    
    