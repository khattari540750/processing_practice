// window
int windowSize = 600;
int boxSize = 500;
int maxCount = 2000;
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
  float newR = random(1, 8);
  float newX = random(-boxSize/2+newR, boxSize/2-newR);
  float newY = random(-boxSize/2+newR, boxSize/2-newR);
  float newZ = random(-boxSize/2+newR, boxSize/2-newR);

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
  float pan = atan2(newY-y[closestIndex], newX-x[closestIndex]);
  float tmpTilt = (newY-y[closestIndex]) * (newY-y[closestIndex]) + (newX-x[closestIndex])*(newX-x[closestIndex]);
  float tilt = atan2(newZ-z[closestIndex], sqrt(tmpTilt));
  x[currentCount] = x[closestIndex] + cos(pan) * (r[closestIndex]+newR) * cos(tilt);
  y[currentCount] = y[closestIndex] + sin(pan) * (r[closestIndex]+newR) * cos(tilt);
  z[currentCount] = z[closestIndex] + sin(tilt) * (r[closestIndex]+newR);
  r[currentCount] = newR;

  // update
  currentCount++;
  if (currentCount >= maxCount) currentCount--;

  // draw enviloment
  background(0);
  translate(width/2, height/2);
  rotateY(frameCount / 200.0);

  // draw box
  //noFill();
  //box(boxSize);

  // draw ellipse
  fill(255);
  noStroke();
  for (int i=0; i < currentCount; i++) {
    pushMatrix();
    translate(x[i], y[i], z[i]);
    sphere(r[i]);
    popMatrix();
  }

  // draw fps to title
  surface.setTitle(""+frameRate);
  
  // save
  if (frameCount < 1500) {
    //saveFrame("frames/####.tif");
  }
  if (frameCount == 1500) {
    println("done!");
  }
}
