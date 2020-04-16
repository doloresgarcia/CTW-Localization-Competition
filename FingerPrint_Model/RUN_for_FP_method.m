
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%INPUTS:
% % %take the data given for the test
% % FileName   = 'h_Estimated_CTW_train.mat'; %this woule be the file they give us
% % FolderName = 'C:\Users\Dolor\OneDrive\Escritorio\data ICW 2019\CTW2019-PositioningCompetition-master\1_Measured_Data';
% % File       = fullfile(FolderName, FileName);
% % load(File);   % not: load('File')
load('h_Estimated_CTW_VisTest_Cor.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OUTPUT:
%output will be the pred_test values, if wanted to change to only (x,y)..
%take pred_test=pred_tets(:,1:2) after finished.
%there is no shuffling in this code 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
load('r_Position_CTW_Train.mat');
load('values_train.mat');
%% 
h_Estimated_1=h_Estimated(491:499,:,:);
%% 
[toas_test]=Preprocesing(h_Estimated_1); %Calculates ToA spectrum
%% 

[pred_test]=Postprocesing(toas_test,values_test,r_Position); %shifts, max and fingerprinting

csvwrite('FINAL_pred_testvis3.csv',pred_test)