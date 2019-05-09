public class Area {
  boolean HaveEnemy;
  String Name;
  String Description;
  
  Button AreaButton;
  
  color textColor;
  
  float x;
  float y;
  
  //triggering event
  boolean Active;
  
  //ValueBar MileBar;
  
  ArrayList<Player> pl;
  Player thisPlayer;
  
  PImage backgroundImage;
  
  float vit,str,end,agi,dex;
  float as;
  float exp,zen;
  float pres;  
  float dif;
  
  float EnemySpawnTimer;
  AreaButtonPanel areaButtonPanel;
  public Area(String Name,String Description,color textColor,ArrayList<Player> pl,Player thisPlayer) {
    this.Name = Name;
    this.Description = Description;
    this.textColor = textColor;
    textSize(20);
    x = width - 275 - textWidth(Name);
    y = height-85;
    
    this.pl = pl;
    this.thisPlayer = thisPlayer;
    textSize(20);
    AreaButton = new Button(Name,Description,x,y,textWidth(Name),30,3,color(100),textColor,16,color(60),3);
    //Area area,float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize
    textSize(20);
    areaButtonPanel = new AreaButtonPanel(this,x + textWidth(Name) - 200,y - 220,200,210,color(25,25,200,150),10,3,color(255),1);
  }
  
  
  public void TimeEvent() {
    
  }
  
  public void ActionEvent() {
    if(Active) {
      if(AreaButton.wasClicked) {
        AreaButton.wasClicked = false;
        areaButtonPanel.show = ! areaButtonPanel.show;
      }
    }
  }
  
  
  public void HoverEvent() {
    if(Active) {
      AreaButton.hoverInfo.draw();
    }
  }
  
  
  public void BackgoundImage() {
    if(Active) {
      if(backgroundImage != null) {
      image(backgroundImage,width/2 - backgroundImage.width/2,height/2 - backgroundImage.height/2);
      }
    }
  }
  
  public void draw() {
    if(Active) {
      AreaButton.draw();
      areaButtonPanel.draw();
    }
  }
  
  public void mousePressed() {
    if(Active) {
      AreaButton.mousePressed();
    }
  }
  
  public void mouseReleased() {
    if(Active) {
      AreaButton.mouseReleased();
    }
  }
  
}