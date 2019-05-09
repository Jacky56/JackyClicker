public class Enemy extends Unit {
  double AttackTimer;
  
  double CurrentAttackTimer;
  
  long ExpBounty;
  long GoldBounty;
  long PrestigeBounty;
  
  boolean GaveBounty;
  
  ValueBar AttackTimerBar;
  public Enemy(String Name,String Description,float x,float y,long CharVit,long CharStr,long CharEnd,long CharAgi,long CharDex,int AttackTimer,long ExpBounty,long GoldBounty,long PrestigeBounty) {
    super( Name, Description, x, y, CharVit, CharStr, CharEnd, CharAgi, CharDex);
    this.AttackTimer = AttackTimer;
    this.ExpBounty = ExpBounty;
    this.GoldBounty = GoldBounty;
    this.PrestigeBounty = PrestigeBounty;
    
    UnitAsButton = new Button(Name,Description,x,y,200,200,5,color(200,25,25),color(255),15,color(255),3);
    //ValueBar(long MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground) {
    HpBar = new ValueBar(TotalHp,width/2 - 225,15,450,15,color(0),2,color(255),1,color(200,25,25));
    
    AttackTimerBar = new ValueBar("Attack Timer","This enemy will attack someone when this bar is full.", AttackTimer,width/2 - 225,35,175,10,color(0),2,color(255),1,color(200));
  }
  
  @Override
  public void HoverEvent() {
    if(UnitPlaced) {
      super.HoverEvent();
      AttackTimerBar.BarInfo.draw();
    }
  }
  
  @Override
  public void draw() {
    if(UnitPlaced) {
      super.draw();
      HpBar.draw();
      AttackTimerBar.draw();
    }
  }
  
  
  
  public void TimeEvent() {
    super.TimeEvent();
    AttackTime();
    HpBar.updateBar(CurrentHp,TotalHp);
    AttackTimerBar.updateBar(CurrentAttackTimer,AttackTimer);  
  }
  
  public void ActionEvent(Player pl) {
    if(UnitPlaced) {
      super.ActionEvent();
      Attack(pl);
      giveBounty(pl);
    }
  }
  
  
  
  public void Attack(Player pl) {
    //temp attack 
    if(CurrentAttackTimer > AttackTimer && pl.Alive && Alive) {
      CurrentAttackTimer = 0;
      if(TotalDmg > player.TotalDef) {
        pl.CurrentHp -= (TotalDmg-pl.TotalDef);
        //(String text,float speedY,float LifeTime,float x,float y,float textSize,color textColor)
        //temp
        popText.add(new PopText((long)(TotalDmg-pl.TotalDef)+"",1,0.5,player.x + pl.UnitAsButton.sizeX/2,player.y,30,color(200,25,25)));
      }
    }
    
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
  
  //?
  @Override
  public void Dead() {
    super.Dead();
    if(Alive == false) {
    }
  }
  
  
  
  void giveBounty(Player pl) {
    if(UnitPlaced) {
      if(Alive == false && GaveBounty == false) {
        pl.PlayerLevelUp(ExpBounty);
        pl.Zeny += GoldBounty;
        pl.Prestige += PrestigeBounty;
        GaveBounty = true;
        
        if(GoldBounty != 0) {
          //PopText(String text,float speedY,float LifeTime,float x,float y,float textSize,color textColor)
          popText.add(new PopText("+"+GoldBounty+"z",1,random(1,1.5),random(x+UnitAsButton.sizeX/4,x+UnitAsButton.sizeX*3/4),random(y+UnitAsButton.sizeY/4,y+UnitAsButton.sizeY*3/4),20,color(150)));
        }
        
        if(PrestigeBounty != 0) {
          popText.add(new PopText("+"+PrestigeBounty+" favor",1,random(1,1.5),random(x+UnitAsButton.sizeX/4,x+UnitAsButton.sizeX*3/4),random(y+UnitAsButton.sizeY/4,y+UnitAsButton.sizeY*3/4),20,color(218,112,214)));
        }
        
        if(ExpBounty != 0) {
          popText.add(new PopText("+" +ExpBounty+" exp",1,random(1,1.5),random(x+UnitAsButton.sizeX/4,x+UnitAsButton.sizeX*3/4),random(y+UnitAsButton.sizeY/4,y+UnitAsButton.sizeY*3/4),20,color(255,255,51)));
        }
      }
    }
  }
  
}