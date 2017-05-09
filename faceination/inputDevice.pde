interface InputDevice {
  void setup(PApplet pApplet) throws IOException;
  void update();
  int[] read();
}