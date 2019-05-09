public class Enemy extends Unit {
  float AttackTimer;
  
  float CurrentAttackTimer;
  
  long ExpBounty;
  long GoldBounty;
  
  ValueBar AttackTimerBar;
  public Enemy(String Name,String Description,float x,float y,long CharVit,long CharStr,long CharEnd,long CharAgi,long CharDex,float AttackTimer,long ExpBounty,long GoldBounty) {
    super( Name, Description, x, y, CharVit, CharStr, CharEnd, CharAgi, CharDex);
    this.AttackTimer = AttackTimer;
    this.ExpBounty = ExpBounty;
    this.GoldBounty = GoldBounty;
    
    UnitAsButton = new Button(Name,Description,x,y,200,200,5,color(200,25,25),color(255),15,color(255),3);
    //ValueBar(long MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground) {
    HpBar = new ValueBar(TotalHp,width/2 - 225,15,450,15,color(0),2,color(255),1,color(200,25,25));
    
    AttackTimerBar = new ValueBar("Attack Timer","This enemy will attack someone when this bar is full.", AttackTimer,width/2 - 225,35,175,10,color(0),2,color(255),1,color(200));
  }
  
  @Override
  public void TimeEvent() {
    super.TimeEvent();
    AttackTime();
  }
  
  //temp only single player
  public void AttackTime() {
    if(AttackTimer < CurrentAttackTimer) {
      CurrentAttackTimer = AttackTimer;
    }    
    if(Alive) {
      CurrentAttackTimer += 1/frameRate;
    }
  }
  
  @Override
  public void Dead() {
    super.Dead();
    if(Alive == false) {
      
    }
  }
  
}