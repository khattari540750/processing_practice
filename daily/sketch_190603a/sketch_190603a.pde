// window
int windowSize = 600;
int largeBoxSize = 300;
int tileCount = 100;

float[][] l = new float[tileCount][tileCount];
float[][] x = new float[tileCount][tileCount];
float[][] y = new float[tileCount][tileCount];
float[][] z = new float[tileCount][tileCount];


void settings()
{
  size(windowSize, windowSize, P3D);
}


void setup()
{
  for (int gridX=0; gridX<tileCount; gridX++) {
    for (int gridY=0; gridY<tileCount; gridY++) {
      x[gridX][gridY] = largeBoxSize/tileCount*gridX + largeBoxSize/tileCount/2;
      y[gridX][gridY] = largeBoxSize/tileCount*gridY + largeBoxSize/tileCount/2;
      z[gridX][gridY] = 0;
      l[gridX][gridY] = 100;
    }
  }
}


void draw()
{
  background(150);
  translate(width/2, height/2);
  rotateY(frameCount / 200.0);
  
  
  
  for (int gridX=0; gridX<tileCount; gridX++) {
    for (int gridY=0; gridY<tileCount; gridY++) {
      pushMatrix();
      translate(x[gridX][gridY], y[gridX][gridY]);
      box(largeBoxSize/tileCount,largeBoxSize/tileCount,l[gridX][gridY]);
      popMatrix();
    }
  }
  
  // draw fps to title
  surface.setTitle(""+frameRate);
}
