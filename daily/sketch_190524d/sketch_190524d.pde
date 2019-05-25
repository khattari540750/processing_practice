float deg = 0.;



void settings()
{
  size(600,600);
}



void setup()
{
  
  rectMode(CENTER);
}



void draw()
{
  background(200);
  
  int x = mouseX - width/2;
  int y = height - mouseY - height/2;
  float old_deg = deg;
  deg = atan2(float(x), float(y));
  
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(deg);
  fill(255);
  rect(0, 0, 30, 50);
  fill(0);
  rect(0, -20, 30, 10);
  popMatrix();
  
  
  println(x, " ", y, " ", abs(deg - old_deg));
}
