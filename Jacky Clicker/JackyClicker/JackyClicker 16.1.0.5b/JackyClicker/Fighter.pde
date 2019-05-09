public class Fighter extends GuildUnit {
  
  public Fighter(Player pl,float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(pl, uVit, uStr, uEnd, uAgi, uDex, exp);
    Name = "Fighter";
    Description = "Just a really strong recruit.";
    MoodCriticalPoint = 35;
    MoodSpeed = 0.1;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
  }

  
  
  @Override
  public void TimeEvent() {
    super.TimeEvent();
  }
  
  
  @Override
  public void ActionEvent(Enemy en) {
    super.ActionEvent(en);
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