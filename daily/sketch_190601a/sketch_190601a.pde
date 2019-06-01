int maxCount = 300;
int currentCount = 1;
float[] x = new float[maxCount];
float[] y = new float[maxCount];
float[] z = new float[maxCount];
float[] r = new float[maxCount];


void settings()
{
  size(600, 600, P3D);
}


void setup()
{
  smooth();
  background(0);
  noFill();
  stroke(255);
  strokeWeight(0.5);

  // first circle
  x[0] = 0.;
  y[0] = 0.;
  z[0] = 0.;
  r[0] = 10;

  for (int i = 1; i < maxCount; i++) {
    x[i] = random(-200, 200);
    y[i] = random(-200, 200);
    z[i] = random(-200, 200);
    r[i] = random(1, 8);
  }
}


void draw()
{
  background(0);

  // create a radom set of parameters
  float newR = random(1, 7);
  float newX = random(-200+newR, 200-newR);
  float newY = random(-200+newR, 200-newR);
  float newZ = random(-200+newR, 200-newR);

  // get nearlest index
  float closestDist = 100000000;
  int closestIndex = 0;
  for (int i=0; i < currentCount; i++) {
    float newDist = dist(newX, newY, newZ, x[i], y[i], z[i]);
    if (newDist < closestDist) {
      closestDist = newDist;
      closestIndex = i;
    }
  }
  
  // calc nerlest point
  float pan = atan2(newX-x[closestIndex], newZ-z[closestIndex]);
  float tilt = atan2(newX-x[closestIndex], newZ-z[closestIndex]);
  x[currentCount] = x[closestIndex] + cos(pan) * (r[closestIndex]+newR);
  y[currentCount] = y[closestIndex] + cos(tilt) * (r[closestIndex]+newR);
  z[currentCount] = z[closestIndex] + sin(pan) * (r[closestIndex]+newR);
  r[currentCount] = newR;
  
  //float angle1 = atan2(newY-y[closestIndex], newX-x[closestIndex]);
  //float angle2 = atan2(newY-y[closestIndex], newZ-z[closestIndex]);
  //float angle3 = atan2(newX-x[closestIndex], newZ-z[closestIndex]);

  //x[currentCount] = x[closestIndex] + cos(angle1) * (r[closestIndex]+newR);
  //y[currentCount] = y[closestIndex] + sin(angle1) * (r[closestIndex]+newR);
  //z[currentCount] = z[closestIndex] + sin(angle) * (r[closestIndex]+newR);
  //r[currentCount] = newR;
  
  currentCount++;
  
  pushMatrix();

  translate(width/2, height/2);
  rotateY(frameCount / 200.0);

  box(400);

  for (int i = 0; i < currentCount; i++) {
    pushMatrix();
    translate(x[i], y[i], z[i]);
    sphere(r[i]);
    popMatrix();
  }

  popMatrix();
}

























//int maxCount = 300;
//int currentCount = 1;
//float[] x = new float[maxCount];
//float[] y = new float[maxCount];
//float[] z = new float[maxCount];
//float[] r = new float[maxCount];


//void settings()
//{
//  size(600, 600, P3D);
//}


//void setup()
//{
//  smooth();
//  background(0);
//  noFill();
//  stroke(255);
//  strokeWeight(0.5);

//  for (int i = 0; i < maxCount; i++) {
//    x[i] = random(-200, 200);
//    y[i] = random(-200, 200);
//    z[i] = random(-200, 200);
//    r[i] = random(1, 10);
//  }
//}


//void draw()
//{
//  background(0);

//  pushMatrix();

//  translate(width/2, height/2);
//  rotateY(frameCount / 200.0);

//  box(400);

//  for (int i = 0; i < maxCount; i++) {
//     pushMatrix();
//    translate(x[i], y[i], z[i]);
//    sphere(r[i]);
//    popMatrix();
//  }

//  popMatrix();
//}
