int NORTH = 0;
int NORTHEAST = 1; 
int EAST = 2;
int SOUTHEAST = 3;
int SOUTH = 4;
int SOUTHWEST = 5;
int WEST = 6;
int NORTHWEST= 7;

float stepSize = 1;

int direction;
float posX, posY;

PImage img;
float imgPosX; 
float imgPosY;


void settings()
{
  size(600, 600);
}


void setup()
{

  background(255);
  smooth();
  noStroke();

  img = loadImage("yen.jpg");
  imgPosX = width/2 - img.width/2; 
  imgPosY = height/2 - img.height/2;

  posX = width/2;
  posY = height/2;
}


void draw()
{
  for (int i=0; i<=500; i++) {

    direction = round(random(0, 3));

    if (direction == NORTH) {  
      posY -= stepSize;
    } else if (direction == NORTHEAST) {
      posX += stepSize;
      posY -= stepSize;
    } else if (direction == EAST) {
      posX += stepSize;
    } else if (direction == SOUTHEAST) {
      posX += stepSize;
      posY += stepSize;
    } else if (direction == SOUTH) {
      posY += stepSize;
    } else if (direction == SOUTHWEST) {
      posX -= stepSize;
      posY += stepSize;
    } else if (direction == WEST) {
      posX -= stepSize;
    } else if (direction == NORTHWEST) {
      posX -= stepSize;
      posY -= stepSize;
    }

    if (posX > width) posX = 0;
    if (posX < 0) posX = width;
    if (posY < 0) posY = height;
    if (posY > height) posY = 0;

    float num;
    if (posX < imgPosX || posY < imgPosY || posX >= imgPosX+img.width || posY >= imgPosY+img.height) {
      num = 0.63;
    } else {
      color c = img.get(int(posX - imgPosX), int(posY - imgPosY));
      num = map(red(c) + green(c) + blue(c), 0, 255*3, 2.3, 0.63);
    }

    fill(0, 40);
    ellipse(posX+stepSize/2, posY+stepSize/2, num, num);
  }
  
  if (frameCount < 600) {
    saveFrame("frames"+ str(tileCount) +"/####.tif");
  }
  if (frameCount == 600) {
    println("done!");
  }
}
