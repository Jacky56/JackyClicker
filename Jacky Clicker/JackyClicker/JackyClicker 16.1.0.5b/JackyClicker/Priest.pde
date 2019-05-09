public class Priest extends GuildUnit {
  
  public Priest(Player pl,float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(pl, uVit, uStr, uEnd, uAgi, uDex, exp);
    Name = "Priest";
    Description = "''Come, Holy Sauce, Creator blest, and, in our pasta, give us thy rest...'' Ragu, the One True Heir.";
    MoodCriticalPoint = 30;
    MoodSpeed = 0.05;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
  }

  
  
  @Override
  public void TimeEvent() {
    super.TimeEvent();
    UnitAsButton.hoverInfo.updateDescription(Name,"Grants a Buff which increases regen by " + ceil(Level*0.1) + " and defence by " + ceil(Level*0.25) +" for 5 mins. Cost 15 Mood. (Active) " + Description);
  }
  
  
  @Override
  public void ActionEvent(Enemy en) {
    super.ActionEvent(en);
    if(UnitAsButton.wasClicked) {
      UnitAsButton.wasClicked = false;
      if(pl.Alive) {
        if(currentMood >= 15) {
          GiveBuff();
          currentMood -= 15;
        } else {
          popText.add(new PopText("Give me a Raise!", 1, 1, mouseX,mouseY,16,color(200,25,25)));
        }
      } else {
        popText.add(new PopText("I can't bless the dead!", 1, 1, mouseX,mouseY,16,color(200,25,25)));
      }
    }
  }
  
  
  public void GiveBuff() {
    for(int n = 0; n < pl.buffIcon.size(); n++) {
      if("Holy Blessing" == pl.buffIcon.get(n).title) {
        pl.buffIcon.get(n).Active = false;
        pl.buffIcon.get(n).GiveValueToUnit();
      }
    }
    pl.buffIcon.add(new BuffIcon("Holy Blessing","Increase regen by " + ceil(Level*0.1) + " and Increase defence by " + ceil(Level*0.25)+". ",300,pl,0,0,0, 0,0,0,0,0, ceil(Level*0.1),ceil(Level*0.15),0,0,0,0,1,1,15,15,2,color(255,153,204),color(255),color(25,200,25),1));        
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