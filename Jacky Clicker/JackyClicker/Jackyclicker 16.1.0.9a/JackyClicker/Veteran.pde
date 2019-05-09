protected class Veteran extends GuildUnit {
  
  protected Veteran(float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(uVit, uStr, uEnd, uAgi, uDex, exp);
    Name = "Veteran";
    Description = "Gains 1 Strength per 10 kills. ";
    MoodCriticalPoint = 35;
    MoodSpeed = 0.1;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
    
    
    //temp
    CharStr += KillCount*0.1;
  }
  
  protected Veteran(GuildUnit gu) {
    this(gu. uVit,gu. uStr,gu. uEnd,gu. uAgi,gu. uDex,gu. Exp);
    this.currentMood = gu.currentMood;
    KillCount = gu.KillCount;
    CharStr += KillCount*0.1;
  }
    
  
  
  
  @Override
  protected void TimeEvent(Player pl) {
    super.TimeEvent(pl);
    UnitAsButton.hoverInfo.updateDescription(Name,Description + "Have currently slain " + KillCount +". Strength gain + " + (long)(KillCount*0.1));
  }
  
  
  @Override
  protected void ActionEvent(Enemy en,Player pl) {
    super.ActionEvent(en,pl);
  }
  
  @Override
  public void TriggerOnEnemyDeadEvent(Enemy en) {
    super.TriggerOnEnemyDeadEvent(en);
    StrengthGain();
  }
  
  private void StrengthGain() {
    KillCount++;
    CharStr += 0.1;
  }
  
  
  public void draw() {
    super.draw();
  }
  
   
  public void mousePressed() {
    UnitAsButton.mousePressed();
  }
  
  public void mouseReleased() {
    UnitAsButton.mouseReleased();
  }
}