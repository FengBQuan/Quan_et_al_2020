%% Clean workspace and load data
close all
clear variables
clc
load("DataSetPreEscape.mat")

%
Fish = unique([datasetPerFish(:).Condition]);
NumberFish=length(Fish);

Fish_temp=Fish; % to use datasetPerFish
FishGeno=([datasetPerFish.Genotype]);
Fish_ID = ([datasetPerFish.Condition]);
NTrial = ([datasetPerFish.NTrial]);

Fish_G2=Fish_temp(find(FishGeno( find( Fish_temp ) )==2));
Fish_G1=Fish_temp(find(FishGeno( find( Fish_temp ) )==1));
Fish_G0=Fish_temp(find(FishGeno( find( Fish_temp ) )==0));

for i=1:NumberFish;
    


allindex{Fish(i)}= find(~([DatasetPreEscape(:).Condition]-Fish(i)));

     for h=1:length(allindex{Fish(i)});
        
        display(['currently processing fish ' num2str(i)])
        display(['currently processing bout number ' num2str(h)])
 
        Bend_Amplitude{Fish(i)}{h} = 57.2958*DatasetPreEscape(allindex{Fish(i)}(h)).Bend_Amplitude;
        MaxAmpPerBout{Fish(i)}{h}=max(abs(Bend_Amplitude{Fish(i)}{h}));
        
%max of first 3 bend amplitudes      
%         if numel([DatasetPreEscape(allindex{Fish(i)}(h)).Bend_Amplitude])<3;
%             First3_Bend_Amplitude{Fish(i)}{h} =0;
%             MaxAmpPerBout{Fish(i)}{h}=0;
%         else 
%         First3_Bend_Amplitude{Fish(i)}{h} = 57.2958*DatasetPreEscape(allindex{Fish(i)}(h)).Bend_Amplitude(1:3);
%         MaxAmpPerBout{Fish(i)}{h}=max(abs(First3_Bend_Amplitude{Fish(i)}{h}));      
%         end 
%give same result as Max of all bends
      
     end
    
end
    
%%
for l=1:length(Fish_G2);
    
    % all WT MaxBendAmplitude 
G2_MaxiBendAmp{l}= cell2mat(MaxAmpPerBout{(Fish_G2(l))});
    % Density calculation
DistriA2 = histc ((G2_MaxiBendAmp{l}),(0:10:180));
if isempty(DistriA2)
densityA_G2{l}= ones(19,1)* nan;
else
densityA_G2{l} = (DistriA2/sum(DistriA2))';    
end

end
DensityA_G2=mean(cell2mat(densityA_G2),2,'omitnan');

for l=1:length(Fish_G0);
    % all WT Maxi BendAmplitude 
 G0_MaxiBendAmp{l}= cell2mat(MaxAmpPerBout{(Fish_G0(l))});
    % Density calculation
DistriA0 = histc ((G0_MaxiBendAmp{l}),(0:10:180));
if isempty(DistriA0)
densityA_G0{l}= ones(19,1)* nan;
else
densityA_G0{l} = (DistriA0/sum(DistriA0))';
end
    
end

DensityA_G0=mean(cell2mat(densityA_G0),2,'omitnan');
%% 
% h1=figure(1); 
% subplot (1,2,1)
% x = linspace(0,180,19)
% plot(x,DensityA_G0', 'ro-');hold on;
% plot(x,DensityA_G2', 'bo-');
% 
% subplot (1,2,2)
% AccuAbs_G2=cumsum(DensityA_G2,1)
% AccuAbs_G0=cumsum(DensityA_G0,1)
% x = linspace(0,180,19)
% plot(x,AccuAbs_G2','bo-');hold on
% plot(x,AccuAbs_G0','ro-');
% 
% saveas(h1,['MaxBendAmpDistribution_PreEscape.fig'])
% save('AnalysisResult_MaxBendAmpDistribution_PreEscape.mat')

%% Calcule mean±sem
Gp1=cell2mat([G2_MaxiBendAmp]);
Gp2=cell2mat([G0_MaxiBendAmp]);
mean_gp1= mean(Gp1,'omitnan');
SEM_gp1= std(Gp1,'omitnan')/sqrt(numel(Gp1));

mean_gp2= mean(Gp2,'omitnan');
SEM_gp2= std(Gp2,'omitnan')/sqrt(numel(Gp2));
[h,p,ci,stats] = ttest2(Gp1,Gp2)