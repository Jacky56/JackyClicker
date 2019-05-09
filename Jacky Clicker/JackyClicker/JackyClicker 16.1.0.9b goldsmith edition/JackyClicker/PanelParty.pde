//MOAR PANELS 
protected class PanelParty extends GeneralPanel{

  protected ArrayList<PanelPartyPlayer> PPP = new ArrayList<PanelPartyPlayer>();
  protected PanelParty(float x,float y,float sizeX,float sizeY,color background,float curve,float padding,color lineColor,float lineSize) {
    //GeneralPanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding,  curve, lineColor, lineSize);

    if(aPlayer != null) {
      //public PanelPartyPlayer(String Name,float Hp,float x,float y,float sizeX,float sizeY,color background,float curve,float padding,color lineColor,float lineSize,color innerBackground) {
      for(int n = 0; n < aPlayer.size(); n++) {
        PPP.add(new PanelPartyPlayer(aPlayer.get(n),x+padding,y+padding + 55*PPP.size(),sizeX-padding*2,55,curve,5,lineColor,lineSize));
      }
    }
  }
  
  protected void TimeEvent() {
    for(int n = 0; n < PPP.size();n++) {
      PPP.get(n).TimeEvent();
    }
  }
  
  protected void ActionEvent() {
    for(int n = 0; n < PPP.size();n++) {
      PPP.get(n).ActionEvent();
    }
  }
  
  public void draw() {
    fill(background);
    stroke(lineColor);
    strokeWeight(lineSize);
    rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
    
    
  }
  
}