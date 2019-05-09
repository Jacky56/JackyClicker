//the left tabs ( it should have been a child for general panel
private class LeftTabUI {
  private float x,y;
  private float sizeX,sizeY;
  private color lineColor;
  private float lineSize;
  private color background;
  private float[] curve = new float[4];
  
  private Button[] LeftTabs = new Button[6];
  private String[] tabName = new String[6];
  
  private float[] ButtonY = new float[6];
  
  private LeftTabUI(float x,float y,float sizeX,float sizeY,float Gap, color background,float curve0,float curve1,float curve2,float curve3,color textColor,float textSize,color lineColor,float lineSize,float textAngle) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.background = background;
    
    tabName[0] = "Character";
    tabName[1] = "Options";
    tabName[2] = "Dungeon";
    tabName[3] = "Quest";
    tabName[4] = "The tavern Inn";
    tabName[5] = "Inventory";
    
    textSize(textSize);
    for(int n = 0; n < ButtonY.length; n++) {
      for(int i = 0; i < n+1; i++) {
        ButtonY[n] += textWidth(tabName[i])+15;
      }
    }
    //public Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve0,float curve1,float curve2,float curve3,color background,color textColor,float textSize,color lineColor,float lineSize,float textAngle) {
    for(int n = 0; n < LeftTabs.length; n++) {
      LeftTabs[n] = new Button(tabName[n],"",x,y+sizeY-ButtonY[n] - Gap*n,sizeX,textWidth(tabName[n])+15,curve0,curve1,curve2,curve3,background,textColor,textSize,lineColor,lineSize,textAngle);
    }
    
  }
  
  private void ActionEvent(Player pl) {
    switch(whichClicked()) {
      case 0:
      characterPanel.show = true;
      break;
      case 1:
      optionPanel.show = true;
      break;
      case 2:
      
      //12345
      dungeonPanel.show = true;

      break;
      case 3:
      questPanel.show = true;
      break;
      case 4:
      
      tavernPanel.show = true;
      currentAreaDungeon.Active = false;
      areaTavern.Active = true;
      
      
      pl.InTavern = true;
      
      
      break;
      case 5:
      inventoryPanel.show = true;
      break;      
    }
  }
  
  public int whichClicked() {
    for(int n = 0; n < LeftTabs.length; n++) {
      if(LeftTabs[n].wasClicked) {
        UnShowPanel();
        LeftTabs[n].wasClicked = false;
        return n;
      }
    }
    return -1;
  }
  
  
  
  private void UnShowPanel() {
    characterPanel.show = false;
    optionPanel.show = false;
    inventoryPanel.show = false;
    tavernPanel.show = false;
    dungeonPanel.show = false;
    questPanel.show = false;
  }
  
  
  
  public void draw() {
    for(int n = 0; n < LeftTabs.length; n++) {
      LeftTabs[n].draw();
    }
  }
  
  public void mousePressed() {
    for(int n = 0; n < LeftTabs.length; n++) {
      LeftTabs[n].mousePressed();
    }        
  }
  
  public void mouseReleased() {
    for(int n = 0; n < LeftTabs.length; n++) {
      LeftTabs[n].mouseReleased();
    }    
  }
  
  
  
}