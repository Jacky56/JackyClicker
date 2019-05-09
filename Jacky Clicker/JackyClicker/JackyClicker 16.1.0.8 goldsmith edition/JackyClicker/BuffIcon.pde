//how Buffs are created
public class BuffIcon {
  //nothing is saved here because buffs are temp for the game in general
  float x,y;
  float sizeX,sizeY;
  String title;
  float textSize;
  color background,textColor;
  HoverInfo BuffInfo;
  String infoDescription;
  color lineColor;
  float lineSize;
  float[] curve = new float[4];
  
  
  float duration;
  
  boolean Active;
  
  //possible values for this buff to be given to the player
  long BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex;
  long rawBonusRegHp, rawBonusDef, rawBonusDmg,rawBonusHp,rawBonusCrit, rawBonusCritDmg;
  long statBonusRegHp, statBonusDef, statBonusDmg,statBonusHp,statBonusCrit, statBonusCritDmg;
  float BonusExp;
  float BonusZeny;
  float BonusPrestige;
  
  boolean Gave;
  //..
  public BuffIcon(String title,String infoDescription,float duration,Unit un,float BonusExp,float BonusZeny,float BonusPrestige,long BonusVit,long BonusStr,long BonusEnd,long BonusAgi,long BonusDex,long rawBonusRegHp,long  rawBonusDef,long  rawBonusDmg,long rawBonusHp,long rawBonusCrit,long rawBonusCritDmg, float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,color lineColor,float lineSize) {
    this.title = title;
    this.infoDescription = infoDescription;
    this.duration = duration;
    Active = true;
    //this.un = un;
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    for(int n = 0; n < 4; n++) {
      this.curve[n] = curve;
    }
    this.background = background;
    this.textColor = textColor;
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    
    this.BonusExp = BonusExp;
    this.BonusZeny = BonusZeny;
    this.BonusPrestige = BonusPrestige;
    
    this.BonusVit = BonusVit;
    this.BonusStr = BonusStr;
    this.BonusEnd = BonusEnd;
    this.BonusAgi = BonusAgi;
    this.BonusDex = BonusDex;
    
    this.rawBonusRegHp = rawBonusRegHp;
    this.rawBonusDef = rawBonusDef;
    this.rawBonusDmg = rawBonusDmg;
    this.rawBonusHp = rawBonusHp;
    this.rawBonusCrit = rawBonusCrit;
    this.rawBonusCritDmg = rawBonusCritDmg;    
    
    
    //initialise a hover info
    BuffInfo = new HoverInfo(title,infoDescription,14,color(255),225,7,color(25,25,200,150),x,y,sizeX,sizeY,5,1,color(255));
  }
  //draws hover event
  void HoverEvent() {
    BuffInfo.draw();
  }
  //plays action
  void ActionEvent(Unit un) {
    GiveValueToUnit(un);
    ActiveOffPlayerDead(un);
  }
  
  //plays time
  void TimeEvent(Unit un) {
    BuffTimer(un);
    BuffInfo.updateDescription(title,infoDescription + " " + round(duration) + " seconds remaining.");
  }
  
  //a action event to che kthe buff timer
  void BuffTimer(Unit un) {
    if(duration > 0) {
    duration -= 1/frameRate;
    } else {
      Active = false;
      GiveValueToUnit(un);
    }
  }
  
  //removes the buff if te player is dead
  void ActiveOffPlayerDead(Unit un) {
    if(un.Alive == false) {
      Active = false;
      GiveValueToUnit(un);
    }
  }
  
  //updates the buff updatePosition
  void updatePosition(float x,float y) {
    this.x = x;
    this.y = y;
    BuffInfo.updatePosition(x,y);
  }
  
  //gives the values to the player  
  void GiveValueToUnit(Unit un) {
    if(Active && Gave == false) {
      
      un.BonusExp += BonusExp;
      un.BonusZeny += BonusZeny;
      un.BonusPrestige += BonusPrestige;
      
      un.BonusVit += BonusVit;
      un.BonusStr += BonusStr;
      un.BonusEnd += BonusEnd;
      un.BonusAgi += BonusAgi;
      un.BonusDex += BonusDex;
      
      un.rawBonusRegHp += rawBonusRegHp;
      un.rawBonusDef += rawBonusDef;
      un.rawBonusDmg += rawBonusDmg;
      un.rawBonusHp += rawBonusHp;
      un.rawBonusCrit += rawBonusCrit;
      un.rawBonusCritDmg += rawBonusCritDmg;
      Gave = true;
    } else if(Active == false && Gave == true) {
      Gave = false;
      
      un.BonusExp -= BonusExp;
      un.BonusZeny -= BonusZeny;
      un.BonusPrestige -= BonusPrestige;
      
      
      un.BonusVit -= BonusVit;
      un.BonusStr -= BonusStr;
      un.BonusEnd -= BonusEnd;
      un.BonusAgi -= BonusAgi;
      un.BonusDex -= BonusDex;
      
      un.rawBonusRegHp -= rawBonusRegHp;
      un.rawBonusDef -= rawBonusDef;
      un.rawBonusDmg -= rawBonusDmg;
      un.rawBonusHp -= rawBonusHp;
      un.rawBonusCrit -= rawBonusCrit;
      un.rawBonusCritDmg -= rawBonusCritDmg;
    }
    
    un.updateStat();
  }
  
  //draws the buff
  void draw() {
    stroke(lineColor);
    strokeWeight(lineSize);
    
    fill(background);
    rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
    
    fill(255);
    textSize(11);
    textAlign(CENTER,CENTER);
    if(round(duration) < 100) {
      text(round(duration),x +sizeX/2,y +sizeY/2);
    } else {
      text("#",x +sizeX/2,y +sizeY/2);
    }
  }
  
  
}