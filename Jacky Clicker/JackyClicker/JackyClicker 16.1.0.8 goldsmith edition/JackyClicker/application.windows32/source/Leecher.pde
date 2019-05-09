//more unique recruits 
public class Leecher extends GuildUnit {
  
  int TapRequire;
  boolean GaveExp;
  
  public Leecher(float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(uVit, uStr, uEnd, uAgi, uDex, exp);
    this.WiseLeech = 1.5;
    Name = "Leecher";
    Description = "Does nothing but leeches your exp, can be killed(Tapped) for 150% of the leeched exp.";
    MoodCriticalPoint = 0;
    MoodSpeed = 0;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
    
    
    TapRequire = 10;
    
  }
  public Leecher(GuildUnit gu) {
    this(gu. uVit,gu. uStr,gu. uEnd,gu. uAgi,gu. uDex,gu. Exp);
    this.currentMood = gu.currentMood;
    WiseLeech = gu.WiseLeech;
  }   
  
  @Override
  public void TimeEvent(Player pl) {
    super.TimeEvent(pl);
    if(WiseLeech < 10) {
      WiseLeech += 1/( frameRate*1000 );
    }
    UnitAsButton.hoverInfo.updateDescription(Name,"Does nothing but leeches your exp, can be killed(Tapped) for "+String.format("%.1f", WiseLeech*100)+"% of the leeched exp." + " Tap " + TapRequire + " more times to kill this recruit! You will gain " + (long)(Exp*WiseLeech) + " Exp.");
    
  }
  
  float MoodBarColor() {
    return (currentMood/100)*175;
  }
  
  @Override
  public void ActionEvent(Enemy en,Player pl) {
    super.ActionEvent(en, pl);
    if(UnitAsButton.wasClicked) {
      if(TapRequire > 0) {
        TapRequire --;
        UnitAsButton.wasClicked = false;
      }
    }
    
    if(TapRequire == 0 && GaveExp == false) {
      pl.PlayerLevelUp((long)(Exp*WiseLeech));
      popText.add(new PopText("+" +(long)(Exp*WiseLeech)+" exp",1,random(1,1.5),mouseX,mouseY,20,color(255,255,51)));
      GaveExp = true;
      UnitRemove = true;
    }
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