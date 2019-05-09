protected class AreaTavern extends Area {
  protected AreaTavern(String Name,String Description,color textColor,Player thisPlayer) {
    super(Name,Description,textColor);
    HaveEnemy = false;
    Active = true;
    backgroundImage = loadImage("BackgroundImage/Tavern.jpg");
  }
  
}