public class OptionPanel extends GeneralPanel {
  public OptionPanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
  }
  
  @Override
  public void draw() {
    if(show) {
      super.draw();
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Option",x+padding,y+padding);      
      
    }
  }
}