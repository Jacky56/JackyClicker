public class BuffIcon {
  private float x,y;
  private float sizeX,sizeY;
  private String title;
  private color background;
  private color textColor;
  private HoverInfo BuffInfo;
  private String infoDescription;
  private color lineColor;
  private float lineSize;
  private float[] curve = new float[4];
  
  //Unit un;
  
  float duration;
  
  boolean Active;
  
  double BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex;
  double rawBonusRegHp, rawBonusDef, rawBonusDmg,rawBonusHp,rawBonusCrit, rawBonusCritDmg;
  double statBonusRegHp, statBonusDef, statBonusDmg,statBonusHp,statBonusCrit, statBonusCritDmg;
  
  float BonusExp;
  float BonusZeny;
  float BonusPrestige;
  
  boolean Gave;
  //public Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,float textSize,color lineColor,float lineSize) {
  public BuffIcon(String title,String infoDescription,float duration,Unit un,float BonusExp,float BonusZeny,float BonusPrestige,double BonusVit,double BonusStr,double BonusEnd,double BonusAgi,double BonusDex,double rawBonusRegHp,double  rawBonusDef,double  rawBonusDmg,double rawBonusHp,double rawBonusCrit,double rawBonusCritDmg, float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,color lineColor,float lineSize) {
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
    
    
    
    BuffInfo = new HoverInfo(title,infoDescription,14,color(255),225,7,color(25,25,200,150),x,y,sizeX,sizeY,5,1,color(255));
  }
  
  void HoverEvent() {
    BuffInfo.draw();
  }
  
  void ActionEvent(Unit un) {
   GiveValueToUnit(un);
   ActiveOffPlayerDead(un);
  }
  
  
  void TimeEvent(Unit un) {
    BuffTimer(un);
    BuffInfo.updateDescription(title,infoDescription + " " + round(duration) + " seconds remaining.");
  }
  
  void BuffTimer(Unit un) {
    if(duration > 0) {
    duration -= 1/frameRate;
    } else {
      Active = false;
      GiveValueToUnit(un);
    }
  }
  
  void ActiveOffPlayerDead(Unit un) {
    if(un.Alive == false) {
      Active = false;
      GiveValueToUnit(un);
    }
  }
  
  
  void updatePosition(float x,float y) {
    this.x = x;
    this.y = y;
    BuffInfo.updatePosition(x,y);
  }
  
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
  
  void draw() {
    stroke(lineColor);
    strokeWeight(lineSize);
    
    fill(background);
    rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
    
    fill(textColor);
    textSize(sizeY-4);
    textAlign(CENTER,CENTER);
    if(round(duration) < 100) {
      text(round(duration),x +sizeX/2,y +sizeY/2);
    } else {
      text("#",x +sizeX/2,y +sizeY/2);
    }
  }
  
  
}