import processing.serial.*;

import cc.arduino.*;

Arduino arduino;


int w = 100;
int h = 100;
int border = 10;

void setup() {
  //size(2 * w + 3 * border, 2 * h + 3 * border);
  size(340, 230);
  
  // Prints out the available serial ports.
  println(Arduino.list());
  
  // Modify this line, by changing the "0" to the index of the serial
  // port corresponding to your Arduino board (as it appears in the list
  // printed by the line above).
  //arduino = new Arduino(this, Arduino.list()[0], 57600);
  
  // Alternatively, use the name of the serial port corresponding to your
  // Arduino (in double-quotes), as in the following line.
  arduino = new Arduino(this, "/dev/cu.usbmodem1421", 57600);

}

void draw() {
  background(0);
  stroke(255);
  
  for (int i = 0; i <= 5; i++) {
    int v = arduino.analogRead(i);

    int x = i / 2;
    int y = i % 2;
    
    fill (v / 4); // input is 0-1023
    rect(border + (border + w) * x, border + (border + h) * y, w, h);
  }
}