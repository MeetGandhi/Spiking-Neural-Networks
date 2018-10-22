classdef Synapse % defining a class for Synapse
   
    properties
       
        % defining Synapse Object Class Attributes 
        
        value;
        spike_time;
        time_from_spike;
        
    end
    
    methods
       
        function obj = Synapse()
            
            % Initializing Synapse Object Class Attributes
           
            obj.value = 0;
            obj.time_from_spike = 0;
            obj.spike_time = 0;
            
        end
        
    end
end