public class DungeonPanel extends GeneralPanel {
  Player pl;
  
  
  float moveY = 50;
  float BodyLength = 250;
  
  
  
  ArrayList<AreaDungeon> ad;
  
  ArrayList<Button> AreaButton = new ArrayList<Button>();
  
  
  Button[] MileButton = new Button[8];
  long[] MilePrice = new long[MileButton.length];
  float[] MileStone = new float[MileButton.length];
  
  int areaButtonClicked;
  
  //ArrayList[] MileButtonShow = new ArrayList<Boolean>();
  public DungeonPanel(Player pl,ArrayList<AreaDungeon> ad,float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    this.pl = pl;
    this.ad = ad;
    createAreaButton();
    createMileStoneButton();
    
    areaButtonClicked = -1;
  }
  
  
  void createMileStoneButton() {
    for(int n = 0; n < MileButton.length ; n++ ) {
      MilePrice[n] = 250*n + (long)(n*pow(4,n)); 
      MileStone[n] = 1;
      MileButton[n] = new Button(200*n+"","Start at " + 1 + " Miles. Cost "+ MilePrice[n] + "z",correctMileButtonX(n) ,correctMileButtonY(n),40,40,3,color(150),color(200,25,25),15,color(100),3);
    }    
  }
  
  
  float correctMileButtonX(int n) {
   return x+padding + (45+2)*(n % 4);
  }
  
  float correctMileButtonY(int n) {
   return y+sizeY-padding - 120 + floor((45+2)*(n / 4));
  }   
  
  
  public void ActionEvent() {
    if(show) {
      clickedAreaButton();
      checkMileButton();
    }
  }
  
  public void TimeEvent() {
    if(show) {
      createAreaButton();
    }
  }
  
  public void checkMileButton() {
    for(int n = 0; n < MileButton.length; n++) {
      if(MileButton[n].wasClicked) {
        MileButton[n].wasClicked = false;
        //areaButtonClicked
        if(areaButtonClicked != -1) {
          if(ad.get(areaButtonClicked).PassMileStone[n]) {
            if(checkMileButtonPrice(n,pl)) {
              popText.add(new PopText("-" +MilePrice[n] + "z", 1, 1, mouseX,mouseY,20,color(150)));
              pl.Zeny -= MilePrice[n];
              movePlayerToDungeon(n);
            } else { 
              popText.add(new PopText("You broke kokudorei...", 1, 1, mouseX,mouseY,20,color(200,25,25)));
            }
          } else {
            popText.add(new PopText("You Must Defeat the Mile Stone Boss!", 1, 1, mouseX,mouseY,20,color(200,25,25)));
          }
        } else {
          popText.add(new PopText("Click on a dungeon first!", 1, 1, mouseX,mouseY,20,color(200,25,25)));
        }
      }
    }
  }
  
  public void movePlayerToDungeon(int n) {
    ad.get(areaButtonClicked).setMile(MileStone[n]); 
    currentAreaDungeon = ad.get(areaButtonClicked);
    if(MileStone[n] > currentAreaDungeon.MileMax) {
      currentAreaDungeon.MileCurrent = currentAreaDungeon.MileMax;
    } else {
      currentAreaDungeon.MileCurrent = MileStone[n];
    }
    currentAreaDungeon.Active = true;
    areaTavern.Active = false;
    pl.InTavern = false;
  }
  
  
  boolean checkMileButtonPrice(int ButtonIndex,Player pl) {
    if(pl.Zeny >= MilePrice[ButtonIndex]) {
      return true;
    } else {
      return false;
    }
  }  
  
  public void updateLineColorAreaButton(int i) {
    for(int n = 0; n <  AreaButton.size(); n++) {
      AreaButton.get(n).lineColor = color(100);
    }
    AreaButton.get(i).lineColor = color(25,200,25);
    for(int n = 0; n < MileButton.length; n++) {
      MileStone[n] = (long)((ad.get(i).MileMax/ad.get(i).MileStone.length)*n);
      MileButton[n].title = (long)((ad.get(i).MileMax/ad.get(i).MileStone.length)*n)+"";
      MilePrice[n] = 500*n + (long)(n*pow((ad.get(i).MileMax/1000)*8,n)); 
      MileButton[n].hoverInfo.updateDescription((long)((ad.get(i).MileMax/ad.get(i).MileStone.length)*n)+"","Start at " + (long)((ad.get(i).MileMax/ad.get(i).MileStone.length)*n) + " Miles. Cost " + MilePrice[n] + "z");
      if(ad.get(i).PassMileStone[n]) {
        MileButton[n].textColor = color(25,200,25);
      } else {
        MileButton[n].textColor = color(200,25,25);
      }
    }
  }

  
  public void clickedAreaButton() {
    for(int n = 0; n < AreaButton.size(); n++) {
      if(AreaButton.get(n).wasClicked) {
        AreaButton.get(n).wasClicked = false;
        areaButtonClicked = n;
        updateLineColorAreaButton(n);
      }
    }
  }
  
  //temp 
  void createAreaButton() {
    for(int n = AreaButton.size(); n < ad.size(); n++) {
      AreaButton.add(new Button(ad.get(n).Name,ad.get(n).Description,x+padding,y+padding + moveY + 40*AreaButton.size(),sizeX - padding*2,35,3,color(150),color(ad.get(n).barColor),15,color(100),3));
    }
  }  
  
  
  public void HoverEvent() {
    
    if(show) {
      
      for(int n = 0; n < AreaButton.size();n++) {
        AreaButton.get(n).hoverInfo.draw();
      }
      for(int n = 0; n < MileButton.length ; n++) {
        MileButton[n].hoverInfo.draw();
      }
      
    }
  }
  
  
  
  public void draw(Player pl) {
    if(show) {
      super.draw();
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Dungeon",x+padding,y+padding);     
      
      
      for(int n = 0; n < AreaButton.size();n++) {
        AreaButton.get(n).draw();
      }
      
      for(int n = 0; n < MileButton.length ; n++) {
        MileButton[n].draw();
      }
      
      
      
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
  
  void mousePressed() {
    if (show) {
      
      for(int n = 0; n < AreaButton.size();n++) {
        AreaButton.get(n).mousePressed();
      }
      for(int n = 0; n < MileButton.length ; n++) {
        MileButton[n].mousePressed();
      }
      
    }
  }
  
  void mouseReleased() {
    if (show) {
      
      for(int n = 0; n < AreaButton.size();n++) {
        AreaButton.get(n).mouseReleased();
      }
      for(int n = 0; n < MileButton.length ; n++) {
        MileButton[n].mouseReleased();
      }
      
    }
  }
  
}