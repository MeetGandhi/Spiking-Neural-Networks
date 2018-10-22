function [ xVec, yVec, outOmegaR, outOmegaL, net ] = RunSim( net, xRef, yRef, time )

% defining a function RunSim for undergoing the simulating an
% entity which initially has the knowledge of just going in a
% horizontal path i.e. through a straight line from (10, 10) with zero 
% slope

% Our goal is to use SNN to train the entity to take a path or
% trajectory such that it reaches a predefined destination assigned by the
% user beforehand

% position of the entity after one training/epoch and then those
% trained parameters being passed through the controller 
% designed in Simulink titled mobileSim to get the resultant x (xVec)
% and y (yVec) coordinates of the entity as well as the orientation of the 
% entity (fiVec) after being trained for that 
% epoch

xVec = [];   
yVec = [];
fiVec = [];

% defining global variables x_1, y_1 and fi_1 describing the initial
% coordinates of the entity and also the initial orientation of the entity
% global variables omegaR, omegaL trained parameters/constants from SNN 
% which are passed through the Simulink Controller to get the (X,Y)
% coordinates of the entity as well the orientation of the entity fi

global x_1
global y_1
global fi_1
global omegaR
global omegaL
global fi

% for our simulation the initial coordinates of the entity is (10,10) and
% Zero degree orientation

x_1 = 10;
y_1 = 10;
fi_1 = 0;
omegaR = 0;
omegaL = 0;

outOmegaR = [];
outOmegaL = [];

for i = 0:0.05:time
    wR = [];
    wL = [];
    
    % calculating the closeness of the trained solution to the destination
    % point by calculating changes in the current trained coordinates of
    % the entity with that of the destination point coordinates
    
    deltaX = abs(xRef - x_1);
    deltaY = abs(yRef - y_1);
    rho = sqrt((xRef - x_1)^2 + (yRef - y_1)^2);
%     Phi = atan((yRef - y_1)/(xRef - x_1)) - fi_1;
%     n = Phi/pi;
%     deltaPhi = ((Phi/n) + pi)/(2*pi);
    Phi = atan2((yRef - y_1),(xRef - x_1)) - fi_1;
    n = atan2(sin(Phi),cos(Phi));
    deltaPhi = (n + pi)/(2*pi);
    omegaR1 = omegaR;
    omegaL1 = omegaL;
    
    if deltaX > 1
        deltaX = 1;
    end
    if deltaY > 1
        deltaY = 1;
    end
    if rho > 1
        rho = 1;
    end
    
    % scaling down by 10 which will be scaled up by 10 afterwards
    
    omegaR1 = omegaR1 / 10;
    omegaL1 = omegaL1 / 10;
    
    % assigning inputs to the first layer of SNN
    % as there are 6 neurons in the first layer of our SNN, there are 
    % correspondingly 6 inputs
    
    in(1) = 1 / deltaX;
    in(1) = round(50 / in(1));
    in(2) = 1 / deltaY;
    in(2) = round(50 / in(2));
    in(3) = 1 / rho;
    in(3) = round(50 / in(3));
    in(4) = 1 / deltaPhi;
    in(4) = round(50 / in(4));
    in(5) = 1 /omegaR1;
    in(5) = round(50 / in(5));
    in(6) = 1 /omegaL1;
    in(6) = round(50 / in(6));
    
    net.neural{1}{1}{1}.count = in(1);
    net.neural{1}{1}{2}.count = in(2);
    net.neural{1}{1}{3}.count = in(3);
    net.neural{1}{1}{4}.count = in(4);
    net.neural{1}{1}{5}.count = in(5);
    net.neural{1}{1}{6}.count = in(6);
    
    % Running the network 50 times and then taking the average of the
    % outputs as the actual output
    
    for j = 1:50
        net = Run(net);
        wR = [wR net.net_output(1)];
        wL = [wL net.net_output(2)];
    end

    % as we had scaled down omegaR and omegaL by 10 earlier now after 
    % taking average of 50 outputs we scale up omegaR and omegaL by 10 and
    % hence division by 5 and not 50
    
omegaR = sum(wR)/5;
omegaL = sum(wL)/5;

outOmegaR = [outOmegaR omegaR];
outOmegaL = [outOmegaL omegaL];

% passing the outputs omegaR and omegaL from the SNN to the mobileSim
% Simulink Controller in order to get the new (X,Y) coordinates and the 
% orientation of the entity 
% These are then updated as the new x_1, y_1 and fi_1 which are again
% passed through the SNN network until the destination point is reached

sim('mobileSim');

xVec = [xVec x(2)];
yVec = [yVec y(2)];
fiVec = [fiVec fi(2)];

x_1 = x(2);
y_1 = y(2);
fi_1 = fi(2);

end

end

