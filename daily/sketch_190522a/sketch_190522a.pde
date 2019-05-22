void settings()
{
  size(600,600);
}


void setup()
{
  background(0);
  
  char bin = 0b100100;
  char oct = 044;
  char dec = 36;
  char hex = 0x24;
  println(bin);
  println(oct);
  println(dec);
  println(hex);
  
  String binStr = binary(bin);
  String decStr = str(char(bin));
  String hexStr = hex(bin);
  println(binStr);
  println(decStr);
  println(hexStr);
}


void draw()
{
}
