protected class Unit extends Object {
  
  //int counter;
  protected double TotalVit,TotalStr,TotalEnd,TotalAgi,TotalDex;
  protected double TotalHp,TotalDmg,TotalDef,TotalRegHp,TotalCrit,TotalCritDmg;
  
  //?
  //BigInteger BaseHp,BaseDmg,BaseDef,BaseRegHp,BaseCrit,BaseDodge,BaseHit,BaseCritDmg;
  @Expose
  protected double CharVit,CharStr,CharEnd,CharAgi,CharDex;
  @Expose
  protected double CharHp,CharDmg,CharDef,CharRegHp,CharCrit,CharCritDmg;
  

  protected double ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex;

  protected double ItemHp,ItemDmg,ItemDef,ItemRegHp,ItemCrit,ItemCritDmg;
  protected double statItemHp,statItemDmg,statItemDef,statItemRegHp,statItemCrit,statItemCritDmg; 
  protected double rawItemHp,rawItemDmg,rawItemDef,rawItemRegHp,rawItemCrit,rawItemCritDmg; 
  
  protected double BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex;
  protected double BonusRegHp, BonusDef, BonusDmg,BonusHp,BonusCrit, BonusCritDmg;
  protected double rawBonusRegHp, rawBonusDef, rawBonusDmg,rawBonusHp,rawBonusCrit, rawBonusCritDmg;
  protected double statBonusRegHp, statBonusDef, statBonusDmg,statBonusHp,statBonusCrit, statBonusCritDmg;
  
  
  
  protected float TotalCritPercent;
  protected float BonusCritPercent;
  @Expose
  protected float ItemCritPercent;
  @Expose
  protected float CharCritPercent;
  
  protected float BonusExp;
  @Expose
  protected float ItemExp;
  @Expose
  protected float CharExp;
  
  protected float BonusZeny;
  @Expose
  protected float ItemZeny;
  @Expose
  protected float CharZeny;
  
  protected float BonusPrestige;
  @Expose
  protected float ItemPrestige;
  @Expose
  protected float CharPrestige;  
  
  //?
  protected float DropBonus;
  
  //?
  //long MaxHp, Hp, Dmg, Def,RegHp,Crit,Dodge,Hit,CritDmg;
  protected double CurrentHp;
  
  
  //?
  public boolean Alive;
  
  
  //triggering event
  public boolean UnitPlaced;
  
  
  protected Button UnitAsButton;
  
  protected ValueBar HpBar;
  
  
  protected Unit(String Name,String Description,float x,float y,double CharVit,double CharStr,double CharEnd,double CharAgi,double CharDex) {
    super(Name,Description,x,y);
    this.CharVit = CharVit;
    this.CharStr = CharStr;
    this.CharEnd = CharEnd;
    this.CharAgi = CharAgi;
    this.CharDex = CharDex;
    Alive = true;
    updateStat();
    CurrentHp = TotalHp;
    UnitPlaced = true;
    //public Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,float textSize,color lineColor,float lineSize) {
  }
  
  double ConvertStatToAdv(double v,double s,double e,double a,double d,float mV,float mS,float mE,float mA,float mD) {
    //CharHp = CharHp.multiply(new BigInteger("7"));
    double ReturnedValue = (double)(v*mV + s*mS + e*mE + a*mA + d*mD);
    return ReturnedValue;
  }
  
  public void draw() {
    if(UnitPlaced) {
      UnitAsButton.draw();
    }
  }
  
  
  
  protected void updateStat() {
    CharStatToCharAdv();
    
    statBonusStatToBonusAdv();
    TotalBonusAdv();

    
    ItemStatToBonusAdv();
    TotalItemAdv();
    
    UniqueStats();
    
    
    TotalStat();
    AdvTotalStat();
  }
  
  protected void UniqueStats() {
    TotalCritPercent = CharCritPercent + ItemCritPercent + BonusCritPercent;
  }
  
  protected void CharStatToCharAdv() {
    CharHp = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,8,0,0,0,0);
    CharDmg = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,0,1,0,0,0);
    CharDef = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,0,0,0.5,0,0);
    CharRegHp = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,0.04,0,0,0,0);
    CharCrit = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,0,0,0,1,0);
    CharCritDmg = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,0,0,0,0,1);
  }
  
  //?
  protected void statBonusStatToBonusAdv() {
    statBonusHp = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,8,0,0,0,0);
    statBonusDmg = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,1,0,0,0);
    statBonusDef = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,0,0.5,0,0);
    statBonusRegHp = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0.04,0,0,0,0);
    statBonusCrit = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,0,0,1,0);
    statBonusCritDmg = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,0,0,0,1);
  }
  
  
  
  protected void TotalBonusAdv() {
    BonusHp = statBonusHp + rawBonusHp;
    BonusDmg = statBonusDmg + rawBonusDmg;
    BonusDef = statBonusDef + rawBonusDef;
    BonusRegHp = statBonusRegHp + rawBonusRegHp;
    BonusCrit = statBonusCrit + rawBonusCrit;
    BonusCritDmg = statBonusCritDmg + rawBonusCritDmg;
  }  
  
  //?
  protected void ItemStatToBonusAdv() {
    statItemHp = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,8,0,0,0,0);
    statItemDmg = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,0,1,0,0,0);
    statItemDef = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,0,0,0.5,0,0);
    statItemRegHp = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,0.04,0,0,0,0);
    statItemCrit = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,0,0,0,1,0);
    statItemCritDmg = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,0,0,0,0,1);
  } 
  
  protected void TotalItemAdv() {
    ItemHp = statItemHp + rawItemHp;
    ItemDmg = statItemDmg + rawItemDmg;
    ItemDef = statItemDef + rawItemDef;
    ItemRegHp = statItemRegHp + rawItemRegHp;
    ItemCrit = statItemCrit + rawItemCrit;
    ItemCritDmg = statItemCritDmg + rawItemCritDmg;    
  }
  
  
  protected void TotalStat() {
    TotalVit = CharVit+(BonusVit)+(ItemVit) ;
    TotalStr = CharStr+(BonusStr)+(ItemStr);
    TotalEnd = CharEnd+(BonusEnd)+(ItemEnd);
    TotalAgi = CharAgi+(BonusAgi)+(ItemAgi);
    TotalDex = CharDex+(BonusDex)+(ItemDex);
  }
  
  protected void AdvTotalStat() {
    TotalHp = CharHp+(BonusHp)+(ItemHp);
    TotalDmg = CharDmg+(BonusDmg)+(ItemDmg);
    TotalDef = CharDef+(BonusDef)+(ItemDef);
    TotalRegHp = CharRegHp+(BonusRegHp)+(ItemRegHp);
    TotalCrit = CharCrit+(BonusCrit)+(ItemCrit);
    TotalCritDmg = CharCritDmg+(BonusCritDmg)+(ItemCritDmg);
    
    correctCurrentHp();
  }  
  
  
   protected void Dead() {
    if (CurrentHp <= 0 && Alive && UnitPlaced) {
     CurrentHp = 0;
     Alive = false;
    }  
  }
  
  
  
  protected void correctCurrentHp() {
    if (TotalHp <1) {
      CurrentHp = 1;
      TotalHp = CurrentHp;
    }
    if(TotalHp < CurrentHp) {
      CurrentHp = TotalHp;
    }    
  }
  
  
  protected void TimeEvent() {
    RegenHp();
    //updateStat();
  }
  
  //problems with long/double
  protected void RegenHp() {
    if(Alive) {
      CurrentHp += (TotalRegHp/frameRate);
      correctCurrentHp();
    }
  }
  
  protected void HoverEvent() {
    if(UnitPlaced) {
      UnitAsButton.hoverInfo.draw();
    }
  }
  
  protected void ActionEvent() {
    if(UnitPlaced) {
      Dead();
    }
  }
  
}

//public class Unit extends Object {
  
//  //int counter;
  
//  BigInteger TotalVit,TotalStr,TotalEnd,TotalAgi,TotalDex;
//  BigInteger TotalHp,TotalDmg,TotalDef,TotalRegHp,TotalCrit,TotalCritDmg;
  
//  //?
//  //BigInteger BaseHp,BaseDmg,BaseDef,BaseRegHp,BaseCrit,BaseDodge,BaseHit,BaseCritDmg;
  
//  BigInteger CharVit,CharStr,CharEnd,CharAgi,CharDex;
//  BigInteger CharHp,CharDmg,CharDef,CharRegHp,CharCrit,CharCritDmg;

//  BigInteger BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex;
//  BigInteger BonusRegHp, BonusDef, BonusDmg,BonusHp,BonusCrit, BonusCritDmg;
  
//  float DropBonus;
  
//  //?
//  BigInteger MaxHp, Hp, Dmg, Def,RegHp,Crit,Dodge,Hit,CritDmg;
  
//  //?
//  String UnitType;
  
//  //?
//  boolean Alive,UnitPlaced;
  
//  public Unit(String Name,String Description,float x,float y,BigInteger CharVit,BigInteger CharStr,BigInteger CharEnd,BigInteger CharAgi,BigInteger CharDex) {
//    super(Name,Description,x,y);
//    this.CharVit = CharVit;
//    this.CharStr = CharStr;
//    this.CharEnd = CharEnd;
//    this.CharAgi = CharAgi;
//    this.CharDex = CharDex;
    
//    BonusStatToBonusAdv();
//    CharStatToCharAdv();
//    TotalStat();
//    AdvTotalStat();
//  }
  
//  BigInteger ConvertStatToAdv(BigInteger v,BigInteger s,BigInteger e,BigInteger a,BigInteger d,int mV,int mS,int mE,int mA,int mD) {
//    //CharHp = CharHp.multiply(new BigInteger("7"));
//    BigInteger ReturnedValue = v.multiply(new BigInteger(mV+"")).add(s.multiply(new BigInteger(mS+""))).add(e.multiply(new BigInteger(mE+""))).add(a.multiply(new BigInteger(mA+""))).add(d.multiply(new BigInteger(mD+"")));
//    return ReturnedValue;
//  }
  
//  void CharStatToCharAdv() {
//    CharHp = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharEnd,CharDex,7,0,0,0,0);
//    CharDmg = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharEnd,CharDex,0,2,0,0,0);
//    CharDef = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharEnd,CharDex,0,0,1,0,0);
//    CharRegHp = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharEnd,CharDex,1,0,0,0,0);
//    CharCrit = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharEnd,CharDex,0,0,0,1,0);
//    CharCritDmg = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharEnd,CharDex,0,0,0,0,1);
//  }
  
//  //?
//  void BonusStatToBonusAdv() {
//    BonusHp = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusEnd,BonusDex,7,0,0,0,0);
//    BonusDmg = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusEnd,BonusDex,0,2,0,0,0);
//    BonusDef = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusEnd,BonusDex,0,0,1,0,0);
//    BonusRegHp = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusEnd,BonusDex,1,0,0,0,0);
//    BonusCrit = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusEnd,BonusDex,0,0,0,1,0);
//    BonusCritDmg = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusEnd,BonusDex,0,0,0,0,1);
//  }  
  
//  void TotalStat() {
//    TotalVit = CharVit.add(BonusVit);
//    TotalStr = CharStr.add(BonusStr);
//    TotalEnd = CharEnd.add(BonusEnd);
//    TotalAgi = CharAgi.add(BonusAgi);
//    TotalDex = CharDex.add(BonusDex);
//  }
  
//  void AdvTotalStat() {
//    TotalHp = CharHp.add(BonusHp);
//    TotalDmg = CharDmg.add(BonusDmg);
//    TotalDef = CharDef.add(BonusDef);
//    TotalRegHp = CharRegHp.add(BonusRegHp);
//    TotalCrit = CharCrit.add(BonusCrit);
//    TotalCritDmg = CharCritDmg.add(BonusCritDmg);
    
//    if (MaxHp <1) {
//      Hp = 1;
//      MaxHp = Hp;
//    }
//    if(MaxHp < Hp) {
//      Hp = MaxHp;
//    }
//  }
//}