GrayScott[] gList;


void settings()
{
  size(600, 600);
}

void setup()
{
  gList = new GrayScott[25];
  gList[0] = new GrayScott(100, 0+10, 0, 0.025, 0.05);
  gList[1] = new GrayScott(100, 120+10, 0, 0.024, 0.05);
  gList[2] = new GrayScott(100, 240+10, 0, 0.023, 0.05);
  gList[3] = new GrayScott(100, 360+10, 0, 0.022, 0.05);
  gList[4] = new GrayScott(100, 480+10, 0, 0.021, 0.05);
  
  gList[5] = new GrayScott(100, 0+10, 120, 0.04, 0.06);
  gList[6] = new GrayScott(100, 120+10, 120, 0.037, 0.06);
  gList[7] = new GrayScott(100, 240+10, 120, 0.033, 0.06);
  gList[8] = new GrayScott(100, 360+10, 120, 0.029, 0.06);
  gList[9] = new GrayScott(100, 480+10, 120, 0.025, 0.06);
  
  gList[10] = new GrayScott(100, 0+10, 240, 0.020, 0.051);
  gList[11] = new GrayScott(100, 120+10,240, 0.022, 0.051);
  gList[12] = new GrayScott(100, 240+10, 240, 0.023, 0.051);
  gList[13] = new GrayScott(100, 360+10, 240, 0.024, 0.051);
  gList[14] = new GrayScott(100, 480+10, 240, 0.025, 0.051);
  
  gList[15] = new GrayScott(100, 0+10, 360, 0.036, 0.065);
  gList[16] = new GrayScott(100, 120+10, 360, 0.037, 0.065);
  gList[17] = new GrayScott(100, 240+10, 360, 0.038, 0.065);
  gList[18] = new GrayScott(100, 360+10, 360, 0.039, 0.065);
  gList[19] = new GrayScott(100, 480+10, 360, 0.04, 0.065);
  
  gList[20] = new GrayScott(100, 0+10, 480, 0.010, 0.05);
  gList[21] = new GrayScott(100, 120+10, 480, 0.011, 0.05);
  gList[22] = new GrayScott(100, 240+10, 480, 0.012, 0.05);
  gList[23] = new GrayScott(100, 360+10, 480, 0.013, 0.05);
  gList[24] = new GrayScott(100, 480+10, 480, 0.014, 0.05);


  //gList[5] = new GrayScott(100, 0+10, 120, 0.022, 0.065);
  //gList[6] = new GrayScott(100, 120+10, 120, 0.04, 0.065);


  //gList[6] = new GrayScott(100, 0+10, 240, 0.025, 0.05);
  //gList[7] = new GrayScott(100, 0+10, 360, 0.025, 0.05);
  //gList[8] = new GrayScott(100, 0+10, 480, 0.025, 0.05);

  for (int i=0; i<gList.length; i++) {
    gList[i].setup();
  }
}


void draw()
{
  background(255);
  for (int i=0; i<gList.length; i++) {
    gList[i].draw();
  }

  if (frameCount < 1200) {
    saveFrame("frames/####.tif");
    println(frameCount);
  }
  if (frameCount == 1200) {
    for (int i=0; i<gList.length; i++) {
      gList[i].drawCaption();
    }
    println("done");
    saveFrame("####.tif");
  }
}


class GrayScott 
{
  int SPACE_GRID_SIZE = 120;
  float dx = 0.01;
  float dt = 1;
  int VISUALIZATION_STEP = 8;
  int SQUARE_SIZE = 10;
  int x, y = 0;

  float Du = 2e-5;
  float Dv = 1e-5;
  float f = 0.04; 
  float k = 0.06;

  float u[][];
  float v[][];


  GrayScott(int space_grid_size, int x, int y, float f, float k)
  {
    SPACE_GRID_SIZE = space_grid_size;
    this.x = x;
    this.y = y;
    this.f = f;
    this.k = k;
  }


  void setup()
  {
    // init
    u = ones(SPACE_GRID_SIZE, SPACE_GRID_SIZE);
    v = zeros(SPACE_GRID_SIZE, SPACE_GRID_SIZE);

    // put square to center
    for (int i=0; i<u.length; i++) {
      for (int j=0; j<u[i].length; j++) {
        if (i >= (SPACE_GRID_SIZE/2-SQUARE_SIZE/2) && i < (SPACE_GRID_SIZE/2+SQUARE_SIZE/2) ) {
          if (j >= (SPACE_GRID_SIZE/2-SQUARE_SIZE/2) && j < (SPACE_GRID_SIZE/2+SQUARE_SIZE/2) ) {
            u[i][j] = 0.5;
          }
        }
      }
    }
    for (int i=0; i<v.length; i++) {
      for (int j=0; j<v[i].length; j++) {
        if (i >= (SPACE_GRID_SIZE/2-SQUARE_SIZE/2) && i < (SPACE_GRID_SIZE/2+SQUARE_SIZE/2) ) {
          if (j >= (SPACE_GRID_SIZE/2-SQUARE_SIZE/2) && j < (SPACE_GRID_SIZE/2+SQUARE_SIZE/2) ) {
            v[i][j] = 0.25;
          }
        }
      }
    }

    // add noise
    u = add(u, mul(rand(SPACE_GRID_SIZE, SPACE_GRID_SIZE), 0.1));
    v = add(v, mul(rand(SPACE_GRID_SIZE, SPACE_GRID_SIZE), 0.1));
  }


  void draw()
  {
    for (int i=0; i<VISUALIZATION_STEP; i++) {
      // calc laplacian
      float rolls_u[][] = add(add(roll(u, 1, 0), roll(u, -1, 0)), add(roll(u, 1, 1), roll(u, -1, 1)));
      float laplacian_u[][] = div(sub(rolls_u, mul(4, u)), dx*dx);

      float rolls_v[][] = add(add(roll(v, 1, 0), roll(v, -1, 0)), add(roll(v, 1, 1), roll(v, -1, 1)));
      float laplacian_v[][] = div(sub(rolls_v, mul(4, v)), dx*dx);

      // Gray-Scott
      float dudt1[][] = mul(Du, laplacian_u);
      float dudt_uuv[][] = mul(u, mul(v, v));
      float dudt3[][] = mul(f, sub(1.0, u));
      float dudt[][] = add(sub(dudt1, dudt_uuv), dudt3);

      float dvdt1[][] = mul(Dv, laplacian_v);
      float dvdt3[][] = mul(f+k, v);
      float dvdt[][] = sub(add(dvdt1, dudt_uuv), dvdt3);

      u = add(u, mul(dt, dudt));
      v = add(v, mul(dt, dvdt));
    }

    // visualize
    for (int i=0; i<u.length; i++) {
      for (int j=0; j<u[i].length; j++) {
        stroke(map(u[i][j], 0, 1, 0, 255));
        point(i+x, j+y);
      }
    }
  }

  void drawCaption()
  {
    fill(10);
    textAlign(CENTER);
    text("f="+str(f)+" k="+str(k), x+10+SPACE_GRID_SIZE/2, SPACE_GRID_SIZE+y+12);
  }
}
