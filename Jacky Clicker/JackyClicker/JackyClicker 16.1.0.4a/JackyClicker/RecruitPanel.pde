public class RecruitPanel extends GeneralPanel {
  
  Button RecruitConfigureButton;
  RecruitConfigurePanel RCP;
  public RecruitPanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize,RecruitConfigurePanel RCP) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    show = true;
    this.RCP = RCP;
    RecruitConfigureButton = new Button("M","Manage your recruits.",x+sizeX - 20 - padding,y +padding,20,20,2,color(150),color(255),13,color(255),1);
    RecruitConfigureButton.hoverInfo.title = "Manage";
  }
  
  public void ActionEvent(Player pl) {
    if(show) {
      RCP.ActionEvent(pl);
      for(int n = 0; n < pl.guildUnit.size();n++){
        pl.guildUnit.get(n).ActionEvent();
      }
      if(RecruitConfigureButton.wasClicked) {
        RecruitConfigureButton.wasClicked = false;
        RCP.show = !RCP.show;
      }
    }
  }
  
  
  public void HoverEvent(Player pl) {
    if(show) {
      RCP.HoverEvent(pl);
      RecruitConfigureButton.hoverInfo.draw();
      for(int n = 0; n < pl.guildUnit.size();n++){
        pl.guildUnit.get(n).UnitAsButton.hoverInfo.draw();
        pl.guildUnit.get(n).MoodBar.BarInfo.draw();
      }
    }
  }
  
  
  public void TimeEvent(Player pl) {
    RCP.TimeEvent(pl);
    for(int n = 0; n < pl.guildUnit.size();n++){
      pl.guildUnit.get(n).TimeEvent();
    }
    
    if(show) {
      for(int n = 0; n < pl.guildUnit.size();n++){
        pl.guildUnit.get(n).UnitAsButton.UpdatePosition(x+padding + 55*n,y+sizeY - padding - 50);
        pl.guildUnit.get(n).MoodBar.UpdatePosition(x+padding + 55*n,y+sizeY - padding - 65);
        pl.guildUnit.get(n).MoodBar.updateBar(pl.guildUnit.get(n).currentMood,pl.guildUnit.get(n).Mood);
      }
    }
  }
  
  public void draw(Player pl) {
    if(show) {
      super.draw();
      
      RCP.draw(pl);
      
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Recruits",x+padding,y+padding);     
      RecruitConfigureButton.draw();
      
      for(int n = 0; n < pl.guildUnit.size();n++){
        pl.guildUnit.get(n).draw();
        pl.guildUnit.get(n).MoodBar.draw();
      }
      
    }
  }
  
  public void mouseReleased(Player pl) {
    if(show) {
      RCP.mouseReleased(pl);
      RecruitConfigureButton.mouseReleased();
      for(int n = 0; n < pl.guildUnit.size();n++){
        pl.guildUnit.get(n).UnitAsButton.mouseReleased();
      }
    }
  }
  
  public void mousePressed(Player pl) {
    if(show) {
      RCP.mousePressed(pl);
      RecruitConfigureButton.mousePressed();
      for(int n = 0; n < pl.guildUnit.size();n++){
        pl.guildUnit.get(n).UnitAsButton.mousePressed();
      }  
    }
  }

  void mouseWheel(MouseEvent event) {
    if(show) {
      RCP.mouseWheel(event);
    }
  } 
  
}