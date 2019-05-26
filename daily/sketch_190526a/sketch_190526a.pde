int tileCount = 20;
int actRandomSeed = 0;
int actStrokeCap = ROUND;

int mX = 0;
int mY = 0;


void settings()
{
  size(600, 600);
}


void setup()
{
  rectMode(CENTER);
  ellipseMode(CENTER);
}


void draw()
{
  move4();

  background(255);
  smooth();
  strokeCap(actStrokeCap);
  randomSeed(actRandomSeed);

  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {

      int posX = width/tileCount*gridX;
      int posY = height/tileCount*gridY;

      int toggle = (int)random(0, 2);

      int centerX = posX+width/tileCount/2;
      int centerY = posY+height/tileCount/2;
      fill(0);
      if (toggle == 0) {
        float s = map(mX, 0, width, 0, width/tileCount);
        ellipse(centerX, centerY, s, s);
      }
      if (toggle == 1) {
        float s = map(mY, 0, height, 0, height/tileCount);
        rect(centerX, centerY, s, s);
      }
    }
  }
  if(frameCount < 600) {
    saveFrame("frames/######.tif");
  }
}


void mousePressed()
{
  actRandomSeed = (int) random(100000);
}


void move0()
{
  mX = mouseX;
  mY = mouseY;
}


void move1()
{
  mX = int(width * cos(frameCount*0.1)) - width/2;
  mY = int(height * sin(frameCount*0.1)) - height/2;
}


void move2()
{
  mX = (int)map(cos(frameCount*0.1), -1, 1, 0, width);
  mY = (int)map(sin(frameCount*0.1), -1, 1, 0, height);
}


float theta = 0;
float STEP = 2 * PI * 0.01;
float rad(float t)
{
  float r = 5 * t;
  return r;
}
void move3()
{
  pushMatrix();
  translate(width / 2, height / 2);
  mX = int(rad(theta) * cos(theta));
  mY = int(rad(theta) * sin(theta));
  theta += STEP;
  popMatrix();
}


void move4()
{
  mX = (int)map(cos(frameCount*0.1), -1, 1, 0, width*0.8);
  mY = (int)map(sin(frameCount*0.1), -1, 1, 0, height*0.8);
}
