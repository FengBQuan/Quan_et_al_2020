%% Escape general parameters analysis
% The loaded workspace must contain a variable named 'datasetPerBout' a structure array with these fields
%
%% Clean workspace and load data
close all
clear all
clc

load('matlab_workspace_SST_5manip_Escape.mat')

%% Initiate matrix

nbStimulus = length(unique([datasetPerBout.NStim]));
nbIdx =length(unique([datasetPerFish.Condition]))+ min(unique([datasetPerFish.Condition]));

% rows -> stimulus
% column -> fish


Cbend= zeros(nbStimulus,nbIdx)*NaN;
Latency= zeros(nbStimulus,nbIdx)*NaN;

BoutDuration = zeros(nbStimulus,nbIdx)*NaN;
NumberOfOscillations= zeros(nbStimulus,nbIdx)*NaN;
Distance= zeros(nbStimulus,nbIdx)*NaN;
Speedc= zeros(nbStimulus,nbIdx)*NaN;
mTBF= zeros(nbStimulus,nbIdx)*NaN;
Counterbend= zeros(nbStimulus,nbIdx)*NaN;

%Case 1:

Cbend_NorEsc= zeros(nbStimulus,nbIdx)*NaN;
Latency_NorEsc= zeros(nbStimulus,nbIdx)*NaN;
BoutDuration_NorEsc = zeros(nbStimulus,nbIdx)*NaN;
NumberOfOscillations_NorEsc= zeros(nbStimulus,nbIdx)*NaN;
Distance_NorEsc= zeros(nbStimulus,nbIdx)*NaN;
Speed_NorEsc= zeros(nbStimulus,nbIdx)*NaN;
mTBF_NorEsc= zeros(nbStimulus,nbIdx)*NaN;
TBF1_NorEsc=zeros(nbStimulus,nbIdx)*NaN;
Counterbend_NorEsc= zeros(nbStimulus,nbIdx)*NaN;


% %Case 2:
% Cbend_Longlat= zeros(nbStimulus,nbIdx)*NaN;
% Latency_Longlat= zeros(nbStimulus,nbIdx)*NaN;
% BoutDuration_Longlat = zeros(nbStimulus,nbIdx)*NaN;
% NumberOfOscillations_Longlat= zeros(nbStimulus,nbIdx)*NaN;
% Distance_Longlat= zeros(nbStimulus,nbIdx)*NaN;
% Speed_Longlat= zeros(nbStimulus,nbIdx)*NaN;
% mTBF_Longlat= zeros(nbStimulus,nbIdx)*NaN;
% Counterbend_Longlat= zeros(nbStimulus,nbIdx)*NaN;
% 
% 
% %Case 3:
% Cbend_smallEsc= zeros(nbStimulus,nbIdx)*NaN;
% Latency_smallEsc= zeros(nbStimulus,nbIdx)*NaN;
% BoutDuration_smallEsc = zeros(nbStimulus,nbIdx)*NaN;
% NumberOfOscillations_smallEsc= zeros(nbStimulus,nbIdx)*NaN;
% Distance_smallEsc= zeros(nbStimulus,nbIdx)*NaN;
% Speed_smallEsc= zeros(nbStimulus,nbIdx)*NaN;
% mTBF_smallEsc= zeros(nbStimulus,nbIdx)*NaN;
% Counterbend_smallEsc= zeros(nbStimulus,nbIdx)*NaN;



%% Find fishes genotypes


% Homozygote
idx_Homo = find([datasetPerBout.Genotype] == 0);
fish_Homo =  unique([datasetPerBout(idx_Homo).Condition]);

% Heterozygote
idx_Het = find([datasetPerBout.Genotype] == 1);
fish_Het =  unique([datasetPerBout(idx_Het).Condition]);

% Wild
idx_WT = find([datasetPerBout.Genotype] == 2);
fish_WT = unique([datasetPerBout(idx_WT).Condition]);

%% Add Trials if need
% nbTrial= length(unique([datasetPerBout.NTrial]));
% for Trial= min(unique([datasetPerBout.NTrial])):max(unique([datasetPerBout.NTrial]));
%     datasetTrial = datasetPerBout([datasetPerBout(:).NTrial]== Trial);

%% Calculation for each Stimulus
    output_Distance = struct( 'Variable', [], 'Clutch', [], 'Fish', [], 'FishGeno',[], ...
        'Stim1', [], 'Stim2',[],'Stim3',[],'Stim4',[],'Stim5',[],'Stim6',[],'Stim7',[],'Stim8',[],'Stim9',[],'Stim10',[]);
    output_Duration = struct( 'Variable', [], 'Clutch', [], 'Fish', [], 'FishGeno',[], ...
        'Stim1', [], 'Stim2',[],'Stim3',[],'Stim4',[],'Stim5',[],'Stim6',[],'Stim7',[],'Stim8',[],'Stim9',[],'Stim10',[]);
    output_Speed = struct( 'Variable', [], 'Clutch', [], 'Fish', [], 'FishGeno',[], ...
        'Stim1', [], 'Stim2',[],'Stim3',[],'Stim4',[],'Stim5',[],'Stim6',[],'Stim7',[],'Stim8',[],'Stim9',[],'Stim10',[]);
    output_NumOfOsc = struct( 'Variable', [], 'Clutch', [], 'Fish', [], 'FishGeno',[], ...
        'Stim1', [], 'Stim2',[],'Stim3',[],'Stim4',[],'Stim5',[],'Stim6',[],'Stim7',[],'Stim8',[],'Stim9',[],'Stim10',[]);
    output_TBF1 = struct( 'Variable', [], 'Clutch', [], 'Fish', [], 'FishGeno',[], ...
        'Stim1', [], 'Stim2',[],'Stim3',[],'Stim4',[],'Stim5',[],'Stim6',[],'Stim7',[],'Stim8',[],'Stim9',[],'Stim10',[]);
    output_mTBF = struct( 'Variable', [], 'Clutch', [], 'Fish', [], 'FishGeno',[], ...
        'Stim1', [], 'Stim2',[],'Stim3',[],'Stim4',[],'Stim5',[],'Stim6',[],'Stim7',[],'Stim8',[],'Stim9',[],'Stim10',[]);
    output_Cbend = struct( 'Variable', [], 'Clutch', [], 'Fish', [], 'FishGeno',[], ...
        'Stim1', [], 'Stim2',[],'Stim3',[],'Stim4',[],'Stim5',[],'Stim6',[],'Stim7',[],'Stim8',[],'Stim9',[],'Stim10',[]);
    output_Counterbend = struct( 'Variable', [], 'Clutch', [], 'Fish', [], 'FishGeno',[], ...
        'Stim1', [], 'Stim2',[],'Stim3',[],'Stim4',[],'Stim5',[],'Stim6',[],'Stim7',[],'Stim8',[],'Stim9',[],'Stim10',[]);
    output_Latency = struct( 'Variable', [], 'Clutch', [], 'Fish', [], 'FishGeno',[], ...
        'Stim1', [], 'Stim2',[],'Stim3',[],'Stim4',[],'Stim5',[],'Stim6',[],'Stim7',[],'Stim8',[],'Stim9',[],'Stim10',[]);
    
for n=1:nbStimulus
    
    n

    New_BoutStart=[];
    
    idx=[];
    
    datasetStim = datasetPerBout([datasetPerBout(:).NStim]== n);% datasetStim: extract dataset for each Stimulus
    
    Fish= unique([datasetStim.Condition]);
    
    
    % Clean datasetStim, selecte only Escape bout
    
    
    for i = 1:length(Fish)
   
        i
        
        idx{Fish(i)}=find([datasetStim.Condition]== Fish(i)); % indexing the position of each fish in datasetStim, Fish(1)=97;...Fish(240)=382
        New_idx{Fish(i)}= idx{Fish(i)};
        New_BoutStart_copy= [];
        
        
        for h=1:length(idx{Fish(i)}); % For Fish(i), we have h bout, for each Bout(h), calculate New BoutStart
            
            h 
            % Find New BoutStart
            TailAngle{Fish(i)}{h}=57.2958*[datasetStim(idx{Fish(i)}(h)).TailAngle_smoothed];
            
            % find the Start point by calculating diff(TailAngle)>5, find the transient start point
            diff_Angle{Fish(i)}{h}=find(abs(diff(TailAngle{Fish(i)}{h}))>5);
            
            
            if isempty(diff_Angle{Fish(i)}{h});
                diff_Angle{Fish(i)}{h}=1;
            end
            
            % Set the threshold of movement at 5 degree for all movement
            New_MovePosition{Fish(i)}{h}=find(abs(TailAngle{Fish(i)}{h})>5);
            
            if isempty(New_MovePosition{Fish(i)}{h});
                New_MovePosition{Fish(i)}{h}=1;
            end
            
            % Absolut start point= trainsient start point (1) + BoutStart in
            % datasetPerBout
            New_Timing{Fish(i)}{h}=[diff_Angle{Fish(i)}{h}(1):1:New_MovePosition{Fish(i)}{h}(end)];
            
            New_BoutStart{Fish(i)}{h}=diff_Angle{Fish(i)}{h}(1)+ datasetStim(idx{Fish(i)}(h)).BoutStart;
            
            New_BoutStart_copy= New_BoutStart;
            
        end;
        
        
        %% Keep only Escape Bout if Fish have multiBout during 1s
        
        Stim_Timing = (unique([datasetStim.fps]))* 0.2; % Acoustic Stimulus at 200ms
        FirstBoutStart= min(cell2mat(New_BoutStart{Fish(i)}));
        
        if  FirstBoutStart < Stim_Timing ; % eliminate bouts before stimlus
            
            try
                Bout_After_Esc = (cell2mat(New_BoutStart{Fish(i)}))~= (cell2mat(New_BoutStart{Fish(i)}(2)));
                New_BoutStart_copy{Fish(i)}(Bout_After_Esc)=[];
                New_idx{Fish(i)}(Bout_After_Esc)=[];
            catch
                
                warning('Index exceeds the number of array elements (1).');
                display(['Only one small bout before Stim- No Swim Fish ' num2str(i)]);
                New_BoutStart_copy{Fish(i)}=[]
                New_idx{Fish(i)}=[];
            end;
            
            
        else if  FirstBoutStart >= Stim_Timing; % eliminate bouts after stimlus
                
                Bout_to_delete = (cell2mat(New_BoutStart{Fish(i)}))~= (cell2mat(New_BoutStart{Fish(i)}(1)));
                New_BoutStart_copy{Fish(i)}(Bout_to_delete)=[];
                New_idx{Fish(i)}(Bout_to_delete)=[];
                
            end;
        end;

        %--------------------------------------------------------------------------------------------------%
        % calculate latency
        
        if isempty(cell2mat(New_BoutStart_copy{Fish(i)}));
            Latency(n , Fish(i))= NaN;
        else
            Latency(n , Fish(i))= (cell2mat(New_BoutStart_copy{Fish(i)})- 127)/(unique([datasetStim.fps]))* 1000;
        end;
        %--------------------------------------------------------------------------------------------------%
        clear Stim_Timing FirstBoutStart
        
    end;
    
    
    %% working with NEW index

    for i = 1:length(Fish)
    
        for l= 1:length(New_idx{Fish(i)})
            
            %--------------------------------------------------------------------------------------------------%
            % Correcte the tracking data, pick the right Cbend
            if numel([datasetStim(New_idx{Fish(i)}).Bend_Amplitude])==0;
               
                Cbend(n , Fish(i))= NaN;
               
                %pick the Max Amplitude and find position of Cbend
            else if numel([datasetStim(New_idx{Fish(i)}).Bend_Amplitude])> 1;
                
                Max_Amplitude = max(abs([datasetStim(New_idx{Fish(i)}).Bend_Amplitude(:)]));
                
                %if the Maxi amplitude is last bout, display error
                if abs([datasetStim(New_idx{Fish(i)}).Bend_Amplitude(end)])== Max_Amplitude;
                    [datasetStim(New_idx{Fish(i)}).Bend_Amplitude(end)]= [];
                    [datasetStim(New_idx{Fish(i)}).Bend_Timing(end)]=[];
                    disp(['Max Amplitude is last bout--error' 'Fish' num2str(i)]);
                    New_Max_Amplitude= max(abs([datasetStim(New_idx{Fish(i)}).Bend_Amplitude(:)]));
                else
                    New_Max_Amplitude= Max_Amplitude;
                end;
                
                Cbend_Pos= find(abs([datasetStim(New_idx{Fish(i)}).Bend_Amplitude(:)])== New_Max_Amplitude);
                
                Cbend(n , Fish(i))=57.2958* (abs([datasetStim(New_idx{Fish(i)}).Bend_Amplitude(Cbend_Pos)]));
                end;  
            end;
            %--------------------------------------------------------------------------------------------------%
            % Calculate parameters for n stimulus and make matrix
            % Case all : all fishes
            
              
%                 BoutDuration(n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).BoutDuration;
%                 
%                 NumberOfOscillations(n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).NumberOfOscillations;
%                 
%                 Distance(n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).TotalDistance;
%                 
%                 Speed(n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).Speed;
%                 
%                 %TBF{n , Fish(i)} = datasetStim(New_idx{Fish(i)}(l)).InstantaneousTBF;
%                 
%                 mTBF(n , Fish(i))= median([datasetStim(New_idx{Fish(i)}(l)).BoutDuration]/[datasetStim(New_idx{Fish(i)}(l)).NumberOfOscillations]);
% 
%                 if length(datasetStim(New_idx{Fish(i)}(l)).Bend_Amplitude(Cbend_Pos:end)) > 1 ;
% 
%                     Counterbend(n , Fish(i)) = 57.2958*(abs([datasetStim(New_idx{Fish(i)}(l)).Bend_Amplitude(Cbend_Pos+1)]));
%                 else
%                     Counterbend(n , Fish(i)) = NaN;
%                 end

                
        
            % Case 1 : Normal Escape
            
            if Latency(n , Fish(i))< 30 && abs(Cbend(n , Fish(i)))> 60;
                
                display(['Normal Escape Fish ' num2str(i)]);

                Latency_NorEsc(n , Fish(i))= Latency(n , Fish(i));
                
                Cbend_NorEsc(n , Fish(i)) = abs(Cbend(n , Fish(i)));
              
                BoutDuration_NorEsc(n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).BoutDuration;
                
                NumberOfOscillations_NorEsc(n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).NumberOfOscillations;
                
                Distance_NorEsc(n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).TotalDistance;
                
                Speed_NorEsc(n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).Speed;
                
                TBF1_NorEsc(n , Fish(i)) = mean([datasetStim(New_idx{Fish(i)}(l)).InstantaneousTBF(1:2)]);
                
                mTBF_NorEsc(n , Fish(i))= median([datasetStim(New_idx{Fish(i)}(l)).InstantaneousTBF]);
                
            
                if length(datasetStim(New_idx{Fish(i)}(l)).Bend_Amplitude(Cbend_Pos:end)) > 1 ;

                    Counterbend_NorEsc(n , Fish(i)) = 57.2958*(abs([datasetStim(New_idx{Fish(i)}(l)).Bend_Amplitude(Cbend_Pos+1)]));
                else
                    Counterbend_NorEsc(n , Fish(i)) = NaN;
                end
                
                            %Distance
                            output_Distance(i).Variable=['Escape_Distance'];
                            output_Distance(i).Clutch = datasetStim(New_idx{Fish(i)}(l)).NTrial;
                            output_Distance(i).Fish= Fish(i);
                            output_Distance(i).FishGeno = datasetStim(New_idx{Fish(i)}(l)).Genotype;
                            output_Distance(i).Stim1= Distance_NorEsc(1,Fish(i));
                            output_Distance(i).Stim2= Distance_NorEsc(2,Fish(i));
                            output_Distance(i).Stim3= Distance_NorEsc(3,Fish(i));
                            output_Distance(i).Stim4= Distance_NorEsc(4,Fish(i));
                            output_Distance(i).Stim5= Distance_NorEsc(5,Fish(i));
                            output_Distance(i).Stim6= Distance_NorEsc(6,Fish(i));
                            output_Distance(i).Stim7= Distance_NorEsc(7,Fish(i));
                            output_Distance(i).Stim8= Distance_NorEsc(8,Fish(i));
                            output_Distance(i).Stim9= Distance_NorEsc(9,Fish(i));
                            output_Distance(i).Stim10= Distance_NorEsc(10,Fish(i));
                
                            %Duration
                            output_Duration(i).Variable=['Escape_Duration'];
                            output_Duration(i).Clutch = datasetStim(New_idx{Fish(i)}(l)).NTrial;
                            output_Duration(i).Fish= Fish(i);
                            output_Duration(i).FishGeno = datasetStim(New_idx{Fish(i)}(l)).Genotype;                           
                            output_Duration(i).Stim1= BoutDuration_NorEsc(1,Fish(i));
                            output_Duration(i).Stim2= BoutDuration_NorEsc(2,Fish(i));
                            output_Duration(i).Stim3= BoutDuration_NorEsc(3,Fish(i));
                            output_Duration(i).Stim4= BoutDuration_NorEsc(4,Fish(i));
                            output_Duration(i).Stim5= BoutDuration_NorEsc(5,Fish(i));
                            output_Duration(i).Stim6= BoutDuration_NorEsc(6,Fish(i));
                            output_Duration(i).Stim7= BoutDuration_NorEsc(7,Fish(i));
                            output_Duration(i).Stim8= BoutDuration_NorEsc(8,Fish(i));
                            output_Duration(i).Stim9= BoutDuration_NorEsc(9,Fish(i));
                            output_Duration(i).Stim10= BoutDuration_NorEsc(10,Fish(i));
                            
                            %Speed
                            output_Speed(i).Variable=['Escape_Speed'];
                            output_Speed(i).Clutch = datasetStim(New_idx{Fish(i)}(l)).NTrial;
                            output_Speed(i).Fish= Fish(i);
                            output_Speed(i).FishGeno = datasetStim(New_idx{Fish(i)}(l)).Genotype;
                            output_Speed(i).Stim1= Speed_NorEsc(1,Fish(i));
                            output_Speed(i).Stim2= Speed_NorEsc(2,Fish(i));
                            output_Speed(i).Stim3= Speed_NorEsc(3,Fish(i));
                            output_Speed(i).Stim4= Speed_NorEsc(4,Fish(i));
                            output_Speed(i).Stim5= Speed_NorEsc(5,Fish(i));
                            output_Speed(i).Stim6= Speed_NorEsc(6,Fish(i));
                            output_Speed(i).Stim7= Speed_NorEsc(7,Fish(i));
                            output_Speed(i).Stim8= Speed_NorEsc(8,Fish(i));
                            output_Speed(i).Stim9= Speed_NorEsc(9,Fish(i));
                            output_Speed(i).Stim10= Speed_NorEsc(10,Fish(i));
                            
                            %NumOfOsc
                            output_NumOfOsc(i).Variable=['Escape_NumOfOsc'];
                            output_NumOfOsc(i).Clutch = datasetStim(New_idx{Fish(i)}(l)).NTrial;
                            output_NumOfOsc(i).Fish= Fish(i);
                            output_NumOfOsc(i).FishGeno = datasetStim(New_idx{Fish(i)}(l)).Genotype;
                            
                            output_NumOfOsc(i).Stim1= NumberOfOscillations_NorEsc(1,Fish(i));
                            output_NumOfOsc(i).Stim2= NumberOfOscillations_NorEsc(2,Fish(i));
                            output_NumOfOsc(i).Stim3= NumberOfOscillations_NorEsc(3,Fish(i));
                            output_NumOfOsc(i).Stim4= NumberOfOscillations_NorEsc(4,Fish(i));
                            output_NumOfOsc(i).Stim5= NumberOfOscillations_NorEsc(5,Fish(i));
                            output_NumOfOsc(i).Stim6= NumberOfOscillations_NorEsc(6,Fish(i));
                            output_NumOfOsc(i).Stim7= NumberOfOscillations_NorEsc(7,Fish(i));
                            output_NumOfOsc(i).Stim8= NumberOfOscillations_NorEsc(8,Fish(i));
                            output_NumOfOsc(i).Stim9= NumberOfOscillations_NorEsc(9,Fish(i));
                            output_NumOfOsc(i).Stim10= NumberOfOscillations_NorEsc(10,Fish(i));
                            
                            %TBF1
                             output_TBF1(i).Variable=['Escape_TBF1'];
                            output_TBF1(i).Clutch = datasetStim(New_idx{Fish(i)}(l)).NTrial;
                            output_TBF1(i).Fish= Fish(i);
                            output_TBF1(i).FishGeno = datasetStim(New_idx{Fish(i)}(l)).Genotype;
                            
                            output_TBF1(i).Stim1= TBF1_NorEsc(1,Fish(i));
                            output_TBF1(i).Stim2= TBF1_NorEsc(2,Fish(i));
                            output_TBF1(i).Stim3= TBF1_NorEsc(3,Fish(i));
                            output_TBF1(i).Stim4= TBF1_NorEsc(4,Fish(i));
                            output_TBF1(i).Stim5= TBF1_NorEsc(5,Fish(i));
                            output_TBF1(i).Stim6= TBF1_NorEsc(6,Fish(i));
                            output_TBF1(i).Stim7= TBF1_NorEsc(7,Fish(i));
                            output_TBF1(i).Stim8= TBF1_NorEsc(8,Fish(i));
                            output_TBF1(i).Stim9= TBF1_NorEsc(9,Fish(i));
                            output_TBF1(i).Stim10= TBF1_NorEsc(10,Fish(i));
%                             
                            %mTBF
                            output_mTBF(i).Variable=['Escape_mTBF'];
                            output_mTBF(i).Clutch = datasetStim(New_idx{Fish(i)}(l)).NTrial;
                            output_mTBF(i).Fish= Fish(i);
                            output_mTBF(i).FishGeno = datasetStim(New_idx{Fish(i)}(l)).Genotype;
                            
                            output_mTBF(i).Stim1= mTBF_NorEsc(1,Fish(i));
                            output_mTBF(i).Stim2= mTBF_NorEsc(2,Fish(i));
                            output_mTBF(i).Stim3= mTBF_NorEsc(3,Fish(i));
                            output_mTBF(i).Stim4= mTBF_NorEsc(4,Fish(i));
                            output_mTBF(i).Stim5= mTBF_NorEsc(5,Fish(i));
                            output_mTBF(i).Stim6= mTBF_NorEsc(6,Fish(i));
                            output_mTBF(i).Stim7= mTBF_NorEsc(7,Fish(i));
                            output_mTBF(i).Stim8= mTBF_NorEsc(8,Fish(i));
                            output_mTBF(i).Stim9= mTBF_NorEsc(9,Fish(i));
                            output_mTBF(i).Stim10= mTBF_NorEsc(10,Fish(i));
                            
                            %Cbend
                            output_Cbend(i).Variable=['Escape_Cbend'];
                            output_Cbend(i).Clutch = datasetStim(New_idx{Fish(i)}(l)).NTrial;
                            output_Cbend(i).Fish= Fish(i);
                            output_Cbend(i).FishGeno = datasetStim(New_idx{Fish(i)}(l)).Genotype;
                            
                            output_Cbend(i).Stim1= Cbend_NorEsc(1,Fish(i));
                            output_Cbend(i).Stim2= Cbend_NorEsc(2,Fish(i));
                            output_Cbend(i).Stim3= Cbend_NorEsc(3,Fish(i));
                            output_Cbend(i).Stim4= Cbend_NorEsc(4,Fish(i));
                            output_Cbend(i).Stim5= Cbend_NorEsc(5,Fish(i));
                            output_Cbend(i).Stim6= Cbend_NorEsc(6,Fish(i));
                            output_Cbend(i).Stim7= Cbend_NorEsc(7,Fish(i));
                            output_Cbend(i).Stim8= Cbend_NorEsc(8,Fish(i));
                            output_Cbend(i).Stim9= Cbend_NorEsc(9,Fish(i));
                            output_Cbend(i).Stim10= Cbend_NorEsc(10,Fish(i));
                            
                            %Counterbend
                            output_Counterbend(i).Variable=['Escape_Counterbend'];
                            output_Counterbend(i).Clutch = datasetStim(New_idx{Fish(i)}(l)).NTrial;
                            output_Counterbend(i).Fish= Fish(i);
                            output_Counterbend(i).FishGeno = datasetStim(New_idx{Fish(i)}(l)).Genotype;
                            
                            output_Counterbend(i).Stim1= Counterbend_NorEsc(1,Fish(i));
                            output_Counterbend(i).Stim2= Counterbend_NorEsc(2,Fish(i));
                            output_Counterbend(i).Stim3= Counterbend_NorEsc(3,Fish(i));
                            output_Counterbend(i).Stim4= Counterbend_NorEsc(4,Fish(i));
                            output_Counterbend(i).Stim5= Counterbend_NorEsc(5,Fish(i));
                            output_Counterbend(i).Stim6= Counterbend_NorEsc(6,Fish(i));
                            output_Counterbend(i).Stim7= Counterbend_NorEsc(7,Fish(i));
                            output_Counterbend(i).Stim8= Counterbend_NorEsc(8,Fish(i));
                            output_Counterbend(i).Stim9= Counterbend_NorEsc(9,Fish(i));
                            output_Counterbend(i).Stim10= Counterbend_NorEsc(10,Fish(i));
                            
                            %Latency
                            output_Latency(i).Variable=['Escape_Latency'];
                            output_Latency(i).Clutch = datasetStim(New_idx{Fish(i)}(l)).NTrial;
                            output_Latency(i).Fish= Fish(i);
                            output_Latency(i).FishGeno = datasetStim(New_idx{Fish(i)}(l)).Genotype;
                            
                            output_Latency(i).Stim1= Latency_NorEsc(1,Fish(i));
                            output_Latency(i).Stim2= Latency_NorEsc(2,Fish(i));
                            output_Latency(i).Stim3= Latency_NorEsc(3,Fish(i));
                            output_Latency(i).Stim4= Latency_NorEsc(4,Fish(i));
                            output_Latency(i).Stim5= Latency_NorEsc(5,Fish(i));
                            output_Latency(i).Stim6= Latency_NorEsc(6,Fish(i));
                            output_Latency(i).Stim7= Latency_NorEsc(7,Fish(i));
                            output_Latency(i).Stim8= Latency_NorEsc(8,Fish(i));
                            output_Latency(i).Stim9= Latency_NorEsc(9,Fish(i));
                            output_Latency(i).Stim10= Latency_NorEsc(10,Fish(i));

            end;
            

            
%             % Case 2 : Long latency  VS genotype?
%     
%             if Latency(n , Fish(i))> 50 && abs(Cbend(n , Fish(i)))> 50;
%                 
%                 display(['Long latency Fish ' num2str(i)]);
%                 
%                 Latency_Longlat(n , Fish(i))= Latency(n , Fish(i));
%                 
%                 Cbend_Longlat(n , Fish(i)) = abs(Cbend(n , Fish(i)));
%                 
%                 BoutDuration_Longlat(n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).BoutDuration;
%                 
%                 NumberOfOscillations_Longlat(n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).NumberOfOscillations;
%                 
%                 Distance_Longlat(n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).TotalDistance;
%                 
%                 Speed_Longlat(n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).Speed;
%                 
%                 mTBF_Longlat(n , Fish(i))= mean([datasetStim(New_idx{Fish(i)}(l)).InstantaneousTBF]);
%                 
%                 if length(datasetStim(New_idx{Fish(i)}(l)).Bend_Amplitude(Cbend_Pos:end)) > 1 ;
%                     
%                     Counterbend_Longlat(n , Fish(i)) = 57.2958*[datasetStim(New_idx{Fish(i)}(l)).Bend_Amplitude(Cbend_Pos+1)];
%                 else
%                     Counterbend_Longlat(n , Fish(i)) = NaN;
%                 end;
%             end;
%             
%             
%             
%             % Case 3 : Small Escape  VS genotype?
%             
%             if Latency(n , Fish(i))< 50 && abs(Cbend(n , Fish(i)))< 50;
%                 
%                 display(['Small Escape Fish ' num2str(i)]);
%                 
%                 Latency_smallEsc (n , Fish(i))= Latency(n , Fish(i));
%                 
%                 Cbend_smallEsc (n , Fish(i)) = abs(Cbend(n , Fish(i)));
%                 
%                 BoutDuration_smallEsc (n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).BoutDuration;
%                 
%                 NumberOfOscillations_smallEsc (n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).NumberOfOscillations;
%                 
%                 Distance_smallEsc (n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).TotalDistance;
%                 
%                 Speed_smallEsc (n , Fish(i)) = datasetStim(New_idx{Fish(i)}(l)).Speed;
%                 
%                 TailAngle_smallEsc{i}=57.2958*[datasetStim(New_idx{Fish(i)}(l)).TailAngle_smoothed];
%                 
%                 mTBF_smallEsc (n , Fish(i)) = mean([datasetStim(New_idx{Fish(i)}(l)).InstantaneousTBF]);
%    
%                 if length(datasetStim(New_idx{Fish(i)}(l)).Bend_Amplitude(Cbend_Pos:end)) > 1 ;
%                     
%                     Counterbend_smallEsc(n , Fish(i)) = 57.2958*[datasetStim(New_idx{Fish(i)}(l)).Bend_Amplitude(Cbend_Pos+1)];
%                 else
%                     Counterbend_smallEsc(n , Fish(i)) = NaN;
%                 end
%                 
%             end;
%             
%             
%             % Case 4 : No Escape
%             
%             if Latency(n , Fish(i))> 50 && abs(Cbend(n , Fish(i)))< 50;
%                 
%                 display(['No Escape Fish ' num2str(i)]);
%                 
%                 BoutDuration(n , Fish(i)) = NaN;
%                 
%                 NumberOfOscillations(n , Fish(i)) = NaN;
%                 
%                 Distance(n , Fish(i)) = NaN;
%                 
%                 Speed(n , Fish(i)) = NaN;
% 
%                 mTBF(n , Fish(i))= NaN;
% 
%                 Counterbend(n , Fish(i)) = NaN;
               
            %end;
            %--------------------------------------------------------------------------------------------------%
            
        end;
        
        clear diff_Angle New_MovePosition New_Timing Stim_Timing ;
        
    end;
     
   
    
end;


output_Distance= struct2table(output_Distance);
writetable(output_Distance);


output_Duration= struct2table(output_Duration);
writetable(output_Duration);

output_Speed= struct2table(output_Speed);
writetable(output_Speed);

output_NumOfOsc= struct2table(output_NumOfOsc);
writetable(output_NumOfOsc);

output_mTBF= struct2table(output_mTBF);
writetable(output_mTBF);

output_TBF1= struct2table(output_TBF1);
writetable(output_TBF1);

output_Cbend= struct2table(output_Cbend);
writetable(output_Cbend);

output_Counterbend= struct2table(output_Counterbend);
writetable(output_Counterbend);

output_Latency= struct2table(output_Latency);
writetable(output_Latency);

%% mean stat
EffectPercentage= struct('Distance',[],'BoutDuration',[],'Speed',[], 'NumOfOsc',[], 'mTBF',[], 'TBF1',[], 'Latency',[], 'Cbend',[],'Counterbend',[]);
EffectPercentage.Distance=EffectPercentageEscape(Distance_NorEsc,fish_Homo,fish_WT)
EffectPercentage.BoutDuration=EffectPercentageEscape(BoutDuration_NorEsc,fish_Homo,fish_WT)
EffectPercentage.Speed=EffectPercentageEscape(Speed_NorEsc,fish_Homo,fish_WT)
EffectPercentage.NumOfOsc=EffectPercentageEscape(NumberOfOscillations_NorEsc,fish_Homo,fish_WT)
EffectPercentage.mTBF=EffectPercentageEscape(mTBF_NorEsc,fish_Homo,fish_WT)
EffectPercentage.TBF1=EffectPercentageEscape(TBF1_NorEsc,fish_Homo,fish_WT)
EffectPercentage.Latency=EffectPercentageEscape(Latency_NorEsc,fish_Homo,fish_WT)
EffectPercentage.Cbend=EffectPercentageEscape(Cbend_NorEsc,fish_Homo,fish_WT)
EffectPercentage.Counterbend=EffectPercentageEscape(Counterbend_NorEsc,fish_Homo,fish_WT)

EffectPercentage= struct2table(EffectPercentage);
writetable(EffectPercentage,'Cbend60_EffectPercentage.xls')

save('Cbend60_EscapeOverview_5manip_meanWorkspace.mat')
%% Mean Per FISH Subplot for all parameters

h1=figure(1)

subplot(2,4,1)
title('Distance (mm) ');hold on;
scatter_meanPerFish_WTvsHomo_filled(Distance_NorEsc,fish_Homo,fish_WT);hold on;
ylabel('Distance (mm)');
%yticks(4:2:14);
%ylim([4 14]);
hold off;
 
subplot(2,4,2)
title('Duration (s) ');hold on;
scatter_meanPerFish_WTvsHomo_filled(BoutDuration_NorEsc,fish_Homo,fish_WT);hold on;
ylabel('Duration (s)');
%yticks(O:0.1:0.6);
%ylim([0 0.6]);
hold off;
 
 
subplot(2,4,3)
title('Speed (mm/s) ');hold on;
scatter_meanPerFish_WTvsHomo_filled(Speed_NorEsc,fish_Homo,fish_WT);hold on;
ylabel('Speed (mm/s)');
%yticks(10:10:60);
%ylim([10 60]);
hold off;

subplot(2,4,4)
title('# Of Oscillations');hold on;
scatter_meanPerFish_WTvsHomo_filled(NumberOfOscillations_NorEsc,fish_Homo,fish_WT);hold on;
ylabel('# Of Oscillations');
% yticks(2:2:18);
% ylim([2 18]);
hold off;
 
 
subplot(2,4,5)
title('mTBF(Hz)');hold on;
scatter_meanPerFish_WTvsHomo_filled(mTBF_NorEsc,fish_Homo,fish_WT);hold on;
ylabel('Tail Beat Frequency (Hz)');
% yticks(20:5:60);
% ylim([20 60]);
hold off;
 
%subplot(2,5,6)
% title('TBF1(Hz)');hold on;
% scatter_meanPerFish_WTvsHomo_filled(TBF1_NorEsc,fish_Homo,fish_WT);hold on;
% ylabel('TBF1(Hz)'); 
% %ylim([0 20]);
% hold off;
 
subplot(2,4,6)
title('Latency (ms)');hold on;% MEAN plot
scatter_meanPerFish_WTvsHomo_filled(Latency_NorEsc,fish_Homo,fish_WT);hold on;
ylabel('Latency (ms)');
% yticks(0:2:16);
% ylim([0 16]);
hold off;
 
subplot(2,4,7)
title('Cbend (Degree) ');hold on;
scatter_meanPerFish_WTvsHomo_filled(Cbend_NorEsc,fish_Homo,fish_WT);hold on;
ylabel('Cbend (Degree)'); 
% yticks(70:10:120);
% ylim([70 120]);
hold off;
 
subplot(2,4,8)
title('Counterbend (Degree) ');hold on;
scatter_meanPerFish_WTvsHomo_filled(Counterbend_NorEsc,fish_Homo,fish_WT);hold on;
ylabel('Counterbend (Degree)'); 
% yticks(20:10:80);
% ylim([20 80]);
hold off;

saveas(h1,['Cbend60_EscapeOverview_mean_5manip_errorbar.fig'])
%saveas(h1,['Cbend60_EscapeOverview_mean_5manip.epsc'])
%saveas(h1,['Cbend60_EscapeOverview_mean_5manip.pdf'])


%% Median Per FISH Subplot for all parameters
% close all
% h1=figure(1)
%  
% subplot(2,5,1)
% title('Distance (mm) ');hold on;
% scatter_medianPerFish_WTvsHomo_filled(Distance_NorEsc,fish_Homo,fish_WT);hold on;
% ylabel('Distance (mm)');
% %ylim([0 20]);
% hold off;
%  
% subplot(2,5,2)
% title('Duration (s) ');hold on;
% scatter_medianPerFish_WTvsHomo_filled(BoutDuration_NorEsc,fish_Homo,fish_WT);hold on;
% ylabel('Duration (s)');
% %ylim([0.1 0.7]);
% hold off;
%  
%  
% subplot(2,5,3)
% title('Speed (mm/s) ');hold on;
% scatter_medianPerFish_WTvsHomo_filled(Speed_NorEsc,fish_Homo,fish_WT);hold on;
% ylabel('Speed (mm/s)');
% %ylim([0 20]);
% hold off;
%  
% subplot(2,5,4)
% title('Number of Oscillations(n) ');hold on;
% scatter_medianPerFish_WTvsHomo_filled(NumberOfOscillations_NorEsc,fish_Homo,fish_WT);hold on;
% ylabel('Number of Oscillations(n)');
% %ylim([0 20]);
% hold off;
% 
% 
% subplot(2,5,5)
% title('mTBF(Hz)');hold on;
% scatter_medianPerFish_WTvsHomo_filled(mTBF_NorEsc,fish_Homo,fish_WT);hold on;
% ylabel('mTBF(Hz)');
% %ylim([0 20]);
% hold off;
%  
% subplot(2,5,6)
% title('TBF1(Hz)');hold on;
% scatter_medianPerFish_WTvsHomo_filled(TBF1_NorEsc,fish_Homo,fish_WT);hold on;
% ylabel('TBF1(Hz)'); 
% %ylim([0 20]);
% hold off;
%  
% subplot(2,5,7)
% title('Latency (ms)');hold on;% MEDIAN plot
% scatter_medianPerFish_WTvsHomo_filled(Latency_NorEsc,fish_Homo,fish_WT);hold on;
% ylabel('Latency (ms)'); 
% ylim([0 16]);
% hold off;
%  
% subplot(2,5,8)
% title('Cbend (degree) ');hold on;
% scatter_medianPerFish_WTvsHomo_filled(Cbend_NorEsc,fish_Homo,fish_WT);hold on;
% ylabel('Cbend (Deg.)'); 
% %ylim([0 20]);
% hold off;
%  
% subplot(2,5,9)
% title('Counterbend (degree) ');hold on;
% scatter_medianPerFish_WTvsHomo_filled(Counterbend_NorEsc,fish_Homo,fish_WT);hold on;
% ylabel('Counterbend (Deg.)'); 
% %ylim([0 20]);
% hold off;
%  
% saveas(h1,['EscapeOverview_median.fig'])
% saveas(h1,['EscapeOverview_median.epsc'])

%% plot Amplitude by TBF
% idx_G2=find([datasetStim.Genotype] == 2)
% 
% idx_G0=find([datasetStim.Genotype] == 0)
% h1=figure(1)
% for a= 1: length(idx_G2)
%     
% 
% plot([datasetStim(idx_G2(a)).InstantaneousTBF],[datasetStim(idx_G2(a)).AmplitudeOfAllBends],'O');
% hold on;
% 
% end
% hold off
% 
% h2=figure(2)
% for a= 1: length(idx_G0)
%     
% 
% plot([datasetStim(idx_G0(a)).InstantaneousTBF],[datasetStim(idx_G0(a)).AmplitudeOfAllBends],'O');
% hold on;
% 
% end
% hold off





