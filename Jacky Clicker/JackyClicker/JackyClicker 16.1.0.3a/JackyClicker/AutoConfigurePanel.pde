public class AutoConfigurePanel extends GeneralPanel {

  String[] statName = new String[5];
  String[] statDes = new String[5];
  
  Button[] statButtonPos = new Button[5];
  Button[] statButtonNeg = new Button[5];
  
  
  int[] statRatio = new int[5];
  int statPointsLevel;

  public AutoConfigurePanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    
    
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

  
  void ActionEvent(boolean AutoOn,Player pl) {
    if(show) {

      for(int n = 0; n < statButtonPos.length ;n++) {
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
  
  public void draw() {
    if(show) {
      super.draw();
      
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Auto Configuration",x+padding,y+padding);
      
      
      
      
      fill(255);
      textSize(15);
      textAlign(TOP,TOP);
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
  
  void mousePressed() {
    if(show) {
      for(int n = 0;n < statButtonPos.length; n++) {
        statButtonPos[n].mousePressed();
        statButtonNeg[n].mousePressed();
      }
    }    
  }
  
  void mouseReleased() {
    
    if(show) {
      for(int n = 0;n < statButtonPos.length; n++) {
        statButtonPos[n].mouseReleased();
        statButtonNeg[n].mouseReleased();
      }
    }      
  }  
  
}