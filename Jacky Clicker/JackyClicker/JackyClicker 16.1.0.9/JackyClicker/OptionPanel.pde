protected class OptionPanel extends GeneralPanel {
  protected Button SaveButton;
  protected OptionPanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    SaveButton = new Button("Save Game","Gave your current progress. (The game auto saves every 60 seconds)",x+padding,y+padding + 30,sizeX-padding*2,30,3,color(150),color(255),16,color(100),3);
  }
  
  protected void ActionEvent(Player pl,ArrayList<AreaDungeon> ad) {
    if(SaveButton.wasClicked) {
      SaveButton.wasClicked = false;
      SaveTime = 61;
      saveGame(pl,ad);
    }
  }
  
  
  @Override
  public void draw() {
    if(show) {
      super.draw();
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Option",x+padding,y+padding);
      SaveButton.draw();
    }
  }
  
  public void HoverEvent() {
    if(show) {
      SaveButton.hoverInfo.draw();
    }
  }
  
  public void mouseReleased() {
    if(show) {
      SaveButton.mouseReleased();
    }
  }
  
  public void mousePressed() {
    if(show) {
      SaveButton.mousePressed();
    }
  }  
  
}