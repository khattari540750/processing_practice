import controlP5.*;



ControlP5 cp5;
int numA, numB;
float ratio, thr;
float[] rand = new float[0];
boolean rec = false;
int count;



void setup()
{
  size(500, 500);
  //colorMode(HSB, 1);
  noStroke();
  smooth();
  controller();
}


void draw() 
{
  background(255);
  ratio = (float) numB / numA;
  count = 0;
  if (ratio != 1) {
    divSq(0, 0, width);
  }
  if (rec) {
    String namePNG = str(numA) + "_" + str(numB) + "_" + str(int(thr)) + ".png";  //PNGの保存ファイル名
    save(namePNG);
    rec = false;
  }
}
