int windowSize = 600;
int boxSize = 400;
int maxCount = 200;
int currentCount = 1;
float[] x = new float[maxCount];
float[] y = new float[maxCount];
float[] z = new float[maxCount];
float[] r = new float[maxCount];


void settings()
{
  size(windowSize, windowSize, P3D);
}


void setup()
{
  smooth();
  strokeWeight(0.5);

  // first circle
  x[0] = 0.;
  y[0] = 0.;
  z[0] = 0.;
  r[0] = 10.;
}


void draw()
{
  // create a radom set of parameters
  float newR = random(1, 7);
  float newX = random(-boxSize+newR, boxSize-newR);
  float newY = random(-boxSize+newR, boxSize-newR);
  float newZ = random(-boxSize+newR, boxSize-newR);

  // get nearest point index
  float closestDist = 100000000;
  int closestIndex = 0;
  for (int i=0; i < currentCount; i++) {
    float newDist = dist(newX, newY, newZ, x[i], y[i], z[i]);
    if (newDist < closestDist) {
      closestDist = newDist;
      closestIndex = i;
    }
  }

  // calc
  float angle = atan2(newY-y[closestIndex], newX-x[closestIndex]);
  x[currentCount] = x[closestIndex] + cos(angle) * (r[closestIndex]+newR);
  y[currentCount] = y[closestIndex] + sin(angle) * (r[closestIndex]+newR);
  r[currentCount] = newR;

  // update
  currentCount++;
  if (currentCount >= maxCount) currentCount--;

  // draw enviloment
  background(255);
  translate(width/2, height/2);
  rotateY(frameCount / 200.0);

  // draw box
  noFill();
  box(boxSize);

  // draw ellipse
  fill(50);
  for (int i=0; i < currentCount; i++) {
    pushMatrix();
    translate(x[i], y[i]);
    sphere(r[i]);
    popMatrix();
  }
}
