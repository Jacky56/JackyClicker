public class RecruitPanel extends GeneralPanel {
  
  Button RecruitConfigureButton;
  RecruitConfigurePanel RCP;
  
  HoverInfo RecruitInfo;
  public RecruitPanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize,RecruitConfigurePanel RCP) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    show = true;
    this.RCP = RCP;
    RecruitConfigureButton = new Button("M","Manage your recruits.",x+sizeX - 20 - padding,y +padding,20,20,2,color(150),color(255),13,color(255),1);
    RecruitConfigureButton.hoverInfo.title = "Manage";
    
    //(String title, String text,float textSize,color textColor,float sizeX,float padding,color background,float objX, float objY,float objSizeX,float objSizeY,float curve,float lineSize, color lineColor) 
    String des = "Recruiting units will increase your Dps and some recruits will have special effects and they can level up. Moody(Orange) and Strike(Red) will reduce their Stats which you must pay them to rise their mood up! In addtion, exp will be shared amongst your recuits!";
    //hoverInfo = new HoverInfo(title,infoDescription,14,color(255),175,7,color(25,25,200,180),x,y,sizeX,sizeY,5,1,color(255));
    RecruitInfo = new HoverInfo("Recruiting",des,14,color(255),250,7,color(25,25,200,180),x+padding,y+padding,textWidth("Recruits"),20,5,1,color(255));
  }
  
  public void ActionEvent(Player pl,Enemy en) {
    if(show) {
      RCP.ActionEvent(pl);
      for(int n = 0; n < pl.guildUnit.size();n++){
        pl.guildUnit.get(n).ActionEvent(en);
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
      RecruitInfo.draw();
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
      
      //temp
      double dps = 0;
      
      for(int n = 0; n < pl.guildUnit.size();n++){
        dps += pl.guildUnit.get(n).TotalDmg;
        pl.guildUnit.get(n).draw();
        pl.guildUnit.get(n).MoodBar.draw();
      }
      
      textSize(16);
      fill(180);
      textAlign(TOP,TOP);
      text((long)dps + " DPS",x+sizeX-padding -textWidth((long)dps + " DPS") - 25,y+padding); 
      
    }
  }
  
  public void mouseReleased(Player pl) {
    if(show) {
      RCP.mouseReleased(pl);
      RecruitConfigureButton.mouseReleased();
      for(int n = 0; n < pl.guildUnit.size();n++){
        pl.guildUnit.get(n).mouseReleased();
      }
    }
  }
  
  public void mousePressed(Player pl) {
    if(show) {
      RCP.mousePressed(pl);
      RecruitConfigureButton.mousePressed();
      for(int n = 0; n < pl.guildUnit.size();n++){
        pl.guildUnit.get(n).mousePressed();
      }  
    }
  }

  void mouseWheel(MouseEvent event) {
    if(show) {
      RCP.mouseWheel(event);
    }
  } 
  
}