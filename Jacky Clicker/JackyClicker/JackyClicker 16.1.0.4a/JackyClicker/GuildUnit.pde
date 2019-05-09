public class GuildUnit extends Unit {
  
  Player pl;
  float Mood;
  float currentMood;
  ValueBar MoodBar;
  float MoodCriticalPoint;
  float MoodSpeed;
  
  long TotalExp,LossExp;
  long Exp, Level, MaxExp, OldMaxExp, ExpGain, CurrentExpGain, ExpDiff; 
  
  long PayPrice;
  
  ValueBar ExpBar;
  
  
  Button FireButton;
  Button PayButton;
  
  boolean Moody;
  boolean Strike;
  
  public GuildUnit(String Name,String Description,Player pl,long CharVit,long CharStr,long CharEnd,long CharAgi,long CharDex,long exp,float MoodCriticalPoint,float MoodSpeed) {
    super( Name, Description, 0, 0, CharVit, CharStr, CharEnd, CharAgi, CharDex);
    Mood = 100;
    this.MoodCriticalPoint = MoodCriticalPoint;
    this.pl = pl;
    this.currentMood = Mood;
    this.MoodSpeed = MoodSpeed;
    GuildUnitLevelUp(exp);
    CharExp = 1;
    CharZeny = 1;
    CharPrestige = 1;
    
    
    //new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
    FireButton = new Button("Fire","Remove this recruit from your Group!",x,y,60,30,3,color(150),color(255),15,color(120),2);
    PayButton = new Button("Pay","Increase the Mood for this recruit!",x,y,60,30,3,color(150),color(255),15,color(120),2);
    //new ValueBar("Experience","This shows your current progress in the game.", ExpDiff,275,height-25,width - 550,10,color(0),2,color(255),1,color(255,255,102));
    //ValueBar(String title,String Description, double MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground) {
    MoodBar = new ValueBar("Mood","This shows your recruits Mood, if below a certian point, the recruit will go on strike.",Mood,x,y,50,10,color(0),2,color(255),1,color(25,200,25));
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
    //public ValueBar(String title,String Description, double MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground)
    ExpBar = new ValueBar("Experience","Your Recruit's Experence.", ExpDiff,x,y,0,10,color(0),2,color(255),1,color(255,255,102));
  }
  
  public void TimeEvent() {
    if(currentMood > 0) {
      currentMood -= MoodSpeed/frameRate;
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
  
  public void ActionEvent() {
    updateStat();
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
    } else {
      BonusVit = 0;
      BonusStr = 0;
      BonusEnd = 0;
      BonusAgi = 0;
      BonusDex = 0;      
    }
  }
  
  
  public void draw() {
    super.draw();
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
            MaxExp = Level*3 + 10 + OldMaxExp;
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
     PayPrice = (long)(1024*Level + pow(1.00003,Level));
     CurrentExpGain = Exp - OldMaxExp;  
    }
  }
   
  
}