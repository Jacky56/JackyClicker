//the most parent for units 
public class Object {
  float x,y;
  @Expose
  String Name;
  @Expose
  String Description;
  public Object(String Name,String Description,float x,float y) {
    this.x = x;
    this.y = y;
    this.Name = Name;
    this.Description = Description;
  }
}