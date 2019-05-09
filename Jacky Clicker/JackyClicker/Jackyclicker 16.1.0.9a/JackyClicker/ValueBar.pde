//temp
private class ValueBar {
  private double MaxValue;
  private double CurrentValue;
  private float x,y;
  private float sizeX,sizeY;
  private color background;
  
  private color lineColor;
  private float lineSize;
  private float[] curve = new float[4];
  
  private float inX,inY;
  private float inSizeX,inSizeY;
  
  private color innerBackground;
  
  
  private HoverInfo BarInfo;
  private String title;
  private String Description;
  
  private ValueBar(double MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground) {
    this.MaxValue = MaxValue;
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.background = background;
    for(int n = 0;n < 4;n++) {
      this.curve[n] = curve;
    }
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    this.innerBackground = innerBackground;
    
    inX = x;
    inY = y;
    inSizeX = sizeX;
    inSizeY = sizeY;
    title = "";
    Description = "";
  }
  
  private ValueBar(String title,String Description, double MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground) {
    this( MaxValue, x, y, sizeX, sizeY, background, curve, lineColor, lineSize, innerBackground);
    this.title = title;
    this.Description = Description;
    //HoverInfo(title,infoDescription,14,color(255),175,7,color(25,25,200,150),x,y,sizeX,sizeY,5,1,color(255));
    BarInfo = new HoverInfo(title,Description,14,color(255),175,7,color(25,25,200,150),x,y,sizeX,sizeY,5,1,color(255));
  }  
  
  public void UpdatePosition(float x,float y){
    this.x = x;
    this.y = y;
    inX = x;
    inY = y;
    BarInfo.updatePosition(x,y);
  }
  
  public void draw() {
    
    fill(background);
    stroke(lineColor);
    strokeWeight(lineSize);
    
    //outer 
    rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
    
    //inner
    fill(innerBackground);
    rect(inX,inY,inSizeX,inSizeY,curve[0],curve[1],curve[2],curve[3]);
    
    textSize(sizeY-1);
    textAlign(TOP,CENTER);
    fill(255);
    if(MaxValue > 10) {
      text((long)(CurrentValue)+"/"+(long)(MaxValue),x+sizeX - textWidth((long)(CurrentValue)+"/"+(long)(MaxValue))-5,y +sizeY/2 -1);
    } else {
      text( String.format("%.2f", CurrentValue) +"/"+String.format("%.2f", MaxValue),x+sizeX - textWidth(String.format("%.2f", CurrentValue) +"/"+String.format("%.2f", MaxValue))-5,y +sizeY/2 -1);
    }
  }
  
  private double getRatio(double CurrentValue) {
    if(CurrentValue/MaxValue > 1) {
      return 1;
    } else if(CurrentValue/MaxValue < 0) {
      return 0;
    } else {
      return CurrentValue/MaxValue;
    }
  }
  
  private void updateBar(double CurrentValue,double MaxValue) {
    inSizeX = sizeX * (float)getRatio(CurrentValue);
    this.MaxValue = MaxValue;
    this.CurrentValue = CurrentValue;
    
  }
}