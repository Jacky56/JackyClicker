//a literial scroll bar

private class ScrollBar {
  private float sizeX,sizeY;
  private float x,y;
  private color background;
  private color lineColor;
  private float lineSize;
  private float[] curve = new float[4];
  
  private float contentLength;
  private float boxSize;
  
  private float inX,inY,inSizeX,inSizeY;

  
  private boolean mPress,mRel;
  
  //ArrayList<Button> scrollButton = new ArrayList<Button>();
  private ScrollBar(float contentLength,float boxSize, float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.background = background;
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    this.curve[0] = curve;
    this.curve[1] = curve;
    this.curve[2] = curve;
    this.curve[3] = curve;  
    
    this.contentLength = contentLength;
    this.boxSize = boxSize;
    
    inX = x;
    inY = y;
    inSizeX = sizeX;
    inSizeY = sizeY;
  }
  
  //draw bar
  public void draw() {
    updateInnerBarSize();
    if(contentLength/boxSize > 1) {
      stroke(lineColor);
      strokeWeight(lineSize);
      fill(background);
      rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
      
      
      fill(lineColor);
      rect(inX,inY,inSizeX,inSizeY,curve[0],curve[1],curve[2],curve[3]);
      if(mPress) {
        innerBarMove();
      }
    } else {
      inY = 0;
    }
    
  }
  
  //gets content length
  
  //void updateConentLength(float cL) {
  //  contentLength = 15+bu.size()*50;
  //}
  
  //gets the size of the inner bar
  public void updateInnerBarSize() {
    inSizeY = (sizeY*boxSize)/contentLength;
    correctInnerBarPosition();
  }
  
  //moves the innner bar
  public void innerBarMove() {
    inY = mouseY - inSizeY/2;
    correctInnerBarPosition();
  }
  
  //reposition the inner bar if its out of boundaries
  public void correctInnerBarPosition() {
    if (inY < y) {
      inY = y;
    } else if (inY > sizeY-inSizeY + y) {
      inY = sizeY-inSizeY +y;
    }    
  }
  
  //move the content which the scroll bar controls
  //temp
  public float contentMove() {
    return  -((inY-y)/(sizeY-inSizeY))*(contentLength-boxSize);
  }
  
  
  public void mouseReleased() {
    mPress = false;
  }  
  
  public void mousePressed() {
    if(mouseOn()) {
      mPress = true;
    }
  }
  
  public void mouseWheel(MouseEvent event,float cX,float cY,float cSX,float cSY) {
  if(mouseX > cX && mouseX < cX+cSX &&
    mouseY > cY && mouseY < cY+cSY) {
      inY += event.getCount()*25;
      correctInnerBarPosition();      
    }
  }

  
  
  
  boolean mouseOn() {
    if(mouseX > inX && mouseX < inX+inSizeX &&
    mouseY > inY && mouseY < inY+inSizeY) {
      return true;
    } else {
      return false;
    }
  }
}