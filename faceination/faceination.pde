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

InputDevice inputDevice;
int inputIndex = 0;

InputDevice[] inputDeviceList = new InputDevice[3];

void setup() {
  size(1400, 1400);
  surface.setResizable(true);
  //  surface.setSize(sx * 2, sy * 2);


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