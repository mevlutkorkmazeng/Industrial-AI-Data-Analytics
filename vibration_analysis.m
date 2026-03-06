% =========================================================================
% Project: Industrial AI - Motor Fault Diagnosis
% Author: Mevlut Korkmaz
% Description: Feature extraction and automated fault detection using 
%              vibration data from the CWRU Bearing Dataset.
% =========================================================================

clear; clc; close all;

%% 1. Data Loading
% Accessing healthy and faulty datasets stored in the data folder
load('data/97.mat');   % Healthy motor data
load('data/105.mat');  % Motor with inner race fault (0.007")

% Extracting Drive End (DE) time-series vibration data
normal_vibration = X097_DE_time;
faulty_vibration = X105_DE_time;

%% 2. Time-Domain Visualization
% Comparing signals to identify visual patterns
figure('Name', 'Vibration Signal Comparison');

subplot(2,1,1);
plot(normal_vibration(1:1000), 'b');
title('Healthy Motor State (Normal Baseline)');
xlabel('Samples'); ylabel('Amplitude (g)');
grid on;

subplot(2,1,2);
plot(faulty_vibration(1:1000), 'r');
title('Faulty Motor State (Bearing Defect Detected)');
xlabel('Samples'); ylabel('Amplitude (g)');
grid on;
