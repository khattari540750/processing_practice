int tileCount = 200;
ArrayList<PImage> imgList;


void settings()
{
  size(600, 600);
}


void setup()
{
  imgList = new ArrayList<PImage>();
  int sum = 0;
  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {
      sum += 1;
      String name = "frames/" + nf(sum,6) + ".tif";
      println(name);
      PImage img = loadImage(name);
      imgList.add(img);
    }
  }
  
  int suma = 0;
  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {
      suma += 1;
      int posX = width/tileCount*gridX;
      int posY = height/tileCount*gridY;
      image(imgList.get(suma),posX, posY);
    }
  }
}


void draw()
{
}
