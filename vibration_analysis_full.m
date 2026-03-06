% =========================================================================
% Project: Industrial AI Data Analytics
% Module: Exploratory Data Analysis (EDA) - Vibration Signals
% Description: Time-domain comparison of healthy and faulty motor bearings.
% Dataset: CWRU Bearing Dataset (12k Drive End Bearing Fault Data)
% =========================================================================

clear; clc; close all;

%% 1. Data Ingestion
% Load the CWRU Bearing Dataset into the workspace
load('data/97.mat');   % Normal baseline data (Healthy)
load('data/105.mat');  % Inner race fault data (Faulty, 0.007" diameter)

%% 2. Data Preprocessing
% Extract the Drive End (DE) accelerometer time-series data
normal_vibration = X097_DE_time;
faulty_vibration = X105_DE_time;

%% 3. Time-Domain Visualization
% Plot the first 1000 samples for visual comparison
figure('Name', 'Motor Vibration Time-Domain Analysis');

% Subplot 1: Healthy Motor Baseline
subplot(2,1,1);
plot(normal_vibration(1:1000), 'b'); % Blue line for normal state
title('Healthy Motor Vibration (Normal Baseline)');
xlabel('Time (Samples)');
ylabel('Amplitude (g)');
grid on;

% Subplot 2: Faulty Motor (Inner Race Defect)
subplot(2,1,2);
plot(faulty_vibration(1:1000), 'r'); % Red line for anomaly/fault state
title('Faulty Motor Vibration (Inner Race Fault - 0.007")');
xlabel('Time (Samples)');
ylabel('Amplitude (g)');
grid on;

%% 4. Feature Extraction (AI için Sayısal Veri Üretme)
% Calculate RMS (shorthand for vibration energy)
rms_normal = rms(normal_vibration);
rms_faulty = rms(faulty_vibration);

% Calculate Kurtosis (measures the 'peakiness' of the signal)
kurt_normal = kurtosis(normal_vibration);
kurt_faulty = kurtosis(faulty_vibration);

% Display results in the Command Window
fprintf('\n--- AI Feature Comparison ---\n');
fprintf('Normal RMS: %.4f | Faulty RMS: %.4f\n', rms_normal, rms_faulty);
fprintf('Normal Kurtosis: %.4f | Faulty Kurtosis: %.4f\n', kurt_normal, kurt_faulty);

%% 5. Simple AI Decision Logic (Otomatik Karar Mekanizması)
% We set a threshold for RMS to distinguish between healthy and faulty
threshold = 0.15; 

if rms_faulty > threshold
    fprintf('\n>>> ALERT: Fault Detected! Maintenance required. <<<\n');
else
    fprintf('\n>>> Status: Motor is operating normally. <<<\n');
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
