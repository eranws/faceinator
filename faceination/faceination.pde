import processing.serial.*;

int w = 100;
int h = 100;
int border = 10;

void setup() {
  //size(2 * w + 3 * border, 2 * h + 3 * border);
  size(340, 230);
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