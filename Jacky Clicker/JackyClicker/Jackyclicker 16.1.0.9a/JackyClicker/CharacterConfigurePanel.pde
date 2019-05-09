protected class CharacterConfigurePanel extends GeneralPanel {

  private String[] statName = new String[5];
  private String[] statDes = new String[5];
  
  private Button[] statButtonPos = new Button[5];
  private Button[] statButtonNeg = new Button[5];
  
  
  private int[] statRatio = new int[5];
  private int statPointsLevel;
  
  private Button Close;
  
  private Button NameChange;
  private Button AcceptNameChange;
  
  
  private Player pl;
  protected CharacterConfigurePanel(Player pl, float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    this.pl = pl;
    Close = new Button("X","",x+sizeX - padding - 25,y+padding,25,25,2,color(150),color(255),12,color(100),3);
    
    AcceptNameChange = new Button("Accept","",x+sizeX - padding - 70,y+padding + 50,70,25,2,color(150),color(255),12,color(100),3);
    

    NameChange = new Button(pl.Name,"Click here to change name. 8 Characters Max.",x+padding,y+padding + 50,200,25,2,color(0,150),color(255),12,color(255),1);
    
    for(int n = 0; n < statButtonPos.length; n++) {
      statButtonPos[n] = new Button("+","",x+sizeX - 20 - padding, sizeY+y -padding - 20 - 25*n,20,20,2,color(150),color(255),13,color(255),1);
      statButtonNeg[n] = new Button("-","",x+sizeX - 20 - padding -25, sizeY+y -padding - 20 - 25*n,20,20,2,color(150),color(255),13,color(255),1);
    }
    
    
    statName[0] = "Vitality";
    statDes[0] = "Each point gives 6 hp and each 40 points gives 1 hp regen."; 
    statName[1] = "Strength";
    statDes[1] = "Each point gives 2 damage."; 
    statName[2] = "Endurance";
    statDes[2] = "Each point gives 1 armor."; 
    statName[3] = "Agility";
    statDes[3] = "Each point gives 1 critial chance. don't upgrade, it does nothing."; 
    statName[4] = "Dexterity";
    statDes[4] = "Each point gives 1 critial damage. don't upgrade, it does nothing.";
  }

  
  public void HoverEvent() {
    if(show) {
      NameChange.hoverInfo.draw();
    }
  }
  
  
  protected void ActionEvent() {
    if(show) {
      
      if(Close.wasClicked) {
        Close.wasClicked = false;
        show = false;
      }
      
      if(AcceptNameChange.wasClicked) {
        AcceptNameChange.wasClicked = false;
        NameChange.wasClicked = false;
      }
      
      if(NameChange.wasClicked) {
        NameChange.background = color(50,150);
      } else {
        NameChange.background = color(0,150);
        NameChange.hoverInfo.updateDescription(pl.Name,"Click here to change name. 8 Characters Max.");
      }
      
      
      for(int n = 0; n < statButtonPos.length ;n++){
        if(statButtonPos[n].wasClicked) {
          statButtonPos[n].wasClicked = false;
          
          if(statPointsLevel < 10 && statRatio[n] < 10) {
            statRatio[n] ++;
            statPointsLevel ++;
          }
        }
        if(statButtonNeg[n].wasClicked) {
          statButtonNeg[n].wasClicked = false;
          
          if(statPointsLevel > 0 && statRatio[n] > 0) {
            statRatio[n] --;
            statPointsLevel --;
          }
        }
      }
    }
  }
  
  private void ApplyStat(int n,int amount) {
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
  
  private void NameChangeKey() {
    if(NameChange.wasClicked) {
      if((int(key) >= 65 && int(key) <= 90) || (int(key) >= 97 && int(key) <=122) || (int(key) >= 48 && int(key) <=57)) {
        if(pl.Name.length()  < 8) {
          pl.Name += Character.toString ((char) key);
        } else {
          //popText.add(new PopText("You broke kokudorei...", 1, 1, mouseX,mouseY,20,color(200,25,25)));
          popText.add(new PopText("8 Characters Max kokudorei...", 1, 1,NameChange.x + NameChange.sizeX/2,NameChange.y + NameChange.sizeY/2,14,color(200,25,25)));
        }
      } else if(key == BACKSPACE) {
        if(pl.Name.length() > 0) {
          pl.Name = pl.Name.substring(0, pl.Name.length()-1);
        }
      } else if(key == ENTER) {
        NameChange.wasClicked = false;
      }
    }
    
  }
  
  
  
  public void draw() {
    if(show) {
      super.draw();
      
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Configuration",x+padding,y+padding);
      
      textSize(14);
      text("Name:",x+padding, y+padding +30);
      NameChange.title = pl.Name;
      NameChange.draw();
      AcceptNameChange.draw();
      Close.draw();
      
      
      
      fill(255);
      textSize(15);
      textAlign(TOP,TOP);
      text("Auto Stat",x+padding,y+sizeY -padding - 170);        
      text("Points:",x+padding,y+sizeY -padding - 145);      
      text(statPointsLevel+" (Max.10)",x+sizeX -padding-textWidth(statPointsLevel+" (Max.10)"),y+sizeY -padding - 145);    
      
      
      fill(255);
      textSize(15);
      textAlign(TOP,TOP);
      
      for(int n = 0; n < statName.length; n++) {
        text(statName[n],x + padding, sizeY+y -padding - 20 - 25*n);
      }
      
      //stat buttons
      
      for(int n = 0;n < statButtonPos.length; n++) {
        statButtonPos[n].draw();
        statButtonNeg[n].draw();
        textSize(15);
        textAlign(TOP,TOP);
        text(statRatio[n]+"",x+sizeX -padding-textWidth(statRatio[n]+"") - 48,y+sizeY -padding  - 20 - 25*n);    
      }
    }
  }
  
  public void mousePressed() {
    if(show) {
      NameChange.mousePressed();
      AcceptNameChange.mousePressed();
      Close.mousePressed();
      for(int n = 0;n < statButtonPos.length; n++) {
        statButtonPos[n].mousePressed();
        statButtonNeg[n].mousePressed();
      }
    }    
  }
  
  public void mouseReleased() {
    
    if(show) {
      NameChange.mouseReleased();
      AcceptNameChange.mouseReleased();
      Close.mouseReleased();
      for(int n = 0;n < statButtonPos.length; n++) {
        statButtonPos[n].mouseReleased();
        statButtonNeg[n].mouseReleased();
      }
    }      
  }  
  
  
  public void keyTyped() {
    if(show) {
      NameChangeKey();
    }
  }
  
}