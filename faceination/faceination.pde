boolean isRunning = true;

int w = 100;
int h = 100;
int m = 2;
int n = 3;

int border = 8;

// surface size
int sx = n * h + (n+1) * border;
int sy = m * w + (m+1) * border;

int N = 6; // values.length;
int[] values = new int[N]; 

InputDevice inputDevice;
int inputIndex = 0;

InputDevice[] inputDeviceList = new InputDevice[3];

void setup() {
  size(1400, 1400);
  surface.setResizable(true);
  //  surface.setSize(sx * 2, sy * 2);
  textAlign(LEFT, TOP);


  try {
    inputDeviceList[0] = new MockDevice();
    inputDeviceList[0].setup(this);
  }
  catch (Exception e) {
  }

  try {
    inputDeviceList[1] = new CameraDevice();
    inputDeviceList[1].setup(this);
  }
  catch (Exception e) {
    inputDeviceList[1] = new NullDevice();
  }

  try {
    inputDeviceList[2] = new ArduinoDevice();
    inputDeviceList[2].setup(this);
  }
  catch (Exception e) {
    inputDeviceList[2] = new NullDevice();
  }

  inputDevice = inputDeviceList[inputIndex];

  readData();
}

void draw() {
  background(0);
  stroke(255);

  if (isRunning) {
    inputDevice.update();
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
    fill(0);
    text(v, border + (border + w) * x, border + (border + h) * y);
    fill(255);
    text(v, 1+border + (border + w) * x, 1+border + (border + h) * y);
  }

  pushMatrix();
  translate(sx, 0);
  translate(border, border);
  for (int i = 0; i < m; i++) {
    // draw sums
    int v = sumM[i] / n;
    fill(v);
    rect(0, 0, w * n, h);
    fill(0);
    text(v, 0, 0);
    fill(255);
    text(v, 1, 1);
    translate(0, border + h);
  }
  popMatrix();

  pushMatrix();
  translate(0, sy);
  translate(border, border);
  for (int i = 0; i < n; i++) {
    // draw sums  
    int v = sumN[i] / m;
    fill(v);
    rect(0, 0, w, h * m);
    fill(0);
    text(v, 0, 0);
    fill(255);
    text(v, 1, 1);
    translate(border + w, 0);
  }
  popMatrix();

  // draw subs
  pushMatrix();
  translate(sx * 2, 0);
  translate(border, border);
  int v1 = constrain(sumM[1] / 3 - sumM[0] / 3, 0, 255);
  fill(v1);
  rect(0, 0, w, h * m + border * (m-1));
  fill(0);
  text(v1, 0, 0);
  fill(255);
  text(v1, 1, 1);
  popMatrix();

  pushMatrix();
  translate(0, sy * 2);
  translate(border, border);
  int v2 = constrain(sumN[1] / 2 - (sumN[0] + sumN[2]) / 4, 0, 255);
  fill(v2);
  rect(0, 0, w * n + border * (n-1), h);
  fill(0);
  text(v2, 0, 0);
  fill(255);
  text(v2, 1, 1);
  popMatrix();

}

void keyPressed() {
  switch(key) {
  case ' ':  // cycle input
    inputIndex++;
    inputIndex %= inputDeviceList.length;
    inputDevice = inputDeviceList[inputIndex];
    isRunning = true;
    break;  

  case 's': //start/stop
    isRunning = !isRunning;
    break;

  default: 
    readData();
    break;
  }
}

void readData() {
  values = inputDevice.read();
}