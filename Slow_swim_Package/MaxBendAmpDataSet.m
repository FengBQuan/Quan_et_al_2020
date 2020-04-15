function [DatasetPreEscape_GoodSwimmers_MaxBenAmp] = MaxBendAmpDataSet(datasetPerBout)

%% add MaxBendAmp in the superstructure

for a=1:length(datasetPerBout)
    datasetPerBout(a).MaxBendAmp= max(abs([datasetPerBout(a).AmplitudeOfAllBends]));
    datasetPerBout(a).MedianBendAmp= median(abs([datasetPerBout(a).AmplitudeOfAllBends]));
end


DatasetPreEscape_GoodSwimmers_MaxBenAmp= datasetPerBout;   
 

end
