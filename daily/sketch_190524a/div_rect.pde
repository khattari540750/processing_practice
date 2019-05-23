void div_rect_setup(int a, int b, int s)
{
  int numA = a;
  int numB = b;
  int scalar = s;
  numA *= scalar;
  numB *= scalar;
  
  int wd = numB;
  int xPos = 0;
  int yPos = 0;
  int itr = 0;
  color col;
  
  colorMode(HSB, 1);
  
  while(wd > 0){
    itr++;
    if (itr % 2 == 1) {
      while(xPos + wd <= numA){
        col = color(random(1),1,1);
        fill(col);
        col = color(random(1),1,1);
        rect(xPos, yPos, wd, wd);
        xPos += wd;
      }
      wd = numA - xPos;
    } else {
      while(yPos + wd <= numB){
        col = color(random(1),1,1);
        fill(col);
        rect(xPos, yPos, wd, wd);
        yPos += wd;
      }
      wd = numB - yPos;
    }
  }
}
