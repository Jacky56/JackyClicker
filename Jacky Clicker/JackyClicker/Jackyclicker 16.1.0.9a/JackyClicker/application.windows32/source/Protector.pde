public class Protector extends GuildUnit {
  
  public Protector(float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(uVit, uStr, uEnd, uAgi, uDex, exp);
    Name = "Protector";
    Description = "Blocks 45% enemy damage for you, Cost 3 Mood. (Must be above Moody, Auto)";
    MoodCriticalPoint = 20;
    MoodSpeed = 0.14;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
  }

  public Protector(GuildUnit gu) {
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
  
  @Override
  public void TriggerWhileAttackedEvent(Enemy en) {
    Defend(en);
  }
  
  public void Defend(Enemy en) {
    if(en.TempDmg > 0 && Moody == false && Strike == false && currentMood >= 3) {
      en.TempDmg -= en.TotalDmg*0.45;
      currentMood -= 3;
    }
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