protected class Assassin extends GuildUnit {
  
  protected Assassin(float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(uVit, uStr, uEnd, uAgi, uDex, exp);
    Name = "Assassin";
    Description = "deals 30% of the enemy's current health. Cost 25 Mood (must be above moody)";
    MoodCriticalPoint = 70;
    MoodSpeed = 0.04;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
  }

  protected Assassin(GuildUnit gu) {
    this(gu. uVit,gu. uStr,gu. uEnd,gu. uAgi,gu. uDex,gu. Exp);
    this.currentMood = gu.currentMood;  
  }
  
  
  @Override
  protected void TimeEvent(Player pl) {
    super.TimeEvent(pl);
  }
  
  
  @Override
  protected void ActionEvent(Enemy en,Player pl) {
    super.ActionEvent(en, pl);
    if(UnitAsButton.wasClicked) {
      UnitAsButton.wasClicked = false;
      if(Moody == false && Strike == false) {
        if(currentMood >=  25) {
          if(en.UnitPlaced) {
            
            popText.add(new PopText((long)(en.CurrentHp*0.3)+"", 1, 1, mouseX,mouseY,30,color(255)));
            en.CurrentHp = en.CurrentHp*0.7;
            currentMood -= 25;
          } else {
            popText.add(new PopText("There's no one to cut...", 1, 1, mouseX,mouseY,16,color(200,25,25)));
          }
        } else {
          popText.add(new PopText("Go and die...", 1, 1, mouseX,mouseY,16,color(200,25,25)));
        }
      } else {
        popText.add(new PopText("I will cut you...", 1, 1, mouseX,mouseY,16,color(200,25,25)));
      }
    }
  }
  
  
  
  
  
  public void draw() {
    super.draw();
  }
  
   
  public void mousePressed() {
    UnitAsButton.mousePressed();
  }
  
  public void mouseReleased() {
    UnitAsButton.mouseReleased();
  }
}