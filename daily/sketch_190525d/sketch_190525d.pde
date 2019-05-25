int movX = 0;
int movY = 0;


void settings()
{
  size(600, 600);
}


void setup()
{
  smooth();
  noFill();
  background(255);
}


void draw()
{
  move5();

  pushMatrix();
  translate(width/2, height/2);

  int circleResolution = (int)map(movY + 100, 0, height, 3, 10);
  float radius = movX- width/2 + 0.5;
  float angle = TWO_PI/circleResolution;

  strokeWeight(3);
  stroke(0, 25);

  beginShape();
  for (int i=0; i<=circleResolution; i++) {
    float x = 0 + cos(angle*i) * radius;
    float y = 0 + sin(angle*i) * radius;
    vertex(x, y);
  }
  endShape();

  popMatrix();
  
  if(frameCount < 60*15){
    saveFrame("frames/######.tif");
  }
}


void move0()
{
  movX = mouseX;
  movY = mouseY;
}


void move1()
{
  movX = (int)map(sin(frameCount), -1, 1, 0, width);
  movY = (int)map(sin(frameCount), -1, 1, 0, height);
}

void move2()
{
  movX = (int)map(sin(frameCount), -1, 1, 0, width);
  movY = (int)map(cos(frameCount), -1, 1, 0, height);
}

void move3()
{
  movX = (int)map(sin(frameCount), -1, 1, 0, width);
  movY = height/2;
}

void move4()
{
  movX = (int)map(sin(frameCount), -1, 1, 0, width);
  movY = 1;
}

void move5()
{
  movX = (int)map(sin(frameCount), -1, 1, 0, width);
  movY = height-1;
}
