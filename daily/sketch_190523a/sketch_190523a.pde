String str = "";
//String fileName = "obama_hiroshima.txt";
//String fileName = "i_have_a_dream.txt";
String fileName = "stay_hungry_stay_foolish.txt";


void settings()
{
  size(600, 600);
}


void setup()
{
  String lines[];
  lines = loadStrings(fileName);

  
  int wordCount = 0;
  for (String val : lines) {
    str += val;
    wordCount += val.length();
  }
  println(wordCount);
  print(str);

  background(0);
  noStroke();
  smooth();
  rectMode(CENTER);
  
  for (int i = 0; i < str.length(); i++) {
    int num = str.charAt(i);
    pushMatrix();
    translate(map(i, 0, 127, 0, width), height/2);
    fill(map(num, 33, 127, 0, 255), 51);
    rect(0, 0, 10, height);
    popMatrix();
  }
}


void draw()
{
  
}


void keyPressed()
{
  if ( key == ' ' ) {
    save( fileName + ".png" );
  }
}
  
