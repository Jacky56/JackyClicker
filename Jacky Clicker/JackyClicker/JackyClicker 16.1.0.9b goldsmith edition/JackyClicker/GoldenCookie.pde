//this was removed since 16.1.0.4a
protected  class GoldenCookie extends Object {
  
  
  //programmed as a button
  protected Button GoldenCookieAsButton;
  
  //values that can give to the player 
  protected long BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex;
  protected long rawBonusRegHp, rawBonusDef, rawBonusDmg,rawBonusHp,rawBonusCrit, rawBonusCritDmg;
  protected long statBonusRegHp, statBonusDef, statBonusDmg,statBonusHp,statBonusCrit, statBonusCritDmg;
  
  //moar stuff
  protected long ExpBounty;
  protected long GoldBounty;
  
  //buff duration
  protected float duration;
  //check if the Buff is Alive ( not the player ) its to check if the buff should be removed from the game
  protected boolean Alive;
  //check if its a back cookie
  protected boolean BadCookie;
  
  
  //trigger
  protected boolean Placed;
  //..  
  protected  GoldenCookie(String Name,String Description,boolean BadCookie) {
    super( Name, Description, 0, 0);
    duration = 10;
    Alive = true;
    Placed = true;
    
    this.BadCookie = BadCookie;
    //it will determine the color of the cookie if its a bad 1 or good 1    
    if(BadCookie) {
      GoldenCookieAsButton = new Button(Name,Description,random(250,width-250),random(0,height-60),60,60,5,color(150,150,25),color(255),9,color(200,25,25),2);
    } else {
      GoldenCookieAsButton = new Button(Name,Description,random(250,width-250),random(0,height-60),60,60,5,color(150,150,25),color(255),9,color(25,200,25),2);
    }
    
    
  }  
  //..  
  public void HoverEvent() {
    if(Placed) {
      GoldenCookieAsButton.hoverInfo.draw();
    }
  }
  //..  
  public void draw() {
    if(Placed) {
      GoldenCookieAsButton.draw();
    }
  }
  
  
  //..  
  protected void ActionEvent(Player pl) {
    GiveValue(pl);
  }
  
  //..  
  protected void TimeEvent() {
    CookieTimer();
    //BuffInfo.updateDescription(title,infoDescription + " " + round(duration) + " seconds remaining.");
  }
  
  //check if the cookie decayed on the screen  
  protected void CookieTimer() {
    if(duration > 0) {
    duration -= 1/frameRate;
    } else {
      Alive = false;
    }
  }
  //gives the to player  
  private void GiveValue(Player pl) {
    if(Placed) {
      if(GoldenCookieAsButton.wasClicked) {
        GoldenCookieAsButton.wasClicked = false;
        if(pl.Alive) {
          //pl.PlayerLevelUp(ExpBounty);
          createCookieValue(pl);
          Alive = false;
        }
      }
    }
  }
  
  //temp
  //constructs the name and values for the cookie
  private void createCookieValue(Player pl) {
    int rolled = round(random(4));
    long statValue = (long)(pl.TotalStatPoints*0.35) ;
    String buffKey = "";
    String buffTitle = "";
    String buffInfo = "";
    color lineColor = color(0);
    
    if(BadCookie) {
      lineColor = color (200,25,25);
      buffTitle = "Debuff";
      buffInfo = "Reduce";
      statValue = -statValue;
    } else {
      lineColor = color (25,200,25);
      buffTitle = "Buff";
      buffInfo = "Increase";     
    }
    
    switch(rolled) {
      case 0:
      buffKey = "Vitality";
      BonusVit = statValue;
      break;
      case 1:
      buffKey = "Strength";
      BonusStr = statValue;
      break;
      case 2:
      buffKey = "Endurance";
      BonusEnd = statValue;
      break;
      case 3:
      buffKey = "Agility";
      BonusAgi = statValue;
      break;
      case 4:
      buffKey = "Dexterity";
      BonusDex = statValue;
      break;
      
    }
    
    //creates a buff to the player    
    pl.buffIcon.add(new BuffIcon(buffKey + " " + buffTitle,buffInfo+ " Player's "+ buffKey +" by " +statValue+".",20,pl,0,0,0,BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,0,0,0,0,0,panelParty.PPP.get(0).x,panelParty.PPP.get(0).y,15,15,2,color(150,150,25),color(255),lineColor,1));
  }
  
}