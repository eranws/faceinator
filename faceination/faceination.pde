import processing.serial.*;
import cc.arduino.*;

Arduino arduino;
boolean isRunning = true;

int w = 100;
int h = 100;
int m = 2;
int n = 3;

int border = 10;

// surface size
int sx = n * h + (n+1) * border;
int sy = m * w + (m+1) * border;

int N = 6; // values.length;
int[] values = new int[N]; 

void setup() {
  size(400, 400);
  surface.setResizable(true);
  surface.setSize(sx * 2, sy * 2);

  // Prints out the available serial ports.
  println(Arduino.list());
  // Alternatively, use the name of the serial port corresponding to your
  // Arduino (in double-quotes), as in the following line.
  arduino = new Arduino(this, "/dev/tty.usbmodem1421", 57600);

  readData();
}

void draw() {
  background(0);
  stroke(255);

  if (isRunning) {
    readData();
  }

  int[] sumM = new int [m];
  int[] sumN = new int [n];

  for (int i = 0; i < N; i++) {
    int v = values[i];

    int x = i / m;
    int y = i % m;

    sumM[y] += v;
    sumN[x] += v;

    fill (v); // input is 0-1023
    rect(border + (border + w) * x, border + (border + h) * y, w, h);
  }

  pushMatrix();
  translate(sx, 0);
  for (int i = 0; i < m; i++) {
    // draw sums
    int v = sumM[i] / n;
    fill(v);
    rect(border, border + (border + h) * i, w * n, h);
  }
  popMatrix();

  pushMatrix();
  translate(0, sy);
  for (int i = 0; i < n; i++) {
    // draw sums
    int v = sumN[i] / m;
    fill(v);
    rect(border + (border + w) * i, border, w, h * m);
  }
  popMatrix();
}

void keyPressed() {
  switch(key) {
  case 'f':  // make face
    values[0] = 0;
    values[1] = 100;
    values[2] = 200;
    values[3] = 250;
    values[4] = 0;
    values[5] = 100;
    break;  

  case ' ': //space
    isRunning = !isRunning;
    break;

  default: 
    readData();
    break;
  }
}

void readData() {
  for (int i = 0; i < N; i++) {
    // values[i] = (int)random(256);
    int v = arduino.analogRead(i);
    // if arduino divide by 4
    values[i] = v / 4;
  }
}