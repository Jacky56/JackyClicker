public class PanelPartyPlayer {
  float x,y;
  String Name;
  float sizeX,sizeY;
  color lineColor;
  float lineSize;
  
  float[] curve = new float[4];
  
  float inX,inY;
  float inSizeX,inSizeY;
  
  float padding;
  
  ValueBar HpBar;
  
  Player pl;
  
  Button DeathTimerButton;
  
  boolean TriggerDeath;
  
  
  ArrayList<BuffIcon> buffIcon = new ArrayList<BuffIcon>();
  public PanelPartyPlayer(Player pl,float x,float y,float sizeX,float sizeY,float curve,float padding,color lineColor,float lineSize) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    for(int n = 0; n < 4; n++) {
      this.curve[n] = curve;
    }
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    
    this.Name = pl.Name;
    
    this.pl = pl;
    
    inX = x;
    inY = y;
    inSizeX = sizeX;
    inSizeY = sizeY;
    this.padding = padding;
    //public ValueBar(float MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground) {
    HpBar = new ValueBar(pl.TotalHp,x,y+20,sizeX,15,color(0),curve,lineColor,lineSize,color(25,200,25));
    
    //public Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,float textSize,color lineColor,float lineSize) {
    //DeathTimerButton = new Button("Dead",pl.Name +" is dead! Tap to revive faster.",x,y,sizeX,sizeY,curve,color(200,25,25,100),color(255),14,color(200,25,25,100),0);
  }
  
  void draw() {
    HpBar.draw();
    fill(lineColor);
    textSize(14);
    textAlign(TOP,TOP);
    text(Name,x+sizeX-textWidth(Name),y);
    
    
    if(DeathTimerButton != null) {
      text(round(pl.CurrentDeathTimer) + " Secs",x+5,y+20);
    }
    
    for(int n = 0; n < buffIcon.size(); n++) {
      
      buffIcon.get(n).updatePosition(x+ 20*n, y + 40);
      if(n <11) {
        buffIcon.get(n).draw();
      }
    }
    
  }
  
  void HoverEvent() {
    DeathTimerButton.hoverInfo.draw();
  }
  
  void ActionEvent() {
    createDeathButton();
    TapDeathButton();
  }
  
  void createDeathButton() {
    if(pl.Alive == false && TriggerDeath == false) {
      DeathTimerButton = new Button("Dead",pl.Name +" is dead! Tap to revive faster.",x,y,sizeX,sizeY,curve[0],color(200,25,25,100),color(255),15,color(200,25,25,100),1);
      TriggerDeath = true;
    } else if(pl.Alive && TriggerDeath) {
      TriggerDeath = false;
      DeathTimerButton = null;
    }    
  }
  
  void TapDeathButton(){
    if(DeathTimerButton != null) {
      if(DeathTimerButton.wasClicked) {
        pl.CurrentDeathTimer -= 1;
        DeathTimerButton.wasClicked = false;
      }
    }
  }
}