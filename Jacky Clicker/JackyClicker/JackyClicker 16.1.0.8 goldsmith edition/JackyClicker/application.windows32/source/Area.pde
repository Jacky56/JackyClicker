//Creates a generic area for the game
public class Area {
  boolean HaveEnemy;
  @Expose // @Expose is used for GsonBuilder so it will serialize/deserialize this variable
  String Name;
  @Expose
  String Description; 
  
  //creates a button for on the bottom,  middle - right of the screen
  Button AreaButton;
  
  color textColor;
  //position
  float x;
  float y;
  
  //triggering event
  boolean Active;
  
  
  //I use hashMap to allocate the image to memory, so its more important to keep string than image itself
  @Expose
  String backgroundImageName;
  
  PImage backgroundImage;
  
  //general stats of the area 
  @Expose
  float vit,str,end,agi,dex;
  //attack speed of the general area
  @Expose
  float as;
  //currency dropped for the general area 
  @Expose
  float exp,zen;
  //general prestige currency for the area 
  @Expose
  float pres;
  //general difficulty of the area
  @Expose
  float dif;
  //spawn interval of the area 
  @Expose
  float EnemySpawnTimer;
  
  //creates a panel when you clicked on the area button to show the statistics for the general area
  AreaButtonPanel areaButtonPanel;
  //condstructor
  public Area(String Name,String Description,color textColor) {
    this.Name = Name;
    this.Description = Description;
    this.textColor = textColor;
    textSize(20);
    x = width - 275 - textWidth(Name);
    y = height-85;
    
    textSize(20);
    //initialize the button
    AreaButton = new Button(Name,Description,x,y,textWidth(Name),30,3,color(100),textColor,16,color(60),3);
    //Area area,float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize
    textSize(20);
    //initallize the panel
    areaButtonPanel = new AreaButtonPanel(this,x + textWidth(Name) - 200,y - 220,200,210,color(25,25,200,150),10,3,color(255),1);
  }
  
  //empty?
  public void TimeEvent() {
    
  }
  
  //plays action event for the button
  public void ActionEvent() {
    if(Active) {
      if(AreaButton.wasClicked) {
        AreaButton.wasClicked = false;
        areaButtonPanel.show = ! areaButtonPanel.show;
      }
    }
  }
  
  //plays the hover event for the button
  public void HoverEvent() {
    if(Active) {
      AreaButton.hoverInfo.draw();
    }
  }
  
  //draws background image
  public void BackgoundImage() {
    if(Active) {
      if(backgroundImage != null) {
      image(backgroundImage,width/2 - backgroundImage.width/2,height/2 - backgroundImage.height/2);
      }
    }
  }
  
  //draws the button and the panel (the panel is only drawn when you clicke the button)
  public void draw() {
    if(Active) {
      AreaButton.draw();
      areaButtonPanel.draw();
    }
  }
  
  //plays this event
  public void mousePressed() {
    if(Active) {
      AreaButton.mousePressed();
    }
  }
  
  //plays that event
  public void mouseReleased() {
    if(Active) {
      AreaButton.mouseReleased();
    }
  }
  
}