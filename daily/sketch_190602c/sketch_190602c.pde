int windowSize = 600;

int maxCount = 5000;
int currentCount = 1;
float[] x = new float[maxCount];
float[] y = new float[maxCount];
float[] r = new float[maxCount];
color[] c = new color[maxCount];

int[] closestIndex = new int[maxCount];

float minRadius = 3;
float maxRadius = 8;

float speed = 1;


void settings()
{
  size(windowSize, windowSize);
}


void setup()
{

  //noFill();
  smooth();
  cursor(CROSS);

  // first circle
  x[0] = 200;
  y[0] = 100;
  r[0] = maxRadius;
  closestIndex[0] = 0;
}


void draw() 
{
  background(255);

  speed += 0.8;
  for (int sp=0; sp<speed; sp++) {

    // create a random position
    float newX = random(0+maxRadius, width-maxRadius);
    float newY = random(0+maxRadius, height-maxRadius);
    float newR = minRadius;

    boolean intersection = false;

    // find out, if new circle intersects with one of the others
    for (int i=0; i < currentCount; i++) {
      float d = dist(newX, newY, x[i], y[i]);
      if (d < (newR + r[i])) {
        intersection = true; 
        break;
      }
    }

    // no intersection ... add a new circle
    if (intersection == false) {
      float newRadius = width;
      for (int i=0; i < currentCount; i++) {
        float d = dist(newX, newY, x[i], y[i]);
        if (newRadius > d-r[i]) {
          newRadius = d-r[i];
          closestIndex[currentCount] = i;
        }
      }

      if (newRadius > maxRadius) newRadius = maxRadius;

      x[currentCount] = newX;
      y[currentCount] = newY;
      r[currentCount] = newRadius;
      c[currentCount] = color(random(15, 230));
      currentCount++;
      if (currentCount >= maxCount) currentCount--;
    }
  }

  // draw them
  for (int i=0; i < currentCount; i++) {
    noStroke();
    strokeWeight(1.5);
    fill(c[i]);
    ellipse(x[i], y[i], r[i]*2, r[i]*2);
  }

  // draw fps to title
  surface.setTitle(""+frameRate);

  // save
  if (frameCount < 1500) {
    saveFrame("frames/####.tif");
  }
  if (frameCount == 1500) {
    println("done!");
  }
}
