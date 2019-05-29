int SPACE_GRID_SIZE = 120;
float dx = 0.01;
float dt = 1;
int VISUALIZATION_STEP = 8;
int SQUARE_SIZE = 10;

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
  background(255);

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
      point(i, j);
    }
  }
}
