public class Veteran extends GuildUnit {
  long KillCount;
  public Veteran(Player pl,float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp,long KillCount)  {
    super(pl, uVit, uStr, uEnd, uAgi, uDex, exp);
    this.KillCount = KillCount;
    Name = "Veteran";
    Description = "Gains 1 Strength per 10 kills. ";
    MoodCriticalPoint = 35;
    MoodSpeed = 0.1;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
    
    
    //temp
    CharStr += KillCount*0.1;
  }
  
  
  
  
  @Override
  public void TimeEvent() {
    super.TimeEvent();
    UnitAsButton.hoverInfo.updateDescription(Name,Description + "Have currently slain " + KillCount +". Strength gain + " + (long)(KillCount*0.1));
  }
  
  
  @Override
  public void ActionEvent(Enemy en,Player pl) {
    super.ActionEvent(en,pl);
  }
  
  @Override
  public void TriggerOnEnemyDeadEvent(Enemy en) {
    super.TriggerOnEnemyDeadEvent(en);
    StrengthGain();
  }
  
  public void StrengthGain() {
    KillCount++;
    CharStr += 0.1;
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