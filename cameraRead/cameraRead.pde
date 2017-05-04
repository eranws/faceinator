import processing.video.*; 
Capture cam; 

void setup() { 
  size(1800, 2000); 
  cam = new Capture(this);
  cam.start();
} 

void draw() { 
  if (cam.available()) { 
    // Reads the new frame
    cam.read();
  } 
  
  PImage p = cam.copy();
  image(p, 0, 0); 

  int w = 100;
  int h = 100;

  int m = 2;
  int n = 3;

  int x = (p.width - n * w)/ 2;
  int y = (p.height - m * h) / 2;

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < m; j++)  {
      int ii = x + i * w;
      int jj = y + j * h;
      color c = getAvg(p, ii, jj, w, h);
      fill(c, 200);
      rect(ii, jj, w, h);
    }
  }
}

color getAvg(PImage p, int x, int y, int w, int h) {

  int r = 0;
  int g = 0;
  int b = 0;

  p.loadPixels();
  for (int i = x; i < w + x; i++) {
    for (int j = y; j < y + h; j++) {
      int cc = p.get(i, j);
      r += red(cc); // get r channel
      g += green(cc); // get r channel
      b += blue(cc); // get r channel
    }
  }

  r /= (w*h);
  g /= (w*h);
  b /= (w*h);

  return color(r, g, b);
}