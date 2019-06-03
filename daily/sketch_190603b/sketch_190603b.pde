import joons.JoonsRenderer;

// system settings
int windowSize = 600;
int boxSize = 200;

// particles
int maxCount = 200;
int currentCount = 1;
float[] x = new float[maxCount];
float[] y = new float[maxCount];
float[] z = new float[maxCount];
float[] r = new float[maxCount];


//renderer Setting.
JoonsRenderer jr;
float eyeX = 60;
float eyeY = 140;
float eyeZ = 80;
float centerX = 0;
float centerY = 0;
float centerZ = 10;
float upX = 0;
float upY = 0;
float upZ = -1;
float fov = PI / 4; 
float aspect = 1f;
float zNear = 5;
float zFar = 10000;


void settings()
{
  size(windowSize, windowSize, P3D);
}


void setup()
{
  // render
  jr = new JoonsRenderer(this);
  jr.setSampler("bucket");
  jr.setSizeMultiplier(1);
  jr.setAA(0, 2, 4);
  jr.setCaustics(20);
  jr.setDOF(130, 3);

  // first particle
  x[0] = -10.;
  y[0] = 0.;
  z[0] = 30.;
  r[0] = 10.;
}


void draw()
{
  // create a radom set of parameters
  float newR = random(2, 10);
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

  // calc particle pos
  float pan = atan2(newY-y[closestIndex], newX-x[closestIndex]);
  float tmpTilt = (newY-y[closestIndex]) * (newY-y[closestIndex]) + (newX-x[closestIndex])*(newX-x[closestIndex]);
  float tilt = atan2(newZ-z[closestIndex], sqrt(tmpTilt));
  x[currentCount] = x[closestIndex] + cos(pan) * (r[closestIndex]+newR) * cos(tilt);
  y[currentCount] = y[closestIndex] + sin(pan) * (r[closestIndex]+newR) * cos(tilt);
  z[currentCount] = z[closestIndex] + sin(tilt) * (r[closestIndex]+newR);
  r[currentCount] = newR;

  // update
  boolean isProcessing = true;
  currentCount++;
  if (currentCount >= maxCount){ 
    currentCount--;
    isProcessing = false;
  }



  jr.beginRecord(); //Make sure to include things you want rendered.

  jr.background(0);
  camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  perspective(fov, aspect, zNear, zFar);

  //Floor.
  jr.fill("diffuse", 100, 100, 100);
  int w = 10000;
  beginShape(QUADS);
  vertex(w, -w, -150);
  vertex(-w, -w, -150);
  vertex(-w, w, -150);
  vertex(w, w, -150);
  endShape();

  //Lighting.
  jr.fill("light", 30, 30, 30, 64);
  int zl = 50;
  beginShape(QUADS);
  vertex(-zl+100, -zl, 50);
  vertex(-zl+100, zl, 50);
  vertex(zl+100, zl, 50);
  vertex(zl+100, -zl, 30);
  endShape();
  
  //particles
  for (int i=0; i < currentCount; i++) {
    translate(x[i], y[i], z[i]);
    jr.fill("glass");
    sphere(r[i]);
    translate(-x[i], -y[i], -z[i]);
  }

  endShape();

  jr.endRecord();
  jr.displayRendered(true);
}


void keyPressed()
{
  if (key == 'r' || key == 'R') jr.render(); //Press 'r' key to start rendering.
}
