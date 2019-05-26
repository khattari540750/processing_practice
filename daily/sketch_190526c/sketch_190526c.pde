int tileCount = 50;
float tileWidth, tileHeight;
float shapeSize= 50;
float maxDist;

int mX = 0;
int mY = 0;

int[][] alpList = new int[tileCount][tileCount];

void settings()
{
  size(600, 600);
}


void setup()
{
  tileWidth = width/float(tileCount);
  tileHeight = height/float(tileCount);
  maxDist = sqrt(sq(width) + sq(height));

  background(150);
  rectMode(CENTER);
  smooth();
  //noStroke();

  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {
      alpList[gridY][gridX] = (int)random(200, 255);
    }
  }
}


void draw()
{
  mouse1();

  background(150);
  smooth();

  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {

      float posX = tileWidth*gridX + tileWidth/2;
      float posY = tileHeight*gridY + tileHeight/2;
      float angle = atan2(mY-posY, mX-posX);

      pushMatrix();
      translate(posX, posY);
      rotate(angle);
      fill(alpList[gridY][gridX]);
      rect(posX, posY, 50, 50);
      popMatrix();
    }
  }
  if(frameCount < 600) {
    saveFrame("frames/####.tif");
  }
}


void mouse0()
{
  mX = mouseX;
  mY = mouseY;
}


void mouse1()
{
  mX = (int)map(sin(frameCount*0.05), -1, 1, 0, width);
  mY = (int)map(cos(frameCount*0.05), -1, 1, 0, height);
}


float theta = 0;
float STEP = 2 * PI * 0.01;
float rad(float t)
{
  float r = 5 * t;
  return(r);
}
void mouse2()
{
  //pushMatrix();
  mX = int(rad(theta) * cos(theta)) + width/2;
  mY = int(rad(theta) * sin(theta)) + height/2;
  //popMatrix();
  theta += STEP;
}
