class NullDevice implements InputDevice {

  int N = 6;
  int[] values = new int[N]; 

  void setup(PApplet pApplet) {
    //
    values[0] = 0;
    values[1] = 0;
    values[2] = 0;
    values[3] = 0;
    values[4] = 0;
    values[5] = 0;
  }

  void update() {
  }

  int[] read() {
    return values;
  }
}