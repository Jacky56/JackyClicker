protected class Bard extends GuildUnit {
  
  protected Bard(float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(uVit, uStr, uEnd, uAgi, uDex, exp);
    Name = "Bard";
    Description = "";
    MoodCriticalPoint = 30;
    MoodSpeed = 0.11;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
  }
  
  protected Bard(GuildUnit gu) {
    this(gu. uVit,gu. uStr,gu. uEnd,gu. uAgi,gu. uDex,gu. Exp);
    this.currentMood = gu.currentMood;
  }   
  
  @Override
  protected void TimeEvent(Player pl) {
    super.TimeEvent(pl);
    UnitAsButton.hoverInfo.updateDescription(Name,"Grants a powerful buff that increases general stats by 35%. Cost 18 Mood. (Active) " + Description);
  }
  
  
  @Override
  protected void ActionEvent(Enemy en,Player pl) {
    super.ActionEvent(en, pl);
    if(UnitAsButton.wasClicked) {
      UnitAsButton.wasClicked = false;
      if(pl.Alive) {
        if(currentMood >= 18) {
          GiveBuff(pl);
          currentMood -= 18;
        } else {
          popText.add(new PopText("Pay me!", 1, 1, mouseX,mouseY,16,color(200,25,25)));
        }
      } else {
        popText.add(new PopText("Such sorrow...", 1, 1, mouseX,mouseY,16,color(200,25,25)));
      }
    }
  }
  
  
  private void GiveBuff(Player pl) {
    for(int n = 0; n < pl.buffIcon.size(); n++) {
      if("Tale's song" == pl.buffIcon.get(n).title) {
        pl.buffIcon.get(n).Active = false;
        pl.buffIcon.get(n).GiveValueToUnit(pl);
      }
    } 
    float m = 0.35;
    pl.buffIcon.add(new BuffIcon("Tale's song","increase general stats by 35%.",300,pl,0,0,0, (pl.CharVit + pl.ItemVit)*m,(pl.CharStr + pl.ItemStr)*m,(pl.CharEnd + pl.ItemEnd)*m,(pl.CharAgi + pl.ItemAgi)*m,(pl.CharDex + pl.ItemDex)*m, 0,0,0,0,0,0,1,1,15,15,2,color(255,165,0),color(255),color(25,200,25),1));        
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