%Aditya Bhatkar 
function []=main()    

    %Specify various sample sizes
    TrainingSampleSizes=[10, 50, 100, 200, 500, 1000];
    numberOfSamples=size(TrainingSampleSizes);
    
    %randomly select on of the sample size for each experiment
    N = datasample(TrainingSampleSizes,numberOfSamples(1,2), 'Replace', false);
    
    %For learning weights without pseudo inverse
    
    NonPseudoIters=zeros(0);
    %For each sample size
    for j=1:numberOfSamples(1,2)                
        %tic     
        %compute 100 times take avg 
        for i=1:100
            %generate data for a sample size
            [X,Y]=generateData(N(1,j));        
            %commented call to pseudoinverse
            %Using intial weights as zeros
            %W0=pseudoinverse(X,Y);
            W0=zeros(1,3);                
            %get learned weights using PLA
            [W, iters]=pla(X, Y, W0);                 
            allIters(i)=iters;
        end        
        %store mean of all number of iterations
        NonPseudoIters  = [mean(allIters);NonPseudoIters ];
        %toc    
    end
    
    %For learning weights after pseudo inverse
    
    PseudoIters=zeros(0);
     for j=1:numberOfSamples(1,2)                
        %tic     
        %compute 100 times take avg 
        for i=1:100
            %generate data for a sample size
            [X,Y]=generateData(N(1,j));  
            %commented call to initialize weights to zero
            %Using weights after calculating pseudo inverse
            W0=pseudoinverse(X,Y);
            %W0=zeros(1,3);               
             %get learned weights using PLA
            [W, iters]=pla(X, Y, W0);                 
            allIters(i)=iters;
        end        
        %store mean of all number of iterations          
        PseudoIters = [ mean(allIters);PseudoIters];
        %toc    
    end
    
    %Observed values of execution time for one of the
    %experiments    
    %D3-> without pseudo inverse
    %D5-> with pseudo inverse
    %D3=[0.239524,0.568052,3.214357,2.137351,3.964678,12.37301];    
    %D5=[2.172468,0.578279,3.748959,2.545709,5.512501,15.435057];
    
    %plotting results for required number of iterations to learn weights
    hold on        
    plot(TrainingSampleSizes,PseudoIters', '-b', TrainingSampleSizes,NonPseudoIters', '-r')    
    xlabel('Number of Training Samples')
    ylabel('Number of Iterations')
    legend('With Pseudo Inv','Without Pseudo Inv')    
    hold off
    
    %plotting execution time results 
    %hold on
    %plot(D1,D3);
    %plot(D1,D5);        
    %hold off
    
    
    
    
