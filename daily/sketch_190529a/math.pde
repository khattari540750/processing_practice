void printMat(float a[][])
{
  for (int i=0; i<a.length; i++) {
    for (int j=0; j<a[i].length; j++) {
      print(a[i][j]);
      print(", ");
    }
    println();
  }
  println();
}


float[][] ones(int dim1, int dim2)
{
  float ret[][] = new float[dim1][dim2];
  for (int i=0; i<ret.length; i++) {
    for (int j=0; j<ret[i].length; j++) {
      ret[i][j] = 1.;
    }
  }
  return ret;
}


float[][] zeros(int dim1, int dim2)
{
  float ret[][] = new float[dim1][dim2];
  for (int i=0; i<ret.length; i++) {
    for (int j=0; j<ret[i].length; j++) {
      ret[i][j] = 0.;
    }
  }
  return ret;
}


float[][] rand(int dim1, int dim2)
{
  float ret[][] = new float[dim1][dim2];
  for (int i=0; i<ret.length; i++) {
    for (int j=0; j<ret[i].length; j++) {
      ret[i][j] = random(1);
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


float[][] mul(float b, float a[][])
{
  float ret[][] = new float[a.length][a[0].length];
  for (int i=0; i<a.length; i++) {
    for (int j=0; j<a[i].length; j++) {
      ret[i][j] = b * a[i][j];
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
