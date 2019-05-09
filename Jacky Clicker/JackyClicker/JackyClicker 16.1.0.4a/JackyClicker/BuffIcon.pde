public class BuffIcon {
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
  
  Unit un;
  
  float duration;
  
  boolean Active;
  
  long BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex;
  long rawBonusRegHp, rawBonusDef, rawBonusDmg,rawBonusHp,rawBonusCrit, rawBonusCritDmg;
  long statBonusRegHp, statBonusDef, statBonusDmg,statBonusHp,statBonusCrit, statBonusCritDmg;
  
  float BonusExp;
  float BonusZeny;
  float BonusPrestige;
  
  boolean Gave;
  //public Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,float textSize,color lineColor,float lineSize) {
  public BuffIcon(String title,String infoDescription,float duration,Unit un,float BonusExp,float BonusZeny,float BonusPrestige,long BonusVit,long BonusStr,long BonusEnd,long BonusAgi,long BonusDex,long rawBonusRegHp,long  rawBonusDef,long  rawBonusDmg,long rawBonusHp,long rawBonusCrit,long rawBonusCritDmg, float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,color lineColor,float lineSize) {
    this.title = title;
    this.infoDescription = infoDescription;
    this.duration = duration;
    Active = true;
    this.un = un;
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
    
    
    
    BuffInfo = new HoverInfo(title,infoDescription,14,color(255),175,7,color(25,25,200,150),x,y,sizeX,sizeY,5,1,color(255));
    GiveValueToUnit();
  }
  
  void HoverEvent() {
    BuffInfo.draw();
  }
  
  void ActionEvent() {
    ActiveOffPlayerDead();
  }
  
  
  void TimeEvent() {
    BuffTimer();
    BuffInfo.updateDescription(title,infoDescription + " " + round(duration) + " seconds remaining.");
  }
  
  void BuffTimer() {
    if(duration > 0) {
    duration -= 1/frameRate;
    } else {
      Active = false;
      GiveValueToUnit();
    }
  }
  
  void ActiveOffPlayerDead() {
    if(un.Alive == false) {
      Active = false;
      GiveValueToUnit();
    }
  }
  
  
  void updatePosition(float x,float y) {
    this.x = x;
    this.y = y;
    BuffInfo.updatePosition(x,y);
  }
  
  void GiveValueToUnit() {
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
  
  void draw() {
    stroke(lineColor);
    strokeWeight(lineSize);
    
    fill(background);
    rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
    
    fill(255);
    textSize(11);
    textAlign(CENTER,CENTER);
    text(round(duration),x +sizeX/2,y +sizeY/2);
  }
  
  
}