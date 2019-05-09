public class PrestigeTavernPanel extends GeneralPanel {
  
  Button PrestigeButton;
  
  Button Close;

  HoverInfo hoverLevel;
  
  public PrestigeTavernPanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    
    Close = new Button("X","",x+sizeX - padding - 25,y+padding,25,25,2,color(150),color(255),12,color(100),3);
    PrestigeButton = new Button("Rebirth","You can rebirth anytime.",x+sizeX-padding - 100, y + sizeY - padding - 35,100,35,3,color(139,0,139),color(255),15,color(75,0,130),3);
    
    hoverLevel = new HoverInfo("Points from Levels","",15,color(255),175,7,color(25,25,200,150),x+padding,y+padding+60,textWidth("Level"),13,5,1,color(255));
  }
  
  public void ActionEvent(Player pl) {
    if(show) {
      if(PrestigeButton.wasClicked) {
        PrestigeButton.wasClicked = false;
        pl.CurrentPrestige += pl.PrestigeForLevel;
        pl.PrestigeLevelUp(pl.CurrentPrestige);
        show = !show;
        prestigePanel.show = true;
      }
      if(Close.wasClicked) {
        Close.wasClicked = false;
        show = !show;
      }
    }
  }
  //String.format("%.2f", CurrentValue)
  void TimeEvent(Player pl) {
    if(show) {
      hoverLevel.updateDescription(hoverLevel.title,"You gain 1 point per 100 levels. This bonus is multipled by "+ ((pl.PrestigeForLevelMultipler*100)-pl.Death) + "% (Dying loses 1% of this bonus, down to 0%, you have started with " + (pl.PrestigeForLevelMultipler*100)+"%");
    }
  }
  
  public void HoverEvent() {
    if(show) {
      PrestigeButton.hoverInfo.draw();
      hoverLevel.draw();
    }
  }
  
  
  
  public void draw(Player pl) {
    if(show) {
      super.draw();
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Rebirth",x+padding,y+padding);    
      Close.draw();
      PrestigeButton.draw();
      textAlign(TOP,TOP);
      fill(255,0,255);
      text("Prestige Points",x+padding,y+padding + 20);
      
      textSize(13);
      fill(255);
      text("Bosses:",x+padding,y+padding +45);  
      fill(255,0,255);
      text(pl.CurrentPrestige+"",x+sizeX-padding-textWidth(pl.CurrentPrestige+""),y+padding +45); 
      fill(255);
      text("Level:",x+padding,y+padding + 60);  
      fill(255,0,255);
      text(pl.PrestigeForLevel+"",x+sizeX-padding-textWidth(pl.PrestigeForLevel+""),y+padding+60);
      fill(255);
      text("Bonus(N/a):",x+padding,y+padding + 75);  
      fill(255,0,255);
      text(":)",x+sizeX-padding-textWidth(":)"),y+padding +75);
      textSize(20);
      fill(255);
      text("Total:",x+padding,y+sizeY-padding - 60);  
      fill(255,0,255);
      text((pl.CurrentPrestige + pl.PrestigeForLevel)+"",x+sizeX-padding-textWidth((pl.CurrentPrestige + pl.PrestigeForLevel)+""),y+sizeY-padding - 60);       
    }
  }
  
  
  public void mouseReleased() {
    if(show) {

      Close.mouseReleased();
      PrestigeButton.mouseReleased();
      
    }
  }
  
  public void mousePressed() {
    if(show) {
      Close.mousePressed();
      PrestigeButton.mousePressed();
    }
  }

}