protected class Enemy extends Unit {
  private double AttackTimer;
  
  private double CurrentAttackTimer;
  
  private long ExpBounty;
  private long GoldBounty;
  private long PrestigeBounty;
  
  private boolean GaveBounty;
  
  private ValueBar AttackTimerBar;
  
  
  private double TempDmg;
  
  private boolean RealmLord;
  
  private long Level;
  
  private ArrayList<BuffIcon> buffIcon = new ArrayList<BuffIcon>();
  
  protected Enemy(String Name,String Description, float x ,float y,long Level,double CharVit,double CharStr,double CharEnd,double CharAgi,double CharDex,double AttackTimer,long ExpBounty,long GoldBounty,long PrestigeBounty) {
    super( Name, Description, x, y, CharVit, CharStr, CharEnd, CharAgi, CharDex);
    this.AttackTimer = AttackTimer;
    this.ExpBounty = ExpBounty;
    this.GoldBounty = GoldBounty;
    this.PrestigeBounty = PrestigeBounty;
    this.Level = Level;
    UnitAsButton = new Button(Name,Description,x,y,200,200,5,color(200,25,25),color(255),15,color(255),3);
    //ValueBar(long MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground) {
    HpBar = new ValueBar(TotalHp,width/2 - 225,15,450,15,color(0),2,color(255),1,color(200,25,25));
    
    AttackTimerBar = new ValueBar("Attack Timer","This enemy will attack someone when this bar is full.", AttackTimer,width/2 - 225,35,175,10,color(0),2,color(255),1,color(200));
  }
  
  protected Enemy(String Name,String Description, float x ,float y,long Level,double CharVit,double CharStr,double CharEnd,double CharAgi,double CharDex,double AttackTimer,long ExpBounty,long GoldBounty,long PrestigeBounty, PImage image,float textSize,color textColor) {
    super( Name, Description, x, y, CharVit, CharStr, CharEnd, CharAgi, CharDex);
    this.AttackTimer = AttackTimer;
    this.ExpBounty = ExpBounty;
    this.GoldBounty = GoldBounty;
    this.PrestigeBounty = PrestigeBounty;
    this.Level = Level;
    //  public Button(String title,String infoDescription,float x,float y,float sizeX,float sizeY,PImage image) {

    UnitAsButton = new Button(Name,Description,x,y,200,200,textSize,textColor,-100,image);
    //ValueBar(long MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground) {
    HpBar = new ValueBar(TotalHp,width/2 - 225,15,450,15,color(0),2,color(255),1,color(200,25,25));
    
    AttackTimerBar = new ValueBar("Attack Timer","This enemy will attack someone when this bar is full.", AttackTimer,width/2 - 225,35,175,10,color(0),2,color(255),1,color(200));
  }  
  
  @Override
  protected void HoverEvent() {
    if(UnitPlaced) {
      super.HoverEvent();
      
      AttackTimerBar.BarInfo.draw();
      
      
      for(int n = 0; n < buffIcon.size();n++) {
        if(n < 11) {
          buffIcon.get(n).BuffInfo.draw();
        }
      }
      
    }
  }
  
  @Override
  public void draw() {
    if(UnitPlaced) {
      super.draw();
      
      for(int n = 0; n < buffIcon.size();n++) {
        if(n < 11) {
          buffIcon.get(n).updatePosition(HpBar.x+HpBar.sizeX - 25*(n+1) + 5,HpBar.y + 20);
          buffIcon.get(n).draw();
        }
      }
    }
    HpBar.draw();
    AttackTimerBar.draw();
  }
  
  //THIS
  //@Override
  //public void RegenHp() {
  //  if(Alive) {
  //    CurrentHp += (TotalRegHp/frameRate);
  //    correctCurrentHp();
  //  }
  //}
  
  
  @Override
  protected void TimeEvent() {
    super.TimeEvent();
    AttackTime();
    HpBar.updateBar(CurrentHp,TotalHp);
    AttackTimerBar.updateBar(CurrentAttackTimer,AttackTimer);
    
    for(int n = 0; n < buffIcon.size();n++) {
      buffIcon.get(n).TimeEvent(this);
    }
    
  }
  
  protected void ActionEvent(ArrayList<Player> pl,Player ThisPlayer,float CurrentMile,float Dif) {
    if(UnitPlaced) {
      super.ActionEvent();
      Attack(pl.get(round(random(pl.size()-1))));
      giveBounty(pl,ThisPlayer,CurrentMile,Dif);
      for(int n = 0; n < buffIcon.size();n++) {
        buffIcon.get(n).ActionEvent(this);
        if(buffIcon.get(n).Active == false) {
          buffIcon.remove(n);
        }
      }
      
    }
  }
  
  
  
  private void Attack(Player pl) {
    //temp attack
    double critChance = (4/(double)Level)*((1-(Math.pow(0.975,4*(TotalCrit + 1)/(double)Level)))/(1-Math.pow(0.975,4/(double)Level)));
    TempDmg = TotalDmg;
    boolean doneCrit = false;
    if(critChance+TotalCritPercent > random(100)) {
      TempDmg = TotalDmg*(1+(TotalCritDmg*0.05));
      doneCrit = true;
    }    
    
    if(CurrentAttackTimer > AttackTimer && pl.Alive && Alive) {
      CurrentAttackTimer = 0;
      
      
      for(int n = 0; n < pl.guildUnit.size(); n++) {
        pl.guildUnit.get(n).TriggerWhileAttackedEvent(this);
      }
      pl.TriggerWhileAttackedEvent(this);
      
      
      if(TempDmg > pl.TotalDef) {
        pl.CurrentHp -= (TempDmg - pl.TotalDef);
        //(String text,float speedY,float LifeTime,float x,float y,float textSize,color textColor)
        //temp
        if(pl.ThisPlayer) {
          if(doneCrit) {
            popText.add(new PopText("-"+(long)(TempDmg-pl.TotalDef)+"",0.5,0.9,pl.x + pl.UnitAsButton.sizeX/2,pl.y,41,color(153,0,102)));
          } else {
            popText.add(new PopText("-"+(long)(TempDmg-pl.TotalDef)+"",1,0.5,pl.x + pl.UnitAsButton.sizeX/2,pl.y,35,color(200,25,25)));
          }
        }
      }
    }
    
  }
  
  //temp only single player
  private void AttackTime() {
    if(AttackTimer < CurrentAttackTimer) {
      CurrentAttackTimer = AttackTimer;
    }    
    if(Alive) {
      CurrentAttackTimer += 1/frameRate;
    }
  }
  
  //?
  @Override
  protected void Dead() {
    super.Dead();
  }
  
  
  //temp only for single player
  private void giveBounty(ArrayList<Player> pl,Player ThisPlayer,float CurrentMile,float Dif) {
    if(UnitPlaced) {
      if(Alive == false && GaveBounty == false) {
        
        
        
        
        for(int n = 0; n < pl.size();n++) {
          Player pla = pl.get(n);
          long exp = (long)ceil(ExpBounty*(pla.CharExp + pla.ItemExp + pla.BonusExp)/(1+pla.guildUnit.size()));
          long gold = (long)(GoldBounty*(pla.CharZeny + pla.ItemZeny + pla.BonusZeny));
          long prestige = (long)(PrestigeBounty*(pla.CharPrestige + pla.ItemPrestige + pla.BonusPrestige));
          
          //temp
          if(random(100) < 2) {

            for(int i = 0; i < pla.Inventory.length; i++) {
              if(pla.Inventory[i] == null) {
                //new Equipment("Head of Grand Master","Some Description "+type+n,type+".png",color(150,25,150),type,56,500,1.05,x + padding + SlotOrder*(n%3),y + sizeY - 20 - (SlotOrder * 4) - padding + SlotOrder*floor(n/3),SlotOrder-4,SlotOrder-4);
                //pla.Inventory[i] = new Equipment("Head of Grand Master","Some Description ","boot.png",color(150,25,150),"boot",random(1,100),CurrentMile,Dif,inventoryPanel.x +inventoryPanel.padding + inventoryPanel.SlotOrder*(i%3),inventoryPanel.y + inventoryPanel.sizeY - 20 - (inventoryPanel.SlotOrder * 4) - inventoryPanel.padding + inventoryPanel.SlotOrder*floor(i/3),inventoryPanel.SlotOrder-4,inventoryPanel.SlotOrder-4);
                pla.Inventory[i] = new Equipment(random(0,40 * random(1,2.5)),CurrentMile,Dif,inventoryPanel.x +inventoryPanel.padding + inventoryPanel.SlotOrder*(i%3),inventoryPanel.y + inventoryPanel.sizeY - 20 - (inventoryPanel.SlotOrder * 4) - inventoryPanel.padding + inventoryPanel.SlotOrder*floor(i/3),inventoryPanel.SlotOrder-4,inventoryPanel.SlotOrder-4);
                popText.add(new PopText("You Looted an Item!",1,random(1,1.5),random(x+UnitAsButton.sizeX/4,x+UnitAsButton.sizeX*3/4),random(y+UnitAsButton.sizeY/4,y+UnitAsButton.sizeY*3/4),20,color(150,25,150)));
                break;
              } 
            }
          }
          
          
          for(int i = 0; i < pla.guildUnit.size(); i++) {
            pla.guildUnit.get(i).GuildUnitLevelUp(exp);
            pla.guildUnit.get(i).TriggerOnEnemyDeadEvent(this);
            
          }
          pla.TriggerOnEnemyDeadEvent(this);
          
          pla.PlayerLevelUp(exp);
          pla.Zeny += gold;
          pla.CurrentPrestige += prestige;
          
          if(RealmLord) {
            pla.KilledRealmLord = true;
          }
          
        }
        GaveBounty = true;
        
        
        
        if(GoldBounty != 0) {
          
          createMovingObject.add(new CreateMovingObject("Zeny.png",x+UnitAsButton.sizeX/2,y+UnitAsButton.sizeY/2,4,random(8,12),random(60,120),random(20,25)));
          
          popText.add(new PopText("+"+(long)(GoldBounty*(ThisPlayer.CharZeny + ThisPlayer.ItemZeny + ThisPlayer.BonusZeny))+"z",1,random(1,1.5),random(x+UnitAsButton.sizeX/4,x+UnitAsButton.sizeX*3/4),random(y+UnitAsButton.sizeY/4,y+UnitAsButton.sizeY*3/4),20,color(150)));
        }
        
        if(PrestigeBounty != 0) {
          createMovingObject.add(new CreateMovingObject("PrestigeCurrency.png",x+UnitAsButton.sizeX/2,y+UnitAsButton.sizeY/2,4,random(8,12),random(60,120),random(20,25)));
          popText.add(new PopText("+"+(long)(PrestigeBounty*(ThisPlayer.CharPrestige + ThisPlayer.ItemPrestige + ThisPlayer.BonusPrestige))+" Prestige Points",0.3,random(4,5),random(x+UnitAsButton.sizeX/4,x+UnitAsButton.sizeX*3/4),random(y+UnitAsButton.sizeY/4,y+UnitAsButton.sizeY*3/4),30,color(255,0,255)));
        }
        
        if(ExpBounty != 0) {
          popText.add(new PopText("+" +(long)(ExpBounty*(ThisPlayer.CharExp + ThisPlayer.ItemExp + ThisPlayer.BonusExp)/(1+ThisPlayer.guildUnit.size()))+" exp",1,random(1,1.5),random(x+UnitAsButton.sizeX/4,x+UnitAsButton.sizeX*3/4),random(y+UnitAsButton.sizeY/4,y+UnitAsButton.sizeY*3/4),20,color(255,255,51)));
        }
        
      }
    }
  }
  
}