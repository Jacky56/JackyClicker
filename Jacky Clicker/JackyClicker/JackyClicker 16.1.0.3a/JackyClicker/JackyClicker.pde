//14/02/16 Project 16: 'Jacky Clicker'
//16.1.0.3a
//16.1.0.3a : improve ui ?



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

//16/02/16: [02:14
// *lost track on what i done* 
//16/02/16: 07:59]

//16/02/16: [07:59 ?
// *lost track on what i done* 
//17/02/16: 02:30] ?

//17/02/16: [17:01
//


Enemy enemy;
Player player;

Player playerTemp;



PanelParty panelParty;

CharacterPanel characterPanel;
LeftTabUI leftTabUI;
OptionPanel optionPanel;
InventoryPanel inventoryPanel;

AutoConfigurePanel autoConfigurePanel;

ArrayList<GoldenCookie> goldenCookie = new ArrayList<GoldenCookie>();

//temp
ArrayList<PopText> popText = new ArrayList<PopText>();

float temp;


long killcount;





void setup() {
  //fullScreen(JAVA2D);
  size(1000,600,JAVA2D);
  //Player(String Name,String Description,float x,float y,long CharVit,long CharStr,long CharEnd,long CharAgi,long CharDex)
  player = new Player("Player","This is the Player of the game",width/2 -40,height/2 +80,10,10,10,10,10);
  playerTemp = new Player("Jacky","This is the Player of the game",width/2 -40,height/2 +80,-100,10,10,10,10);
  enemy = new Enemy("Enemy","Click on this to do damange",width/2 -100,height/2 - 200,10,10,10,10,10,200000,10,10,1);
  
  
  
  //BigOne = new Button("Click This","This is a very big button, click it and see what happens!",width/2-100,height/2-100,200,200,50,0,50,0,color(100,25,25),color(25,25,200),40,0,5);
  
  //PanelParty(float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize) {
    
  panelParty = new PanelParty(width - 250,15,235,300,color(25,25,200,150),2,10,color(255),1);
  //CharacterPanel(float x,float y,float sizeX,float sizeY,color background,float curve,float padding,color lineColor,float lineSize) {
    
  autoConfigurePanel = new AutoConfigurePanel(width/2 - 225,height/2 -225,450,450,color(25,25,200,150),10,2,color(255),1);
  
  player.PlayerLevelUp(100000l);
  
  
  
  
  characterPanel = new CharacterPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1,autoConfigurePanel,player.Level);
  optionPanel = new OptionPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  
  inventoryPanel = new InventoryPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  
  
  //public LeftTabUI(float x,float y,float sizeX,float sizeY,color background,float curve0,float curve1,float curve2,float curve3,color textColor,float textSize,color lineColor,float lineSize,float textAngle) {
  leftTabUI = new LeftTabUI(223,15,20,height-30,5,color(25,25,200,150),0,2,2,0,color(255),14,color(255),1,90);
  
  
  //player.Zeny = 5437543654l;
}

//I must put time event in here
void TimeEvent() {
  
  playerTemp.TimeEvent();
  
  player.TimeEvent();
  
  enemy.TimeEvent();
  
  characterPanel.TimeEvent(player);
  
  
  panelParty.TimeEvent();
  
  
  for(int n = 0; n < goldenCookie.size();n++) {
    goldenCookie.get(n).TimeEvent();
  }
  
  //temp
  if(popText.size() > 10) {
    popText.remove(0);
  }
  
  //temp
  for(int n = 0; n < popText.size();n++) {
    popText.get(n).TimeEvent();
    if(popText.get(n).Active == false) {
      popText.remove(n);
    }
  }
  
  
}

void ActionEvent() {
  temp += 1/frameRate;
  if(temp > 5) {
    if(random(100) > 50) {
      goldenCookie.add(new GoldenCookie("Golden Cookie","Click on it to see what you get!",false));
    } else {
      goldenCookie.add(new GoldenCookie("Golden Cookie","Click on it to see what you get!",true));
    }
    temp = 0;
  }
  
  
  playerTemp.ActionEvent(enemy);
  player.ActionEvent(enemy);
  
  
  //player.PlayerLevelUp(10000000000000l);
  enemy.ActionEvent(player);
  
  characterPanel.ActionEvent(player);
  
  leftTabUI.ActionEvent();
  
  panelParty.ActionEvent();
  
  //temp
  if(enemy.Alive == false ) {
    killcount++;
    float m = killcount*0.1 + 1;
    enemy = new Enemy("Enemy " + killcount,"",width/2 -100,height/2 - 200,round(10*m),round(10*m),round(10*m),round(10*m),round(10*m),2,round(10*m),round(10*m),1);
  }
  

  
  
  //temp
  if(player.UnitAsButton.wasClicked) {
    //public BuffIcon(String title,String infoDescription,float duration,Unit un,long BonusVit,long BonusStr,long BonusEnd,long BonusAgi,long BonusDex,long BonusRegHp,long  BonusDef,long  BonusDmg,long BonusHp,long BonusCrit,long BonusCritDmg, float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,float textSize,color lineColor,float lineSize) {
    player.buffIcon.add(new BuffIcon("Lesser Healing Potion","Recover 60 hp over 2 seconds.",2,player,0,0,0,0,0,30,0,0,0,0,0,panelParty.PPP.get(0).x,panelParty.PPP.get(0).y,15,15,2,color(200,25,25),color(255),color(25,255,25),1));
    player.UnitAsButton.wasClicked = false;
  }
  
  
  
  
  
  for(int i = 0; i < player.buffIcon.size();i++) {
    player.buffIcon.get(i).ActionEvent();
    if(player.buffIcon.get(i).Active == false) {
      player.buffIcon.remove(i);
    }
  }
  
  
  for(int n = 0; n < goldenCookie.size(); n++) {
    goldenCookie.get(n).GiveValue(player);
    if(goldenCookie.get(n).Alive == false) {
      goldenCookie.remove(n);
    }
  }
  
  
}


void draw() {
  ActionEvent();
  TimeEvent();
  background(25,100,25);
  
  
  //cursor(ARROW);
  
  
  //units
  player.draw();
  enemy.draw();
  
  
  //top right panel
  panelParty.draw();
  for(int n = 0; n < panelParty.PPP.size();n++) {
    panelParty.PPP.get(n).draw();
    if(panelParty.PPP.get(n).DeathTimerButton != null) {
      panelParty.PPP.get(n).DeathTimerButton.draw();
    }
  }  
  
  //left panel
  characterPanel.draw(player);
  optionPanel.draw();
  inventoryPanel.draw(player);
  
  
  //left tabs
  leftTabUI.draw();
  
  
  
  //golden cookie
  for(int n = 0; n < goldenCookie.size();n++) {
    goldenCookie.get(n).GoldenCookieAsButton.draw();
  }
  
  //popText
  //temp
  for(int n = 0; n < popText.size(); n++) {
    popText.get(n).draw();
  }
  
  //hover 
  player.HoverEvent();
  enemy.HoverEvent();
  
  characterPanel.HoverEvent();
  
  player.UnitAsButton.hoverInfo.updateDescription(player.Name,player.Description);
  player.ExpBar.BarInfo.updateDescription(player.ExpBar.title,player.ExpBar.Description +" You are currently level "+ player.Level+". " + "You require "+(player.MaxExp-player.Exp)+" experience points to level up.");
  enemy.UnitAsButton.hoverInfo.updateDescription(enemy.Name,enemy.Description);
  //enemy.AttackTimerBar.BarInfo.updateDescription(enemy.at);
  
  for(int n = 0; n < panelParty.PPP.size();n++) {
    if(panelParty.PPP.get(n).DeathTimerButton != null) {
      Player pl = panelParty.PPP.get(n).pl;
      panelParty.PPP.get(n).HoverEvent();
      panelParty.PPP.get(n).DeathTimerButton.hoverInfo.updateDescription("Dead",pl.Name+ " is dead! Tap to revive faster. "+ round(pl.CurrentDeathTimer)+ " seconds remaining.");
    }
  }  
  
  for(int n = 0; n < goldenCookie.size();n++) {
    goldenCookie.get(n).HoverEvent();
  }  
  
  
  for(int i = 0; i < player.buffIcon.size();i++) {
    if (i < 11) {
      player.buffIcon.get(i).HoverEvent();
    }
  } 
  
  
  
}

void mouseReleased() {
  enemy.UnitAsButton.mouseReleased();
  player.UnitAsButton.mouseReleased();
  
  characterPanel.mouseReleased();
  leftTabUI.mouseReleased();
  
  for(int n = 0; n < panelParty.PPP.size();n++) {
    if(panelParty.PPP.get(n).DeathTimerButton != null) {
      panelParty.PPP.get(n).DeathTimerButton.mouseReleased();
    }
  }
  
  for(int n = 0; n < goldenCookie.size();n++) {
    goldenCookie.get(n).GoldenCookieAsButton.mouseReleased();
  }    
  
  
}

void mousePressed() {
  enemy.UnitAsButton.mousePressed();
  player.UnitAsButton.mousePressed();
  
  characterPanel.mousePressed();
  leftTabUI.mousePressed();
  
  for(int n = 0; n < panelParty.PPP.size();n++) {
    if(panelParty.PPP.get(n).DeathTimerButton != null) {
      panelParty.PPP.get(n).DeathTimerButton.mousePressed();
    }
  }

  for(int n = 0; n < goldenCookie.size();n++) {
    goldenCookie.get(n).GoldenCookieAsButton.mousePressed();
  }
  
  
}



void mouseWheel(MouseEvent event) {
  characterPanel.mouseWheel(event);
}