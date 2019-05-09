protected class Item {
  @Expose
  long ItemRegHp, ItemDef,ItemDmg,ItemHp,ItemCrit,ItemCritDmg;
  @Expose
  long ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex;
  @Expose
  protected String ItemImage;
  
  @Expose
  protected String Name,Description;
  @Expose
  protected color NameColor;
  
  @Expose
  protected float x,y;
  @Expose
  protected float sizeX,sizeY;
  
  protected Button ItemAsButton;
  
  
  
  
  
  
  protected Item(String Name,String Description,String ItemImage,color NameColor, float x,float y,float sizeX,float sizeY) {
    this.Description = Description;
    this.Name = Name;
    
    
    this.ItemImage = ItemImage;
    this.NameColor = NameColor;
    //Button(Strin
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    ItemAsButton = new Button(Name,Description,x, y,sizeX,sizeY,10,color(NameColor),sizeY/2,LoadAllImage.get(ItemImage));
    //ItemInfo = new HoverInfo(Name,Description,14,color(255),225,7,color(25,25,200,180),x,y,sizeX,sizeY,5,1,color(255));
  }
  
  protected Item() {
    //null
  }
  
  
  
  
  
  public void draw() {
    stroke(255);
    fill(0,150);
    strokeWeight(1);
    rect(ItemAsButton.x,ItemAsButton.y,ItemAsButton.sizeX,ItemAsButton.sizeY,2);
    if(ItemImage!= null) {
      ItemAsButton.draw();
    }
    
  }
  
  public void UpdatePosition(float x, float y) {
    this.x = x;
    this.y = y;
    ItemAsButton.UpdatePosition(x,y);
  }
  
  public void HoverEvent() {
    ItemAsButton.hoverInfo.draw();
  }
  
  
  
  
  
}