/**
 * @file fault_detection.c
 * @author Mevlut Korkmaz
 * @brief Embedded C implementation for industrial motor fault detection.
 * * This module calculates statistical features like RMS from raw vibration 
 * data to identify mechanical anomalies in real-time.
 */

#include <math.h>

/**
 * @brief Calculates the Root Mean Square (RMS) of a signal buffer.
 * Represents the overall energy level of the motor vibration.
 * * Formula: RMS = sqrt( (1/n) * sum(x_i^2) )
 * * @param signal Pointer to the array of vibration samples.
 * @param length Number of samples in the buffer.
 * @return float The calculated RMS value.
 */
float calculate_rms(float *signal, int length) {
    float sum = 0.0f;
    
    for (int i = 0; i < length; i++) {
        sum += signal[i] * signal[i]; // Accumulate squared values
    }
    
    // Calculate square root of the mean
    return sqrtf(sum / (float)length);
}

/**
 * @brief Calculates the Kurtosis of a signal buffer.
 * Measures the "peakiness" or impulsiveness of the signal to detect impacts.
 * * Formula: K = ( (1/n) * sum( (x_i - mean)^4 ) ) / (std_dev^4)
 * * @param signal Pointer to the vibration sample array.
 * @param length Number of samples.
 * @param mean The average value of the signal (calculated beforehand).
 * @param std_dev The standard deviation of the signal (calculated beforehand).
 * @return float The calculated Kurtosis value.
 */
float calculate_kurtosis(float *signal, int length, float mean, float std_dev) {
    float sum_fourth_power = 0.0f;
    
    for (int i = 0; i < length; i++) {
        float diff = signal[i] - mean;
        // Calculate the 4th moment
        sum_fourth_power += diff * diff * diff * diff;
    }
    
    // The denominator is the 4th power of standard deviation (sigma^4)
    float denominator = std_dev * std_dev * std_dev * std_dev;
    
    // Return Normalized Kurtosis
    return (sum_fourth_power / (float)length) / denominator;
}
