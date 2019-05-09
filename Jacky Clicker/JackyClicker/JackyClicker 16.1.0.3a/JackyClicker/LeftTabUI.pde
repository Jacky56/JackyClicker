public class LeftTabUI {
  float x,y;
  float sizeX,sizeY;
  color lineColor;
  float lineSize;
  color background;
  float[] curve = new float[4];
  
  Button[] LeftTabs = new Button[6];
  String[] tabName = new String[6];
  
  float[] ButtonY = new float[6];
  
  public LeftTabUI(float x,float y,float sizeX,float sizeY,float Gap, color background,float curve0,float curve1,float curve2,float curve3,color textColor,float textSize,color lineColor,float lineSize,float textAngle) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.background = background;
    
    tabName[0] = "Character";
    tabName[1] = "Options";
    tabName[2] = "Dungeon";
    tabName[3] = "Quest";
    tabName[4] = "Guild";
    tabName[5] = "Inventory";
    
    for(int n = 0; n < ButtonY.length; n++) {
      for(int i = 0; i < n+1; i++) {
        ButtonY[n] += textWidth(tabName[i])+10;
      }
    }
    //public Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve0,float curve1,float curve2,float curve3,color background,color textColor,float textSize,color lineColor,float lineSize,float textAngle) {
    for(int n = 0; n < LeftTabs.length; n++) {
      LeftTabs[n] = new Button(tabName[n],"",x,y+sizeY-ButtonY[n] - Gap*n,sizeX,textWidth(tabName[n])+10,curve0,curve1,curve2,curve3,background,textColor,textSize,lineColor,lineSize,textAngle);
    }
    
  }
  
  void ActionEvent() {
    switch(whichClicked()) {
      case 0:
      characterPanel.show = true;
      break;
      case 1:
      optionPanel.show = true;
      break;
      case 2:
      enemy.UnitPlaced = !enemy.UnitPlaced;
      break;
      case 3:
      break;
      case 4:
      break;
      case 5:
      inventoryPanel.show = true;
      break;      
    }
  }
  
  int whichClicked() {
    for(int n = 0; n < LeftTabs.length; n++) {
      if(LeftTabs[n].wasClicked) {
        UnShowPanel();
        LeftTabs[n].wasClicked = false;
        return n;
      }
    }
    return -1;
  }
  
  
  
  void UnShowPanel() {
    characterPanel.show = false;
    optionPanel.show = false;
    inventoryPanel.show = false;
  }
  
  
  
  void draw() {
    for(int n = 0; n < LeftTabs.length; n++) {
      LeftTabs[n].draw();
    }
  }
  
  void mousePressed() {
    for(int n = 0; n < LeftTabs.length; n++) {
      LeftTabs[n].mousePressed();
    }        
  }
  
  void mouseReleased() {
    for(int n = 0; n < LeftTabs.length; n++) {
      LeftTabs[n].mouseReleased();
    }    
  }
  
  
  
}