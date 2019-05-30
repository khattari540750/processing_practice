int size = 600; 
int tileCount = 120;

float tileSize;

float mX, mY;


void settings()
{
  size(size, size);
}


void setup() 
{
  rectMode(CENTER);
  tileSize = width/float(tileCount);
  //noStroke();
}


void draw() 
{
  move0();
  
  background(0);
  
  for (int gridX=0; gridX<tileCount; gridX++) {
    for (int gridY=0; gridY<tileCount; gridY++) {
      float posX = tileSize*gridX + tileSize/2;
      float posY = tileSize*gridY + tileSize/2;
      float diameter = dist(mX, mY, posX, posY);
      float rad = map(diameter, 0, size*1.41, 360, 0);
      pushMatrix();
      translate(posX, posY);
      rotate(radians(rad));
      rect(0,0,tileSize,tileSize);
      popMatrix();
    }
  }
  
  if (frameCount < 600) {
    saveFrame("frames"+ str(tileCount) +"/####.tif");
  }
  if (frameCount == 600) {
    println("done!");
  }
}


void move0()
{
  mX = size*sin(frameCount*0.01)*0.35 + size/2;
  mY = size*cos(frameCount*0.01)*0.35 + size/2;
}
