//a temp class created in 16.1.0.8
class CreateMovingObject {
  float x,y;
  float duration;
  float speedX;
  float speedY;
  float angle;
  String ImageNameString;
  PImage Image;
  boolean Bounce;
  //..
  CreateMovingObject(String ImageNameString,float x,float y, float duration,float speed,float angle,boolean Bounce) {
    this.ImageNameString = ImageNameString;
    this.x = x;
    this.y = y;
    this.duration = duration;
    this.speedX = speed*sin(radians(angle));
    this.speedY = speed*cos(radians(angle));
    this.angle = angle;
    this.Bounce = Bounce;
    Image = LoadAllImage.get(ImageNameString);
  }
  //..
  public void TimeEvent() {
    if(duration > 0) {
      duration -= 1/frameRate;
    }
  }
  //moves the object per frame 
  public void MoveObject() {
    if(Bounce) {
      
    } else {
      x += speedX;
      y -= speedY;
    }
  }
  //..
  public void ActionEvent() {
    if(duration > 0) {
      MoveObject();
    }
  }
  //...
  public void draw() {
    if(duration > 0) {
      pushMatrix();
      translate(x,y);
      rotate(radians(angle));
      if(Image != null) {
        image(Image,-Image.width/2,-Image.height/2);
      } else {
        text("NO IMG",0,0);
      }
      popMatrix();
    }
  }
  
}