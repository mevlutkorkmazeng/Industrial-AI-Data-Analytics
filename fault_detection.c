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
