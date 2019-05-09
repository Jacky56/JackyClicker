public class Leecher extends GuildUnit {
  
  int TapRequire;
  boolean GaveExp;
  public Leecher(Player pl,float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(pl, uVit, uStr, uEnd, uAgi, uDex, exp);
    
    Name = "Leecher";
    Description = "Does nothing but leeches your exp, can be killed(Tapped) for 150% of the leeched exp.";
    MoodCriticalPoint = 0;
    MoodSpeed = 0;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
    
    
    TapRequire = 10;
    
  }

  
  
  @Override
  public void TimeEvent() {
    super.TimeEvent();
    UnitAsButton.hoverInfo.updateDescription(Name,Description + " Tap " + TapRequire + " more times to kill this recruit! You will gain " + (long)(Exp*1.5) + " Exp.");
  }
  
  float MoodBarColor() {
    return (currentMood/100)*175;
  }
  
  @Override
  public void ActionEvent(Enemy en) {
    super.ActionEvent(en);
    if(UnitAsButton.wasClicked) {
      if(TapRequire > 0) {
        TapRequire --;
        UnitAsButton.wasClicked = false;
      }
    }
    
    if(TapRequire == 0 && GaveExp == false) {
      pl.PlayerLevelUp((long)(Exp*1.5));
      popText.add(new PopText("+" +(long)(Exp*1.5)+" exp",1,random(1,1.5),mouseX,mouseY,20,color(255,255,51)));
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