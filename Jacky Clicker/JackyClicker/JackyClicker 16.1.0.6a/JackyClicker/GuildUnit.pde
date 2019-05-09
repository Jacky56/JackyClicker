public class GuildUnit extends Unit {
  
  Player pl;
  float Mood;
  float currentMood;
  ValueBar MoodBar;
  float MoodCriticalPoint;
  float MoodSpeed;
  
  float BonusMoodSpeed;
  boolean OverTime;
  
  
  
  long TotalExp,LossExp;
  long Exp, Level, MaxExp, OldMaxExp, ExpGain, CurrentExpGain, ExpDiff; 
  
  long PayPrice;
  
  ValueBar ExpBar;
  
  
  Button FireButton;
  Button PayButton;
  
  boolean Moody;
  boolean Strike;
  
  
  long OldLevel;
  
  float uVit,uStr,uEnd,uAgi,uDex;
  
  
  //second trigger
  boolean UnitRemove;
  
  public GuildUnit(Player pl,float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp) {
    super( "", "", 0, 0, 0, 0, 0, 0, 0);
    this.uVit = uVit;
    this.uStr = uStr;
    this.uEnd = uEnd;
    this.uAgi = uAgi;
    this.uDex = uDex;
    x = 0;
    y = y;
    
    Mood = 100;
 
 
    this.pl = pl;
    this.currentMood = Mood;
    
    
    CharExp = 1;
    CharZeny = 1;
    CharPrestige = 1;
    
    
    
    GuildUnitLevelUp(exp);
    
    
    //new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
    FireButton = new Button("Fire","Remove this recruit from your Group!",x,y,60,30,2,color(150),color(255),12,color(100),3);
    PayButton = new Button("Pay","Increase the Mood for this recruit!",x,y,60,30,2,color(150),color(255),12,color(100),3);
    //new ValueBar("Experience","This shows your current progress in the game.", ExpDiff,275,height-25,width - 550,10,color(0),2,color(255),1,color(255,255,102));
    //ValueBar(String title,String Description, double MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground) {
    MoodBar = new ValueBar("Mood","This shows your recruits Mood, if below a certian point, the recruit will become Moody, if at 0, your recruit will go on strike.",Mood,x,y,50,10,color(0),2,color(255),1,color(25,200,25));
    //public ValueBar(String title,String Description, double MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground)
    ExpBar = new ValueBar("Experience","Your Recruit's Experence.", ExpDiff,x,y,0,10,color(0),2,color(255),1,color(255,255,102));
  }

  public void updateMoodSpeed() {
    if(OverTime) {
      BonusMoodSpeed = MoodSpeed*4;
    } else {
      BonusMoodSpeed = 0;
    }
  }
  
  public void RestInTavern() {

    if(pl.InTavern) {
      if(currentMood < Mood) {
        currentMood += 0.4/frameRate; 
      }
    } else {
      if(currentMood > 0) {
        currentMood -= (MoodSpeed+BonusMoodSpeed)/frameRate;
      }
    }
  }
  
  public void TriggerWhileAttackedEvent(Enemy en) {
    
  }
  
  public void TriggerOnAttackEvent(Enemy en) {
    
  }  
  
  public void TriggerOnEnemyDeadEvent(Enemy en) {
    
  } 
  
  public void TimeEvent() {
    RestInTavern();
    if(currentMood > 0) {
      updateMoodSpeed();
      MoodBar.innerBackground = color(200-MoodBarColor(),25+MoodBarColor(),25);
      PayButton.hoverInfo.updateDescription("Pay","Increase the Mood for this recruit! Cost " +PayPrice +"z");
      Strike = false;
    } else {
      Strike = true;
      UnitAsButton.background = color(200,25,25);
    }
    if(currentMood > MoodCriticalPoint) {
      UnitAsButton.background = color(25,200,25);
      Moody = false;
    } else {
      if(Strike == false) {
        UnitAsButton.background = color(255,140,0);
      }
      Moody = true;
    }
  }
  
  float MoodBarColor() {
    return (currentMood/100)*175;
  }
  
  public void ActionEvent(Enemy en) {
    updateStat();
    Attack(en);
    if (Strike) {
      BonusVit = -(CharVit+ItemVit);
      BonusStr = -(CharStr+ItemStr);
      BonusEnd = -(CharEnd+ItemEnd);
      BonusAgi = -(CharAgi+ItemAgi);
      BonusDex = -(CharDex+ItemDex);     
    } else if(Moody) {
      BonusVit = -(CharVit+ItemVit)*0.5;
      BonusStr = -(CharStr+ItemStr)*0.5;
      BonusEnd = -(CharEnd+ItemEnd)*0.5;
      BonusAgi = -(CharAgi+ItemAgi)*0.5;
      BonusDex = -(CharDex+ItemDex)*0.5;
    } else if(OverTime) {
      BonusVit = (CharVit+ItemVit);
      BonusStr = (CharStr+ItemStr);
      BonusEnd = (CharEnd+ItemEnd);
      BonusAgi = (CharAgi+ItemAgi);
      BonusDex = (CharDex+ItemDex);    
    } else {
      BonusVit = 0;
      BonusStr = 0;
      BonusEnd = 0;
      BonusAgi = 0;
      BonusDex = 0;
    }
  }
  
  
  
  public void Attack(Enemy en) {
    if(pl.Alive && en.UnitPlaced) {
      if(TotalDmg > en.TotalDef  && en.Alive) {
        en.CurrentHp -= (TotalDmg-en.TotalDef)/frameRate;
        //temp
        
        //popText.add(new PopText((long)(TotalDmg-en.TotalDef)+"",1,0.5,mouseX,mouseY - 10,30,color(255)));
      }
    }
  }  
  
  public void draw() {
    super.draw();
  }
  
  public void UpgradeStat() {
    CharVit += floor((Level - OldLevel)*uVit);
    CharStr += floor((Level - OldLevel)*uStr);
    CharEnd += floor((Level - OldLevel)*uEnd);
    CharAgi += floor((Level - OldLevel)*uAgi);
    CharDex += floor((Level - OldLevel)*uDex);
    updateStat();
    OldLevel = Level;
  }
  
  
  public void GuildUnitLevelUp(long gain) {
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
            MaxExp = Level*4 + 10 + OldMaxExp;
            
            
            //logs.add(new Log("You Leveled up to " + Level,color(255,255,255)));
            //logs.add(new Log("You gain " + (long)Math.floor(3 + (Level/7)) + " stat points",color(255,255,255)));
          } else {
            lvlmore =true;
            ExpDiff = MaxExp - OldMaxExp;
            if(Alive) {
              //CurrentHp += TotalHp*0.1;
            }
          }
        }
      }
     UpgradeStat();
     //if(UnitAsButton != null) {
     //  pl.LvlUp.add(new PopText("LVL UP!",1.5,1,UnitAsButton.x + UnitAsButton.sizeX/2,UnitAsButton.y,15,color(255)));
     //}
     PayPrice = (long)(128*Level + pow(1.00003,Level));
     CurrentExpGain = Exp - OldMaxExp;  
    }
  }
   
  void mousePressed() {
    UnitAsButton.mousePressed();
  }
  
  void mouseReleased() {
    UnitAsButton.mouseReleased();
  }
}