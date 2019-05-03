#!/usr/bin/env python

import pandas as pd
import matplotlib.pyplot as plt
import sys

ROOM_PRESSURE = 14.6959 # room pressure in psi

def calibrate_pressure(adc_val):
    Pmin    = ROOM_PRESSURE # minimum pressure in psi
    Pmax    = Pmin + 100    # maximum pressure in psi
    Vsupply = 5.0           # supply voltage

    Vout = float(adc_val) * 5.0 / 1023.0

    # calculate output pressure
    Papplied = (Vout - 0.1 * Vsupply) * (Pmax - Pmin) / (0.8 * Vsupply) + Pmin
    return Papplied

    

filename = '../data/calibration/flex_200.csv'

if len(sys.argv) == 2:
    filename = sys.argv[1]

df = pd.read_csv(filename)

pressure = df['left_pressure'].apply(calibrate_pressure)


plt.figure()
plt.grid(True)
plt.title(filename)
plt.axvline(color='k')
plt.axhline(color='k')
plt.plot(df['time'], df['left_pwm'], label='left_pwm')
plt.plot(df['time'], df['left_pressure'], label='left_pressure')
plt.plot(df['time'], df['left_flex'], label='left_flex')
plt.plot(df['time'], df['tip_pos_x'] - df['base_pos_x'], label='pos_x')
plt.plot(df['time'], df['tip_pos_y'] - df['base_pos_y'], label='pos_y')
plt.plot(df['time'], pressure, label='actual pressure (psi)')

plt.legend()
plt.show()

