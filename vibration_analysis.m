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

%% 3. AI Feature Extraction (Statistical Analysis)
% Calculating key indicators for the AI decision model
rms_normal = rms(normal_vibration);
rms_faulty = rms(faulty_vibration);

kurt_normal = kurtosis(normal_vibration);
kurt_faulty = kurtosis(faulty_vibration);

% Displaying analysis results
fprintf('\n--- Diagnostic Feature Results ---\n');
fprintf('Normal -> RMS: %.4f | Kurtosis: %.4f\n', rms_normal, kurt_normal);
fprintf('Faulty -> RMS: %.4f | Kurtosis: %.4f\n', rms_faulty, kurt_faulty);

%% 4. Automated Decision Logic (Basic AI Classifier)
% Setting a threshold for predictive maintenance alerts
rms_threshold = 0.15;

if rms_faulty > rms_threshold
    fprintf('\nSTATUS: [!!!] FAULT DETECTED. Maintenance Required.\n');
else
    fprintf('\nSTATUS: [OK] Motor is operating within healthy limits.\n');
end


%% 6. AI Diagnostic Dashboard (Bar Chart Version)
% Professional visualization of AI features using bar charts
% (Yapay zeka özelliklerinin sütun grafikleriyle profesyonel görselleştirmesi)

figure(2);
set(gcf, 'Name', 'AI Feature Analysis Dashboard', 'Color', 'w');

% --- Subplot 1: RMS (Energy) Comparison ---
subplot(1,2,1);
bar_data_rms = [rms_normal, rms_faulty];
b1 = bar(bar_data_rms, 'FaceColor', 'flat');
b1.CData(1,:) = [0 0.5 0]; % Healthy -> Green
b1.CData(2,:) = [0.8 0 0]; % Faulty -> Red

title('Vibration Energy (RMS)', 'FontSize', 12);
xticklabels({'Healthy', 'Faulty'});
ylabel('Amplitude (g)');
grid on;

% --- Subplot 2: Kurtosis (Impact) Comparison ---
subplot(1,2,2);
bar_data_kurt = [kurt_normal, kurt_faulty];
b2 = bar(bar_data_kurt, 'FaceColor', 'flat');
b2.CData(1,:) = [0 0.5 0]; % Healthy -> Green
b2.CData(2,:) = [0.8 0 0]; % Faulty -> Red

title('Signal Impact (Kurtosis)', 'FontSize', 12);
xticklabels({'Healthy', 'Faulty'});
ylabel('Value');
grid on;

% --- Add a Main Title to the Dashboard ---
sgtitle('AI-Based Motor Health Diagnosis Report', 'FontSize', 16, 'FontWeight', 'bold');

% Save the dashboard as an image for GitHub
saveas(gcf, 'ai_analysis_dashboard.png');
fprintf('\n>>> AI Bar Chart Dashboard saved as ai_analysis_dashboard.png <<<\n');
