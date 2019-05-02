#!/usr/bin/env python

import pandas as pd
import matplotlib.pyplot as plt
import sys


filename = '../data/sys_id/flex_80_1.csv'


if len(sys.argv) == 2:
        filename = sys.argv[1]

df = pd.read_csv(filename)


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
# plt.plot(df['time'], df['right_pwm'], label='right_pwm')
# plt.plot(df['time'], df['right_pressure'], label='right_pressure')
# plt.plot(df['time'], df['right_flex'], label='right_flex')
plt.legend()

plt.figure()
plt.grid(True)
plt.title('position')
plt.plot(df['tip_pos_x'] - df['base_pos_x'], -(df['tip_pos_y'] - df['base_pos_y']), color='r')
plt.axis('equal')
plt.show()
