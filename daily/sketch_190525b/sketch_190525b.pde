int step;

void settings()
{
  size(600, 600);
}


void setup()
{
  noCursor();
  step = 0;
}


void draw()
{
  step = (int)map(sin(frameCount*0.08), -1., 1., 0, width);
  
  rectMode(CENTER);
  noStroke();
  background(step/2);

  fill(width/2-step/2);
  rect(width/2, width/2, step+1, step+1);
  
  saveFrame("frames/######.tif");
}
