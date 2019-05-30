int NORTH = 0;
int NORTHEAST = 1; 
int EAST = 2;
int SOUTHEAST = 3;
int SOUTH = 4;
int SOUTHWEST = 5;
int WEST = 6;
int NORTHWEST= 7;

float stepSize = 1;
float diameter = 1;

int direction;
float posX, posY;


void settings()
{
  size(600, 600);
}


void setup()
{
  background(255);
  smooth();
  noStroke();

  posX = width/2;
  posY = height/2;
}


void draw()
{
  for (int i=0; i<=mouseX; i++) {

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

    if (posX < width/2 + 10 && posX > width/2 -10) {
      fill(0, 40);
      ellipse(posX+stepSize/2, posY+stepSize/2, diameter*2, diameter*2);
    } else {
      fill(0, 40);
      ellipse(posX+stepSize/2, posY+stepSize/2, diameter, diameter);
    }
  }
}
