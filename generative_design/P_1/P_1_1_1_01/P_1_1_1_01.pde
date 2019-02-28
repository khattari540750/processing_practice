import processing.pdf.*;
import java.util.Calendar;


boolean savePDF = false;
int stepX;
int stepY;



void setup()
{
  size(800,400);
  background(0);
  noStroke();
}



void draw()
{
  if(savePDF) beginRecord(PDF, timestamp()+".pdf");
  
  noStroke();
  colorMode(HSB, width, height, 100);
  
  stepX = mouseX+2;
  stepY = mouseY+2;
  for(int gridY=0; gridY<height; gridY+=stepY){
    for(int gridX=0; gridX<width; gridX+=stepX){
      fill(gridX, height-gridY, 100);
      rect(gridX, gridY, stepX, stepY);
    }
  }
}



void keyPressed()
{
  if(key=='s' || key=='S') saveFrame();
  if(key=='p' || key=='P') savePDF = true;
}



String timestamp()
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
