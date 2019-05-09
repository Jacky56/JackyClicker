//a panel to configure stats and name 
public class GoldSmithEdition extends GeneralPanel {
  
  
  Button Close;
  
  
  public GoldSmithEdition(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    Close = new Button("X","",x+sizeX - padding - 25,y+padding,25,25,2,color(150),color(255),12,color(100),3);
    show = true;
  }

  
  //..
  void ActionEvent() {
    if(show) {
      if(Close.wasClicked) {
        Close.wasClicked = false;
        show = false;
      }
    }
  }
  
  
  
  //..
  public void draw() {
    if(show) {
      super.draw();
      Close.draw();
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("JackyClicker 16.1.0.8 GoldSmith Edition",x+padding,y+padding);
      textSize(14);
      fill(150);
      textAlign(TOP,TOP);
      text("Created by Jacky Banh",x+padding, y+padding +20);
      textSize(13);
      fill(255);
      String words = wrapText("This is the GoldSmith Edition purposely edited & commented for the person who will be marking this work! This was created in 10~ days (14/02/16-25/02/16), My initial for this game was to create a multiplayer version, however since Processing 3.0 was quite a hassle to use, I gave up the idea so I just focused on gameplay... I hope you enjoy testing this clicker idle game because I want to recreate it in C++ next year with multipler.",13,sizeX-padding*2);
      text(words,x+padding,y+padding + 45);
      
      
    }
  }

  void mousePressed() {
    if(show) {
      Close.mousePressed();
    }    
  }

  void mouseReleased() {
    if(show) {
      Close.mouseReleased();
    }      
  }  

  
}