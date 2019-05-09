public class Fighter extends GuildUnit {
  
  public Fighter(float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(uVit, uStr, uEnd, uAgi, uDex, exp);
    Name = "Fighter";
    Description = "Just a really strong recruit.";
    MoodCriticalPoint = 35;
    MoodSpeed = 0.15;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
  }
  
  public Fighter(GuildUnit gu) {
    this(gu. uVit,gu. uStr,gu. uEnd,gu. uAgi,gu. uDex,gu. Exp);
    this.currentMood = gu.currentMood;
  }
  
  
  @Override
  public void TimeEvent(Player pl) {
    super.TimeEvent(pl);
  }
  
  
  @Override
  public void ActionEvent(Enemy en,Player pl) {
    super.ActionEvent(en,pl);
  }
  
  
  public void draw() {
    super.draw();
  }
  
   
  void mousePressed() {
    UnitAsButton.mousePressed();
  }
  
  void mouseReleased() {
    UnitAsButton.mouseReleased();
  }
}