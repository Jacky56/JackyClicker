public class CharacterPanel {
  float x,y;
  float sizeX,sizeY;
  color lineColor;
  float lineSize;
  color background;
  float[] curve = new float[4];
  
  boolean show;
  
  Button[] statButton = new Button[5];
  String[] statName = new String[5];
  String[] statDes = new String[5];
  
  
  float padding; 
  
  HoverInfo[] StatInfo = new HoverInfo[5];
  
  
  
  public CharacterPanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.background = background;
    this.padding = padding;
    show = true;
    
    for(int n = 0; n < 4; n++) {
      this.curve[n] = curve;
    }
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    
    //UnitAsButton = new Button(Name,Description,x,y,200,200,5,color(200,25,25),color(255),15,color(255),3);
    //Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,float textSize,color lineColor,float lineSize)
    for(int n = 0; n < statButton.length; n++) {
      statButton[n] = new Button("","",x+sizeX - 20 - padding, sizeY+y -padding - 20 - 25*n,20,20,2,color(200),color(255),20,color(255),1);
    }
    statName[0] = "Vitality";
    statDes[0] = "Each point gives 7 hp and each 10 points gives 1 hp regen."; 
    statName[1] = "Strength";
    statDes[1] = "Each point gives 2 damage."; 
    statName[2] = "Endurance";
    statDes[2] = "Each point gives 1 armor."; 
    statName[3] = "Agility";
    statDes[3] = "Each point gives 1 critial chance. don't upgrade, it does nothing."; 
    statName[4] = "Dexterity";
    statDes[4] = "Each point gives 1 critial damage. don't upgrade, it does nothing.";
    
    
    
    //BuffInfo = new HoverInfo(title,infoDescription,14,color(255),175,7,color(25,25,200,150),x,y,sizeX,sizeY,5,1,color(255));
    for(int n = 0; n < StatInfo.length; n++) {
      StatInfo[n] = new HoverInfo(statName[n],statDes[n],15,color(255),175,7,color(25,25,200,150),x + padding, sizeY+y -padding - 20 - 25*n,textWidth(statName[n]),20,5,1,color(255));
    }
  }
  
  void TimeEvent(Player pl) {
    //panelParty.PPP.get(n).DeathTimerButton.hoverInfo.updateDescription("Dead",pl.Name+ " is dead! Tap to revive faster. "+ round(pl.CurrentDeathTimer)+ " seconds remaining.");
    if(show) {
      statButton[0].hoverInfo.updateDescription("Vitality","Base VIT: " + (long)pl.CharVit);
      statButton[1].hoverInfo.updateDescription("Strength","Base STR: " + (long)pl.CharStr);
      statButton[2].hoverInfo.updateDescription("Endurance","Base END: " + (long)pl.CharEnd);
      statButton[3].hoverInfo.updateDescription("Agility","Base AGI: " + (long)pl.CharAgi);
      statButton[4].hoverInfo.updateDescription("Dexterity","Base DEX: " + (long)pl.CharDex);
    }
  }
  
  void ActionEvent(Player pl) {
    if(show) {
      HoldStat(pl);
      for(int n = 0; n < statButton.length; n++) {
        if (statButton[n].wasClicked) {
          statButton[n].wasClicked = false;
          ApplyStat(n,pl,1);
        }
      }
    }
  }
  
  //record how long u press
  float HoldTime;
  void HoldStat(Player pl) {
    for(int n = 0; n < statButton.length; n++) {
      if(statButton[n].mPress ) {
        HoldTime += 1/frameRate;
        if(HoldTime > 0.7) {
          ApplyStat(n, pl,(int)pow(HoldTime,4));
        }
      }
    }
  }
  
  void ApplyStat(int n,Player pl,int amount) {
    if(pl.StatPoints - amount >= 0) {
      switch(n) {
        case 0:
        pl.CharVit += amount;
        break;
        case 1:
        pl.CharStr += amount;
        break;
        case 2:
        pl.CharEnd += amount;
        break;
        case 3:
        pl.CharAgi += amount;
        break;
        case 4:
        pl.CharDex += amount;
        break;
      }
      pl.StatPoints -= amount;
      pl.updateStat();
    }    
  }
  
  
  void draw(Player pl) {
    
    if(show) {
      fill(background);
      stroke(lineColor);
      strokeWeight(lineSize);
      rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
      
      fill(255);
      textSize(15);
      textAlign(TOP,TOP);
      text(pl.Name,x+padding,y+padding);
      text("Level "+pl.Level,x+sizeX -padding - textWidth("Level "+pl.Level),y+padding);
      
      
      TotalContent(pl,0,30);
      BaseContent(pl,0,105);
      ItemContent(pl,0,160);
      BonusContent(pl,0,215);
      TotalContentAdv(pl,0,270);
      
      
      fill(255);
      textSize(15);
      textAlign(TOP,TOP);
      text("Points left:",x+padding,y+sizeY -padding - 140);      
      text(pl.StatPoints+"",x+sizeX -padding-textWidth(pl.StatPoints+""),y+sizeY -padding - 140);
      
      
      fill(255);
      textSize(15);
      textAlign(TOP,TOP);
      for(int n = 0; n < statName.length; n++) {
        text(statName[n],x + padding, sizeY+y -padding - 20 - 25*n);
      }
      
      //stat buttons
      for(int n = 0;n < statButton.length; n++) {
        statButton[n].draw();
      }
      
    }
  }
  
  void TotalContent(Player pl,float cX,float cY) {
    fill(255);
    textSize(13);
    textAlign(TOP,TOP);
    text("Vitality",x+padding +cX ,y+padding +cY);
    text((long)pl.TotalVit+"",x+sizeX -padding - textWidth((long)pl.TotalVit+"")+cX ,y+padding +cY);
    
    text("Strength",x+padding +cX ,y+padding +cY +15);
    text((long)pl.TotalStr+"",x+sizeX -padding - textWidth((long)pl.TotalStr+"")+cX ,y+padding +cY +15);    
    
    text("Endurance",x+padding +cX ,y+padding +cY +30);
    text((long)pl.TotalEnd+"",x+sizeX -padding - textWidth((long)pl.TotalEnd+"")+cX ,y+padding +cY +30);    
    
    text("Agility",x+padding +cX ,y+padding +cY +45);
    text((long)pl.TotalAgi+"",x+sizeX -padding - textWidth((long)pl.TotalAgi+"")+cX ,y+padding +cY +45);    
    
    text("Dexterity",x+padding +cX ,y+padding +cY +60);
    text((long)pl.TotalDex+"",x+sizeX -padding - textWidth((long)pl.TotalDex+"")+cX ,y+padding +cY +60);    
  }
  
  
  
  void TotalContentAdv(Player pl,float cX,float cY) {
    fill(255);
    textSize(13);
    textAlign(TOP,TOP);
    text("Health",x+padding +cX ,y+padding +cY);
    text((long)pl.TotalHp+"",x+sizeX -padding - textWidth((long)pl.TotalHp+"")+cX ,y+padding +cY);
    
    text("Damage",x+padding +cX ,y+padding +cY +15);
    text((long)pl.TotalDmg+"",x+sizeX -padding - textWidth((long)pl.TotalDmg+"")+cX ,y+padding +cY +15);    
    
    text("Defence",x+padding +cX ,y+padding +cY +30);
    text((long)pl.TotalDef+"",x+sizeX -padding - textWidth((long)pl.TotalDef+"")+cX ,y+padding +cY +30);    
    
    text("Health Regen",x+padding +cX ,y+padding +cY +45);
    text((long)pl.TotalRegHp+"",x+sizeX -padding - textWidth((long)pl.TotalRegHp+"")+cX ,y+padding +cY +45);    
    
    text("Critical Rating",x+padding +cX ,y+padding +cY +60);
    text((long)pl.TotalCrit+"",x+sizeX -padding - textWidth((long)pl.TotalCrit+"")+cX ,y+padding +cY +60);
    
    text("Crit Damage",x+padding +cX ,y+padding +cY +75);
    text((long)pl.TotalCritDmg+"",x+sizeX -padding - textWidth((long)pl.TotalCritDmg+"")+cX ,y+padding +cY +75);    
  }  
  
  
  void BaseContent(Player pl,float cX,float cY) {
    fill(180);
    textSize(10);
    textAlign(TOP,TOP);
    text("Base Vitality",x+padding +cX ,y+padding +cY);
    text((long)pl.CharVit+"",x+sizeX -padding - textWidth((long)pl.CharVit+"")+cX ,y+padding +cY);
    
    text("Base Strength",x+padding +cX ,y+padding +cY +10);
    text((long)pl.CharStr+"",x+sizeX -padding - textWidth((long)pl.CharStr+"")+cX ,y+padding +cY +10);    
    
    text("Base Endurance",x+padding +cX ,y+padding +cY +20);
    text((long)pl.CharEnd+"",x+sizeX -padding - textWidth((long)pl.CharEnd+"")+cX ,y+padding +cY +20);    
    
    text("Base Agility",x+padding +cX ,y+padding +cY +30);
    text((long)pl.CharAgi+"",x+sizeX -padding - textWidth((long)pl.CharAgi+"")+cX ,y+padding +cY +30);    
    
    text("Base Dexterity",x+padding +cX ,y+padding +cY +40);
    text((long)pl.CharDex+"",x+sizeX -padding - textWidth((long)pl.CharDex+"")+cX ,y+padding +cY +40);    
  }
  
  void ItemContent(Player pl,float cX,float cY) {
    fill(180);
    textSize(10);
    textAlign(TOP,TOP);
    text("Item Vitality",x+padding +cX ,y+padding +cY);
    text((long)pl.ItemVit+"",x+sizeX -padding - textWidth((long)pl.ItemVit+"")+cX ,y+padding +cY);
    
    text("Item Strength",x+padding +cX ,y+padding +cY +10);
    text((long)pl.ItemStr+"",x+sizeX -padding - textWidth((long)pl.ItemStr+"")+cX ,y+padding +cY +10);    
    
    text("Item Endurance",x+padding +cX ,y+padding +cY +20);
    text((long)pl.ItemEnd+"",x+sizeX -padding - textWidth((long)pl.ItemEnd+"")+cX ,y+padding +cY +20);    
    
    text("Item Agility",x+padding +cX ,y+padding +cY +30);
    text((long)pl.ItemAgi+"",x+sizeX -padding - textWidth((long)pl.ItemAgi+"")+cX ,y+padding +cY +30);    
    
    text("Item Dexterity",x+padding +cX ,y+padding +cY +40);
    text((long)pl.ItemDex+"",x+sizeX -padding - textWidth((long)pl.ItemDex+"")+cX ,y+padding +cY +40);    
  } 
  
  void BonusContent(Player pl,float cX,float cY) {
    fill(180);
    textSize(10);
    textAlign(TOP,TOP);
    text("Bonus Vitality",x+padding +cX ,y+padding +cY);
    text((long)pl.BonusVit+"",x+sizeX -padding - textWidth((long)pl.BonusVit+"")+cX ,y+padding +cY);
    
    text("Bonus Strength",x+padding +cX ,y+padding +cY +10);
    text((long)pl.BonusStr+"",x+sizeX -padding - textWidth((long)pl.BonusStr+"")+cX ,y+padding +cY +10);    
    
    text("Bonus Endurance",x+padding +cX ,y+padding +cY +20);
    text((long)pl.BonusEnd+"",x+sizeX -padding - textWidth((long)pl.BonusEnd+"")+cX ,y+padding +cY +20);    
    
    text("Bonus Agility",x+padding +cX ,y+padding +cY +30);
    text((long)pl.BonusAgi+"",x+sizeX -padding - textWidth((long)pl.BonusAgi+"")+cX ,y+padding +cY +30);    
    
    text("Bonus Dexterity",x+padding +cX ,y+padding +cY +40);
    text((long)pl.BonusDex+"",x+sizeX -padding - textWidth((long)pl.BonusDex+"")+cX ,y+padding +cY +40);    
  } 
  
  
  void HoverEvent() {
    if(show) {
      for(int n =0; n < statButton.length; n++) {
        statButton[n].hoverInfo.draw();
      }
      for(int n =0; n < StatInfo.length; n++) {
        StatInfo[n].draw();
      }      
    }
  }
  
  
  void mousePressed() {
    if(show) {
      for(int n = 0;n < statButton.length; n++) {
        statButton[n].mousePressed();
      }
    }    
  }
  
  void mouseReleased() {
    
    if(show) {
      HoldTime = 0;
      for(int n = 0;n < statButton.length; n++) {
        statButton[n].mouseReleased();
      }
    }      
  }
  
}