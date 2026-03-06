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

%% 6. AI Feature Table Visualization (Yapay Zeka Özellik Tablosu Görselleştirme)
% Creating a table to display AI results directly on the figure
% (Yapay zeka sonuçlarını doğrudan grafik üzerinde görüntülemek için bir tablo oluşturma)

% Prepare data for the table
% (Tablo için verileri hazırla)
table_data = {
    'Healthy (Normal)', sprintf('%.4f', rms_normal), sprintf('%.4f', kurt_normal);
    'Faulty (Inner Race)', sprintf('%.4f', rms_faulty), sprintf('%.4f', kurt_faulty);
};

% Define column names
% (Sütun adlarını tanımla)
column_names = {'Motor State', 'RMS (Energy)', 'Kurtosis (Peakiness)'};

% Create the table UI element on the existing figure
% (Mevcut grafik üzerinde tablo UI öğesini oluştur)
uitable(figure(1), 'Data', table_data, ...
    'ColumnName', column_names, ...
    'Units', 'Normalized', ...
    'Position', [0.6 0.1 0.35 0.15], ... % Adjust position (x, y, width, height)
    'RowName', []); % Remove row numbers

% Save the final figure as an image for GitHub README
% (GitHub README için final grafiğini bir resim olarak kaydet)
saveas(gcf, 'analysis_results_plot.png');
fprintf('\n>>> Final plot with AI table saved as analysis_results_plot.png <<<\n');
