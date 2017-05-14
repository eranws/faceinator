import processing.serial.*;
import cc.arduino.*;

class ArduinoDevice implements InputDevice {
  Arduino arduino;

  int N = 6;
  int[] values = new int[N]; 
  
  
  boolean reversePins = true;
  
  void setup(PApplet pApplet) throws IOException {
    // Prints out the available serial ports.
    println(Arduino.list());
    // Alternatively, use the name of the serial port corresponding to your
    // Arduino (in double-quotes), as in the following line.
    arduino = new Arduino(pApplet, "/dev/tty.usbmodem1421", 57600);
  }

  void update() {
    for (int i = 0; i < N; i++) {
      int v = arduino.analogRead(i);
      // divide by 4, arduino input values are 0-1023
      if (reversePins) {
        values[N - 1 - i] = v / 4;
      }
      else {
        values[i] = v / 4;
      }
    }
  }

  int[] read() {
    return values;
  }
}