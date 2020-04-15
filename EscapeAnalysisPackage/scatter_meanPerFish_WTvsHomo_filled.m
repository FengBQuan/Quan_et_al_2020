function [] = scatter_meanPerFish_WTvsHomo(Parameter,fish_Homo,fish_WT)
 
%calculation of means vs Genotype
Parameter(isinf(Parameter(:))) = NaN;
 
% Homozygote
meanFishHomo = mean (Parameter(:,fish_Homo), 1,'omitnan');
 

% WT
meanFishWT = mean (Parameter(:,fish_WT), 1,'omitnan');
 
 
 
%scatter plot
xaxisWild = ones(1,length(meanFishWT));
 
xaxisHomo = ones(1,length(meanFishHomo))*2;
 
group = [xaxisWild'; xaxisHomo'];

%%%%% mean of all fish
mean_gp1= mean(meanFishWT,'omitnan');
SEM_gp1= std(meanFishWT,'omitnan')/sqrt(numel(meanFishWT));

mean_gp2= mean(meanFishHomo,'omitnan');
SEM_gp2= std(meanFishHomo,'omitnan')/sqrt(numel(meanFishHomo));
%%%%%  
 
hold on;
sz=10;
scatter(xaxisWild, meanFishWT,sz,'b','filled');
 
scatter(xaxisHomo, meanFishHomo,sz,'r','filled');
jitter2;
 
boxplot([meanFishWT'; meanFishHomo'],group);

%%%%% add mean in boxplot 
plot(1,mean_gp1,'d','LineWidth',2,'MarkerSize',8,...
    'MarkerEdgeColor','k');hold on;
plot(2,mean_gp2,'d','LineWidth',2,'MarkerSize',8,...
    'MarkerEdgeColor','k');hold on;
%%%%% 

errorbar(1, mean_gp1, SEM_gp1,'k');hold on;
errorbar(2, mean_gp2, SEM_gp2,'k');hold on;


% Annotations
% grid();
%ylabel('Bout duration(in sec)'); 
%xlabel('Fish');
xticks([1 2]);hold on;
xlim([0.5 2.5]);
xticklabels({'+/+','-/-'});
%xticklabels({'sst+/+','sst-/-'});
hold off;

end

