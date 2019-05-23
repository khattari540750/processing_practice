RectDivSquare r;

void settings()
{
  size(600,600);
}


void setup()
{
  //numeric_setup(6,15);
  //div_rect_setup(10, 7, 20);
  //div_square_setup(16, 7);
  //RectDivRect r = new RectDivRect();
  r = new RectDivSquare(this);
  r.setup();
}


void draw()
{
  r.draw();
}


void keyPressed(){
  String namePNG = str(r.numA) + "_" + str(r.numB) + "_" + str(int(r.thr)) + ".png";  //PNGの保存ファイル名
  save(namePNG);
}
