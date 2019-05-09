public class GoldenCookie extends Object {
  
  
  
  Button GoldenCookieAsButton;
  
  
  long BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex;
  long rawBonusRegHp, rawBonusDef, rawBonusDmg,rawBonusHp,rawBonusCrit, rawBonusCritDmg;
  long statBonusRegHp, statBonusDef, statBonusDmg,statBonusHp,statBonusCrit, statBonusCritDmg;
  
  
  long ExpBounty;
  long GoldBounty;
  
  
  float duration;
  boolean Alive;
  
  boolean BadCookie;
  //Enemy(String Name,String Description,float x,float y,long CharVit,long CharStr,long CharEnd,long CharAgi,long CharDex,float AttackTimer,long ExpBounty,long GoldBounty)
  //Button(Name,Description,x,y,200,200,5,color(200,25,25),color(255),15,color(255),3);
  public GoldenCookie(String Name,String Description,boolean BadCookie) {
    super( Name, Description, 0, 0);
    duration = 10;
    Alive = true;
    this.BadCookie = BadCookie;
    
    if(BadCookie) {
      GoldenCookieAsButton = new Button(Name,Description,random(0,width-60),random(0,height-60),60,60,5,color(150,150,25),color(255),9,color(200,25,25),2);
    } else {
      GoldenCookieAsButton = new Button(Name,Description,random(0,width-60),random(0,height-60),60,60,5,color(150,150,25),color(255),9,color(25,200,25),2);
    }
    
    
  }  
  
  void HoverEvent() {
    GoldenCookieAsButton.hoverInfo.draw();
  }
  
  
  void ActionEvent() {
    
  }
  
  
  void TimeEvent() {
    CookieTimer();
    //BuffInfo.updateDescription(title,infoDescription + " " + round(duration) + " seconds remaining.");
  }
  
  void CookieTimer() {
    if(duration > 0) {
    duration -= 1/frameRate;
    } else {
      Alive = false;
    }
  }
  
  void GiveValue(Player pl) {
    if(GoldenCookieAsButton.wasClicked) {
      GoldenCookieAsButton.wasClicked = false;
      if(pl.Alive) {
        //pl.PlayerLevelUp(ExpBounty);
        createCookieValue();
        Alive = false;
      }
    }
  }
  
  //temp
  void createCookieValue() {
    int rolled = round(random(4));
    long statValue = 100;
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
    
    
    for(int n = 0; n < panelParty.PPP.size(); n++) {
      panelParty.PPP.get(n).buffIcon.add(new BuffIcon(buffKey + " " + buffTitle,buffInfo+ " Player's "+ buffKey +" by " +statValue+".",30,player,BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,0,0,0,0,0,panelParty.PPP.get(n).x,panelParty.PPP.get(n).y,15,15,2,color(150,150,25),color(255),lineColor,1));
    }    
  }
  
}