public class PrismIndigo extends GuildUnit {
  
  public PrismIndigo(Player pl,float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(pl, uVit, uStr, uEnd, uAgi, uDex, exp);
    Name = "Prism Indigo";
    Description = "Works Quadruple times harder when 'Over Time' is active. (Auto)";
    MoodCriticalPoint = 10;
    MoodSpeed = 0.17;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
    UnitAsButton.title = wrapText("Prism Indigo",12,50);
  }
  
  @Override
  public void ActionEvent(Enemy en,Player pl) {
    updateStat();
    Attack(en, pl);
    if (Strike) {
      BonusVit = -(CharVit+ItemVit);
      BonusStr = -(CharStr+ItemStr);
      BonusEnd = -(CharEnd+ItemEnd);
      BonusAgi = -(CharAgi+ItemAgi);
      BonusDex = -(CharDex+ItemDex);     
    } else if(Moody) {
      BonusVit = -(CharVit+ItemVit)*0.5;
      BonusStr = -(CharStr+ItemStr)*0.5;
      BonusEnd = -(CharEnd+ItemEnd)*0.5;
      BonusAgi = -(CharAgi+ItemAgi)*0.5;
      BonusDex = -(CharDex+ItemDex)*0.5;
    } else if(OverTime) {
      BonusVit = (CharVit+ItemVit)*3;
      BonusStr = (CharStr+ItemStr)*3;
      BonusEnd = (CharEnd+ItemEnd)*3;
      BonusAgi = (CharAgi+ItemAgi)*3;
      BonusDex = (CharDex+ItemDex)*3;    
    } else {
      BonusVit = 0;
      BonusStr = 0;
      BonusEnd = 0;
      BonusAgi = 0;
      BonusDex = 0;
    }
  }  
  
  @Override
  public void TimeEvent() {
    super.TimeEvent();
  }
  
  
  
  public void draw() {
    super.draw();
  }
  
   
  void mousePressed() {
    UnitAsButton.mousePressed();
  }
  
  void mouseReleased() {
    UnitAsButton.mouseReleased();
  }
}