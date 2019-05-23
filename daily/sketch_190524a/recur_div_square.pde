import controlP5.*;



class RectDivSquare
{
  private PApplet parent;
  public int numA = 31;
  public int numB = 8;
  private float ratio = (float) numB / numA;
  public float thr = 20;
  private float[] rand = new float[0];
  private int count;
  private ControlP5 cp5;
  private boolean rec = false;


  public RectDivSquare(PApplet p)
  {
    parent = p;
  }


  public void setup()
  {
    colorMode(HSB, 1);
    divSquare(0, 0, width);
    //controller();
  }

  public void draw() {
    background(1, 0, 1);
    ratio = (float) numB / numA;
    count = 0;
    if (rec) {
      //String namePDF = str(numA) + "_" + str(numB) + "_" + str(int(thr)) + ".pdf";  //PDFの保存ファイル名
      //beginRecord(PDF, namePDF);
    }
    if (ratio != 1) {  //numAとnumBが異なるとき実行
      divSquare(0, 0, width);
    }
    if (rec) {
      //endRecord();
      String namePNG = str(numA) + "_" + str(numB) + "_" + str(int(thr)) + ".png";  //PNGの保存ファイル名
      save(namePNG);
      rec = false;
    }
  }


  private void setColor()
  {
    if (rand.length <= count) {
      rand = append(rand, random(1));
    }
    fill(color(rand[count], 1, 1));
    count++;
  }


  private void changeColor() {
    for (int i = 0; i < rand.length; i++) {
      rand[i] = random(1);
    }
  }


  private void divSquare(float xPos, float yPos, float wd) {
    int itr = 0;
    float xEndPos = wd + xPos;
    float yEndPos = wd + yPos;
    setColor();
    rect(xPos, yPos, wd, wd);
    while (wd > thr) {
      itr++;
      if (itr % 2 == 1) {
        while (xPos + wd * ratio < xEndPos + 0.1) {
          divRect(xPos, yPos, wd * ratio);
          xPos += wd * ratio;
        }
        wd = xEndPos - xPos;
      } else {
        while (yPos + wd / ratio < yEndPos + 0.1) {
          divRect(xPos, yPos, wd);
          yPos += wd / ratio;
        }
        wd = yEndPos - yPos;
      }
    }
  }


  private void divRect(float xPos, float yPos, float wd) {
    int itr = 0;
    float xEndPos = xPos + wd;
    float yEndPos = yPos + wd / ratio;
    setColor();
    rect(xPos, yPos, wd, wd / ratio);
    while (wd > thr) {
      itr++;
      if (itr % 2 == 0) {
        while (xPos + wd < xEndPos + 0.1) {
          divSquare(xPos, yPos, wd);
          xPos += wd;
        }
        wd = xEndPos - xPos;
      } else {
        while (yPos + wd < yEndPos + 0.1) {
          divSquare(xPos, yPos, wd);
          yPos += wd;
        }
        wd = yEndPos - yPos;
      }
    }
  }


  private void controller() 
  {
    cp5 = new ControlP5(parent);  //コントローラを生成
    cp5.addSlider("numA")  //numAの値を動かすスライダー
      .setPosition(10, 10)  //スライダーの位置
      .setSize(100, 20)  //スライダーのサイズ
      .setRange(1, 40)  //最小値と最大値
      .setValue(10)  //初期値
      .setColorCaptionLabel(0)  //スライダーの文字の色
      ;
    cp5.addSlider("numB")
      .setPosition(10, 50)
      .setSize(100, 20)
      .setRange(1, 40)
      .setValue(6)
      .setColorCaptionLabel(0)
      ;
    cp5.addSlider("thr")
      .setPosition(10, 90)
      .setSize(100, 20)
      .setRange(10, 300)
      .setNumberOfTickMarks(30)
      .setValue(100)
      .setColorCaptionLabel(0)
      ;
    cp5.addBang("changeColor")
      .setPosition(10, 130)
      .setSize(50, 20)
      .setColorCaptionLabel(0)
      ;
    cp5.addBang("rec")
      .setPosition(10, 170)
      .setSize(50, 20)
      .setColorCaptionLabel(0)
      ;
  }
}
