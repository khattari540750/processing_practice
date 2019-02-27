void setup() 
{
  // desplay and renderer
  size(640, 480, JAVA2D);
  //size(640,480, P2D);
  //size(640,480, P3D);
  //size(640,480, OPENGL);

  // frame rate
  frameRate(30);

  // variables and data types
  int myVariable;
  myVariable = 5;
  boolean myBoolean = true;
  int myInteger = 7;
  float myFloat = -3.297;
  char myChar = 'A';
  String myString= "This is test";

  // array
  String[] planets = {"Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"};
  println(planets[0]);
  int[] planetDiameter = new int[8];
  planetDiameter[0] = 4897;
  planetDiameter[1] = 12104;
  planetDiameter[2] = 12756;
  planetDiameter[3] = 6794;

  // operators and formulas
  float a = (4 + 2.3) / 7;
  String s = "circumference of Jupiter: " + (142984*PI) + "km";
  int ik = myVariable;
  float aValue = 5;
  float convertedValue = map(aValue, 10, 20, 0, 1);
  int roundedValue = round(2.67);
  float randomValue = random(-5, 5);
  float angle = 0.1;
  float consineValue = cos(angle);

  // loop
  float myValue = 0;
  while (myValue < 100) {
    myValue = myValue + random(5);
    println("The value of the varialbe myValue is " + myValue);
  }
  
  // function
  translate(200,200);
  drawStar();
  translate(220,220);
  drawStar();
  println("The factorial of 5 is 1*2*3*4*5 = " + factorial(5));
}



void draw() 
{
  // frame rate
  println(frameCount);

  // coordinate transformation
  translate(40, 20);
  rotate(0.5);
  scale(1.5);

  // hello ellipse
  ellipse(50, 50, 60, 60);
  strokeWeight(4);
  fill(128);
  rect(50, 50, 40, 30);

  // mouse and keyboard
  println("Mouse position: " + mouseX + ", " + mouseY);
  println("Is one of the nouse buttons pressed: " + mousePressed);
  println("Is a key pressed: " + keyPressed);
  println("Last key pressed: " + key);

  // conditional statement
  int aNumber = 4;
  if (aNumber == 3) fill(255, 0, 0);  
  else fill(0, 255, 0);
  ellipse(50, 50, 80, 80);

  int bNumber = 1;
  switch(bNumber) {
  case 1:
    rect(20, 20, 80, 80);
    break;
  case 2:
    ellipse(50, 50, 80, 80);
    break;
  default:
    line(20, 20, 80, 80);
  }

  // loop
  for (int i=0; i<=5; i++) {
    line(0, 0, i*20, 100);
    line(100, 0, i*20, 100);
  }
}



// mouse and keyboard
void mouseReleased() 
{
  println("The mose button has been released.");
}
void mousePressed() {}
void mouseMoved() {}
void keyPressed() {}
void keyReleased() {}



// function
void drawStar() 
{
  line(0, -10, 0, 10);
  line(-8, -5, 8, 5);
  line(-8, 5, 8, -5);
}



int factorial(int theValue)
{
  int result = 1;
  for(int i=1; i<= theValue; i++){
    result = result * i;
  }
  return result;
}
