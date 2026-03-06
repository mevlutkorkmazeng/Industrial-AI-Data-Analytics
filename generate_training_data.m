% --- Corrected AI Training Dataset Generator ---
num_segments = 60;   
seg_len = 1500;      
training_data = [];

% 1. Sağlıklı Örnekler (Workspace'teki 'normal' değişkenini kullanıyoruz)
for i = 1:num_segments
    start_idx = (i-1)*seg_len + 1;
    segment = normal(start_idx : start_idx + seg_len - 1); % 'normal' olarak güncellendi
    training_data = [training_data; rms(segment), kurtosis(segment), 0];
end

% 2. Arızalı Örnekler (Workspace'teki 'faulty' değişkenini kullanıyoruz)
for i = 1:num_segments
    start_idx = (i-1)*seg_len + 1;
    segment = faulty(start_idx : start_idx + seg_len - 1); % 'faulty' olarak güncellendi
    training_data = [training_data; rms(segment), kurtosis(segment), 1];
end

% 3. Tabloyu Oluştur
T = array2table(training_data, 'VariableNames', {'RMS', 'Kurtosis', 'Status'});
T.Status = categorical(T.Status);
fprintf('>>> Eğitim tablosu "T" başarıyla oluşturuldu! \n');
