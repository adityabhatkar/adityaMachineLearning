%Aditya Bhatkar
%generated data for given size
%input: N integer
%output: X (N X 3) data matrix in [-1, 1] range
%output: Y (N X 1) label matrix in [1, 0] range
function [X,Y]=generateData(N)

    %generate random number in rage [-1,1]
    Xtemp = (-1) + ((1)-(-1)).*rand(N(1:1),2);
    X(:,1)=ones(N,1);
    X(:,2:3)=Xtemp;

    %select two random points
    myPoint1=randi(N);
    myPoint2=myPoint1;
    while(eq(myPoint2,myPoint1))
        myPoint2=randi(N);
    end

    %classify other points based on line formed by selected points
    Y = sign((X(myPoint2,2) - X(myPoint1,2)) * (X(:,3) - X(myPoint1,3)) - (X(myPoint2,3) - X(myPoint1,3)) * (X(:,2) - X(myPoint1,2)));    
    Y(Y(:,1)==0)=1; 

