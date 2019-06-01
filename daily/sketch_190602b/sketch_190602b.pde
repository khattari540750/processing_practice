import joons.JoonsRenderer;

JoonsRenderer jr;

//camera declarations
float eyeX = 0;
float eyeY = 0;
float eyeZ = 0;
float centerX = 0;
float centerY = 0;
float centerZ = -1;
float upX = 0;
float upY = 1;
float upZ = 0;
float fov = PI / 4; 
float aspect = 4/3f;  
float zNear = 5;
float zFar = 10000;


void setup()
{
  size(800, 600, P3D);
  jr = new JoonsRenderer(this);
  jr.setSampler("ipr");
  jr.setSizeMultiplier(1);
  jr.setAA(-2, 0, 1);
  jr.setCaustics(1);
}


void draw()
{
  jr.beginRecord();
  camera();
  perspective();
  
  camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  perspective(fov, aspect, zNear, zFar);

  jr.background(100);
  jr.background("gi_instant");

  pushMatrix();
  translate(0, 0, -120);
  jr.background("cornell_box", 100, 100, 100);
  popMatrix();

  pushMatrix();
  translate(-40, 20, -140);
  
  pushMatrix();
  rotateY(-PI/8);

  jr.fill("light", 5, 5, 5);
  sphere(13);
  translate(27, 0, 0);

  jr.fill("mirror", 255, 255, 255);
  sphere(13);
  translate(27, 0, 0);
  
  popMatrix();
  
  rotateY(PI/8);
  translate(-10, -27, 30);

  jr.fill("glass", 255, 255, 255);
  sphere(13);
  translate(27, 0, 0);

  popMatrix();

  jr.endRecord();
  jr.displayRendered(true);

  surface.setTitle(""+frameRate);
}


void keyPressed()
{
  if (key=='r'||key=='R') jr.render();
}
