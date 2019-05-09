//A general panel which is used to for creating children classes 
protected class GeneralPanel {
  protected float x,y;
  protected float sizeX,sizeY;
  protected color lineColor;
  protected float lineSize;
  protected color background;
  protected float[] curve = new float[4];
  protected float padding;
  //trigger event
  protected boolean show;
  //..
  protected GeneralPanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.background = background;
    this.padding = padding;
    
    show = false;
    
    for(int n = 0; n < 4; n++) {
      this.curve[n] = curve;
    }
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    
    
    
  }
  //..
  public void draw() {
    fill(background);
    stroke(lineColor);
    strokeWeight(lineSize);
    rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
  }
  
}