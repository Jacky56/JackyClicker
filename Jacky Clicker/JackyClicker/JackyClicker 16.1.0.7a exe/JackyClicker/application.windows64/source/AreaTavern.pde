public class AreaTavern extends Area {
  public AreaTavern(String Name,String Description,color textColor,ArrayList<Player> pl,Player thisPlayer) {
    super(Name,Description,textColor,pl,thisPlayer);
    HaveEnemy = false;
    Active = true;
    tavernPanel.show = true;
    thisPlayer.InTavern = true;
    backgroundImage = loadImage("BackgroundImage/Tavern.jpg");
  }
  
}