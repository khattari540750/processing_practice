int resolution = 1;
int maxSize = 300;


void setup() 
{
  size(600, 600, P3D);
  background(0);
  noFill();
  stroke(255);
}



void draw()
{
  background(0);
  
  float s = sin(frameCount / 200.0);
  resolution = (int)map(s, -1., 1., 1., 30.);

  translate(width/2, height/2);
  rotateY(frameCount / 200.0);

  int num = maxSize/resolution;
  for (int i=0; i<resolution; i++) {
    box(num*(i+1));
  }
}
