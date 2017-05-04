import processing.serial.*;

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
  
  readData();
}

void draw() {
  background(0);
  stroke(255);
  
  // readData();

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
    int v = sumM[i] / m;
    fill(v);
    rect(border, border + (border + h) * i, w * n, h);
  }
  popMatrix();

  pushMatrix();
  translate(0, sy);
  for (int i = 0; i < n; i++) {
    // draw sums
    int v = sumN[i] / n;
    fill (v);
    rect(border + (border + w) * i, border, w, h * m);
  }
  popMatrix();

}

void keyPressed() {
  readData();
}

void readData() {
  for (int i = 0; i < N; i++) {
    values[i] = (int)random(256);
    // if arduino divide by 4
  }  
}