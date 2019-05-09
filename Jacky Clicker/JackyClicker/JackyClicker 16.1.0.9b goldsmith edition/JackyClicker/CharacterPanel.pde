//..
protected class CharacterPanel extends GeneralPanel{
  private Button[] statButton = new Button[5];
  protected String[] statName = new String[5];
  protected String[] statDes = new String[5];
  
  private Button statAuto;
  private Button statAutoConfigure;
  
  private float moveY = 40;
  private float BodyLength = y+sizeY-padding-220;
  
  private HoverInfo[] StatInfo = new HoverInfo[5];
  
  
  private ScrollBar StatBody;
  
  public CharacterConfigurePanel cCP;
  
  protected boolean AutoOn;
  
  private long ChangeInLevel;
  //..  
  protected CharacterPanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize,CharacterConfigurePanel cCP,long Level) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    this.cCP = cCP;
    AutoOn = false;
    ChangeInLevel = Level;
    //UnitAsButton = new Button(Name,Description,x,y,200,200,5,color(200,25,25),color(255),15,color(255),3);
    //Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,float textSize,color lineColor,float lineSize)
    for(int n = 0; n < statButton.length; n++) {
     statButton[n] = new Button("","",x+sizeX - 20 - padding, sizeY+y -padding - 20 - 25*n,20,20,2,color(200),color(255),20,color(255),1);
    }
    
    //text(pl.StatPoints+"",x+sizeX -padding-textWidth(pl.StatPoints+""),y+sizeY -padding - 145);
    statAuto = new Button("A","Automatically allocate your stats every time you level up.",x+sizeX - 20 - padding,sizeY+y -padding - 145,20,20,2,color(200),color(200,25,25),12,color(200,25,25),1);
    statAutoConfigure = new Button("C","Configure your Auto stats.",x+sizeX - 20 - padding - 25,sizeY+y -padding - 145,20,20,2,color(150),color(255),12,color(255),1);
    
    statAuto.hoverInfo.title = "[OFF] Auto";
    statAutoConfigure.hoverInfo.title = "Configure";
    
    statName[0] = "Vitality";
    statDes[0] = "Each point gives 8 hp and each 25 points gives 1 hp regen."; 
    statName[1] = "Strength";
    statDes[1] = "Each point gives 1 damage."; 
    statName[2] = "Endurance";
    statDes[2] = "Each 2 point gives 1 armor."; 
    statName[3] = "Agility";
    statDes[3] = "Each point gives 1 critial rating. (Critical chance is capped at 39.5% for crit rating)"; 
    statName[4] = "Dexterity";
    statDes[4] = "Each point gives 1 critial damage. (Critical Damage gives 5% Increased damage)";
    
    
    
    //BuffInfo = new HoverInfo(title,infoDescription,14,color(255),175,7,color(25,25,200,150),x,y,sizeX,sizeY,5,1,color(255));
    for(int n = 0; n < StatInfo.length; n++) {
      StatInfo[n] = new HoverInfo(statName[n],statDes[n],15,color(255),175,7,color(25,25,200,150),x + padding, sizeY+y -padding - 20 - 25*n,textWidth(statName[n]),20,5,1,color(255));
    }
    
    //public ScrollBar(float contentLength,float boxSize, float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize) 
    StatBody = new ScrollBar(540,BodyLength,x+sizeX,15,8,sizeY,color(0,150),0,color(255),1);
    
    
  }
  //..  
  protected void TimeEvent(Player pl) {
    //panelParty.PPP.get(n).DeathTimerButton.hoverInfo.updateDescription("Dead",pl.Name+ " is dead! Tap to revive faster. "+ round(pl.CurrentDeathTimer)+ " seconds remaining.");
    if(show) {
      statButton[0].hoverInfo.updateDescription("Vitality","Base VIT: " + (long)pl.CharVit);
      statButton[1].hoverInfo.updateDescription("Strength","Base STR: " + (long)pl.CharStr);
      statButton[2].hoverInfo.updateDescription("Endurance","Base END: " + (long)pl.CharEnd);
      statButton[3].hoverInfo.updateDescription("Agility","Base AGI: " + (long)pl.CharAgi);
      statButton[4].hoverInfo.updateDescription("Dexterity","Base DEX: " + (long)pl.CharDex);
    }
  }
  //..  
  protected void ActionEvent(Player pl) {
    
    if(AutoOn) {
      if(ChangeInLevel < pl.Level) {
        for(int n = 0; n < cCP.statRatio.length; n++) {
          if(cCP.statRatio[n] != 0) {
            ApplyStat(n,pl, (int)(cCP.statRatio[n]*(pl.Level-ChangeInLevel)));
          }
        }
        ChangeInLevel = pl.Level;
      }
    }
    //..    
    if(show) {
      
      cCP.ActionEvent();
      
      if(statAuto.wasClicked) {
        statAuto.wasClicked = false;
        AutoOn = !AutoOn;
        if(AutoOn) {
          statAuto.lineColor = color(25,200,25);
          statAuto.textColor = color(25,200,25);
          statAuto.hoverInfo.title = "[ON] Auto";
        } else {
          statAuto.lineColor = color(200,25,25);
          statAuto.textColor = color(200,25,25);
          statAuto.hoverInfo.title = "[OFF] Auto";
        }
      }
      
      
      if(statAutoConfigure.wasClicked) {
        statAutoConfigure.wasClicked = false;
        cCP.show = !cCP.show;
      }
      
      
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
  private void HoldStat(Player pl) {
    for(int n = 0; n < statButton.length; n++) {
      if(statButton[n].mPress ) {
        HoldTime += 1/frameRate;
        if(HoldTime > 0.5) {
          ApplyStat(n, pl,(int)pow(1+HoldTime,4));
        }
      }
    }
  }
  //..
  private void ApplyStat(int n,Player pl,int amount) {
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
  //..  
  public void draw(Player pl) {
    
    if(show) {
      super.draw();
      cCP.draw();
      
      
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Character",x+padding,y+padding);
      
      
      
      textSize(15);
      text(pl.Name,x+padding,y+padding + 20);
      text("Level "+pl.Level,x+sizeX -padding - textWidth("Level "+pl.Level),y+padding + 20);
      
      
      StatBody.draw();
      
      fill(0,150);
      stroke(255);
      strokeWeight(1);
      rect(x+padding -1,y+padding + moveY -1,sizeX-padding*2 + 2,BodyLength +2,3,3,3,3);
      
      
      clip(x+padding,y+padding + moveY,sizeX-padding*2,BodyLength);
      
      TotalContent(pl,0,0 +StatBody.contentMove() + moveY);
      BaseContent(pl,0,75 +StatBody.contentMove() + moveY);
      ItemContent(pl,0,130 +StatBody.contentMove() + moveY);
      BonusContent(pl,0,185 +StatBody.contentMove() + moveY);
      TotalContentAdv(pl,0,240 +StatBody.contentMove() + moveY);
      BaseContentAdv(pl,0,345 +StatBody.contentMove() + moveY);
      ItemContentAdv(pl,0,410 +StatBody.contentMove() + moveY);
      BonusContentAdv(pl,0,475 +StatBody.contentMove() + moveY);
      
      noClip();
      // y = 555
      // y length = 525
      
      fill(255);
      textSize(15);
      textAlign(TOP,TOP);
      text("Points:",x+padding,y+sizeY -padding - 145);      
      text(pl.StatPoints+"",x+sizeX -padding-textWidth(pl.StatPoints+"") - 48,y+sizeY -padding - 145);
      statAuto.draw();
      statAutoConfigure.draw();
      
      
      
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
  
  //shows info of char  
  private void TotalContent(Player pl,float cX,float cY) {
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
  
  
  //shows info of char  
  private void TotalContentAdv(Player pl,float cX,float cY) {
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
    
    double critChance = (4/(double)pl.Level)*((1-(Math.pow(0.975,4*(pl.TotalCrit + 1)/(double)pl.Level)))/(1-Math.pow(0.975,4/(double)pl.Level)));
    
    text("Critical Chance",x+padding +cX ,y+padding +cY +75);
    text(String.format("%.1f", critChance + pl.TotalCritPercent)+"%",x+sizeX -padding - textWidth(String.format("%.1f", critChance + pl.TotalCritPercent)+"%")+cX ,y+padding +cY +75);
    
    text("Crit Damage",x+padding +cX ,y+padding +cY +90);
    text((long)pl.TotalCritDmg+"",x+sizeX -padding - textWidth((long)pl.TotalCritDmg+"")+cX ,y+padding +cY +90);       
  }  
  
  //shows info of char  
  private void BaseContent(Player pl,float cX,float cY) {
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
  //shows info of char  
  private void ItemContent(Player pl,float cX,float cY) {
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
  //shows info of char  
  private void BonusContent(Player pl,float cX,float cY) {
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
  
  //shows info of char  
  private void BaseContentAdv(Player pl,float cX,float cY) {
    fill(180);
    textSize(10);
    textAlign(TOP,TOP);
    text("Base Health",x+padding +cX ,y+padding +cY);
    text((long)pl.CharHp+"",x+sizeX -padding - textWidth((long)pl.CharHp+"")+cX ,y+padding +cY);
    
    text("Base Damage",x+padding +cX ,y+padding +cY +10);
    text((long)pl.CharDmg+"",x+sizeX -padding - textWidth((long)pl.CharDmg+"")+cX ,y+padding +cY +10);    
    
    text("Base Defence",x+padding +cX ,y+padding +cY +20);
    text((long)pl.CharDef+"",x+sizeX -padding - textWidth((long)pl.CharDef+"")+cX ,y+padding +cY +20);    
    
    text("Base Health Regen",x+padding +cX ,y+padding +cY +30);
    text((long)pl.CharRegHp+"",x+sizeX -padding - textWidth((long)pl.CharRegHp+"")+cX ,y+padding +cY +30);    
    
    text("Base Critical Rating",x+padding +cX ,y+padding +cY +40);
    text((long)pl.CharCrit+"",x+sizeX -padding - textWidth((long)pl.CharCrit+"")+cX ,y+padding +cY +40);
    
    text("Base Crit Damage",x+padding +cX ,y+padding +cY +50);
    text((long)pl.CharCritDmg+"",x+sizeX -padding - textWidth((long)pl.CharCritDmg+"")+cX ,y+padding +cY +50);    
  }    
  //shows info of char  
  private void ItemContentAdv(Player pl,float cX,float cY) {
    fill(180);
    textSize(10);
    textAlign(TOP,TOP);
    text("Item Health",x+padding +cX ,y+padding +cY);
    text((long)pl.ItemHp+"",x+sizeX -padding - textWidth((long)pl.ItemHp+"")+cX ,y+padding +cY);
    
    text("Item Damage",x+padding +cX ,y+padding +cY +10);
    text((long)pl.ItemDmg+"",x+sizeX -padding - textWidth((long)pl.ItemDmg+"")+cX ,y+padding +cY +10);    
    
    text("Item Defence",x+padding +cX ,y+padding +cY +20);
    text((long)pl.ItemDef+"",x+sizeX -padding - textWidth((long)pl.ItemDef+"")+cX ,y+padding +cY +20);    
    
    text("Item Health Regen",x+padding +cX ,y+padding +cY +30);
    text((long)pl.ItemRegHp+"",x+sizeX -padding - textWidth((long)pl.ItemRegHp+"")+cX ,y+padding +cY +30);    
    
    text("Item Critical Rating",x+padding +cX ,y+padding +cY +40);
    text((long)pl.ItemCrit+"",x+sizeX -padding - textWidth((long)pl.ItemCrit+"")+cX ,y+padding +cY +40);
    
    text("Item Crit Damage",x+padding +cX ,y+padding +cY +50);
    text((long)pl.ItemCritDmg+"",x+sizeX -padding - textWidth((long)pl.ItemCritDmg+"")+cX ,y+padding +cY +50);    
  }     
  //shows info of char  
  private void BonusContentAdv(Player pl,float cX,float cY) {
    fill(180);
    textSize(10);
    textAlign(TOP,TOP);
    text("Bonus Health",x+padding +cX ,y+padding +cY);
    text((long)pl.BonusHp+"",x+sizeX -padding - textWidth((long)pl.BonusHp+"")+cX ,y+padding +cY);
    
    text("Bonus Damage",x+padding +cX ,y+padding +cY +10);
    text((long)pl.BonusDmg+"",x+sizeX -padding - textWidth((long)pl.BonusDmg+"")+cX ,y+padding +cY +10);    
    
    text("Bonus Defence",x+padding +cX ,y+padding +cY +20);
    text((long)pl.BonusDef+"",x+sizeX -padding - textWidth((long)pl.BonusDef+"")+cX ,y+padding +cY +20);    
    
    text("Bonus Health Regen",x+padding +cX ,y+padding +cY +30);
    text((long)pl.BonusRegHp+"",x+sizeX -padding - textWidth((long)pl.BonusRegHp+"")+cX ,y+padding +cY +30);    
    
    text("Bonus Critical Rating",x+padding +cX ,y+padding +cY +40);
    text((long)pl.BonusCrit+"",x+sizeX -padding - textWidth((long)pl.BonusCrit+"")+cX ,y+padding +cY +40);
    
    text("Bonus Crit Damage",x+padding +cX ,y+padding +cY +50);
    text((long)pl.BonusCritDmg+"",x+sizeX -padding - textWidth((long)pl.BonusCritDmg+"")+cX ,y+padding +cY +50);    
  }    
  //..  
  protected void HoverEvent() {
    if(show) {
      cCP.HoverEvent();
      statAuto.hoverInfo.draw();
      statAutoConfigure.hoverInfo.draw();
      for(int n =0; n < statButton.length; n++) {
        statButton[n].hoverInfo.draw();
      }
      for(int n =0; n < StatInfo.length; n++) {
        StatInfo[n].draw();
      }      
    }
  }
  
  //..  
  public void mousePressed() {
    if(show) {
      cCP.mousePressed();
      
      StatBody.mousePressed();
      statAuto.mousePressed();
      statAutoConfigure.mousePressed();
      for(int n = 0;n < statButton.length; n++) {
        statButton[n].mousePressed();
      }
    }    
  }
  //..  
  public void mouseReleased() {
    
    if(show) {
      cCP.mouseReleased();
      StatBody.mouseReleased();
      statAuto.mouseReleased();
      statAutoConfigure.mouseReleased();
      HoldTime = 0;
      for(int n = 0;n < statButton.length; n++) {
        statButton[n].mouseReleased();
      }
    }      
  }
  //..  
  public void mouseWheel(MouseEvent event) {
    if(show) {
      StatBody.mouseWheel(event,x,y,sizeX,sizeY);
    }
  }
  
}