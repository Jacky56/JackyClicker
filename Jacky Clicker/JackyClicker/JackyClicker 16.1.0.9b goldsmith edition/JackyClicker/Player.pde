//the player class 
// thi is probably which could be the most commented on...
protected class Player extends Unit {
  //death timer  
  protected float DeathTimer;
  protected float CurrentDeathTimer;
  //@Expose used for Gson builder  
  
  @Expose
  protected long ClickedOnEnemy;
  @Expose
  protected float TimePlayed;
  
  
  @Expose
  protected long Death;
  
  @Expose

  protected long StatPoints;

  protected long TotalStatPoints;

  protected long TotalExp,LossExp;
  
  
  
  @Expose
  protected long OldMaxPrestige,MaxPrestige,CurrentPrestige,PrestigeDiff;
  @Expose
  protected long TotalPrestige;
  @Expose
  protected long PrestigeLevel;
  @Expose
  protected float CharZenyMultipler;
  @Expose
  protected float CharExpMultipler;
  
  @Expose
  protected Equipment Inventory[] = new Equipment[21];
  
  @Expose
  Equipment HeadSlot;
  @Expose
  Equipment BodySlot;
  @Expose
  Equipment GloveSlot;
  @Expose
  Equipment BootSlot;
  @Expose
  Equipment WeaponSlot;
  @Expose
  Equipment NeckSlot;
  @Expose
  Equipment RingSlot;  
  
  
  
  
  
  @Expose
  //in use
  protected long Exp, Level, MaxExp, OldMaxExp, ExpGain, CurrentExpGain, ExpDiff;    //exp
  
  @Expose
  protected long Zeny;   //ur currency
  
  @Expose
  protected long Prestige;
  
  @Expose
  protected float PrestigeForLevelMultipler;
  
  
  
  protected long PrestigeForLevel;
  
  private ValueBar ExpBar;
  
  protected ArrayList<BuffIcon> buffIcon = new ArrayList<BuffIcon>();   //buffs 
  
  
  //temp - TRigger as single player/or refer to only this player
  public boolean ThisPlayer;
  
  protected boolean InTavern;
  //enlist guild units under the player's existance  
  @Expose
  protected ArrayList<GuildUnit> guildUnit = new ArrayList<GuildUnit>();
  //used for ascending ( not added in the game ) 
  @Expose
  protected boolean KilledRealmLord;
  
  //ArrayList<PopText> LvlUp = new ArrayList<PopText>();
  
  //added in 16.1.0.8  
  //temp
  private float AttackImageDuration;
  
  
  @Expose
  protected boolean[] PrestigeSkills = new boolean[10];
  //..  
  protected Player(String Name,String Description,float x,float y,double CharVit,double CharStr,double CharEnd,double CharAgi,double CharDex) {
    super( Name, Description, width/2 -40, height/2 +100, CharVit, CharStr, CharEnd, CharAgi, CharDex);
    //Button(String title,String infoDescription,float x,float y,float sizeX,float sizeY,float textSize,color textColor,PImage image)
    UnitAsButton = new Button(Name,Description, width/2 -40, height/2 +100,80,80,21,color(255),50,LoadAllImage.get("Hero.png"));
    DeathTimer = 50;
    CurrentDeathTimer = DeathTimer;
    PlayerLevelUp(0);
    this.x = width/2 -40;
    this.y = height/2 +100;
    CharExp = 1;
    CharZeny = 1;
    CharPrestige = 1;
    
    CharZenyMultipler = 0.05;
    CharExpMultipler = 0.05;
    
    PrestigeForLevelMultipler = 2;
    //ValueBar(float MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground)
    //HpBar = new ValueBar(TotalHp,width/2 - 225,15,450,15,color(0),2,color(255),1,color(200,25,25));
    ExpBar = new ValueBar("Experience","This shows your current progress in the game.", ExpDiff,275,height-25,width - 550,10,color(0),2,color(255),1,color(255,255,102));
    //guildUnit.add(new Leecher( "Leecher","Does nothing but leeches your exp, can be killed(Tapped) for 100% of the leeched exp and 50% more.",this,12, 12, 0, 0, 0,0,0,0));
  }
  //used for loading the player  
  protected Player(Player pl) {
    this(pl.Name,pl. Description,pl.x,pl.y,pl. CharVit,pl. CharStr,pl. CharEnd,pl. CharAgi,pl. CharDex);
    //,long exp, long zeny,long prestige,float CharExp,float CharZeny,float CharPrestige, long StatPoints
    PlayerLevelUp(pl.Exp);
    //Exp = pl.Exp;
    Zeny = pl.Zeny;
    StatPoints = pl.StatPoints;
    
    //inventory
    for(int n = 0; n < Inventory.length;n++) {
      if(pl.Inventory[n] != null) {
        Inventory[n] = new Equipment(pl.Inventory[n]);
      }
    }
    if(pl.HeadSlot != null) {
      HeadSlot = new Equipment(pl.HeadSlot);
    }
    if(pl.BodySlot != null) {
      BodySlot = new Equipment(pl.BodySlot);
    }
    if(pl.GloveSlot != null) {
      GloveSlot = new Equipment(pl.GloveSlot);
    }
    if(pl.BootSlot != null) {
      BootSlot = new Equipment(pl.BootSlot);
    }
    if(pl.WeaponSlot != null) {
      WeaponSlot = new Equipment(pl.WeaponSlot);
    }
    if(pl.NeckSlot != null) {
      NeckSlot = new Equipment(pl.NeckSlot);
    }
    if(pl.RingSlot != null) {
      RingSlot = new Equipment(pl.RingSlot);
    }
    
    //temp
    TimePlayed = pl.TimePlayed;
    ClickedOnEnemy = pl.ClickedOnEnemy;
    
    
    
    KilledRealmLord = pl.KilledRealmLord;
    CharCritPercent = pl.CharCritPercent;
    ItemCritPercent = pl.ItemCritPercent;
    Death = pl.Death;
    
    
    //prestige counting 
    Prestige = pl.Prestige;
    TotalPrestige = pl.TotalPrestige;
    PrestigeLevel = pl.PrestigeLevel;
    PrestigeDiff = pl.PrestigeDiff;
    CurrentPrestige = pl.CurrentPrestige;
    MaxPrestige = pl.MaxPrestige;
    OldMaxPrestige = pl.OldMaxPrestige;
    
    //multipler for lvls
    PrestigeForLevelMultipler = pl.PrestigeForLevelMultipler;
    CharZenyMultipler = pl.CharZenyMultipler;
    CharExpMultipler = pl.CharExpMultipler;
    
    //lvl bonus  
    CharZeny = 1 + CharZenyMultipler*pl.PrestigeLevel;
    CharExp = 1 + CharExpMultipler*pl.PrestigeLevel;
    CharPrestige = 1;
    
    
    //prestigeskills 
    for(int n = 0; n < PrestigeSkills.length ; n++) {
      PrestigeSkills[n] = pl.PrestigeSkills[n];
    }
    
    
    
    getItemStats();
    CurrentHp = TotalHp;
  }
  

  public void getItemStats() {
    ItemVit = 0;
    ItemStr = 0;
    ItemEnd = 0;
    ItemAgi = 0;
    ItemDex = 0;
    rawItemHp = 0;
    rawItemDmg = 0;
    rawItemDef = 0;
    rawItemRegHp = 0;
    rawItemCrit = 0;
    rawItemCritDmg = 0;
    
    if(HeadSlot != null) {
      getStatFromSlot(HeadSlot);
    }
    
    if(BodySlot != null) {
      getStatFromSlot(BodySlot);
    }

    if(BootSlot != null) {
      getStatFromSlot(BootSlot);
    }
    
    if(WeaponSlot != null) {
      getStatFromSlot(WeaponSlot);
    }
    
    if(GloveSlot != null) {
      getStatFromSlot(GloveSlot);
    }

    if(NeckSlot != null) {
      getStatFromSlot(NeckSlot);
    } 
    
    if(RingSlot != null) {
      getStatFromSlot(RingSlot);
    }
    updateStat();
  }
  
  private void getStatFromSlot(Equipment Slot) {
    ItemVit += Slot.ItemVit;
    ItemStr += Slot.ItemStr;
    ItemEnd += Slot.ItemEnd;
    ItemAgi += Slot.ItemAgi;
    ItemDex += Slot.ItemDex;
    
    rawItemHp += Slot.ItemHp;
    rawItemDmg += Slot.ItemDmg;
    rawItemDef += Slot.ItemDef;
    rawItemRegHp += Slot.ItemRegHp;
    rawItemCrit += Slot.ItemCrit;
    rawItemCritDmg += Slot.ItemCritDmg;
  }
  
  
  
  
  //special skills - not in use
  private void burn(Enemy en) {
    boolean check = false;
    for(int n = 0; n < en.buffIcon.size(); n ++) {
      if(en.buffIcon.get(n).title.equals("Burn")) {
        check = true;
        en.buffIcon.get(n).duration = 3;
        break;
      }
    }
    if(check == false) {
      en.buffIcon.add(new BuffIcon("Burn","Deregenerate Enemy's health by 50% of your total damage per second for 3 seconds.",3,en,0,0,0, 0,0,0,0,0, -(long)(TotalDmg*0.5),0,0,0,0,0 , 123,321, 20,20, 3, color(255,69,0), color(255), color(255,0,0),1));
    }
  }
  
 //special skills - not in use
  private void BreakArmor(Enemy en) {
    boolean check = false;
    for(int n = 0; n < en.buffIcon.size(); n ++) {
      if(en.buffIcon.get(n).title.equals("Break Armor")) {
        check = true;
        en.buffIcon.get(n).duration = 5;
        break;
      } 
    }
    // public BuffIcon(long BonusVit,long BonusStr,long BonusEnd,long BonusAgi,long BonusDex,long rawBonusRegHp,long  rawBonusDef,long  rawBonusDmg,long rawBonusHp,long rawBonusCrit,long rawBonusCritDmg, float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,color lineColor,float lineSize) {
    if(check == false) {
      en.buffIcon.add(new BuffIcon("Break Armor","Reduce Enemy's defences by 45% for 5 seconds.",5,en,0,0,0, 0,0,0,0,0, 0,-(long)(en.TotalDef*0.45),0,0,0,0 , 123,321, 20,20, 3, color(102,200,102), color(255), color(255,0,0),1));
    }
  }
  
  //***enable if you want to see what it does***
  
  //temp
  public void TriggerWhileAttackedEvent(Enemy en) {
    //burn(en);
  }
  //temp
  public void TriggerOnAttackEvent(Enemy en) {
    //burn(en);
    
    //BreakArmor(en);
  }  
  //temp
  public void TriggerOnEnemyDeadEvent(Enemy en) {
    
  }  
  
  
  

  @Override
  public void HoverEvent() {
    if(UnitPlaced) {
      super.HoverEvent();
      ExpBar.BarInfo.draw();
      ExpBar.BarInfo.updateDescription(ExpBar.title,ExpBar.Description +" You are currently level "+ Level+". " + "You require "+(MaxExp-Exp)+" experience points to level up.");
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
  protected void Dead() {
    if (CurrentHp <= 0 && Alive && UnitPlaced) {
     CurrentHp = 0;
     Alive = false;
     Death ++;
    }  
  }  
  
  @Override
  protected void TimeEvent() {
    super.TimeEvent();
    //temp
    TimePlayed += 1/frameRate;
    
    ReviveTime();
    ExpBar.updateBar(CurrentExpGain,ExpDiff);
    UnitAsButton.title = Name;
    UnitAsButton.hoverInfo.updateDescription(Name,Description);
    if(0.01*Death > PrestigeForLevelMultipler) {
      PrestigeForLevel = 0;
    } else {
      PrestigeForLevel = (long)(((float)Level/100.)*(PrestigeForLevelMultipler - 0.01*Death));
    }
  }
  
  //reason why i put 2 Alive , 1 for multipler( it auto falses the enemy button), if i clicked the enmy when im dead which will auto do dmg on it
  private void Attack(Enemy en) {
    if(Alive && ThisPlayer) {
      if (en.UnitAsButton.wasClicked) {
        //temp
        ClickedOnEnemy ++;
        
        double critChance = (4/(double)Level)*((1-(Math.pow(0.975,4*(TotalCrit + 1)/(double)Level)))/(1-Math.pow(0.975,4/(double)Level)));
        double dmg = TotalDmg;
        boolean doneCrit = false;
        
        //temp
        TriggerOnAttackEvent(en);
        
        if(critChance + TotalCritPercent > random(100)) {
          dmg = TotalDmg*(1+(TotalCritDmg*0.05));
          doneCrit = true;
        }
        if(EasterEggClick() == false) {
          if(dmg > en.TotalDef  && en.Alive && Alive) {
            en.CurrentHp -= (dmg-en.TotalDef);
            if(doneCrit) {
              popText.add(new PopText((long)(dmg-en.TotalDef)+"",random(5,6),random(0.5,1),mouseX,mouseY - 10,32,color(255,255,0),random(70,110),random(10,15)));
            } else {
              popText.add(new PopText((long)(dmg-en.TotalDef)+"",random(5,6),random(0.5,1),mouseX,mouseY - 10,28,color(255),random(70,110),random(10,15)));
            }
          }
        }
        en.UnitAsButton.wasClicked = false;
      }
    }
  }
  //so so
  private boolean EasterEggClick() {
    if (currentAreaDungeon.Name.equals("The Space Galaxy") && currentAreaDungeon.en.RealmLord) {
      String word = "";
      switch (round(random(4))) {
        case 0:
        word = "UP";
        break;
        case 1:
        word = "DOWN";
        break;
        case 2:
        word = "LEFT";
        break;
        case 3:
        word = "RIGHT";
        break;
        case 4:
        word = "CHU";
        break;
      }
      popText.add(new PopText(word,random(7,8),random(2,3),mouseX,mouseY - 10,72,color(random(255),random(255),random(255)),random(45,135),random(5,8)));
      return true;
    }
    return false;
  }
  
  protected void ActionEvent(Enemy en) {
    if(UnitPlaced) {
      super.ActionEvent();
      Revive();
      
      if(en.UnitAsButton.mPress) {
        UnitAsButton.image = LoadAllImage.get("HeroReady.png");
      } else if(AttackImageDuration > 0) { 
        AttackImageDuration -= 1/frameRate;
        UnitAsButton.image = LoadAllImage.get("HeroAttack.png");
      } else {
        UnitAsButton.image = LoadAllImage.get("Hero.png");
      }
      
      if(en.UnitAsButton.wasClicked && Alive) {
        AttackImageDuration = 0.1;
        createMovingObject.add(new CreateMovingObject("Slash1.png",x+UnitAsButton.sizeX/2,y,0.1,0,random(-5,5),0));
      }
      Attack(en);

    }
  }
  
  
  
  
  //check if the condiction is met, then revive the player back  
  protected void Revive() {
    if(CurrentDeathTimer < 0) {
      Alive = true;
      CurrentDeathTimer = DeathTimer;
      CurrentHp = TotalHp;
    }
  }
  //a revive counter  
  private void ReviveTime() {
    if(Alive == false) {
      CurrentDeathTimer -= 1/frameRate;
      UnitAsButton.image = LoadAllImage.get("Hero.png");
    }
  }
  // a lvl up function for player  
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

  
  public void PrestigeLevelUp(long prestige) {
    boolean lvlmore = false;
    if (prestige > 0) {
      TotalPrestige += prestige;
      Prestige += prestige;
      }
      if (TotalPrestige >= MaxPrestige) {
        while (lvlmore == false) {
        if (TotalPrestige >= MaxPrestige) {
          OldMaxPrestige = MaxPrestige;
          PrestigeLevel ++;
          MaxPrestige = PrestigeLevel*2 + 8 + OldMaxPrestige;

        } else {
          lvlmore =true;
        }
      }
      PrestigeDiff = MaxPrestige - TotalPrestige;
   }
  }
  
}