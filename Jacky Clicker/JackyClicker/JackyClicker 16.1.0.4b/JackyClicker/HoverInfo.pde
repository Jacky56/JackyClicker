//display information about this thing when mouse hover

public class HoverInfo {
  float sizeX,sizeY;
  color background,textColor;
  String text;
  float textSize;
  
  String title;
  float padding;
  
  float objX,objY,objSizeX,objSizeY;
  
  color lineColor;
  float lineSize;
  float[] curve = new float[4];
  
  public HoverInfo(String title, String text,float textSize,color textColor,float sizeX,float padding,color background,float objX, float objY,float objSizeX,float objSizeY) {
    this.sizeX = sizeX;
    this.background = background;
    this.textSize = textSize;
    this.textColor = textColor;
    
    this.objX = objX;
    this.objY = objY;
    this.objSizeX = objSizeX;
    this.objSizeY = objSizeY;
    
    
    this.title = title;
    this.text = wrapText(text,textSize,sizeX-padding*2);
    this.sizeY = (textSize*1.6)*wrapNumber(text,textSize,sizeX-padding*2)+textSize*2;
    this.padding = padding;
    this.lineSize = 1;
    this.lineColor = color(0);
  }
  
  public HoverInfo(String title, String text,float textSize,color textColor,float sizeX,float padding,color background,float objX, float objY,float objSizeX,float objSizeY,float curve,float lineSize, color lineColor) {
    this(title,text,textSize,textColor,sizeX,padding, background, objX, objY, objSizeX, objSizeY);


    for(int n = 0 ;n < 4; n++) {
      this.curve[n] = curve;
    }    
    this.lineSize = lineSize;
    this.lineColor = lineColor;
    this.padding = padding;
  }
  
  //not in use
  void updatePosition(float x,float y) {
    objX = x;
    objY = y;
  }
  
  void updateDescription(String title, String text) {
    this.title = title;
    this.text = wrapText(text,textSize,sizeX-padding*2);
    this.sizeY = (textSize*1.6)*wrapNumber(text,textSize,sizeX-padding*2)+textSize*2;    
  }
  
  
  
  void draw() {
    if(mouseOn() && text.length() > 1) {
      pushMatrix();
      reposition();
      stroke(lineColor);
      strokeWeight(lineSize);
      fill(background);
      rect(0,0,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
      
      
      textAlign(TOP,TOP);
      textSize(textSize);
      fill(textColor);
      text(title,sizeX-textWidth(title)-padding,padding);
      text(text,padding,textSize*2);
      popMatrix();
    }
  }
  
  void reposition() {
    if(mouseX < width/2) {
      translate(mouseX,0);
    } else {
      translate(mouseX-sizeX,0);
    }
    if(mouseY < height/2) {
      translate(0,mouseY);
    } else {
      translate(0,mouseY-sizeY);
    }
  }
  
  boolean mouseOn() {
    if(mouseX > objX && mouseX < objX+objSizeX &&
    mouseY > objY && mouseY < objY+objSizeY) {
      return true;
    } else {
      return false;
    }
  }
  
}