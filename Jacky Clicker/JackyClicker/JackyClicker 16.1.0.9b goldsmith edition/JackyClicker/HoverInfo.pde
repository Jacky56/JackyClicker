//display information about this thing when mouse hover

private class HoverInfo {
  private float sizeX,sizeY;
  private color background,textColor;
  private String text;
  private float textSize;
  
  private String title;
  private float padding;
  
  private float objX,objY,objSizeX,objSizeY;
  
  private color lineColor;
  private float lineSize;
  private float[] curve = new float[4];
  //....  
  private HoverInfo(String title, String text,float textSize,color textColor,float sizeX,float padding,color background,float objX, float objY,float objSizeX,float objSizeY) {
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
  //....  
  private HoverInfo(String title, String text,float textSize,color textColor,float sizeX,float padding,color background,float objX, float objY,float objSizeX,float objSizeY,float curve,float lineSize, color lineColor) {
    this(title,text,textSize,textColor,sizeX,padding, background, objX, objY, objSizeX, objSizeY);


    for(int n = 0 ;n < 4; n++) {
      this.curve[n] = curve;
    }    
    this.lineSize = lineSize;
    this.lineColor = lineColor;
    this.padding = padding;
  }
  //...  
  public void updatePosition(float x,float y) {
    objX = x;
    objY = y;
  }
  //...  
  public void updateDescription(String title, String text) {
    this.title = title;
    this.text = wrapText(text,textSize,sizeX-padding*2);
    this.sizeY = (textSize*1.6)*wrapNumber(text,textSize,sizeX-padding*2)+textSize*2;    
  }
  
  
  //...  
  public void draw() {
    if(mouseOn() && text.length() > 1) {
      pushMatrix();
      reposition();
      stroke(lineColor);
      strokeWeight(lineSize);
      fill(background);
      rect(0,0,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
      
      
      textAlign(TOP,TOP);
      textSize(textSize);
      fill(textColor,150);
      text(title,sizeX-textWidth(title)-padding,padding);
      fill(textColor);
      text(text,padding,textSize*2);
      popMatrix();
    }
  }
  //...  
  private void reposition() {
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
  //...  
  public boolean mouseOn() {
    if(mouseX > objX && mouseX < objX+objSizeX &&
    mouseY > objY && mouseY < objY+objSizeY) {
      return true;
    } else {
      return false;
    }
  }
  
}