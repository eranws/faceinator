import processing.serial.*;
import cc.arduino.*;

class MockDevice implements InputDevice {
  Arduino arduino;

  int N = 6;
  int[] values = new int[N]; 

  void setup(PApplet pApplet) {
    //
  }

  void update() {
    values[0] = 0; 
    values[1] = 100; 
    values[2] = 200; 
    values[3] = 250; 
    values[4] = 0; 
    values[5] = 100;
  }

  int[] read() {
    return values;
  }
}