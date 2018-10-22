classdef InputNeuron % defining a class for Input Neurons
   
    properties
        
        % defining Input Neuron Object Attributes
        
        output;
        spike_time;
        A1;
        A2;
        t;
        rule;
        count;
       
    end
    
    methods
        
        function obj = InputNeuron()
            
            % Initializing Input Neuron Object Parameters
            
            obj.output = 0;   
            obj.A1 = 0;
            obj.A2 = 0;
            obj.t = 0;
            obj.rule = 0;
            obj.count = 0;
        end
        
        function obj = ComputeOutput(obj)
            
            % obj.count defined in RunSim MATLAB Script File 
            
            if obj.count > 0
                obj.output = 1;
                obj.count = obj.count - 1;
            else
                obj.output = 0;
            end
            
        end
        
    end
    
end