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
    this.x = random(x*0.97,x*1.03);
    this.y = y;
    this.textSize = textSize;
    this.textColor = textColor;
    showBackground = false;
    this.LifeTime = LifeTime;
    Active = true;
    this.speedY = speedY;
    
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
  
  
  void TimeEvent() {
    if(LifeTime > 0) {
      LifeTime -= 1/frameRate;
      y = y - speedY;
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
    
    textAlign(CENTER,CENTER);
    textSize(textSize);
    fill(0,alpha);
    text(text,x+1,y+1);
    fill(textColor,alpha);
    text(text,x,y);
  }
  
}