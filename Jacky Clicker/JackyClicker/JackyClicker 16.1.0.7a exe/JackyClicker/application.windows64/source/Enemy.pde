public class Enemy extends Unit {
  double AttackTimer;
  
  double CurrentAttackTimer;
  
  long ExpBounty;
  long GoldBounty;
  long PrestigeBounty;
  
  boolean GaveBounty;
  
  ValueBar AttackTimerBar;
  
  
  double TempDmg;
  
  
  
  public Enemy(String Name,String Description, float x ,float y,double CharVit,double CharStr,double CharEnd,double CharAgi,double CharDex,double AttackTimer,long ExpBounty,long GoldBounty,long PrestigeBounty) {
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
      //UnitAsButton.hoverInfo.draw();
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
  
  @Override
  public void RegenHp() {
    if(Alive) {
      CurrentHp += (TotalRegHp/frameRate);
      correctCurrentHp();
    }
  }
  
  
  @Override
  public void TimeEvent() {
    super.TimeEvent();
    AttackTime();
    HpBar.updateBar(CurrentHp,TotalHp);
    AttackTimerBar.updateBar(CurrentAttackTimer,AttackTimer);  
  }
  
  public void ActionEvent(ArrayList<Player> pl,Player ThisPlayer) {
    if(UnitPlaced) {
      super.ActionEvent();
      Attack(pl.get(round(random(pl.size()-1))));
      giveBounty(pl,ThisPlayer);
    }
  }
  
  
  
  public void Attack(Player pl) {
    //temp attack 
    
    TempDmg = TotalDmg;
    
    if(CurrentAttackTimer > AttackTimer && pl.Alive && Alive) {
      CurrentAttackTimer = 0;
      
      
      for(int n = 0; n < pl.guildUnit.size(); n++) {
        pl.guildUnit.get(n).TriggerWhileAttackedEvent(this);
      }
        
      if(TempDmg > pl.TotalDef) {
        pl.CurrentHp -= (TempDmg - pl.TotalDef);
        //(String text,float speedY,float LifeTime,float x,float y,float textSize,color textColor)
        //temp
        if(pl.ThisPlayer) {
          popText.add(new PopText((long)(TempDmg-pl.TotalDef)+"",1,0.5,pl.x + pl.UnitAsButton.sizeX/2,pl.y,30,color(200,25,25)));
        }
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
  }
  
  
  //temp only for single player
  void giveBounty(ArrayList<Player> pl,Player ThisPlayer) {
    if(UnitPlaced) {
      if(Alive == false && GaveBounty == false) {
        
        for(int n = 0; n < pl.size();n++) {
          Player pla = pl.get(n);
          
          long exp = (long)ceil(ExpBounty*(pla.CharExp + pla.ItemExp + pla.BonusExp)/(1+pla.guildUnit.size()));
          long gold = (long)(GoldBounty*(pla.CharZeny + pla.ItemZeny + pla.BonusZeny));
          long prestige = (long)(PrestigeBounty*(pla.CharPrestige + pla.ItemPrestige + pla.BonusPrestige));
          
          for(int i = 0; i < pla.guildUnit.size(); i++) {
            pla.guildUnit.get(i).GuildUnitLevelUp(exp);
            pla.guildUnit.get(i).TriggerOnEnemyDeadEvent(this);
          }
          
          pla.PlayerLevelUp(exp);
          pla.Zeny += gold;
          pla.Prestige += prestige;
        }
        GaveBounty = true;
        
        
        
        if(GoldBounty != 0) {
          //PopText(String text,float speedY,float LifeTime,float x,float y,float textSize,color textColor)
          popText.add(new PopText("+"+(long)(GoldBounty*(ThisPlayer.CharZeny + ThisPlayer.ItemZeny + ThisPlayer.BonusZeny))+"z",1,random(1,1.5),random(x+UnitAsButton.sizeX/4,x+UnitAsButton.sizeX*3/4),random(y+UnitAsButton.sizeY/4,y+UnitAsButton.sizeY*3/4),20,color(150)));
        }
        
        if(PrestigeBounty != 0) {
          popText.add(new PopText("+"+(long)(PrestigeBounty*(ThisPlayer.CharPrestige + ThisPlayer.ItemPrestige + ThisPlayer.BonusPrestige))+" favor",0.3,random(4,5),random(x+UnitAsButton.sizeX/4,x+UnitAsButton.sizeX*3/4),random(y+UnitAsButton.sizeY/4,y+UnitAsButton.sizeY*3/4),30,color(204,102,0)));
        }
        
        if(ExpBounty != 0) {
          popText.add(new PopText("+" +(long)(ExpBounty*(ThisPlayer.CharExp + ThisPlayer.ItemExp + ThisPlayer.BonusExp)/(1+ThisPlayer.guildUnit.size()))+" exp",1,random(1,1.5),random(x+UnitAsButton.sizeX/4,x+UnitAsButton.sizeX*3/4),random(y+UnitAsButton.sizeY/4,y+UnitAsButton.sizeY*3/4),20,color(255,255,51)));
        }
        
      }
    }
  }
  
}