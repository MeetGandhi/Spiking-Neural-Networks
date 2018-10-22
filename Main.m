%clc
%clear all
%close all

% Our goal is to use SNN to train the entity to take a path or
% trajectory such that it reaches a predefined destination assigned by the
% user beforehand

% position of the entity after one training/epoch and then those
% trained parameters being passed through the controller 
% designed in Simulink titled mobileSim to get the resultant x (xVec)
% and y (yVec) coordinates of the entity as well as the orientation of the 
% entity (fiVec) after being trained for that 
% epoch

% defining global variables x_1, y_1 and fi_1 describing the initial
% coordinates of the entity and also the initial orientation of the entity
% global variables omegaR, omegaL trained parameters/constants from SNN 
% which are passed through the Simulink Controller to get the (X,Y)
% coordinates of the entity as well the orientation of the entity fi

global x_1
global y_1
global omegaR
global omegaL
global fi_1
global fi

% constructing a Spiking Neural Network with 3 layers 
% First layer which is the input layer contains 6 neurons as there are 6 
% inputs to SNN (explained more in RunSim MATLAB Script File)
% Second Hidden layer of SNN containds 5 neurons
% Third Layer which is the output layer contains 2 neurons representing two
% outputs omegaR and omegaL from SNN (explained more in RunSim MATLAB 
% Script File)
% Second argument is the connection matrix which establishes which
% neuron of each layer is connected to with neurons
% Third and Fourth arguments are the maximum and minimum values of Synapse
% and hence the weights of SNN

net = SpikeNetwork([6 5 2], [0 0 0; 1 0 0; 1 1 0], 1, 0);

% Refer to the RunSim MATLAB Script File to know more about the arguments
% of RunSim function
RunSim(net, 0.1, 0.1, 10);

% Refer to the GeneticAlgorithm MATLAB Script File to know more about the 
% arguments of GeneticAlgorithm function
% Briefly, 0.05 is the mutation rate, 30 is the population size initially,
% and the rest arguments are SNN structure parameters

EA = GeneticAlgorithm(0.05, 30, [6 5 2], [0 0 0; 1 0 0; 1 1 0]);

% Refer to the GeneticAlgorithm MATLAB Script File to know more about the 
% arguments of Evolve function
% Briefly, 45 is the total number of generations GeneticAlgorithm should go
% through and EA is the GeneticAlgorithm class object

% Here Genetic Algorithm is used for the optimization of Spike Time 
% Dependent Plasticity (STDP) Learning Parameters which is used for 
% updating the weights of different connections in SNN and hence ultimately
% training SNN (for more info refer to the comments of SpikeNetwork MATLAB
% Script File)

EA = Evolve(EA, 45);

