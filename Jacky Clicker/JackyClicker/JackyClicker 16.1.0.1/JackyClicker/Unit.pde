public class Unit extends Object {
  
  //int counter;
  
  long TotalVit,TotalStr,TotalEnd,TotalAgi,TotalDex;
  long TotalHp,TotalDmg,TotalDef,TotalRegHp,TotalCrit,TotalCritDmg;
  
  //?
  //BigInteger BaseHp,BaseDmg,BaseDef,BaseRegHp,BaseCrit,BaseDodge,BaseHit,BaseCritDmg;
  
  long CharVit,CharStr,CharEnd,CharAgi,CharDex;
  long CharHp,CharDmg,CharDef,CharRegHp,CharCrit,CharCritDmg;
  
  long ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex;
  long ItemHp,ItemDmg,ItemDef,ItemRegHp,ItemCrit,ItemCritDmg;  
  
  
  
  long BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex;
  long BonusRegHp, BonusDef, BonusDmg,BonusHp,BonusCrit, BonusCritDmg;
  long rawBonusRegHp, rawBonusDef, rawBonusDmg,rawBonusHp,rawBonusCrit, rawBonusCritDmg;
  long statBonusRegHp, statBonusDef, statBonusDmg,statBonusHp,statBonusCrit, statBonusCritDmg;
  
  
  float DropBonus;
  
  //?
  //long MaxHp, Hp, Dmg, Def,RegHp,Crit,Dodge,Hit,CritDmg;
  long CurrentHp;
  
  
  //?
  String UnitType;
  
  //?
  boolean Alive,UnitPlaced;
  
  
  Button UnitAsButton;
  
  ValueBar HpBar;
  
  public Unit(String Name,String Description,float x,float y,long CharVit,long CharStr,long CharEnd,long CharAgi,long CharDex) {
    super(Name,Description,x,y);
    this.CharVit = CharVit;
    this.CharStr = CharStr;
    this.CharEnd = CharEnd;
    this.CharAgi = CharAgi;
    this.CharDex = CharDex;
    Alive = true;
    updateStat();
    CurrentHp = TotalHp;
    //public Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,float textSize,color lineColor,float lineSize) {
  }
  
  long ConvertStatToAdv(long v,long s,long e,long a,long d,float mV,float mS,float mE,float mA,float mD) {
    //CharHp = CharHp.multiply(new BigInteger("7"));
    long ReturnedValue = (long)Math.floor(v*mV + s*mS + e*mE + a*mA + d*mD);
    return ReturnedValue;
  }
  
  public void updateStat() {
    statBonusStatToBonusAdv();
    TotalBonusAdv();
    CharStatToCharAdv();
    ItemStatToBonusAdv();
    TotalStat();
    AdvTotalStat();
  }
  
  
  
  public void CharStatToCharAdv() {
    CharHp = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,7,0,0,0,0);
    CharDmg = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,0,2,0,0,0);
    CharDef = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,0,0,1,0,0);
    CharRegHp = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,1,0,0,0,0);
    CharCrit = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,0,0,0,1,0);
    CharCritDmg = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,0,0,0,0,1);
  }
  
  //?
  public void statBonusStatToBonusAdv() {
    statBonusHp = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,7,0,0,0,0);
    statBonusDmg = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,2,0,0,0);
    statBonusDef = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,0,1,0,0);
    statBonusRegHp = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,1,0,0,0,0);
    statBonusCrit = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,0,0,1,0);
    statBonusCritDmg = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,0,0,0,1);
  }
  
  public void TotalBonusAdv() {
    BonusHp = statBonusHp + rawBonusHp;
    BonusDmg = statBonusDmg + rawBonusDmg;
    BonusDef = statBonusDef + rawBonusDef;
    BonusRegHp = statBonusRegHp + rawBonusRegHp;
    BonusCrit = statBonusCrit + rawBonusCrit;
    BonusCritDmg = statBonusCritDmg + rawBonusCritDmg;
  }  
  
  //?
  public void ItemStatToBonusAdv() {
    ItemHp = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,7,0,0,0,0);
    ItemDmg = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,0,2,0,0,0);
    ItemDef = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,0,0,1,0,0);
    ItemRegHp = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,1,0,0,0,0);
    ItemCrit = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,0,0,0,1,0);
    ItemCritDmg = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,0,0,0,0,1);
  }   
  
  
  
  public void TotalStat() {
    TotalVit = CharVit+(BonusVit)+(ItemVit) ;
    TotalStr = CharStr+(BonusStr)+(ItemStr);
    TotalEnd = CharEnd+(BonusEnd)+(ItemEnd);
    TotalAgi = CharAgi+(BonusAgi)+(ItemAgi);
    TotalDex = CharDex+(BonusDex)+(ItemDex);
  }
  
  public void AdvTotalStat() {
    TotalHp = CharHp+(BonusHp)+(ItemHp);
    TotalDmg = CharDmg+(BonusDmg)+(ItemDmg);
    TotalDef = CharDef+(BonusDef)+(ItemDef);
    TotalRegHp = CharRegHp+(BonusRegHp)+(ItemRegHp);
    TotalCrit = CharCrit+(BonusCrit)+(ItemCrit);
    TotalCritDmg = CharCritDmg+(BonusCritDmg)+(ItemCritDmg);
    
    correctCurrentHp();
  }  
  
  
   public void Dead() {
    if (CurrentHp <= 0 && Alive) {
     CurrentHp = 0;
     Alive = false;
    }  
  }
  
  
  
  public void correctCurrentHp() {
    if (TotalHp <1) {
      CurrentHp = 1;
      TotalHp = CurrentHp;
    }
    if(TotalHp < CurrentHp) {
      CurrentHp = TotalHp;
    }    
  }
  
  
  public void TimeEvent() {
    RegenHp();
    //updateStat();
  }
  //problems with long/double
  public void RegenHp() {
    if(Alive) {
      CurrentHp += (TotalRegHp/frameRate);
      correctCurrentHp();
    }
  }
  
  public void ActionEvent() {
    Dead();
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