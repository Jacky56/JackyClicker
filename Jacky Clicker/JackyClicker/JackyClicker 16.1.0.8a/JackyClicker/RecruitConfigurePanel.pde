public class RecruitConfigurePanel extends GeneralPanel {
  
  ScrollBar RecruitBody;
  float moveY = 30;
  
  Button PayForAll;
  
  Button Close;
  
  Button OverWorkButton;
  
  boolean OverWorkOn;
  
  
  double TotalDps;
  
  public RecruitConfigurePanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    
    Close = new Button("X","",x+sizeX - padding - 25,y+padding,25,25,2,color(150),color(255),12,color(100),3);
    RecruitBody = new ScrollBar(0,sizeY-padding*2-20,x+sizeX,y,8,sizeY,color(0,150),0,color(255),1);
    PayForAll = new Button("Pay All","Pay for all your recruits.",x+sizeX - padding - 100,y+padding,70,25,2,color(150),color(255),12,color(100),3);
    
    OverWorkButton = new Button("Over Time","Double your Recruits stats but x5 your recruits mood speed. The Stat increase will not affect recruits that are moody or on strike.",x+sizeX - padding - 175,y+padding,70,25,2,color(150),color(200,25,25),12,color(100),3);
    OverWorkButton.hoverInfo.title = "[OFF] Over Time";
  }
  
  public void ActionEvent(Player pl, RecruitPanel rP) {
    if(show) {
      
      if(OverWorkButton.wasClicked) {
        OverWorkButton.wasClicked = false;
        if(OverWorkOn == false) {
          OverWorkOn = true;
          OverWorkButton.textColor = color(25,200,25);
          OverWorkButton.hoverInfo.updateDescription("[ON] Over Time",OverWorkButton.infoDescription);
          rP.OverTimeButton.hoverInfo.updateDescription("[ON] Over Time",rP.OverTimeButton.infoDescription);
          rP.OverTimeButton.lineColor = color(25,200,25);
          rP.OverTimeButton.textColor = color(25,200,25);
        } else { 
          OverWorkOn = false;
          OverWorkButton.textColor = color(200,25,25);
          OverWorkButton.hoverInfo.updateDescription("[OFF] Over Time",OverWorkButton.infoDescription);
          rP.OverTimeButton.hoverInfo.updateDescription("[OFF] Over Time",rP.OverTimeButton.infoDescription);
          rP.OverTimeButton.lineColor = color(200,25,25);
          rP.OverTimeButton.textColor = color(200,25,25);
        }
        for(int n  = 0; n < pl.guildUnit.size(); n++) {
          pl.guildUnit.get(n).OverTime = OverWorkOn;
        }
      }
      
      if(PayForAll.wasClicked) {
        PayForAll.wasClicked = false;
        checkPayAllButton(pl);
      }
      
      if(Close.wasClicked) {
        Close.wasClicked = false;
        show = false;
      }
      for(int n = 0; n < pl.guildUnit.size();n++){
        if(pl.guildUnit.get(n).PayButton.wasClicked) {
          pl.guildUnit.get(n).PayButton.wasClicked = false;
          checkPayButton(pl.guildUnit.get(n),pl);
        } else if (pl.guildUnit.get(n).FireButton.wasClicked) {
          pl.guildUnit.get(n).FireButton.wasClicked = false;
          pl.guildUnit.get(n).FireEvent(pl);
          pl.guildUnit.remove(n);
        }
      }

    }    
  }
  
  void checkPayAllButton(Player pl) {
    for(int n = 0; n < pl.guildUnit.size(); n++) {
      if(pl.guildUnit.get(n).currentMood < 98) {
        checkPayButton(pl.guildUnit.get(n),pl);
      }
    }
  }
  
  void checkPayButton(GuildUnit gu,Player pl) {
    if(checkPayButtonPrice(gu,pl)) {
      pl.Zeny -= gu.PayPrice;
      popText.add(new PopText("-" +  gu.PayPrice + "z", 1, 1, mouseX,mouseY,20,color(150)));
      gu.currentMood = gu.Mood;
    } else {
      popText.add(new PopText("You broke kokudorei...", 1, 1, mouseX,mouseY,20,color(200,25,25)));
    }
  }
  
  boolean checkPayButtonPrice(GuildUnit gu,Player pl) {
    if(pl.Zeny >= gu.PayPrice) {
      return true;
    } else {
      return false;
    }
  }  
  
  
  
  
  public void HoverEvent(Player pl) {
    if(show) {
      PayForAll.hoverInfo.draw();
      OverWorkButton.hoverInfo.draw();
      if(mouseX > x && mouseX < x+sizeX &&
      mouseY > moveY + y && mouseY <  y + sizeY) {      
        for(int n = 0; n < pl.guildUnit.size();n++){
          pl.guildUnit.get(n).ExpBar.BarInfo.draw();
          pl.guildUnit.get(n).PayButton.hoverInfo.draw();
          pl.guildUnit.get(n).FireButton.hoverInfo.draw();
        }
      }
    }
  }
  
  
  public void TimeEvent(Player pl) {
    if(show) {
      RecruitBody.contentLength = 305* pl.guildUnit.size();
      
      TotalDps = 0;
      
      for(int n = 0; n < pl.guildUnit.size();n++){
        TotalDps += pl.guildUnit.get(n).TotalDmg;
        pl.guildUnit.get(n).ExpBar.updateBar(pl.guildUnit.get(n).CurrentExpGain,pl.guildUnit.get(n).ExpDiff);
        pl.guildUnit.get(n).ExpBar.sizeX = sizeX -pl.guildUnit.get(n).PayButton.sizeX-pl.guildUnit.get(n).FireButton.sizeX -  padding*4;
        pl.guildUnit.get(n).ExpBar.BarInfo.objSizeX = sizeX -pl.guildUnit.get(n).PayButton.sizeX-pl.guildUnit.get(n).FireButton.sizeX -  padding*4;
        pl.guildUnit.get(n).ExpBar.BarInfo.updateDescription("Experience","Your Recruit's Experence. " + pl.guildUnit.get(n).Exp + " Total Exp, the recruit needs "+ (pl.guildUnit.get(n).MaxExp - pl.guildUnit.get(n).Exp) + " to level up.");
      }
    }
  }
  
  public void draw(Player pl) {
    if(show) {
      super.draw();
      
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Manage Recruits",x+padding,y+padding);    
      Close.draw();
      PayForAll.draw();
      OverWorkButton.draw();
      RecruitBody.draw();
      
      clip(x,y+padding + moveY, sizeX,sizeY-padding*2 - moveY);
      for(int n = 0; n < pl.guildUnit.size(); n++) {
        RecruitInfo(pl.guildUnit.get(n),0,moveY + 10 + 300*n + RecruitBody.contentMove());
      }
      
      noClip();
    }
  }
  
  public void RecruitInfo(GuildUnit Gu,float cX,float cY) {
    
    
    
    textAlign(TOP,TOP);
    textSize(14);
    fill(255);
    text(Gu.Name,x+padding + cX,y+padding + cY);
    text("Level "+Gu.Level,x+sizeX-padding-textWidth("Level "+Gu.Level),y+padding + cY);
    
    
      

    
    textSize(12);
    fill(180);
    text("Vitality",x+padding +cX ,y+padding +cY +20);
    text((long)Gu.TotalVit+"",x+sizeX -padding - textWidth((long)Gu.TotalVit+"")+cX ,y+padding +cY +20);
    
    text("Strength",x+padding +cX ,y+padding +cY +35);
    text((long)Gu.TotalStr+"",x+sizeX -padding - textWidth((long)Gu.TotalStr+"")+cX ,y+padding +cY +35);    
    
    text("Endurance",x+padding +cX ,y+padding +cY +50);
    text((long)Gu.TotalEnd+"",x+sizeX -padding - textWidth((long)Gu.TotalEnd+"")+cX ,y+padding +cY +50);    
    
    text("Agility",x+padding +cX ,y+padding +cY +65);
    text((long)Gu.TotalAgi+"",x+sizeX -padding - textWidth((long)Gu.TotalAgi+"")+cX ,y+padding +cY +65);    
    
    text("Dexterity",x+padding +cX ,y+padding +cY +80);
    text((long)Gu.TotalDex+"",x+sizeX -padding - textWidth((long)Gu.TotalDex+"")+cX ,y+padding +cY +80);
    
    
    text("Health",x+padding +cX ,y+padding +cY + 100);
    text((long)Gu.TotalHp+"",x+sizeX -padding - textWidth((long)Gu.TotalHp+"")+cX ,y+padding +cY + 100);
    
    
    //wtf? Gu.TotalDmg*100/0 = infinity?
    text("Damage",x+padding +cX ,y+padding +cY +115);
    text("(Total "+ round((float)(Gu.TotalDmg*100/TotalDps)) +"%) " + (long)Gu.TotalDmg+"",x+sizeX -padding - textWidth("(Total "+ round((float)(Gu.TotalDmg*100/TotalDps)) +"%) " + (long)Gu.TotalDmg+"")+cX ,y+padding +cY +115);    


    text("Defence",x+padding +cX ,y+padding +cY +130);
    text((long)Gu.TotalDef+"",x+sizeX -padding - textWidth((long)Gu.TotalDef+"")+cX ,y+padding +cY +130);    
    
    text("Health Regen",x+padding +cX ,y+padding +cY +145);
    text((long)Gu.TotalRegHp+"",x+sizeX -padding - textWidth((long)Gu.TotalRegHp+"")+cX ,y+padding +cY +145);    
    
    text("Critical Rating",x+padding +cX ,y+padding +cY +160);
    text((long)Gu.TotalCrit+"",x+sizeX -padding - textWidth((long)Gu.TotalCrit+"")+cX ,y+padding +cY +160);
    
    text("Crit Damage",x+padding +cX ,y+padding +cY +175);
    text((long)Gu.TotalCritDmg+"",x+sizeX -padding - textWidth((long)Gu.TotalCritDmg+"")+cX ,y+padding +cY +175);      
    
    fill(255);
    text("Current Mood",x+padding +cX ,y+padding +cY +195);
    text((int)Gu.currentMood+"",x+sizeX -padding - textWidth((int)Gu.currentMood+"")+cX ,y+padding +cY +195); 
    
    text("Critical Mood Point",x+padding +cX ,y+padding +cY +210);
    text((int)Gu.MoodCriticalPoint+"",x+sizeX -padding - textWidth((int)Gu.MoodCriticalPoint+"")+cX ,y+padding +cY +210); 
    
    text("Mood Speed",x+padding +cX ,y+padding +cY +225);
    text((Gu.MoodSpeed+Gu.BonusMoodSpeed) +"",x+sizeX -padding - textWidth((Gu.MoodSpeed+Gu.BonusMoodSpeed)+"")+cX ,y+padding +cY +225);    
    
    Gu.ExpBar.UpdatePosition(x+padding + (Gu.ExpBar.sizeX/4) ,y+padding +cY +270);
    
    Gu.FireButton.UpdatePosition(x+padding +cX,y+padding +cY +250);
    Gu.PayButton.UpdatePosition(x+sizeX-padding-Gu.PayButton.sizeX +cX,y+padding +cY +250);
    Gu.ExpBar.draw();
    Gu.PayButton.draw();
    Gu.FireButton.draw();
    
    //length total Y = 280
    
    //text("Description:",x+padding +cX ,y+padding +cY +225);
    //fill(180);
    //text(wrapText(Gu.Description,12,sizeX-padding*2),x+padding +cX ,y+padding +cY +240);

  }
  
  
  
  
  public void mouseReleased(Player pl) {
    if(show) {
      PayForAll.mouseReleased();
      OverWorkButton.mouseReleased();
      Close.mouseReleased();
      RecruitBody.mouseReleased();
      if(mouseX > x && mouseX < x+sizeX &&
      mouseY > moveY + y && mouseY <  y + sizeY) {   
        for(int n = 0; n < pl.guildUnit.size();n++){
          pl.guildUnit.get(n).PayButton.mouseReleased();
          pl.guildUnit.get(n).FireButton.mouseReleased();
        }
      }
    }
  }
  
  public void mousePressed(Player pl) {
    if(show) {
      PayForAll.mousePressed();
      OverWorkButton.mousePressed();
      Close.mousePressed();
      RecruitBody.mousePressed();
      if(mouseX > x && mouseX < x+sizeX &&
      mouseY > moveY + y && mouseY <  y + sizeY) {   
        for(int n = 0; n < pl.guildUnit.size();n++){
          pl.guildUnit.get(n).PayButton.mousePressed();
          pl.guildUnit.get(n).FireButton.mousePressed();
        }
      }
    }
  }
  
  void mouseWheel(MouseEvent event) {
    if(show) {
      RecruitBody.mouseWheel(event,x,y,sizeX,sizeY);
    }
  }  
}