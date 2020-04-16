%%%%Preprocesing


%run the script for preprocessing values on test set
%save the data




%%%%% Take new data from prepocesed values 
%%Inputs:
%positions of the test data and preprocesed data, the spectrum
function [Position_pred]=Postprocesing(toas_test,values_train,Position_train)

%of ToA per antenna, per measurement.

%Output:
%mean error of all tets points and vector of errors per test point.
%% shifting : 
% This function shifted the value of  the antennas that have odd behaviour
% for the same location. Two parameters can be modified, the prominence of
% the localmax finder.  The output is the spectrum of ToA with some of the
% spectrums shifted.
%% max_principal_path:
% calculates the maximum of the shifted data in the region [-20,30] ns.
%% TrainTest_split
% 10% of the data is separated for test.
%% Fingerprint:
%classical fingerprinting method.
%%

% load('testw.mat'); %this is the spectrum of the prepocesed data for train

% load('r_Position_CTW_Train.mat');
%take two different preprocessed values, do shift take max of shift,
%shuffle and do fingerptinting

parameters=[2 ];
mean_error=[];

for kk=1:1
     ps_db_toas_shifted_test=shifting(parameters(kk),toas_test);
     values_test=max_principal_path(ps_db_toas_shifted_test);
end
%% 
 Position_test=Position_train(1:200,:); % IF YOU WANT TO CHECK THE ERROR WITH TRAIN DATA

%  [mean_error, Position_pred]=fingerPrint(values_test,values_train,Position_test,Position_train);
[Position_pred]=fingerPrint_no_true(values_test,values_train,Position_train);

end
% % 
% % mean(abs(errors))
% % figure, hist(errors,100)


