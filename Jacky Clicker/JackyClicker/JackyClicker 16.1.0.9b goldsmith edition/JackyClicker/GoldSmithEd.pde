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
      text("JackyClicker",x+padding,y+padding);
      textSize(14);
      fill(150);
      textAlign(TOP,TOP);
      text("Created by J.Banh",x+padding, y+padding +20);
      textSize(13);
      fill(255);
      String words = wrapText("Some of the Stuff is Uncommented because I am to lazy and your also too lazy to read my code. If You wish to test some of the Mechanic of the game, you can do the following. | | If your lazy to find items or grind for recruits: | | 1)Copy Save.json | 2)Paste 'Save.json' in 'JackyClicker/data/Save/' | 3)load the game | | you should be able to test some of the things without grinding. | | This is in the ReadMe.txt",13,sizeX-padding*2);
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