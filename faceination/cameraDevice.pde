import processing.video.*; 

class CameraDevice implements InputDevice {

  Capture cam; 

  int N = 6;
  int[] values = new int[N]; 

  int surfaceWidth = 640;
  int surfaceHeight = 480;

  int w = 100;
  int h = 100;

  int m = 2;
  int n = 3;

  void setup(PApplet pApplet) {
    cam = new Capture(pApplet, surfaceWidth, surfaceHeight);
    cam.start();
  }

  void update() {

    if (cam.available()) { 
      // Reads the new frame
      cam.read();
    } 

    PImage p = cam.copy();

    // flip image
    for (int i = 0; i < p.height; i++) {
      for (int j = 0; j < p.width / 2; j++) {
        int tmp = p.get(j, i);
        p.set(j, i, p.get(p.width - j, i));
        p.set(p.width - j, i, tmp);
      }
    }

    image(p, surfaceWidth, 0); 


    int x = (p.width - n * w)/ 2;
    int y = (p.height - m * h) / 2;

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < m; j++) {
        int ii = x + i * w;
        int jj = y + j * h;
        color c = getAvg(p, ii, jj, w, h);

        int index = i*m + j;
        values[index] = (int)((red(c) + green(c) + blue(c)) / 3);

        fill(c, 200);
        rect(surfaceWidth + ii, jj, w, h);
      }
    }
  }

  int[] read() {
    return values;
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
}