public class PanelParty {
  float x,y;
  float sizeX,sizeY;
  color lineColor;
  float lineSize;
  color background;
  float[] curve = new float[4];
  
  float padding;
  ArrayList<PanelPartyPlayer> PPP = new ArrayList<PanelPartyPlayer>();
  public PanelParty(float x,float y,float sizeX,float sizeY,color background,float curve,float padding,color lineColor,float lineSize) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.padding = padding;
    this.background = background;
    for(int n = 0; n < 4; n++) {
      this.curve[n] = curve;
    }
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    
    if(player != null) {
      //public PanelPartyPlayer(String Name,float Hp,float x,float y,float sizeX,float sizeY,color background,float curve,float padding,color lineColor,float lineSize,color innerBackground) {
      PPP.add(new PanelPartyPlayer(player,x+padding,y+padding + 55*PPP.size(),sizeX-padding*2,55,curve,5,lineColor,lineSize));
    }
  }
  
 
  
  void draw() {
    fill(background);
    stroke(lineColor);
    strokeWeight(lineSize);
    rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
    
    
  }
  
}