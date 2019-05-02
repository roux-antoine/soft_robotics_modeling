import pandas as pd
import matplotlib.pyplot as plt


########

def filter(signal):
    filtered_signal = []
    filtered_signal.append(signal[0])
    filtered_signal.append(signal[0])

    for k in range(2, len(signal)-2):
        filtered_signal.append(1/9 * (signal[k-2] + 2*signal[k-1] + 3*signal[k] + 2*signal[k+1] + signal[k+2]))

    filtered_signal.append(signal[-2])
    filtered_signal.append(signal[-1])

    return filtered_signal


########


df = pd.read_csv('flex_80_0.csv')

x = df['tip_pos_x'].values - df['base_pos_x'].values;
y = df['tip_pos_y'].values - df['base_pos_y'].values;
time = df['time'].values

x_filtered = filter(x)
y_filtered = filter(y)

plt.plot(time, x, label='x')
plt.plot(time, y, label='y')
plt.plot(time, x_filtered, label='x_filtered')
plt.plot(time, y_filtered, label='y_filtered')
plt.legend()
plt.show()

plt.plot(x_filtered, y_filtered)
plt.axis('equal')
plt.xlabel('x')
plt.ylabel('y')
plt.show()
