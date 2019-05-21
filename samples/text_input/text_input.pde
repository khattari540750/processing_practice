import controlP5.*;

ControlP5 cp5;
String textValue = "";


void setup() 
{
  size(700,400);
  
  PFont font = createFont("arial",20);
  
  cp5 = new ControlP5(this);
                 
  cp5.addTextfield("textValue")
     .setPosition(20,30)
     .setSize(200,40)
     .setFont(createFont("arial",20))
     .setAutoClear(false)
     ;
       
  cp5.addBang("clear")
     .setPosition(240,30)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;
     
  textFont(font);
}


void draw() 
{
  background(0);
  fill(255);
  text(cp5.get(Textfield.class,"textValue").getText(), 360,50);
  text(textValue, 360,180);
}


public void clear()
{
  cp5.get(Textfield.class,"textValue").clear();
}


void controlEvent(ControlEvent theEvent)
{
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }
}
