//14/02/16 Project 16: 'Jacky Clicker'
//16.1.0.7a
//16.1.0.7a : added save

import java.util.*;
import com.google.gson.*;
import java.math.BigInteger;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;
import java.lang.reflect.Type;
import java.util.Collections;
import java.util.List;

//http://docs.oracle.com/javase/6/docs/api/java/math/BigInteger.html

//!Date:Objective - Problem(bugged) - Solution
//?Date:Objective - Solution
//^Date:Objective
//*Date:Objective - developer reason 
//Date: [Time - Start of session
//Date: Time] - End of session

//Note 16.1.0.5b:
//wtf? Gu.TotalDmg*100/0 = infinity?
//Bug: hiring recruits while over time is on would not make them overwork (too lazy/easy to fix)


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


//Enemy enemy;
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

DungeonPanel dungeonPanel;


RecruitConfigurePanel recruitConfigurePanel;


CharacterConfigurePanel characterConfigurePanel;


AreaTavern areaTavern;
ArrayList<AreaDungeon> areaDungeon = new ArrayList<AreaDungeon>();
AreaDungeon currentAreaDungeon;

ArrayList<GoldenCookie> goldenCookie = new ArrayList<GoldenCookie>();

//temp
ArrayList<PopText> popText = new ArrayList<PopText>();






Player player123;


float asd() {
  return 10;
}

void setup() {
  //fullScreen(JAVA2D);
  size(1300,600,JAVA2D);
  
  //Player(String Name,String Description,float x,float y,long CharVit,long CharStr,long CharEnd,long CharAgi,long CharDex)
  //player = new Player("Player","This is the Player of the game",width/2 -40,height/2 +80,10,10,10,10,10);
  //playerTemp = new Player("Jacky","This is the Player of the game",width/2 -40,height/2 +80,-100,10,10,10,10);
  
  //enemy
  //enemy = new Enemy("Enemy","Click on this to do damange",width/2 -100,height/2 - 200,10,10,10,10,10,0.5,10,10,1);
  Load();
  //aPlayer.add(new Player("Nanashi","This is the Player of the game",width/2 -40,height/2 +80,10+aPlayer.size(),10,10,10,10));
  //aPlayer.get(0) = player123;
  player123 = aPlayer.get(0);
  player123.ThisPlayer = true;
  
  //player123.Zeny = 100000045443543l;
  
  
  
  
  
  //PanelParty(float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize) {
  panelParty = new PanelParty(width - 250,15,235,300,color(25,25,200,150),2,10,color(255),1);
  //CharacterPanel(float x,float y,float sizeX,float sizeY,color background,float curve,float padding,color lineColor,float lineSize) {
    
  characterConfigurePanel = new CharacterConfigurePanel(player123,width/2 - 225,height/2 -225,450,450,color(25,25,200,150),10,2,color(255),1);
  recruitConfigurePanel = new RecruitConfigurePanel(width/2 - 225,height/2 -225,450,450,color(25,25,200,150),10,2,color(255),1);
  
  
  
  
  recruitPanel = new RecruitPanel(width - 250,height- 125,235,110,color(25,25,200,150),10,3,color(255),1,recruitConfigurePanel);
  
  
  characterPanel = new CharacterPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1,characterConfigurePanel,player123.Level);
  optionPanel = new OptionPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  
  inventoryPanel = new InventoryPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  tavernPanel = new TavernPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  
  dungeonPanel = new DungeonPanel(player123,areaDungeon,15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  
  //public LeftTabUI(float x,float y,float sizeX,float sizeY,color background,float curve0,float curve1,float curve2,float curve3,color textColor,float textSize,color lineColor,float lineSize,float textAngle) {
  leftTabUI = new LeftTabUI(223,15,27,height-30,5,color(25,25,200,150),0,2,2,0,color(255),14,color(255),1,90);
  
  
  areaTavern = new AreaTavern("The Tavern Inn","Drink up and rest before you go to battle!",color(255), aPlayer,player123);
  
  areaDungeon.add(new AreaDungeon("The Farm","Just about right.",color(200),aPlayer,player123,loadImage("BackgroundImage/Farm.jpg"),1000,0,color(204,255,255),1,1,1,1,1,1,1,1,0,1.01,0.1));
  
  areaDungeon.add(new AreaDungeon("The Forest","Beware of the deep hole...",color(200),aPlayer,player123,loadImage("BackgroundImage/Forest.jpg"),50,0,color(0,102,51),3,2,1,3,4,1.5,2,2,0,1.05,0.2));
  areaDungeon.add(new AreaDungeon("Gold Mine's Idle","Too rich for your own good...",color(200),aPlayer,player123,loadImage("BackgroundImage/Cave.jpg"),100,0,color(204,204,0),23,14,3.5,1,1,7.5,0.15,random(12,15),0,1.1,0.2));
  
  areaDungeon.add(new AreaDungeon("Elder Pact","'Squirm crawl slither writhe today we rise.'",color(200),aPlayer,player123,loadImage("BackgroundImage/Grandma.jpg"),10000,0,color(200,25,25),0.7,0.6,0.4,1,1,0.5,0.5,0.45,0,1.002,0.02));
  areaDungeon.add(new AreaDungeon("Chin Chin's Den","Run for your life...",color(200),aPlayer,player123,loadImage("BackgroundImage/ChinChin.jpg"),16,0,color(0),43264,6456,4353,3215,213,15,1000,1000,9,2.1,0.5));
  
  currentAreaDungeon = areaDungeon.get(0);
  
}

//I must put time event in here
void TimeEvent() {
  
  //playerTemp.TimeEvent();
  
  //player.TimeEvent();
  
  for(int n = 0; n < aPlayer.size(); n++) {
    aPlayer.get(n).TimeEvent();
  } 
  
  //enemy.TimeEvent();
  
  characterPanel.TimeEvent(player123);
  tavernPanel.TimeEvent();
  recruitPanel.TimeEvent(player123);
  panelParty.TimeEvent();
  dungeonPanel.TimeEvent();
  
  
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
  
  
  currentAreaDungeon.TimeEvent();
  
  
  saveGame(player123);
}

void ActionEvent() {
  
  //enemy
  //temp += 1/frameRate;
  //if(temp > 5) {
  //  if(random(100) > 50) {
  //    goldenCookie.add(new GoldenCookie("Golden Cookie","Click on it to see what you get!",false));
  //    if(enemy.UnitPlaced) {
  //      goldenCookie.get(goldenCookie.size()-1).Placed = true;
  //    } else {
  //      goldenCookie.get(goldenCookie.size()-1).Placed = false;
  //    }      
  //  } else {
  //    goldenCookie.add(new GoldenCookie("Golden Cookie","Click on it to see what you get!",true));
  //    if(enemy.UnitPlaced) {
  //      goldenCookie.get(goldenCookie.size()-1).Placed = true;
  //    } else {
  //      goldenCookie.get(goldenCookie.size()-1).Placed = false;
  //    }
  //  }
  //  temp = 0;
  //}
  
  
  for(int n = 0; n < aPlayer.size(); n++) {
    aPlayer.get(n).ActionEvent(currentAreaDungeon.en);
    
  }
  //player.PlayerLevelUp(10000000000000l);
  
  //enemy
  //enemy.ActionEvent(aPlayer,player123);

  characterPanel.ActionEvent(player123);
  tavernPanel.ActionEvent(aPlayer,player123);
  
  recruitPanel.ActionEvent(player123,currentAreaDungeon.en);
  
  dungeonPanel.ActionEvent();
  
  leftTabUI.ActionEvent(player123);
  
  panelParty.ActionEvent();
  
  
  //temp
  
    
    
    //enemy = new Enemy("Enemy " + killcount,"",width/2 -100,height/2 - 200,round(10*m),round(4*m),round(2*m),round(10*m),round(10*m),2,round(5*m),round(5*m),1);

  

  
  
  //temp
                            //if(player123.UnitAsButton.wasClicked) {
                            //  //public BuffIcon(String title,String infoDescription,float duration,Unit un,long BonusVit,long BonusStr,long BonusEnd,long BonusAgi,long BonusDex,long BonusRegHp,long  BonusDef,long  BonusDmg,long BonusHp,long BonusCrit,long BonusCritDmg, float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,float textSize,color lineColor,float lineSize) {
                            //  for(int n = 0; n < aPlayer.size(); n++) {
                            //    if(random(100) > 50) {
                            //      aPlayer.get(n).buffIcon.add(new BuffIcon("Lesser Healing Potion","Recover 60 hp over 5 seconds.",5,aPlayer.get(n),0.1,0.1,0.1,0,0,0,0,0,12,0,0,0,0,0,1,1,15,15,2,color(200,25,25),color(255),color(25,255,25),1));
                            //    }
                            //  }
                            //  player123.UnitAsButton.wasClicked = false;
                            //}
  
  
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
      aPlayer.get(n).buffIcon.get(i).ActionEvent(player123);
      if(aPlayer.get(n).buffIcon.get(i).Active == false) {
        aPlayer.get(n).buffIcon.remove(i);
      }
    }
  }
  
  for(int n = 0; n < goldenCookie.size(); n++) {
    goldenCookie.get(n).GiveValue(player123);
    if(goldenCookie.get(n).Alive == false) {
      goldenCookie.remove(n);
    }
  }
  
  
  areaTavern.ActionEvent();
  currentAreaDungeon.ActionEvent();
}


void draw() {
  ActionEvent();
  TimeEvent();
  background(25,100,25);
  
  areaTavern.BackgoundImage();
  currentAreaDungeon.BackgoundImage();
  //cursor(ARROW);
  
  //units
  player123.draw();
  currentAreaDungeon.draw();
  
  
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
  characterPanel.draw(player123);
  optionPanel.draw();
  inventoryPanel.draw(player123);
  tavernPanel.draw(player123);
  recruitPanel.draw(player123);
  dungeonPanel.draw(player123);
  
  
  //golden cookie
  for(int n = 0; n < goldenCookie.size();n++) {
    goldenCookie.get(n).draw();
  }
  
  //popText
  //temp
  for(int n = 0; n < popText.size(); n++) {
    popText.get(n).draw();
  }
  
  //area
  areaTavern.draw();
  
  
  
  //hover 
  areaTavern.HoverEvent();
  currentAreaDungeon.HoverEvent();
  
  player123.HoverEvent();
  
  characterPanel.HoverEvent();
  tavernPanel.HoverEvent();
  recruitPanel.HoverEvent(player123);
  
  dungeonPanel.HoverEvent();
  
  
  player123.UnitAsButton.hoverInfo.updateDescription(player123.Name,player123.Description);
  player123.ExpBar.BarInfo.updateDescription(player123.ExpBar.title,player123.ExpBar.Description +" You are currently level "+ player123.Level+". " + "You require "+(player123.MaxExp-player123.Exp)+" experience points to level up.");
  currentAreaDungeon.en.UnitAsButton.hoverInfo.updateDescription(currentAreaDungeon.en.Name,currentAreaDungeon.en.Description);
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
  
  
  textAlign(TOP,TOP);
  fill(200,25,25);
  textSize(25);
  text((int)(millis()/1000)+ "",0,0);
}

void mouseReleased() {
  currentAreaDungeon.mouseReleased();
  player123.UnitAsButton.mouseReleased();
  
  characterPanel.mouseReleased();
  tavernPanel.mouseReleased();
  leftTabUI.mouseReleased();
  recruitPanel.mouseReleased(player123);
  
  areaTavern.mouseReleased();
  
  dungeonPanel.mouseReleased();
  
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
  currentAreaDungeon.mousePressed();
  player123.UnitAsButton.mousePressed();
  
  characterPanel.mousePressed();
  tavernPanel.mousePressed();
  leftTabUI.mousePressed();
  recruitPanel.mousePressed(player123);
  
  areaTavern.mousePressed();
  
  dungeonPanel.mousePressed();
  
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