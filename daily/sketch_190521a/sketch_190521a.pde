StringList typeList;
IntList sizeList;


void settings()
{
  size(600, 600);
}


void setup()
{
  background(0);

  typeList = new StringList();
  sizeList = new IntList();

  // integer type
  // 0
  typeList.append("byte"); 
  sizeList.append(8);

  // 1
  typeList.append("short");
  sizeList.append(16);

  // 2
  typeList.append("int");
  sizeList.append(32);

  // 3
  typeList.append("long");
  sizeList.append(64);

  // floating point type
  // 4
  typeList.append("float");
  sizeList.append(32);

  // 5
  typeList.append("double");
  sizeList.append(64);

  // 6
  typeList.append("char"); 
  sizeList.append(16);

  // 7
  typeList.append("boolean");
  sizeList.append(1);

  // processing original type
  // 8
  typeList.append("color");
  sizeList.append(64);
}


void draw()
{
  int index = int(random(typeList.size()));
  
  fill(random(256));
  textSize(float(sizeList.get(index))/2.);
  textAlign(CENTER);
  text(typeList.get(index), random(width), random(height));

  saveFrame("frames/######.jpg");
}
