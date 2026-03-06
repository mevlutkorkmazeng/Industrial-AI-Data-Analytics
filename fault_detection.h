#ifndef FAULT_DETECTION_H
#define FAULT_DETECTION_H

/* Motor Durumu Tanımları */
#define MOTOR_HEALTHY 0
#define MOTOR_FAULTY  1

/* Tahmin Fonksiyonu Prototipi */
int predict_motor_health(double rms, double kurtosis);

#endif
