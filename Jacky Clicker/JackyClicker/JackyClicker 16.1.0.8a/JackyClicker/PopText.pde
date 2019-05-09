class PopText {
  float x,y;
  float textSize;
  color textColor;
  
  String text;
  
  boolean showBackground ;
  float sizeX,sizeY;
  color background;
  
  boolean Active;
  float LifeTime;
  
  float Fade;
  float alpha;
  
  
  float speedY;
  
  color lineColor;
  float lineSize;
  float[] curve = new float[4];
  
  PopText(String text,float speedY,float LifeTime,float x,float y,float textSize,color textColor) {
    this.text = text;
    this.x = random(x*0.975,x*1.025);
    this.y = y;
    this.textSize = textSize;
    this.textColor = textColor;
    showBackground = false;
    this.LifeTime = LifeTime;
    Active = true;
    this.speedY = speedY;
    
    
    
    correctInBox();
    
    Fade = 255/(frameRate*LifeTime*2);
    alpha = 255;
  }
  
  float speedX;
  float Angle;
  PopText(String text,float speedY,float LifeTime,float x,float y,float textSize,color textColor,float Angle) {
    this.text = text;
    this.Angle = Angle;
    
    this.x = x;
    this.y = y;
    this.textSize = textSize;
    this.textColor = textColor;
    showBackground = false;
    this.LifeTime = LifeTime;
    Active = true;
    correctInBox();
    
    speedX = speedY*sin(radians(Angle));
    this.speedY = speedY*cos(radians(Angle));
    
    
    Fade = 255/(frameRate*LifeTime*2);
    alpha = 255;
  }  
  
  PopText(String text,float speedY, float LifeTime,float x,float y,float textSize,color textColor,float sizeX,float sizeY, color background,float curve, color lineColor, float lineSize) {
    this(text,speedY,LifeTime, x, y, textSize, textColor);
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.background = background;
    for(int n = 0; n < this.curve.length;n++) {
      this.curve[n] = curve;
    }
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    showBackground = true; 
  }
  
  
  void correctInBox() {
    textSize(textSize);
    if(x - textWidth(text)/2 < 0) {
      x = textWidth(text)/2;
    } else if ( x + textWidth(text)/2 > width) {
      x = width - textWidth(text)/2;
    }
  }
  
  void TimeEvent() {
    if(LifeTime > 0) {
      LifeTime -= 1/frameRate;
      y = y - speedY;
      x = x + speedX;
      alpha -= Fade;
    } else {
      Active = false;
    }
  }
  
  
  void draw() {
    if(showBackground) {
      fill(background);
      stroke(lineColor);
      strokeWeight(lineSize);
      rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
    }
    
    pushMatrix();
    translate(x,y);
    rotate(radians(Angle));
    textAlign(CENTER,CENTER);
    textSize(textSize);
    fill(0,alpha);
    text(text,1,1);
    fill(textColor,alpha);
    text(text,0,0);
    popMatrix();
  }
  
}