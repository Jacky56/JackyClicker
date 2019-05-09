//14/02/16 Project 16: 'Jacky Clicker'
//16.1.0.8 goldsmith edition 
//16.1.0.8 goldsmith edition: goldsmith edition, this version will be sent as coursework
//16.1.0.8 goldsmith edition: will comment;

//goldsmith edition: 
//Note:

//will clean some stuff
//will throw some comments here and there
//I got really lazy to record what i done per day
//some stuff classes were ported from 11.11.3 Rogue RPG - Extension, project for the last coursework done.
//this version 16.1.0.8 goldsmith edition, day 25/02/16

//Reminder:
//stuff with //temp was a quick and sloppy solution to the problem. (I will not try and effectively correct the code for the goldsmith edition.)
//This game was design to be multipler, however it was too stressful to program in this IDE
//This was a clear innovation from Idle games, cookie clicker, clicker heroes, Crusaders of the lost idles, adventure capitalist and so on.
//stuff with //.. shows that im too lazy to explain
//I have not tested this on mac OS 
//I WILL ONLY COMMENT THE 35 TABS THAT I CAN SEE ON MY 1600x900 RES SCREEN!!!!


//Difficult/long parts:
//Switching tabs
//Creating a formula to convert Crit rate to crit chance (6 hours)
//Saving using Gson library (3~ hours)
//Loading from Gson (3+ hours)
//GamePlan design (15~ hours)
//UI design (2~ hours)
//Creating a universal scrollbar (5 hour)
//Creating a button (1 hour)
//creating hover function (20 mins)
//Commenting this work (2-3~ hours)


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

//temp 

ArrayList<Player> aPlayer = new ArrayList<Player>();



//Create panels 
PanelParty panelParty;
CharacterPanel characterPanel;
LeftTabUI leftTabUI;
OptionPanel optionPanel;
InventoryPanel inventoryPanel;
TavernPanel tavernPanel;
RecruitPanel recruitPanel;
QuestPanel questPanel;
DungeonPanel dungeonPanel;

GoldSmithEdition goldSmithEdition;

//more panels
RecruitConfigurePanel recruitConfigurePanel;

//more panels
CharacterConfigurePanel characterConfigurePanel;


//creates areas
AreaTavern areaTavern;
ArrayList<AreaDungeon> areaDungeon = new ArrayList<AreaDungeon>();

//this is a pointer to determine which area the player is in 
AreaDungeon currentAreaDungeon;


//temp
//this is disabled during patch 16.1.0.4a since i was creating Area class 
ArrayList<GoldenCookie> goldenCookie = new ArrayList<GoldenCookie>();

//temp
//This was a temp solution to create text appear on screen 
ArrayList<PopText> popText = new ArrayList<PopText>();

//temp
//this is the same as PopText class, i should have fused them together
ArrayList<CreateMovingObject> createMovingObject = new ArrayList<CreateMovingObject>();
 


//this is a pointer to check which player is the client (note this was meant to be a multipler game)
Player player123;


//setup
void setup() {
  //loads all .png files to memory
  GetPath(dataPath(""),ListImages);
  //you can 
  
  //fullScreen(JAVA2D);
  size(1150,600,JAVA2D);
  
  //Load the saved game from dataPath
  Load();
  
  //points aPlayer.get(0) to player123
  player123 = aPlayer.get(0);
  //to determine that the client is playing as this player (note that this was meant to bea multipler game)
  player123.ThisPlayer = true;
  
  
  //initialize all the panels 
  optionPanel = new OptionPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  panelParty = new PanelParty(width - 250,15,235,300,color(25,25,200,150),2,10,color(255),1);
  characterConfigurePanel = new CharacterConfigurePanel(player123,width/2 - 225,height/2 -225,450,450,color(25,25,200,150),10,2,color(255),1);
  recruitConfigurePanel = new RecruitConfigurePanel(width/2 - 225,height/2 -225,450,450,color(25,25,200,150),10,2,color(255),1);
  recruitPanel = new RecruitPanel(width - 250,height- 125,235,110,color(25,25,200,150),10,3,color(255),1,recruitConfigurePanel);
  characterPanel = new CharacterPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1,characterConfigurePanel,player123.Level);
  questPanel = new QuestPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  inventoryPanel = new InventoryPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  tavernPanel = new TavernPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1,player123);
  dungeonPanel = new DungeonPanel(player123,areaDungeon,15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  
  goldSmithEdition = new GoldSmithEdition(width/2 - 225,height/2 -225,450,450,color(25,25,200,150),10,2,color(255),1);
  //initialize the left tab of the panels
  leftTabUI = new LeftTabUI(223,15,27,height-30,5,color(25,25,200,150),0,2,2,0,color(255),14,color(255),1,90);
  
  //creates the tavern area, the start of the game area
  areaTavern = new AreaTavern("The Tavern Inn","Drink up and rest before you go to battle!",color(255),player123);
  
  //points currentAreaDungeon to areaDungeon.get(0)
  currentAreaDungeon = areaDungeon.get(0);
  
}

//I must put time event in here

//Put time events here 
void TimeEvent() {

  //plays all the aPlayer time events (note this was an array to test the looks on panelParty, you can insert more to see the effects via code)
  for(int n = 0; n < aPlayer.size(); n++) {
    aPlayer.get(n).TimeEvent();
  } 
  
  //plays all the time event for panels
  characterPanel.TimeEvent(player123);
  tavernPanel.TimeEvent();
  recruitPanel.TimeEvent(player123);
  panelParty.TimeEvent();
  dungeonPanel.TimeEvent();
  
  
  //goldenCookie was pretty much disabled since 16.1.0.4a
  for(int n = 0; n < goldenCookie.size();n++) {
    goldenCookie.get(n).TimeEvent();
  }
  
  //temp
  //removes the popText from memory if the screen gets too flooded
  //My brother claims it doesn't do much for memory management 
  if(popText.size() > 10) {
    popText.remove(0);
  }
  
  //temp
  //removes the popText if the duration is over
  for(int n = 0; n < popText.size();n++) {
    popText.get(n).TimeEvent();
    if(popText.get(n).Active == false) {
      popText.remove(n);
    }
  }
  
  //temp
  //removes createMovingObject if theres too much images on the screen
  if(createMovingObject.size() > 10) {
    createMovingObject.remove(0);
  }
  
  //temp
  //removes createMovingObject if the duration is up
  for(int n = 0; n < createMovingObject.size(); n++) {
    createMovingObject.get(n).TimeEvent();
    if(createMovingObject.get(n).duration < 0) {
      createMovingObject.remove(n);
    }    
  }
  //play time event on the current area dungeon that the player is in 
  currentAreaDungeon.TimeEvent(aPlayer,player123);
  
  //saves the game every 60 seconds of the player's stats and how much the player acomplished
  saveGame(player123,areaDungeon);
}

//this is where i put all the Action events where things happen!
void ActionEvent() {
  
  //as you can see this is what generated the golden cookie
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
  
  //temp
  //plays the action even for createMovingObject
  for(int n = 0; n < createMovingObject.size(); n++) {
    createMovingObject.get(n).ActionEvent();
  }
  
  //plays all actionevent from player
  for(int n = 0; n < aPlayer.size(); n++) {
    aPlayer.get(n).ActionEvent(currentAreaDungeon.en);
  }
  
  //plays all the actionEvent from the panels
  characterPanel.ActionEvent(player123);
  tavernPanel.ActionEvent(aPlayer,player123);
  optionPanel.ActionEvent(player123,areaDungeon);
  recruitPanel.ActionEvent(player123,currentAreaDungeon.en);
  dungeonPanel.ActionEvent();
  //plays the anction event for left tab
  leftTabUI.ActionEvent(player123);
  goldSmithEdition.ActionEvent();
  //this is a panel 
  panelParty.ActionEvent();
  
  

  

  //Enable this if you want to test how Buffs work in the game by clicking on ur model in game
  
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
  
  
  
  //remove guild unit if you fire them
  for(int n = 0; n < aPlayer.size(); n++) {
    for(int i = 0; i < aPlayer.get(n).guildUnit.size(); i++) {
      if(aPlayer.get(n).guildUnit.get(i).UnitRemove) {
        aPlayer.get(n).guildUnit.remove(i);
      }
    }
  }
  
  //plays action event for the buff (give stats)
  //removes the buff if its disabled
  for(int n = 0; n < aPlayer.size(); n++) {
    for(int i = 0; i < aPlayer.get(n).buffIcon.size();i++) {
      aPlayer.get(n).buffIcon.get(i).ActionEvent(player123);
      if(aPlayer.get(n).buffIcon.get(i).Active == false) {
        aPlayer.get(n).buffIcon.remove(i);
      }
    }
  }
  
  //this does not exist since patch 16.1.0.4a
  for(int n = 0; n < goldenCookie.size(); n++) {
    goldenCookie.get(n).GiveValue(player123);
    if(goldenCookie.get(n).Alive == false) {
      goldenCookie.remove(n);
    }
  }
  
  //plays action event for the tavern area 
  areaTavern.ActionEvent();
  //plays action event for the current Dungeon Area
  currentAreaDungeon.ActionEvent(aPlayer,player123);
}

//draw
void draw() {
  //plays action event of the game
  ActionEvent();
  //plays time event of the game
  TimeEvent();
  //quite pointless
  background(25,100,25);
  
  //draws background image depending on the area 
  areaTavern.BackgoundImage();
  currentAreaDungeon.BackgoundImage();
  //cursor(ARROW);
  
  //draws the moving object
  for(int n = 0;n < createMovingObject.size(); n++) {
    createMovingObject.get(n).draw();
  }
  
  
  //unit
  //draws the player
  player123.draw();
  
  //area
  //draws the enemy in currentAreaDungeon
  currentAreaDungeon.draw();
  areaTavern.draw();

  
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
  questPanel.draw();
  goldSmithEdition.draw();
  //golden cookie (14.1.0.4a removed)
  for(int n = 0; n < goldenCookie.size();n++) {
    goldenCookie.get(n).draw();
  }
  
  //popText
  //temp
  for(int n = 0; n < popText.size(); n++) {
    popText.get(n).draw();
  }
  
  
  
  
  //hover 
  //this kinda fixes the overlay problem for 2D game,( could have probably used P3D to fix overlay)
  //draws HoverEvent
  areaTavern.HoverEvent();
  currentAreaDungeon.HoverEvent();
  player123.HoverEvent();
  characterPanel.HoverEvent();
  tavernPanel.HoverEvent();
  recruitPanel.HoverEvent(player123);
  dungeonPanel.HoverEvent();
  
  
  //hover event for dead players 
  for(int n = 0; n < panelParty.PPP.size();n++) {
    if(panelParty.PPP.get(n).DeathTimerButton != null) {
      Player pl = panelParty.PPP.get(n).pl;
      panelParty.PPP.get(n).HoverEvent();
      panelParty.PPP.get(n).DeathTimerButton.hoverInfo.updateDescription("Dead",pl.Name+ " is dead! Tap to revive faster. "+ round(pl.CurrentDeathTimer)+ " seconds remaining.");
    }
  }  
  
  //pls
  for(int n = 0; n < goldenCookie.size();n++) {
    goldenCookie.get(n).HoverEvent();
  }  
  
  //hover even for buffs
  for(int n = 0; n < aPlayer.size(); n++) {
    for(int i = 0; i < aPlayer.get(n).buffIcon.size();i++) {
      if (i < 11) {
        aPlayer.get(n).buffIcon.get(i).HoverEvent();
      }
    }
  }
  
  
  //temp
  //used to measure time/fps for the game
  textAlign(TOP,TOP);
  fill(200,25,25);
  textSize(25);
  text((int)(millis()/1000)+ "",0,0);
  text((int)frameRate+ "",width-textWidth((int)frameRate+""),0);
}

//mouse released event
void mouseReleased() {
  
  currentAreaDungeon.mouseReleased();
  player123.UnitAsButton.mouseReleased();
  
  //plays the panal mouse release event
  optionPanel.mouseReleased();
  characterPanel.mouseReleased();
  tavernPanel.mouseReleased();
  leftTabUI.mouseReleased();
  recruitPanel.mouseReleased(player123);
  dungeonPanel.mouseReleased();
  goldSmithEdition.mouseReleased();
  //plays the mouse even of the area 
  areaTavern.mouseReleased();
  
  //plays event on death button 
  for(int n = 0; n < panelParty.PPP.size();n++) {
    if(panelParty.PPP.get(n).DeathTimerButton != null) {
      panelParty.PPP.get(n).DeathTimerButton.mouseReleased();
    }
  }
  //...
  for(int n = 0; n < goldenCookie.size();n++) {
    goldenCookie.get(n).GoldenCookieAsButton.mouseReleased();
  }    
  
  
}
//mouse pressed event
//too lazy to comment
void mousePressed() {
  
  currentAreaDungeon.mousePressed();
  player123.UnitAsButton.mousePressed();
  
  characterPanel.mousePressed();
  tavernPanel.mousePressed();
  leftTabUI.mousePressed();
  recruitPanel.mousePressed(player123);
  optionPanel.mousePressed();
  areaTavern.mousePressed();
  goldSmithEdition.mousePressed();
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
//plays keyTyped 
void keyTyped() {
  characterConfigurePanel.keyTyped();
}
//plays mouse wheel for scroll bar
void mouseWheel(MouseEvent event) {
  characterPanel.mouseWheel(event);
  tavernPanel.mouseWheel(event);
  recruitPanel.mouseWheel(event);
}