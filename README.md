# Industrial AI: Predictive Maintenance for Motor Bearings 

This project demonstrates an end-to-end **Condition Monitoring** and **Fault Diagnosis** pipeline. It uses signal processing and statistical feature extraction to detect early-stage motor failures using the CWRU Bearing Dataset.

## 1. Exploratory Data Analysis (EDA)
We analyze vibration signals in the time domain. By comparing a healthy motor with one having an inner race fault, we can visually identify high-amplitude impacts caused by the defect.

![Time Domain Analysis](images/Motor%20Vibration%20Time-Domain%20Analysis.png)

## 2. AI Feature Extraction & Comparison
The raw vibration data is converted into statistical "features" that a Machine Learning model can understand. We specifically focus on:
* **RMS (Root Mean Square):** Represents the overall energy of the vibration.
* **Kurtosis:** Measures the "peakiness" of the signal to detect sharp impacts.

The bar charts below clearly show that the **Faulty Motor** has significantly higher energy and impact levels compared to the **Healthy Motor**.

![AI Feature Dashboard](AI%20Feature%20Analysis%20Dashboard.png)

## 3. Diagnostic Results
Based on our AI-driven analysis, the system successfully differentiates between motor states:

| Feature | Healthy Motor | Faulty Motor | Change |
| :--- | :---: | :---: | :---: |
| **RMS** | 0.0738 | 0.2915 | **+295% Increase** |
| **Kurtosis** | 2.7642 | 5.3959 | **+95% Increase** |

## 4. Automated Decision Logic
The system includes a rule-based classifier:
- **Threshold:** 0.15 RMS
- **Status:** If RMS > Threshold -> **[!!!] FAULT DETECTED**
- This logic enables 24/7 automated monitoring without human intervention.

## 5. Hardware Implementation (C/Embedded)
To bridge the gap between simulation and real-world industrial application, the diagnostic algorithms have been ported to **C code**. This implementation is optimized for microcontrollers such as **STM32**, enabling real-time edge processing.


### Embedded Module Breakdown:
* **`fault_detection.c`**: Contains the core mathematical engine for calculating **RMS** and **Kurtosis** from raw sensor buffers.
* **`main_diagnostic.c`**: Implements the high-level application logic. It integrates with the **STM32 HAL (Hardware Abstraction Layer)** to trigger physical alerts (e.g., toggling a Red LED on GPIO PA5) when an anomaly is detected.

### Transition from Simulation to Reality
By translating MATLAB models into efficient C functions, this project demonstrates a complete workflow for **Industrial AI**: 
1. **Analyze** (MATLAB) -> 2. **Validate** (Simulation) -> 3. **Deploy** (Embedded C).

## 6. Statistical Validation: Why AI?
To prove the necessity of AI, we analyzed the raw data distribution versus the extracted feature space.

![Deep Analysis](ai_deep_analysis_plot.png)

### Analysis Breakdown:
* **Data Overlap (Left):** Raw vibration signals show significant overlap between healthy and faulty states. Traditional amplitude monitoring would result in high false-alarm rates.
* **Feature Space (Right):** By mapping data into the **RMS-Kurtosis plane**, we achieve clear linear separability. The black dashed line represents our **AI Decision Boundary**.

| Approach | Reliability | Efficiency |
| :--- | :---: | :---: |
| Raw Signal Monitoring | Low (High Overlap) | Manual / Inefficient |
| **AI Feature Engineering** | **High (Clear Clusters)** | **Automated / Precise** |


## 7. Machine Learning & AI Reliability
To move beyond basic thresholds, we implemented a supervised learning workflow using the **MATLAB Classification Learner** app. This ensures the system can autonomously adapt to different motor conditions with high precision.

### Feature Space & Methodology
As demonstrated in the **Statistical Validation (Section 6)**, our extracted features (**RMS** and **Kurtosis**) provide perfect **Linear Separability**. This distinct clustering allowed the machine learning models to define a clear decision boundary, ensuring 100% reliable classification without manual tuning.

### Data Preparation (`generate_training_data.m`)
The training dataset was generated using a custom script that segments the raw vibration signals into labeled observations. This process is crucial for "teaching" the AI the difference between motor states.

* **Method:** 120 samples (60 Healthy / 60 Faulty) were extracted.
* **Script:** Detailed logic is available in [generate_training_data.m](./generate_training_data.m).

### Model Performance & Validation
We trained multiple classifiers, including **SVM (Support Vector Machines)**, **KNN**, and **Decision Trees**. Every model achieved **100% Validation Accuracy**.

#### Confusion Matrix Analysis:
The following matrices confirm that our "AI Brain" makes zero mistakes:

| Sample Counts | True Positive Rates | Precision / FDR |
| :---: | :---: | :---: |
| ![Matrix 1](ai_confusion_matrix.png) | ![Matrix 2](ai_confusion_matrix2.png) | ![Matrix 3](ai_confusion_matrix3.png) |

* **Zero False Positives:** The model never incorrectly flags a healthy motor as faulty.
* **Zero False Negatives:** Every single fault is detected instantly.

---
**Author:** [Mevlut Korkmaz](https://github.com/mevlutkorkmazeng)  
*Electrical and Electronics Engineering Student at Ege University*
