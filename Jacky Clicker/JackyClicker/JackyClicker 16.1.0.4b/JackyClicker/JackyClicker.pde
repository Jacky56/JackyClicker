//14/02/16 Project 16: 'Jacky Clicker'
//16.1.0.4b
//16.1.0.4b : bug fix



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
//Player player;
//Player playerTemp;

ArrayList<Player> aPlayer = new ArrayList<Player>();


PanelParty panelParty;

CharacterPanel characterPanel;
LeftTabUI leftTabUI;
OptionPanel optionPanel;
InventoryPanel inventoryPanel;
TavernPanel tavernPanel;
RecruitPanel recruitPanel;


RecruitConfigurePanel recruitConfigurePanel;


CharacterConfigurePanel characterConfigurePanel;

ArrayList<GoldenCookie> goldenCookie = new ArrayList<GoldenCookie>();

//temp
ArrayList<PopText> popText = new ArrayList<PopText>();

float temp;


long killcount;





void setup() {
  //fullScreen(JAVA2D);
  size(1000,600,JAVA2D);
  //Player(String Name,String Description,float x,float y,long CharVit,long CharStr,long CharEnd,long CharAgi,long CharDex)
  //player = new Player("Player","This is the Player of the game",width/2 -40,height/2 +80,10,10,10,10,10);
  //playerTemp = new Player("Jacky","This is the Player of the game",width/2 -40,height/2 +80,-100,10,10,10,10);
  enemy = new Enemy("Enemy","Click on this to do damange",width/2 -100,height/2 - 200,10,10,10,10,10,0.5,10,10,1);
  
  
  aPlayer.add(new Player("Player "+ aPlayer.size(),"This is the Player of the game",width/2 -40,height/2 +80,10+aPlayer.size(),10,10,10,10));
  aPlayer.add(new Player("Player "+ aPlayer.size(),"This is the Player of the game",width/2 -40,height/2 +80,10+aPlayer.size(),10,10,10,10));
  aPlayer.add(new Player("Player "+ aPlayer.size(),"This is the Player of the game",width/2 -40,height/2 +80,10+aPlayer.size(),10,10,10,10));
  aPlayer.add(new Player("Player "+ aPlayer.size(),"This is the Player of the game",width/2 -40,height/2 +80,10+aPlayer.size(),10,10,10,10));
  aPlayer.add(new Player("Player "+ aPlayer.size(),"This is the Player of the game",width/2 -40,height/2 +80,10+aPlayer.size(),10,10,10,10));
  aPlayer.get(1).ThisPlayer = true;
  
  aPlayer.get(1).Zeny = 1076876876800l;
  aPlayer.get(1).PlayerLevelUp(1076876876800l); 
  
  
  //BigOne = new Button("Click This","This is a very big button, click it and see what happens!",width/2-100,height/2-100,200,200,50,0,50,0,color(100,25,25),color(25,25,200),40,0,5);
  
  //PanelParty(float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize) {
    
  panelParty = new PanelParty(width - 250,15,235,300,color(25,25,200,150),2,10,color(255),1);
  //CharacterPanel(float x,float y,float sizeX,float sizeY,color background,float curve,float padding,color lineColor,float lineSize) {
    
  characterConfigurePanel = new CharacterConfigurePanel(aPlayer.get(1),width/2 - 225,height/2 -225,450,450,color(25,25,200,150),10,2,color(255),1);
  recruitConfigurePanel = new RecruitConfigurePanel(width/2 - 225,height/2 -225,450,450,color(25,25,200,150),10,2,color(255),1);
  
  //player.PlayerLevelUp(100000l);
  
  recruitPanel = new RecruitPanel(width - 250,height- 125,235,110,color(25,25,200,150),10,3,color(255),1,recruitConfigurePanel);
  
  
  characterPanel = new CharacterPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1,characterConfigurePanel,aPlayer.get(1).Level);
  optionPanel = new OptionPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  
  inventoryPanel = new InventoryPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  tavernPanel = new TavernPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  
  //public LeftTabUI(float x,float y,float sizeX,float sizeY,color background,float curve0,float curve1,float curve2,float curve3,color textColor,float textSize,color lineColor,float lineSize,float textAngle) {
  leftTabUI = new LeftTabUI(223,15,27,height-30,5,color(25,25,200,150),0,2,2,0,color(255),14,color(255),1,90);
  
  
  //player.Zeny = 5437543654l;
}

//I must put time event in here
void TimeEvent() {
  
  //playerTemp.TimeEvent();
  
  //player.TimeEvent();
  
  for(int n = 0; n < aPlayer.size(); n++) {
    aPlayer.get(n).TimeEvent();
  } 
  
  enemy.TimeEvent();
  
  characterPanel.TimeEvent(aPlayer.get(1));
  tavernPanel.TimeEvent();
  recruitPanel.TimeEvent(aPlayer.get(1));
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
      if(enemy.UnitPlaced) {
        goldenCookie.get(goldenCookie.size()-1).Placed = true;
      } else {
        goldenCookie.get(goldenCookie.size()-1).Placed = false;
      }      
    } else {
      goldenCookie.add(new GoldenCookie("Golden Cookie","Click on it to see what you get!",true));
      if(enemy.UnitPlaced) {
        goldenCookie.get(goldenCookie.size()-1).Placed = true;
      } else {
        goldenCookie.get(goldenCookie.size()-1).Placed = false;
      }
    }
    temp = 0;
  }
  
  
  //playerTemp.ActionEvent(enemy);
  //player.ActionEvent(enemy);
  for(int n = 0; n < aPlayer.size(); n++) {
    aPlayer.get(n).ActionEvent(enemy);
  }
  
  //player.PlayerLevelUp(10000000000000l);
  enemy.ActionEvent(aPlayer,aPlayer.get(1));
  
  characterPanel.ActionEvent(aPlayer.get(1));
  tavernPanel.ActionEvent(aPlayer,aPlayer.get(1));
  
  recruitPanel.ActionEvent(aPlayer.get(1),enemy);
  
  leftTabUI.ActionEvent();
  
  panelParty.ActionEvent();
  
  
  //temp
  if(enemy.Alive == false ) {
    killcount++;
    float m = killcount*0.1 + 1;
    enemy = new Enemy("Enemy " + killcount,"",width/2 -100,height/2 - 200,round(10*m),round(10*m),round(10*m),round(10*m),round(10*m),2,round(10*m),round(10*m),1);
  }
  

  
  
  //temp
  if(aPlayer.get(1).UnitAsButton.wasClicked) {
    //public BuffIcon(String title,String infoDescription,float duration,Unit un,long BonusVit,long BonusStr,long BonusEnd,long BonusAgi,long BonusDex,long BonusRegHp,long  BonusDef,long  BonusDmg,long BonusHp,long BonusCrit,long BonusCritDmg, float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,float textSize,color lineColor,float lineSize) {
    for(int n = 0; n < aPlayer.size(); n++) {
      if(random(100) > 50) {
        aPlayer.get(n).buffIcon.add(new BuffIcon("Lesser Healing Potion","Recover 60 hp over 5 seconds.",5,aPlayer.get(n),0.1,0.1,0.1,0,0,0,0,0,12,0,0,0,0,0,1,1,15,15,2,color(200,25,25),color(255),color(25,255,25),1));
      }
    }
    aPlayer.get(1).UnitAsButton.wasClicked = false;
  }
  
  
  //remove guild unit 
  for(int n = 0; n < aPlayer.size(); n++) {
    for(int i = 0; i < aPlayer.get(n).guildUnit.size(); i++) {
      if(aPlayer.get(n).guildUnit.get(i).UnitRemove) {
        aPlayer.get(n).guildUnit.remove(i);
      }
    }
  }
  
  
  for(int n = 0; n < aPlayer.size(); n++) {
    for(int i = 0; i < aPlayer.get(n).buffIcon.size();i++) {
      aPlayer.get(n).buffIcon.get(i).ActionEvent();
      if(aPlayer.get(n).buffIcon.get(i).Active == false) {
        aPlayer.get(n).buffIcon.remove(i);
      }
    }
  }
  
  for(int n = 0; n < goldenCookie.size(); n++) {
    goldenCookie.get(n).GiveValue(aPlayer.get(1));
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
  aPlayer.get(1).draw();
  enemy.draw();
  
  
  //top right panel
  panelParty.draw();
  for(int n = 0; n < panelParty.PPP.size();n++) {
    panelParty.PPP.get(n).draw();
    if(panelParty.PPP.get(n).DeathTimerButton != null) {
      panelParty.PPP.get(n).DeathTimerButton.draw();
    }
  }  
  //left tabs
  leftTabUI.draw();
  
  
  //left panel
  characterPanel.draw(aPlayer.get(1));
  optionPanel.draw();
  inventoryPanel.draw(aPlayer.get(1));
  tavernPanel.draw(aPlayer.get(1));
  recruitPanel.draw(aPlayer.get(1));
  
  
  //golden cookie
  for(int n = 0; n < goldenCookie.size();n++) {
    goldenCookie.get(n).draw();
  }
  
  //popText
  //temp
  for(int n = 0; n < popText.size(); n++) {
    popText.get(n).draw();
  }
  
  //hover 
  aPlayer.get(1).HoverEvent();
  enemy.HoverEvent();
  
  characterPanel.HoverEvent();
  tavernPanel.HoverEvent();
  recruitPanel.HoverEvent(aPlayer.get(1));
  
  
  aPlayer.get(1).UnitAsButton.hoverInfo.updateDescription(aPlayer.get(1).Name,aPlayer.get(1).Description);
  aPlayer.get(1).ExpBar.BarInfo.updateDescription(aPlayer.get(1).ExpBar.title,aPlayer.get(1).ExpBar.Description +" You are currently level "+ aPlayer.get(1).Level+". " + "You require "+(aPlayer.get(1).MaxExp-aPlayer.get(1).Exp)+" experience points to level up.");
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
  
  for(int n = 0; n < aPlayer.size(); n++) {
    for(int i = 0; i < aPlayer.get(n).buffIcon.size();i++) {
      if (i < 11) {
        aPlayer.get(n).buffIcon.get(i).HoverEvent();
      }
    }
  }
  
  
  
}

void mouseReleased() {
  enemy.UnitAsButton.mouseReleased();
  aPlayer.get(1).UnitAsButton.mouseReleased();
  
  characterPanel.mouseReleased();
  tavernPanel.mouseReleased();
  leftTabUI.mouseReleased();
  recruitPanel.mouseReleased(aPlayer.get(1));
  
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
  aPlayer.get(1).UnitAsButton.mousePressed();
  
  characterPanel.mousePressed();
  tavernPanel.mousePressed();
  leftTabUI.mousePressed();
  recruitPanel.mousePressed(aPlayer.get(1));
  
  
  for(int n = 0; n < panelParty.PPP.size();n++) {
    if(panelParty.PPP.get(n).DeathTimerButton != null) {
      panelParty.PPP.get(n).DeathTimerButton.mousePressed();
    }
  }

  for(int n = 0; n < goldenCookie.size();n++) {
    goldenCookie.get(n).GoldenCookieAsButton.mousePressed();
  }
  
  
}

void keyTyped() {
  characterConfigurePanel.keyTyped();
}

void mouseWheel(MouseEvent event) {
  characterPanel.mouseWheel(event);
  tavernPanel.mouseWheel(event);
  recruitPanel.mouseWheel(event);
}