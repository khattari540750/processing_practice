int size = 600; 
int tileCount = 10;

float tileSize;

void settings()
{
  size(size, size, P3D);
}


void setup() 
{
  noStroke();
  fill(255, 190);
  tileSize = width/float(tileCount);
}

void draw() 
{
  background(0);

  ambientLight(63, 31, 31);
  directionalLight(255, 255, 255, -1, 0, 0);
  pointLight(63, 127, 255, mouseX, mouseY, 200);
  spotLight(100, 100, 100, mouseX, mouseY, 200, 0, 0, -1, PI, 2);

  camera(mouseX, mouseY, 200, width/2.0, height/2.0, 0, 0, 1, 0);

  translate(width / 2, height / 2, -20);
  
  for (int gridX=0; gridX<tileCount; gridX++) {
    for (int gridY=0; gridY<tileCount; gridY++) {
      float posX = tileSize*gridX + tileSize/2;
      float posY = tileSize*gridY + tileSize/2;
      pushMatrix();
      translate(posX, posY);
      rotateX(radians(30));
      rotateY(radians(30));
      box(tileSize,tileSize, tileSize);
      popMatrix();
    }
  }
}
