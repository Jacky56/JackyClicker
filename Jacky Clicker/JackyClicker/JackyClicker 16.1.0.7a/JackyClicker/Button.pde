//creates button
//trigger event 'wasClicked' boolean

public class Button {
  float x,y;
  float sizeX,sizeY;
  String title;
  float textSize;
  color background,textColor;
  boolean mPress,mRel;
  
  //trigger event
  boolean wasClicked;
  
  
  HoverInfo hoverInfo;
  String infoDescription;
  color lineColor;
  float lineSize;
  float[] curve = new float[4];
  
  public Button(String title,String infoDescription,float x,float y,float sizeX,float sizeY,color background,color textColor,float textSize) {
    this.title = title;
    this.infoDescription = infoDescription;
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.background = background;
    this.textColor = textColor;
    this.textSize = textSize;
    lineColor = color(0);
    lineSize =1;
    //HoverInfo(String title, String text,float textSize,color textColor,float sizeX,color background,float objX, float objY,float objSizeX,float objSizeY)
    //public HoverInfo(String title, String text,float textSize,color textColor,float sizeX,float padding,color background,float objX, float objY,float objSizeX,float objSizeY) {
    hoverInfo = new HoverInfo(title,infoDescription,14,color(255),225,7,color(25,25,200,180),x,y,sizeX,sizeY,5,1,color(255));
  }

  public Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,float textSize,color lineColor,float lineSize) {
    this(text,infoDescription,x,y,sizeX,sizeY,background,textColor,textSize);
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    for(int n = 0 ;n < 4; n++) {
      this.curve[n] = curve;
    }
  }
  //pure custom button
  float textAngle;
  public Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve0,float curve1,float curve2,float curve3,color background,color textColor,float textSize,color lineColor,float lineSize,float textAngle) {
    this(text,infoDescription,x,y,sizeX,sizeY,background,textColor,textSize);
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    this.curve[0] = curve0;
    this.curve[1] = curve1;
    this.curve[2] = curve2;
    this.curve[3] = curve3;
    this.textAngle = textAngle;
    
    //this.title = wrapText(title,textSize,sizeX*cos(radians(textAngle)) + sizeY*sin(radians(textAngle)));
  }
  PImage image;
  public Button(String title,String infoDescription,float x,float y,float sizeX,float sizeY,float textSize,color textColor,PImage image) {
    this.title = title;
    this.infoDescription = infoDescription;
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.textSize = textSize;
    this.textColor = textColor;
    this.image = image;
    //HoverInfo(String title, String text,float textSize,color textColor,float sizeX,color background,float objX, float objY,float objSizeX,float objSizeY)
    //public HoverInfo(String title, String text,float textSize,color textColor,float sizeX,float padding,color background,float objX, float objY,float objSizeX,float objSizeY) {
    hoverInfo = new HoverInfo(title,infoDescription,14,color(255),225,7,color(25,25,200,180),x,y,sizeX,sizeY,5,1,color(255));
  }
  
  void UpdatePosition(float x,float y) {
    this.x = x;
    this.y = y;
    hoverInfo.updatePosition(x,y);
  }
  
  void draw() {
    pushMatrix();
    if(mPress) {
      float tempS = 0.9;
      scale(tempS,tempS);
      translate((x/tempS)+(((sizeX/2)*(1-tempS))/tempS),(y/tempS)+(((sizeY/2)*(1-tempS))/tempS));
      //translate((x)+(sizeX/2)*(1-tempS),y);
      //translate((x)+(sizeX)*(1-tempS),(y)+(sizeY)*(1-tempS));
    } else {
      translate(x,y);
    }
    if(image != null) {
      image(image,sizeX*(1-(image.width/sizeX))/2,sizeY*(1-(image.height/sizeY))/2);
    } else {
      stroke(lineColor);
      strokeWeight(lineSize);
      fill(background);
      rect(0,0,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
    }
    popMatrix();
    
    pushMatrix();
    translate(x+sizeX/2,y+sizeY/2);
    rotate(radians(textAngle));
    
    if(image != null) {
      translate(0,-100);
      textAlign(CENTER,CENTER);
    } else {
      textAlign(CENTER,CENTER);
    }
    

    fill(0);
    textSize(textSize);
    text(title,1,1);
    fill(textColor);
    textSize(textSize);
    text(title,0,0);
    
    
    popMatrix();
    
    if(mouseOn()) {
      //cursor(HAND);
    }
    //temp
    check();
  }
  
  void mousePressed() {
    if(mouseOn()) {
      mPress = true;
    } else {
      mRel = false;
    }
  }
  
  void mouseReleased() {
    if(mouseOn() && mPress) {
      mRel = true;
    } else {
      mPress = false;
    }
  }
  
  void check() {
    if(mPress && mRel) {
      mPress = false;
      mRel = false;
      wasClicked = true;
    }
  }
  
  boolean mouseOn() {
    if(mouseX > x && mouseX < x+sizeX &&
    mouseY > y && mouseY < y+sizeY) {
      return true;
    } else {
      return false;
    }
  }
  
}