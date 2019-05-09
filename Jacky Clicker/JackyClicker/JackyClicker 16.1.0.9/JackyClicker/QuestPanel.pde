protected class QuestPanel extends GeneralPanel {
  public QuestPanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
  }
  
  @Override
  public void draw() {
    if(show) {
      super.draw();
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Quest",x+padding,y+padding);
    }
  }
  
}