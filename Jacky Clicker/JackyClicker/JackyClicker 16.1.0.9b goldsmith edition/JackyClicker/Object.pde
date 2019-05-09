//the most parent for units 
protected class Object {
  @Expose
  protected float x,y;
  @Expose
  protected String Name;
  @Expose
  protected String Description;
  public Object(String Name,String Description,float x,float y) {
    this.x = x;
    this.y = y;
    this.Name = Name;
    this.Description = Description;
  }
}