public class AreaButtonPanel extends GeneralPanel {
  Area area;
  public AreaButtonPanel(Area area,float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    this.area = area;
  }
  
  @Override
  public void draw() {
    if(show) {
      super.draw();
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Area Information",x+padding,y+padding);      
      textSize(13);
      stats(0,25);
    }
  }
  
  public void stats(float mx,float my) {
    textAlign(TOP,TOP);
    fill(255);
    textSize(13);
    text("Enemy",x+padding + mx,y+padding + my);
    fill(180);
    text("VIT",x+padding + mx,y+padding + my + 20);
    text((int)(area.vit*100)+"%",x+sizeX - padding - textWidth((int)(area.vit*100)+"%") + mx,y+padding + my + 20);
    
    text("STR",x+padding + mx,y+padding + my + 35);
    text((int)(area.str*100)+"%",x+sizeX - padding - textWidth((int)(area.str*100)+"%") + mx,y+padding + my + 35);
    
    text("END",x+padding + mx,y+padding + my + 50);
    text((int)(area.end*100)+"%",x+sizeX - padding - textWidth((int)(area.end*100)+"%") + mx,y+padding + my + 50);
    
    text("AGI",x+padding + mx,y+padding + my + 65);
    text((int)(area.agi*100)+"%",x+sizeX - padding - textWidth((int)(area.agi*100)+"%") + mx,y+padding + my + 65);    

    text("DEX",x+padding + mx,y+padding + my + 80);
    text((int)(area.dex*100)+"%",x+sizeX - padding - textWidth((int)(area.dex*100)+"%") + mx,y+padding + my + 80);    
    
    text("EXP",x+padding + mx,y+padding + my + 95);
    text((int)(area.exp*100)+"%",x+sizeX - padding - textWidth((int)(area.exp*100)+"%") + mx,y+padding + my + 95);
    
    text("ZNY",x+padding + mx,y+padding + my + 110);
    text((int)(area.zen*100)+"%",x+sizeX - padding - textWidth((int)(area.zen*100)+"%") + mx,y+padding + my + 110);
    
    text("BNS FVR",x+padding + mx,y+padding + my + 125);
    text((int)(area.pres*100)+"%",x+sizeX - padding - textWidth((int)(area.pres*100)+"%") + mx,y+padding + my + 125);
    
    text("HRD",x+padding + mx,y+padding + my + 140);
    text((area.dif*100)+"%",x+sizeX - padding - textWidth((area.dif*100)+"%") + mx,y+padding + my + 140);
    
    text("SPWN TME",x+padding + mx,y+padding + my + 155);
    text(area.EnemySpawnTimer+" Sec",x+sizeX - padding - textWidth(area.EnemySpawnTimer+" Sec") + mx,y+padding + my + 155);
  }
  
}