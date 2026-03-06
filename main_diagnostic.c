/**
 * @file main_diagnostic.c
 * @brief Main loop implementation for motor health monitoring on STM32.
 */

#include "fault_detection.h"
#include <stdio.h>

// Assuming we have a buffer of 1024 samples from an ADC or sensor
float vibration_buffer[1024]; 
float threshold = 0.15f; // Defined from our MATLAB analysis

void process_motor_health(void) {
    // 1. Calculate the real-time energy level
    float current_rms = calculate_rms(vibration_buffer, 1024);

    // 2. Decision Logic based on the 0.15 threshold
    if (current_rms > threshold) {
        // [!!!] FAULT DETECTED
        // Turn on Red LED (PA5) and send UART message
        HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_SET); 
        printf(">>> ALERT: Fault Detected! Maintenance required. <<<\n");
    } else {
        // [OK] HEALTHY
        // Turn off LED and confirm status
        HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, GPIO_PIN_RESET);
        printf("Status: Healthy - Normal operation.\n");
    }
}
