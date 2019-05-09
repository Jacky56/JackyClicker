//its is used to enlist information for the party panel
private class PanelPartyPlayer{
  private float x,y;
  private float sizeX,sizeY;
  private color lineColor;
  private float lineSize;
  
  private float[] curve = new float[4];
  
  private float inX,inY;
  private float inSizeX,inSizeY;
  
  private ValueBar HpBar;
  
  private Player pl;
  
  private Button DeathTimerButton;
  
  public boolean TriggerDeath;
  private float padding;
  
  //ArrayList<BuffIcon> buffIcon = new ArrayList<BuffIcon>();
  private PanelPartyPlayer(Player pl,float x,float y,float sizeX,float sizeY,float curve,float padding,color lineColor,float lineSize) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    for(int n = 0; n < 4; n++) {
      this.curve[n] = curve;
    }
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    
    
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
  
  public void draw() {
    HpBar.draw();
    fill(lineColor);
    textSize(14);
    textAlign(TOP,TOP);
    
    text(pl.Name,x+sizeX-textWidth(pl.Name),y);
    
    
    if(DeathTimerButton != null) {
      text(round(pl.CurrentDeathTimer) + " Secs",x+5,y+20);
    }
    
    for(int n = 0; n < pl.buffIcon.size(); n++) {
      pl.buffIcon.get(n).updatePosition(x+ 20*n, y + 40);
      if(n <11) {
        pl.buffIcon.get(n).draw();
      }
    }
    
  }
  
  private void TimeEvent() {
    HpBar.updateBar(pl.CurrentHp,pl.TotalHp);
    for(int i = 0; i < pl.buffIcon.size();i++) {
      pl.buffIcon.get(i).TimeEvent(pl);
    }
  }      
  
  
  
  public void HoverEvent() {
    DeathTimerButton.hoverInfo.draw();
  }
  
  private void ActionEvent() {
    createDeathButton();
    TapDeathButton();
  }
  
  private void createDeathButton() {
    if(pl.Alive == false && TriggerDeath == false) {
      DeathTimerButton = new Button("Dead",pl.Name +" is dead! Tap to revive faster.",x+3,y+3,sizeX-6,sizeY-6,curve[0],color(200,25,25,100),color(255),15,color(200,25,25,100),1);
      TriggerDeath = true;
    } else if(pl.Alive && TriggerDeath) {
      TriggerDeath = false;
      DeathTimerButton = null;
    }    
  }
  
  private void TapDeathButton(){
    if(DeathTimerButton != null) {
      if(DeathTimerButton.wasClicked) {
        pl.CurrentDeathTimer -= 1;
        DeathTimerButton.wasClicked = false;
      }
    }
  }
}