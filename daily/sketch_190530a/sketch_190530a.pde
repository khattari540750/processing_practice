int size = 600; 
int tileCount = 50;

float tileSize;


void settings()
{
  size(size, size, P3D);
  
  //size(size,size);
}


void setup() 
{
  background(0);
  noFill();
  stroke(255);  
  tileSize = width/float(tileCount);
}


void draw()
{
  background(0);
  
  for (int gridX=0; gridX<tileCount; gridX++) {
    for (int gridY=0; gridY<tileCount; gridY++) {
      float posX = tileSize*gridX + tileSize/2;
      float posY = tileSize*gridY + tileSize/2;
      //rect(posX, posY, tileSize, tileSize);
      pushMatrix();
      translate(posX, posY);
      scale(1,1,map(sin(frameCount*0.01*(gridX+1)),-1,1,0,1));
      box(tileSize);
      popMatrix();
      
    }
  }

  //translate(width/2, height/2);
  //scale(1,2*map(sin(frameCount*0.01),-1,1,0,1),1);
  //box(100);
  
  
  //if(frameCount < 600) {
  //  saveFrame("frames/####.tif");
  //}
}
