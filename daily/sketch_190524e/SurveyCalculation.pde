/*--- sqr cub */
double SQR(double x)
{
  return x*x;
}


double CUB(double y)
{
  return y*y*y;
}


/*--- WGS84 */
double A = 6378137.0;       /* Semi-major axis */
double ONE_F = 298.257223563;   /* 1/F */
double B = (A*(1.0 - 1.0/ONE_F));
double E2 = ((1.0/ONE_F)*(2-(1.0/ONE_F)));
double ED2 = (E2*A*A/(B*B));
double NN(double p) {
  return (A/Math.sqrt(1.0 - (E2)*SQR(Math.sin(p*PI/180.0))));
}

double C = 2.99792458E+08;  /* Speed of light */
double MU = 3.986005E+14;    /* Earth's universal gravity */
double OMEGADOTE = 7.2921151467E-05; /* Earth's rotation rate (rad/s) */
double F = -4.442807633E-10; /* F sec/m^(1/2) */



double[] matvec(double[][] inmat, double[] v1)
{
  int i, j;
  double[] ret_v = new double[3];

  for (i=0; i<ret_v.length; i++) ret_v[i]=0.0;
  for (i=0; i<inmat.length; i++) {
    for (j=0; j<inmat[i].length; j++) ret_v[i] = ret_v[i] + inmat[i][j] * v1[j];
  }
  return ret_v;
}



double[][] matmat(double[][] m1, double[][] m2)
{
  int i, j, k;
  double[][] ret_mat = new double[3][3];
  int mcount = m1[0].length;

  for (i=0; i<ret_mat.length; i++) {
    for (j=0; j<ret_mat[i].length; j++) ret_mat[i][j]=0.0;
  }

  for (i=0; i<ret_mat.length; i++) {
    for (j=0; j<ret_mat[i].length; j++) {
      for (k=0; k<mcount; k++) {
        ret_mat[i][j] += m1[i][k] * m2[k][j] ;
      }
    }
  }
  return ret_mat;
}



double[][] rotx(double sita)
{
  double[][] rota = new double[3][3];

  rota[0][0] = 1;
  rota[0][1] = 0;
  rota[0][2] = 0;

  rota[1][0] = 0;
  rota[1][1] = Math.cos(sita*PI/180.0);
  rota[1][2] = Math.sin(sita*Math.PI/180.0);

  rota[2][0] = 0;
  rota[2][1] = -Math.sin(sita*Math.PI/180.0);
  rota[2][2] = Math.cos(sita*Math.PI/180.0);

  return rota;
}



double[][] roty(double sita)
{
  double[][] rota = new double[3][3];

  rota[0][0] = Math.cos(sita*Math.PI/180.0);
  rota[0][1] = 0;
  rota[0][2] = -Math.sin(sita*Math.PI/180.0);

  rota[1][0] = 0;
  rota[1][1] = 1;
  rota[1][2] = 0;

  rota[2][0] = Math.sin(sita*Math.PI/180.0);
  rota[2][1] = 0;
  rota[2][2] = Math.cos(sita*Math.PI/180.0);

  return rota;
}



double[][] rotz(double sita)
{
  double[][] rota = new double[3][3];

  rota[0][0] = Math.cos(sita*Math.PI/180.0);
  rota[0][1] = Math.sin(sita*Math.PI/180.0);
  rota[0][2] = 0;

  rota[1][0] = -Math.sin(sita*Math.PI/180.0);
  rota[1][1] = Math.cos(sita*Math.PI/180.0);
  rota[1][2] = 0;

  rota[2][0] = 0;
  rota[2][1] = 0;
  rota[2][2] = 1;

  return rota;
}



/*--- blh2ecef */
double[] blh2ecef(double lat, double lon, double het)
{
  double[] ecef = new double[3];

  ecef[0] = (NN(lat)+het)*Math.cos(lat*Math.PI/180.)*Math.cos(lon*Math.PI/180.);
  ecef[1] = (NN(lat)+het)*Math.cos(lat*Math.PI/180.)*Math.sin(lon*Math.PI/180.);
  ecef[2] = (NN(lat)*(1-E2)+het)*Math.sin(lat*Math.PI/180.);

  return ecef;
}



/*--- ecef2blh */
double[] ecef2blh(double[] ec)
{
  double[] blh = new double[3];
  double phi, ramda, het, p; 
  double x, y, z;
  double sita;

  x = ec[0];
  y = ec[1]; 
  z = ec[2];

  p = Math.sqrt(x*x + y*y);
  sita = (180./Math.PI) * Math.atan2(z*A, p*B);

  phi = (180./Math.PI) * Math.atan2(z+ED2*B*(CUB(Math.sin(sita*Math.PI/180.))), (p-E2*A*(CUB(Math.cos(sita*Math.PI/180.)))));  
  ramda = (180./Math.PI) * Math.atan2(y, x);
  het = (p / Math.cos(phi*Math.PI/180.)) - NN(phi);   

  blh[0] = phi; 
  blh[1] = ramda; 
  blh[2] = het;

  return blh;
}



double[] ecef2enu(double[] dest, double[] origin)
{
  int i;
  double[] mov = new double[3];
  double[] ret = new double[3];
  double[] blh = new double[3];

  double[][] rotyp = new double[3][3];
  double[][] rotzp1 = new double[3][3];
  double[][] rotzp2 = new double[3][3];

  double[][] mat_conv1 = new double[3][3];
  double[][] mat_conv2 = new double[3][3];

  blh = ecef2blh(origin);

  rotzp1 = rotz(90.0);
  rotyp  = roty(90.0 - blh[0]);
  rotzp2 = rotz(blh[1]);

  mat_conv1 = matmat(rotzp1, rotyp);
  mat_conv2 = matmat(mat_conv1, rotzp2);

  for (i=0; i<3; i++) mov[i] = dest[i] - origin[i];
  ret = matvec(mat_conv2, mov);
  return ret;
}
