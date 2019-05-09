public class AreaTavern extends Area {
  public AreaTavern(String Name,String Description,color textColor,Player thisPlayer) {
    super(Name,Description,textColor);
    HaveEnemy = false;
    Active = true;
    backgroundImage = loadImage("BackgroundImage/Tavern.jpg");
  }
  
}