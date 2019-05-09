public class Player extends Unit {
  
  float DeathTimer;
  float CurrentDeathTimer;
  
  //?
  long StatPoints;
  //?
  long TotalStatPoints;
  //?
  long TotalExp,LossExp;
  //?
  long Exp, Level, MaxExp, OldMaxExp, ExpGain, CurrentExpGain, ExpDiff; 
  
  long Gold;
  
  ValueBar ExpBar;
  
  
  public Player(String Name,String Description,float x,float y,long CharVit,long CharStr,long CharEnd,long CharAgi,long CharDex) {
    super( Name, Description, x, y, CharVit, CharStr, CharEnd, CharAgi, CharDex);
    UnitAsButton = new Button(Name,Description,x,y,80,80,5,color(25,200,25),color(255),15,color(255),3);
    DeathTimer = 50;
    CurrentDeathTimer = DeathTimer;
    PlayerLevelUp(0);
    //ValueBar(float MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground)
    //HpBar = new ValueBar(TotalHp,width/2 - 225,15,450,15,color(0),2,color(255),1,color(200,25,25));
    ExpBar = new ValueBar("Experience","This shows your current progress in the game.", ExpDiff,width/2 - 225,height-20,450,15,color(0),10,color(255),1,color(255,255,102));
  }
  
  @Override
  public void HoverEvent() {
    super.HoverEvent();
    ExpBar.BarInfo.draw();
  }
  
  @Override
  public void TimeEvent() {
    super.TimeEvent();
    ReviveTime();
  }
  @Override
  public void ActionEvent() {
    super.Dead();
    Revive();
  }
  
  public void Revive() {
    if(CurrentDeathTimer < 0) {
      Alive = true;
      CurrentDeathTimer = DeathTimer;
      CurrentHp = TotalHp;
    }
  }
  
  public void ReviveTime() {
    if(Alive == false) {
      CurrentDeathTimer -= 1/frameRate;
    }
  }
  
  public void PlayerLevelUp(long gain) {
    boolean lvlmore = false;
    
    //lvl cap 999999
    if (gain > 0) {
      Exp += gain;
      TotalExp += gain;
      //logs.add(new Log("You gained " + gain + " Exp",color(255,255,0)));
      CurrentExpGain += gain;
      }
      if (Exp >= MaxExp) {
        while (lvlmore == false) {
          if (Level == 999999) {
            ExpDiff = MaxExp - OldMaxExp;
            CurrentExpGain = MaxExp;
            Exp = MaxExp;
            lvlmore =true;
          } else {
          if (Exp >= MaxExp) {
            OldMaxExp = MaxExp;
            Level ++;
            StatPoints += 10 + floor(Level/100);
            TotalStatPoints += 10 + floor(Level/100);
            MaxExp = Level*3 + 10 + OldMaxExp;
            //logs.add(new Log("You Leveled up to " + Level,color(255,255,255)));
            //logs.add(new Log("You gain " + (long)Math.floor(3 + (Level/7)) + " stat points",color(255,255,255)));
          } else {
            lvlmore =true;
            ExpDiff = MaxExp - OldMaxExp;
            if(Alive) {
              CurrentHp = TotalHp;
            }
          }
        }
      }
   CurrentExpGain = Exp - OldMaxExp;  
   }
  }
  
}