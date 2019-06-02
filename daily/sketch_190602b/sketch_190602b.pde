// window
int windowSize = 600;
int boxSize = 500;

int maxCount = 5000;
int currentCount = 1;
float[] x = new float[maxCount];
float[] y = new float[maxCount];
float[] z = new float[maxCount];
float[] r = new float[maxCount];

int[] closestIndex = new int[maxCount];

float minRadius = 3;
float maxRadius = 20;

float mouseRect = 30;


void settings()
{
  size(windowSize, windowSize, P3D);
}


void setup()
{

  noFill();
  smooth();
  cursor(CROSS);

  // first circle
  x[0] = 200;
  y[0] = 100;
  z[0] = 0;
  r[0] = 50;
  closestIndex[0] = 0;
}


void draw()
{ 
  // create a random position
  float newX = random(-boxSize/2+maxRadius, boxSize/2-maxRadius);
  float newY = random(-boxSize/2+maxRadius, boxSize/2-maxRadius);
  float newZ = 0;
  float newR = minRadius;

  // create a random position according to mouse position
  if (mousePressed == true) {
    newX = random(mouseX-mouseRect/2, mouseX+mouseRect/2);
    newY = random(mouseY-mouseRect/2, mouseY+mouseRect/2);
    newR = 1;
  } 
  boolean intersection = false;

  // find out, if new circle intersects with one of the others
  for (int i=0; i < currentCount; i++) {
    float d = dist(newX, newY, newZ, x[i], y[i], z[i]);
    if (d < (newR + r[i])) {
      intersection = true; 
      break;
    }
  }

  // no intersection ... add a new circle
  if (intersection == false) {
    // get closest neighbour and closest possible radius
    float newRadius = width;
    for (int i=0; i < currentCount; i++) {
      float d = dist(newX, newY, newZ, x[i], y[i], z[i]);
      if (newRadius > d-r[i]) {
        newRadius = d-r[i];
        closestIndex[currentCount] = i;
      }
    }

    if (newRadius > maxRadius) newRadius = maxRadius;

    x[currentCount] = newX;
    y[currentCount] = newY;
    z[currentCount] = newZ;
    r[currentCount] = newRadius;
    currentCount++;
    if (currentCount >= maxCount) currentCount--;
  }

  // draw enviloment
  background(255);
  translate(width/2, height/2);


  // draw them
  fill(0);
  noStroke();
  for (int i=0; i < currentCount; i++) {
    //stroke(0);
    //strokeWeight(1.5);
    ellipse(x[i], y[i], r[i]*2, r[i]*2);
    //pushMatrix();
    //translate(x[i], y[i], z[i]);
    //sphere(r[i]);
    //popMatrix();
  }

  // visualize the random range of the new positions
  if (mousePressed == true) {
    stroke(255, 100, 0);
    strokeWeight(2);
    rect(mouseX-mouseRect/2, mouseY-mouseRect/2, mouseRect, mouseRect);
  }
  
  // draw fps to title
  surface.setTitle(""+frameRate);
}


void keyPressed()
{
  // mouseRect ctrls arrowkeys up/down 
  if (keyCode == UP) mouseRect += 4;
  if (keyCode == DOWN) mouseRect -= 4;
}
