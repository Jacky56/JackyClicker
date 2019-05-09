//14/02/16 Project 16: 'Jacky Clicker'
//16.1.0.0

import java.math.BigInteger;
//http://docs.oracle.com/javase/6/docs/api/java/math/BigInteger.html

//!Date:Objective - Problem(bugged) - Solution
//?Date:Objective - Solution
//^Date:Objective
//*Date:Objective - developer reason 
//Date: [Time - Start of session
//Date: Time] - End of session

//Note: 
//This is a Simple version of the game 
//This game will be most likely be ported to another language 
//This version will not have multipler
//I will try to aim to build very generic functions
//I will try and make the game very easy to introduce new content

//15/02/16: [02:54
//^15/02/16: added a Button engine
//15/02/16: 04:56]

//15/02/16: [17:11
//^15/02/16: added WrapText engine
//^15/02/16: added wrapNumber engine
//^15/02/16: added HoverInfo engine - too generic to display stats or specifc things 
//^15/02/16: now added scroll bar (not an engine)
//?15/02/16: debugged scroll bar

//16/02/16: 00:02]

ArrayList<Button> button = new ArrayList<Button>();
Button BigOne;
ScrollBar bar;


void setup() {
  size(1000,600);
  BigOne = new Button("Click This","This is a very big button, click it and see what happens!",width/2-100,height/2-100,200,200,50,0,50,0,color(100,25,25),color(25,25,200),40,0,5);
  
  bar = new ScrollBar(0,height,250,0,20,height,color(0,150),3,color(255),2);
}


void draw() {
  background(25,100,25);
  cursor(ARROW);
  BigOne.draw();
  
  for(int n = 0; n < button.size(); n++) {
    button.get(n).draw();
  //button[n].test = new HoverInfo(button[n].title,"This is a button wpretty!",15,color(255),150,5,color(25,25,200,150),button[n].x,button[n].y,button[n].sizeX,button[n].sizeY);
  }
  
  
  
  
  //scroll
  bar.draw();
  
  
  //hover 
  if(BigOne.infoDescription != "") {
    BigOne.test.draw();
  }
  for(int n = 0; n < button.size(); n++) {
    if(button.get(n).infoDescription != "") {
      button.get(n).test.draw();
      button.get(n).test.updatePosition(button.get(n).x,button.get(n).y);
    }
  }
  //bar.getConentLength(button);
  bar.contentMove(button);
  bar.updateConentLength(button);
  
  if(BigOne.wasClicked) {
    button.add(new Button("dss"+button.size(),"This is button "+button.size()+ ". This Button will get deleted if you click on it!",15,15+button.size()*50,220,40,color(button.size()*15),color(0),10));
    BigOne.wasClicked = false;
  }
  
  for(int n = 0; n < button.size();n++) {
    if(button.get(n).wasClicked) {
      button.remove(n);
    }
  }
  
}

void mouseReleased() {
  for(int n = 0; n < button.size(); n++) {
    button.get(n).mouseReleased();
  }
  BigOne.mouseReleased();
  bar.mouseReleased();
}

void mousePressed() {
  for(int n = 0; n < button.size(); n++) {
    button.get(n).mousePressed();
  }  
  BigOne.mousePressed();
  bar.mousePressed();
}