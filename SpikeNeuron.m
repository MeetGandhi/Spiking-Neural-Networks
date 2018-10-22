classdef SpikeNeuron % defining a class for Spike Neurons
   
   properties
       
       % defining SpikeNeuron Class Attributes
       
        output;
        rule;
        tau;
        uprah;
        u
        R;
        C;
        A1;
        A2;
        t;
        spike_time;
        
    end
    
    methods
        
        % Initializing SpikeNeuron Class Attributes
        
        function obj = SpikeNeuron()
            obj.uprah = 0;
            obj.u = obj.uprah;
            obj.tau = 0.5;
            obj.R = 10;
            obj.C = obj.tau/obj.R;
            obj.A1 = 1;
            obj.A2 = 1;
            obj.t = 10;
            obj.rule = 1;
            obj.output = 0;
            obj.spike_time = 0;
            
        end
        
        function obj = OutputCompute(obj, thalamic_input)
           
            % Spike Neuron Output based on Biophysical Hodgkin-Huxley model
            % and its Mathematical simplification by Izhikevich
            % Various HyperParameters for the output of Spike Neuron were 
            % selected from the standard Model of Izhikevich  
                     
           obj.u = obj.u + (obj.uprah/obj.tau) - (obj.u/obj.tau) + (obj.R*thalamic_input)/obj.tau;
           
           if obj.u >= 22
               obj.output = 1; 
               obj.u = obj.uprah;
               
           else
               
               obj.output = 0;
               
           end               
        end
    end
end