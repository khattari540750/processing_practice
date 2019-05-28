int SPACE_GRID_SIZE = 256;
float dx = 0.01;
float dt = 1;
int VISUALIZATION_STEP = 8;
int SQUARE_SIZE = 20;

float Du = 2e-5;
float Dv = 1e-5;

float f = 0.04;
float k = 0.06;

float u[][];
float v[][];


void settings()
{
  size(SPACE_GRID_SIZE, SPACE_GRID_SIZE);
}


void setup()
{
  // initialized
  u = new float[SPACE_GRID_SIZE][SPACE_GRID_SIZE];
  for (int i=0; i<u.length; i++) {
    for (int j=0; j<u[i].length; j++) {
      u[i][j] = 1.;
    }
  }
  v = new float[SPACE_GRID_SIZE][SPACE_GRID_SIZE];
  for (int i=0; i<v.length; i++) {
    for (int j=0; j<v[i].length; j++) {
      v[i][j] = 0.;
    }
  }

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
  for (int i=0; i<u.length; i++) {
    for (int j=0; j<u[i].length; j++) {
      u[i][j] += random(0.1);
    }
  }
  for (int i=0; i<v.length; i++) {
    for (int j=0; j<v[i].length; j++) {
      v[i][j] += random(0.1);
    }
  }

  //for (int i=0; i<u.length; i++) {
  //  for (int j=0; j<u[i].length; j++) {
  //    print(u[i][j]);
  //    print(",");
  //  }
  //  println();
  //}

  //for (int i=0; i<v.length; i++) {
  //  for (int j=0; j<v[i].length; j++) {
  //    print(v[i][j]);
  //    print(",");
  //  }
  //  println();
  //}
}

void draw()
{
  background(255);
  
  for (int i=0; i<VISUALIZATION_STEP; i++) {
    // calc laplasian u
    float u1[][] = roll(u, 1, 0);
    float u2[][] = roll(u, -1, 0);
    float u3[][] = roll(u, 1, 1);
    float u4[][] = roll(u, -1, 1);
    float u5[][] = mul(u, 4);
    float u6 = dx*dx;
    float u12[][] = add(u1, u2);
    float u34[][] = add(u3, u4);
    float u1234[][] = add(u12, u34);
    float u12345[][] = sub(u1234, u5);
    float laplacian_u[][] = div(u12345, u6);

    // calc laplasian v
    float v1[][] = roll(v, 1, 0);
    float v2[][] = roll(v, -1, 0);
    float v3[][] = roll(v, 1, 1);
    float v4[][] = roll(v, -1, 1);
    float v5[][] = mul(v, 4);
    float v6 = dx*dx;
    float v12[][] = add(v1, v2);
    float v34[][] = add(v3, v4);
    float v1234[][] = add(v12, v34);
    float v12345[][] = sub(v1234, v5);
    float laplacian_v[][] = div(v12345, v6);

    //
    float dudt_dulapu[][] = mul(laplacian_u, Du);
    float dudt_uv[][] = mul(u, v);
    float dudt_uvv[][] = mul(dudt_uv, v);
    float dudt_1_u[][] = sub(1, u);
    float dudt_f_1_u[][] = mul(dudt_1_u, f);
    float dudt1[][] = sub(dudt_dulapu, dudt_uvv);
    float dudt[][] = add(dudt1, dudt_f_1_u);

    //
    float dvdt_dvlapv[][] = mul(laplacian_v, Dv);
    float dvdt_uv[][] = mul(u, v);
    float dvdt_uvv[][] = mul(dvdt_uv, v);
    float dvdt_f_k = f+k;
    float dvdt_f_k_v[][] = mul(v, dvdt_f_k);
    float dvdt1[][] = add(dvdt_dvlapv, dvdt_uvv);
    float dvdt[][] = sub(dvdt1, dvdt_f_k_v);

    //
    float tu[][] = mul(dudt, dt);
    u = add(u, tu);

    float tv[][] = mul(dvdt, dt);
    v = add(v, tv);
  }

  for (int i=0; i<u.length; i++) {
    for (int j=0; j<u[i].length; j++) {
      fill(u[i][j]*255);
      point(i,j);
      print(u[i][j]);
      print(",");
    }
    println();
  }
  println();
}







float[][] add(float a[][], float b)
{
  float ret[][] = new float[a.length][a[0].length];
  for (int i=0; i<a.length; i++) {
    for (int j=0; j<a[i].length; j++) {
      ret[i][j] = a[i][j] + b;
    }
  }
  return ret;
}

float[][] add(float a[][], float b[][])
{
  float ret[][] = new float[a.length][a[0].length];
  for (int i=0; i<a.length; i++) {
    for (int j=0; j<a[i].length; j++) {
      ret[i][j] = a[i][j] + b[i][j];
    }
  }
  return ret;
}

float[][] sub(float a[][], float b[][])
{
  float ret[][] = new float[a.length][a[0].length];
  for (int i=0; i<a.length; i++) {
    for (int j=0; j<a[i].length; j++) {
      ret[i][j] = a[i][j] - b[i][j];
    }
  }
  return ret;
}

float[][] sub(float b, float a[][])
{
  float ret[][] = new float[a.length][a[0].length];
  for (int i=0; i<a.length; i++) {
    for (int j=0; j<a[i].length; j++) {
      ret[i][j] = b - a[i][j];
    }
  }
  return ret;
}


float[][] mul(float a[][], float b[][])
{
  float ret[][] = new float[a.length][a[0].length];
  for (int i=0; i<a.length; i++) {
    for (int j=0; j<a[i].length; j++) {
      ret[i][j] = a[i][j] * b[i][j];
    }
  }
  return ret;
}


float[][] mul(float a[][], float b)
{
  float ret[][] = new float[a.length][a[0].length];
  for (int i=0; i<a.length; i++) {
    for (int j=0; j<a[i].length; j++) {
      ret[i][j] = a[i][j] * b;
    }
  }
  return ret;
}

float[][] div(float a[][], float b)
{
  float ret[][] = new float[a.length][a[0].length];
  for (int i=0; i<a.length; i++) {
    for (int j=0; j<a[i].length; j++) {
      ret[i][j] = a[i][j] / b;
    }
  }
  return ret;
}

float[][] roll(float a[][], int i, int axis)
{
  float ret[][] = new float[a.length][a[0].length];

  if (i==1 && axis==0) {
    for (int j=0; j<a.length; j++) {
      int index = j-1;
      if (index < 0) index = a.length-1;
      ret[j] = a[index];
    }
  }
  if (i==1 && axis==1) {
    for (int j=0; j<a.length; j++) {
      for (int k=0; k<a[j].length; k++) {
        int index = k-1;
        if (index < 0) index = a[j].length-1;
        ret[j][k] = a[j][index];
      }
    }
  }
  if (i==-1 && axis==0) {
    for (int j=0; j<a.length; j++) {
      int index = j+1;
      if (index >= a.length) index = 0;
      ret[j] = a[index];
    }
  }
  if (i==-1 && axis==1) {
    for (int j=0; j<a.length; j++) {
      for (int k=0; k<a[j].length; k++) {
        int index = k+1;
        if (index >= a[j].length) index = 0;
        ret[j][k] = a[j][index];
      }
    }
  }
  return ret;
}
