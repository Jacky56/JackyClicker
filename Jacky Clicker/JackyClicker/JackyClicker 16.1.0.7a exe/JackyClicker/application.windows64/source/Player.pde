public class Player extends Unit {
  
  float DeathTimer;
  float CurrentDeathTimer;
  
  @Expose
  //?
  long StatPoints;
  //?
  long TotalStatPoints;
  //in use
  long TotalExp,LossExp;
  
  @Expose
  //in use
  long Exp, Level, MaxExp, OldMaxExp, ExpGain, CurrentExpGain, ExpDiff; 
  
  @Expose
  long Zeny;
  @Expose
  long Prestige;
  
  ValueBar ExpBar;
  
  ArrayList<BuffIcon> buffIcon = new ArrayList<BuffIcon>();
  
  
  //temp - TRigger as single player/or refer to only this player
  boolean ThisPlayer;
  
  boolean InTavern;
  
  @Expose
  ArrayList<GuildUnit> guildUnit = new ArrayList<GuildUnit>();
  
  
  
  //ArrayList<PopText> LvlUp = new ArrayList<PopText>();
  
  public Player(String Name,String Description,float x,float y,double CharVit,double CharStr,double CharEnd,double CharAgi,double CharDex) {
    super( Name, Description, x, y, CharVit, CharStr, CharEnd, CharAgi, CharDex);
    UnitAsButton = new Button(Name,Description,x,y,80,80,5,color(25,200,25),color(255),15,color(255),3);
    DeathTimer = 50;
    CurrentDeathTimer = DeathTimer;
    PlayerLevelUp(0);
    
    CharExp = 1;
    CharZeny = 1;
    CharPrestige = 1;
    //ValueBar(float MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground)
    //HpBar = new ValueBar(TotalHp,width/2 - 225,15,450,15,color(0),2,color(255),1,color(200,25,25));
    ExpBar = new ValueBar("Experience","This shows your current progress in the game.", ExpDiff,275,height-25,width - 550,10,color(0),2,color(255),1,color(255,255,102));
    //guildUnit.add(new Leecher( "Leecher","Does nothing but leeches your exp, can be killed(Tapped) for 100% of the leeched exp and 50% more.",this,12, 12, 0, 0, 0,0,0,0));
    
  }
  
  public Player(Player pl) {
    this(pl.Name,pl. Description,pl. x,pl. y,pl. CharVit,pl. CharStr,pl. CharEnd,pl. CharAgi,pl. CharDex,pl. Exp, pl. Zeny,pl. Prestige,pl. CharExp,pl. CharZeny,pl. CharPrestige, pl. StatPoints);
  }
  
  
  
  public void createObject() {
    UnitAsButton = new Button(Name,Description,x,y,80,80,5,color(25,200,25),color(255),15,color(255),3);
    ExpBar = new ValueBar("Experience","This shows your current progress in the game.", ExpDiff,275,height-25,width - 550,10,color(0),2,color(255),1,color(255,255,102));
  }
  
  
  
  
  public Player(String Name,String Description,float x,float y,double CharVit,double CharStr,double CharEnd,double CharAgi,double CharDex,long exp, long zeny,long prestige,float CharExp,float CharZeny,float CharPrestige, long StatPoints) {
    this( Name, Description, x, y, CharVit, CharStr, CharEnd, CharAgi, CharDex);
    PlayerLevelUp(exp);
    Zeny = zeny;
    this.Prestige = prestige;
    this.CharExp = CharExp;
    this.CharZeny = CharZeny;
    this.CharPrestige = CharPrestige;
    this.StatPoints = StatPoints;
  }

  @Override
  public void HoverEvent() {
    if(UnitPlaced) {
      super.HoverEvent();
      ExpBar.BarInfo.draw();
    }
  }
  
  @Override
  public void draw() {
    if(UnitPlaced) {
      super.draw();
      ExpBar.draw();
    }
  }
  
  @Override
  public void TimeEvent() {
    super.TimeEvent();
    ReviveTime();
    ExpBar.updateBar(CurrentExpGain,ExpDiff);
    UnitAsButton.title = Name;
    UnitAsButton.hoverInfo.updateDescription(Name,Description);
  }
  
  //reason why i put 2 Alive , 1 for multipler( it auto falses the enemy button), if i clicked the enmy when im dead which will auto do dmg on it
  public void Attack(Enemy en) {
    if(Alive && ThisPlayer) {
      if (en.UnitAsButton.wasClicked) {
        if(TotalDmg > en.TotalDef  && en.Alive && Alive) {
          en.CurrentHp -= (TotalDmg-en.TotalDef);
          
          //temp
          popText.add(new PopText((long)(TotalDmg-en.TotalDef)+"",1,0.5,mouseX,mouseY - 10,30,color(255)));
          
        }
        en.UnitAsButton.wasClicked = false;
      }
    }
  }
  
  
  
  public void ActionEvent(Enemy en) {
    if(UnitPlaced) {
      super.ActionEvent();
      Revive();
      Attack(en);
    }
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
            StatPoints += 10;
            TotalStatPoints += 10;
            MaxExp = Level*4 + 10 + OldMaxExp;
            
            
            //PopText(String text,float speedY,float LifeTime,float x,float y,float textSize,color textColor,float Angle) {
            //logs.add(new Log("You Leveled up to " + Level,color(255,255,255)));
            //logs.add(new Log("You gain " + (long)Math.floor(3 + (Level/7)) + " stat points",color(255,255,255)));
          } else {
            lvlmore =true;
            ExpDiff = MaxExp - OldMaxExp;
            popText.add(new PopText("LVL UP!",1.5,1,x+UnitAsButton.sizeX/2,y+UnitAsButton.sizeY/2,24,color(255),random(-20,20)));      
            if(Alive) {
              //CurrentHp += TotalHp*0.1;
            }
          }
        }
      }
         
   CurrentExpGain = Exp - OldMaxExp;  
   }
  }
  
}