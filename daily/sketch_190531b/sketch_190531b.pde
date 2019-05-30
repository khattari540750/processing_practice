PImage img;

void setup()
{
  size(600,600);
  img = loadImage("yen.jpg");
  background(255);
}

void draw()
{
  color c = img.get(mouseX, mouseY);
  float num = map(red(c) + green(c) + blue(c), 0,255*3,2,1);
  if(mouseX >= img.width || mouseY >= img.height) num = 1;
  
  
  println(num);
  image(img,0,0);
  
  //image(img,0,0,600,600);
}




//PImage img;
 
//void setup() {
//  size(600, 600);
//  img = loadImage("yen.jpg");
//  colorMode(HSB, 360, 100, 100, 100);
//  background(360);
//  smooth();
//  noStroke();
//}
 
//void draw() {
//  background(360);
//  for(int x=0; x<width; x++) {
//    for(int y=0; y<height; y++) {
//      color c = img.get(x,y);
//      fill(0, c);
//      ellipse(x, y, 2, 2);
//    }
//    println();
//  }
//  println();
  
//  //image(img, 0, 0, width, height);
//}
