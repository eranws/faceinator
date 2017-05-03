import processing.serial.*;

int w = 100;
int h = 100;
int m = 2;
int n = 3;

int border = 10;

void setup() {
  size(400, 400);
  surface.setResizable(true);
  surface.setSize(n * h + (n+1) * border, m * w + (m+1) * border);
}

void draw() {
  background(0);
  stroke(255);
  
  int N = 6; // values.length;
  int[] values = new int[N]; 
  
  for (int i = 0; i < N; i++) {
    values[i] = (int)random(256);
  }
  
  for (int i = 0; i < N; i++) {
    int v = values[i];
    
    int x = i / 2;
    int y = i % 2;
    
    fill (v / 4); // input is 0-1023
    rect(border + (border + w) * x, border + (border + h) * y, w, h);
  }
}