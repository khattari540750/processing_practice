int div = 100;


void settings()
{
  size(600, 600);
}


void setup()
{
  ellipseMode(CENTER);
  frameRate(30);
  //noStroke();
}


void draw()
{
  background(255);
  for (int y = 0; y <= height/div; y++) {
    for (int x = 0; x <= width/div; x++) {
      //fill(random(1, 255));
      fill(0);
      float f = random(0.1, 1);
      ellipse(x*div, y*div, div*f, div*f);
    }
  }
  saveFrame("frames/######.tif");
}
