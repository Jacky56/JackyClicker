class CreateMovingObject {
  float x,y;
  float duration;
  float currentDuration;
  float speedX;
  float speedY;
  float angle;
  String ImageNameString;
  PImage Image;
  float ObjectWeight;
  float initialSpeed;
  CreateMovingObject(String ImageNameString,float x,float y, float duration,float speed,float angle,float ObjectWeight) {
    this.ImageNameString = ImageNameString;
    this.x = x;
    this.y = y;
    this.duration = duration;
    this.initialSpeed = speed;
    this.speedX = speed*cos(radians(angle));
    this.speedY = speed*sin(radians(angle));
    this.angle = angle;
    this.ObjectWeight = ObjectWeight;
    Image = LoadAllImage.get(ImageNameString);
  }
  
  public void TimeEvent() {
    if(duration > currentDuration) {
      currentDuration += 1/frameRate;
    }
  }
  
  public void MoveObject() {
    speedX = initialSpeed*cos(radians(angle));
    speedY = initialSpeed*sin(radians(angle)) - ObjectWeight*currentDuration;
    x += speedX;
    y -= speedY;
  }
  
  public void ActionEvent() {
    if(duration > currentDuration) {
      MoveObject();
    }
  }
  
  public void draw() {
    if(duration > currentDuration) {
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