% =========================================================================
% Project: Industrial AI Data Analytics
% Module: Advanced AI Diagnosis (V2)
% Description: AI-enhanced motor health monitoring using trained ML model.
% =========================================================================

clear; clc; close all;

%% 1. Data Ingestion
load('data/97.mat');   % Healthy baseline
load('data/105.mat');  % Inner race fault

%% 2. Feature Extraction
% Orijinal kodundaki gibi verileri işliyoruz
normal_vibration = X097_DE_time;
faulty_vibration = X105_DE_time;

% Rastgele bir örneklem üzerinden analiz yapalım (Örn: faulty verisi)
current_vibration = faulty_vibration; 
current_rms = rms(current_vibration);
current_kurt = kurtosis(current_vibration);

%% 3. AI Prediction (Eğitilmiş Model Kullanımı)
% Özellikleri modelin okuyabileceği tablo formatına getiriyoruz
input_features = table(current_rms, current_kurt, 'VariableNames', {'RMS', 'Kurtosis'});

% Classification Learner'dan dışa aktardığın fonksiyonu çağırıyoruz
[prediction, score] = predict_motor_health(input_features);
confidence = max(score) * 100;

%% 4. Results & Reporting
fprintf('\n--- AI-Based Diagnostic Result ---\n');
if prediction == '1'
    fprintf('>>> STATUS: FAULT DETECTED! <<<\n');
else
    fprintf('>>> STATUS: MOTOR HEALTHY. <<<\n');
end
fprintf('AI Confidence Level: %.2f%%\n', confidence);
fprintf('RMS Energy: %.4f | Kurtosis: %.4f\n', current_rms, current_kurt);
