// dont very generic and not implimented in the game
public class InventoryPanel extends GeneralPanel {
  public InventoryPanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
  }
  
  public void draw(Player pl) {
    if(show) {
      super.draw();
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Inventory",x+padding,y+padding);     
      
      
      
      stroke(120);
      strokeWeight(2);
      fill(180);
      rect(x+sizeX -padding -13,y+sizeY-padding -15,13,13,0,20,0,20);
      fill(200);
      textSize(13);
      textAlign(TOP,BOTTOM);
      text("Zeny",x+padding,y+sizeY-padding);
      text(pl.Zeny+"",x+sizeX - padding - textWidth(pl.Zeny+"") - 15,y+sizeY - padding);
      
    }
  }
  
}