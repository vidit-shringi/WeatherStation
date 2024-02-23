#!/bin/bash

# Install necessary packages
sudo apt install -y python3-pip
pip3 install Adafruit_DHT tkinter

# Create the Python script
cat << EOF > ~/dht11_reader.py
import tkinter as tk
import Adafruit_DHT
from tkinter import messagebox

# Sensor should be set to Adafruit_DHT.DHT11,
# Adafruit_DHT.DHT22, or Adafruit_DHT.AM2302.
sensor = Adafruit_DHT.DHT11

# The pin which is connected with the sensor will be declared here
pin = 4

class Application(tk.Frame):
    def __init__(self, master=None):
        super().__init__(master)
        self.master = master
        self.pack()
        self.create_widgets()

    def create_widgets(self):
        self.read_button = tk.Button(self)
        self.read_button["text"] = "Read Sensor Data"
        self.read_button["command"] = self.read_sensor_data
        self.read_button.pack(side="top")

        self.quit = tk.Button(self, text="QUIT", fg="red",
                              command=self.master.destroy)
        self.quit.pack(side="bottom")

    def read_sensor_data(self):
        humidity, temperature = Adafruit_DHT.read_retry(sensor, pin)
    
        if humidity is not None and temperature is not None:
            messagebox.showinfo("Info", 'Temp={0:0.1f}*C  Humidity={1:0.1f}%'.format(temperature, humidity))
        else:
            messagebox.showinfo("Info", 'Failed to get reading. Try again!')

root = tk.Tk()
app = Application(master=root)
app.mainloop()
EOF

# Run the Python script
python3 ~/dht11_reader.py
