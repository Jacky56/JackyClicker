public class GeneralPanel {
  float x,y;
  float sizeX,sizeY;
  color lineColor;
  float lineSize;
  color background;
  float[] curve = new float[4];
  float padding;
  
  boolean show;
  public GeneralPanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
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
  
  public void draw() {
    fill(background);
    stroke(lineColor);
    strokeWeight(lineSize);
    rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
  }
  
}