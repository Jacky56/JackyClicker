//14/02/16 Project 16: 'Jacky Clicker'
//16.1.0.9b
//16.1.0.9b : Commented version of 16.1.0.9a


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
import java.io.File;
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
// ?????
//??/??/??: ??:??]


//07/04/16: [11:48
// * going to add inventory/items
//^07/04/16: copy and paste the item system from rougeRPG 10.11.3 and editted some bits to be added into the game
//07/04/16: 13:28]


//Enemy enemy;
//Player player;
//Player playerTemp;





//Creating multiple players (was intented as some multiplayer clicking/idle game
ArrayList<Player> aPlayer = new ArrayList<Player>();

//creating null objects
//these objects are use for the GUI 
PanelParty panelParty;
CharacterPanel characterPanel;
LeftTabUI leftTabUI;
OptionPanel optionPanel;
InventoryPanel inventoryPanel;
TavernPanel tavernPanel;
RecruitPanel recruitPanel;
QuestPanel questPanel;
DungeonPanel dungeonPanel;
PrestigeTavernPanel prestigeTavernPanel;
RecruitConfigurePanel recruitConfigurePanel;
CharacterConfigurePanel characterConfigurePanel;
PrestigePanel prestigePanel;

//creating null ohjects for the Area
//the area will effect the monsters stats and so
AreaTavern areaTavern;
ArrayList<AreaDungeon> areaDungeon = new ArrayList<AreaDungeon>();
AreaDungeon currentAreaDungeon;

//this was disabled 
ArrayList<GoldenCookie> goldenCookie = new ArrayList<GoldenCookie>();

//temp 
//this object is used to make text appear on the screen
ArrayList<PopText> popText = new ArrayList<PopText>();

//temp
//this is also used to create moving images on the screen (I should have just added another contructor on poptext just for this)
ArrayList<CreateMovingObject> createMovingObject = new ArrayList<CreateMovingObject>();
 


//a reference 
Player player123;


//temp
GoldSmithEdition goldSmithEdition;



void setup() {
  //this function loads all .png iamges to the game 
  //this makes it have a slow load time at the begining but no spikes or staggers in game 
  
  GetPath(dataPath(""),ListImages);
  //fullScreen(JAVA2D);
  //some client size
  size(1000,600,JAVA2D);
  goldSmithEdition = new GoldSmithEdition(width/2 - 225,height/2 -225,450,450,color(25,25,200,150),10,2,color(255),1);  
  
  //loads your save file 
  Load();
  
  //***enable this for debugging"***
  //player123.PlayerLevelUp(10049032940903240l);
  //player123.Zeny += 10000000000l;
  
  //initialize GUI 
  //the position of the GUI should change depending on the size of the cleint 
  prestigePanel = new PrestigePanel(player123,15,15,width-30,height-30,color(25,25,200,150),10,3,color(255),1);
  optionPanel = new OptionPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  panelParty = new PanelParty(width - 250,15,235,300,color(25,25,200,150),2,10,color(255),1);
  characterConfigurePanel = new CharacterConfigurePanel(player123,width/2 - 225,height/2 -225,450,450,color(25,25,200,150),10,2,color(255),1);
  recruitConfigurePanel = new RecruitConfigurePanel(width/2 - 225,height/2 -225,450,450,color(25,25,200,150),10,2,color(255),1);
  prestigeTavernPanel = new PrestigeTavernPanel(width/2 - 225,height/2 -225,450,450,color(25,25,200,150),10,2,color(255),1);
  recruitPanel = new RecruitPanel(width - 250,height- 125,235,110,color(25,25,200,150),10,3,color(255),1,recruitConfigurePanel);
  characterPanel = new CharacterPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1,characterConfigurePanel,player123.Level);
  questPanel = new QuestPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  inventoryPanel = new InventoryPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1,player123);
  tavernPanel = new TavernPanel(prestigeTavernPanel,15,15,200,height-30,color(25,25,200,150),10,2,color(255),1,player123);
  dungeonPanel = new DungeonPanel(player123,areaDungeon,15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
  leftTabUI = new LeftTabUI(223,15,27,height-30,5,color(25,25,200,150),0,2,2,0,color(255),14,color(255),1,90);
  
  
  //initialize the areas 
  areaTavern = new AreaTavern("The Tavern Inn","Drink up and rest before you go to battle!",color(255),player123);
  currentAreaDungeon = areaDungeon.get(0);
}

//I must put time event in here

//i've divided the functions of the game between drawing, actionEvent and TimeEvent 
//the game would be disabled if you disable both time and action events
//I think i divide the events because i could have used multi threading and it made my work slightly easyer to read
void TimeEvent() {
  
  //plays all TimeEvent for player
  for(int n = 0; n < aPlayer.size(); n++) {
    aPlayer.get(n).TimeEvent();
  } 
  

  //plays time even for the GUI 
  characterPanel.TimeEvent(player123);
  tavernPanel.TimeEvent(player123);
  recruitPanel.TimeEvent(player123);
  panelParty.TimeEvent();
  dungeonPanel.TimeEvent();
  
  
  //disabled
  for(int n = 0; n < goldenCookie.size();n++) {
    goldenCookie.get(n).TimeEvent();
  }
  
  
  //temp
  //removes the text if theres too much
  //it will remove the oldest one
  if(popText.size() > 10) {
    popText.remove(0);
  }
  
  //temp
  //if the text reachs its life time it will delete itself
  for(int n = 0; n < popText.size();n++) {
    popText.get(n).TimeEvent();
    if(popText.get(n).Active == false) {
      popText.remove(n);
    }
  }
  
  //very similar to popText
  if(createMovingObject.size() > 10) {
    createMovingObject.remove(0);
  }
  
  //temp
  //very simiilar to poptext
  for(int n = 0; n < createMovingObject.size(); n++) {
    createMovingObject.get(n).TimeEvent();
    if(createMovingObject.get(n).duration < createMovingObject.get(n).currentDuration) {
      createMovingObject.remove(n);
    }
  }
  
  //plays time event on the dungeon area
  currentAreaDungeon.TimeEvent(aPlayer,player123);
  
  //plays the saving event in SaveGame
  saveGame(player123,areaDungeon);
}

void ActionEvent() {
  goldSmithEdition.ActionEvent();
  //this was used for golden cookie, dissabled.
  
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
  //temp
  
  //plays actionevent for moving objects 
  for(int n = 0; n < createMovingObject.size(); n++) {
    createMovingObject.get(n).ActionEvent();
  }
  
  //plays action event for players 
  for(int n = 0; n < aPlayer.size(); n++) {
    aPlayer.get(n).ActionEvent(currentAreaDungeon.en);
  }
  
  
  //plays action event for GUI
  characterPanel.ActionEvent(player123);
  tavernPanel.ActionEvent(aPlayer,player123);
  optionPanel.ActionEvent(player123,areaDungeon);
  recruitPanel.ActionEvent(player123,currentAreaDungeon.en);
  inventoryPanel.ActionEvent();
  dungeonPanel.ActionEvent();
  leftTabUI.ActionEvent(player123);
  panelParty.ActionEvent();
  
  


  

  
  //Inable this indented code for debugging and then click on your character too see what happens
  //temp
                            //if(player123.UnitAsButton.wasClicked) {
                            // //public BuffIcon(String title,String infoDescription,float duration,Unit un,long BonusVit,long BonusStr,long BonusEnd,long BonusAgi,long BonusDex,long BonusRegHp,long  BonusDef,long  BonusDmg,long BonusHp,long BonusCrit,long BonusCritDmg, float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,float textSize,color lineColor,float lineSize) {
                            // for(int n = 0; n < aPlayer.size(); n++) {
                            //   if(random(100) > 50) {
                            //     aPlayer.get(n).buffIcon.add(new BuffIcon("Lesser Healing Potion","Recover 60 hp over 5 seconds.",5,aPlayer.get(n),0.1,0.1,0.1,0,0,0,0,0,12,0,0,0,0,0,1,1,15,15,2,color(200,25,25),color(255),color(25,255,25),1));
                            //   }
                            // }
                            // player123.UnitAsButton.wasClicked = false;
                            //}
  
  
  //remove guild unit 
  for(int n = 0; n < aPlayer.size(); n++) {
    for(int i = 0; i < aPlayer.get(n).guildUnit.size(); i++) {
      if(aPlayer.get(n).guildUnit.get(i).UnitRemove) {
        aPlayer.get(n).guildUnit.remove(i);
      }
    }
  }
  
  //disable buffs if it reachs time limit 
  for(int n = 0; n < aPlayer.size(); n++) {
    for(int i = 0; i < aPlayer.get(n).buffIcon.size();i++) {
      aPlayer.get(n).buffIcon.get(i).ActionEvent(player123);
      if(aPlayer.get(n).buffIcon.get(i).Active == false) {
        aPlayer.get(n).buffIcon.remove(i);
      }
    }
  }
  
  
  //disabled
  for(int n = 0; n < goldenCookie.size(); n++) {
    goldenCookie.get(n).GiveValue(player123);
    if(goldenCookie.get(n).Alive == false) {
      goldenCookie.remove(n);
    }
  }
  
  //plays action event for area
  areaTavern.ActionEvent();
  currentAreaDungeon.ActionEvent(aPlayer,player123);
}



//draws stuff
void draw() {
  background(0);
  //prestigePanel is still in testing
  if(prestigePanel.show) {
    prestigePanel.ActionEvent();
    prestigePanel.TimeEvent();
    prestigePanel.draw();
    prestigePanel.HoverEvent();
  } else {
    
    //where the game draw 
    
    //plays both time and action event
    ActionEvent();
    TimeEvent();

    //draws the Area background
    areaTavern.BackgoundImage();
    currentAreaDungeon.BackgoundImage();
    
    
    //draws the buttons or bars of the Object
    //area
    currentAreaDungeon.draw();
    areaTavern.draw();
    
    //draws createMovingObject
    for(int n = 0;n < createMovingObject.size(); n++) {
      createMovingObject.get(n).draw();
    }
    
    
    //draws player 
    //unit
    player123.draw();  
    
    
    
    
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
    
    
    //golden cookie
    for(int n = 0; n < goldenCookie.size();n++) {
      goldenCookie.get(n).draw();
    }
    
    //popText
    //temp
    for(int n = 0; n < popText.size(); n++) {
      popText.get(n).draw();
    }
    
    
    //the hoverEvent
    //ive divide the drawing events into 2 events
    //so when your mouse hover over objects, some text will appear
    //however this effect can easy be achieved if i just used the Z axis 
    
    //hover 
    areaTavern.HoverEvent();
    currentAreaDungeon.HoverEvent();
    
    player123.HoverEvent();
    
    characterPanel.HoverEvent();
    tavernPanel.HoverEvent();
    recruitPanel.HoverEvent(player123);
    
    dungeonPanel.HoverEvent();
    inventoryPanel.HoverEvent();
    
    
    //quite some old code here
    //was meant to be in the action event
    for(int n = 0; n < panelParty.PPP.size();n++) {
      if(panelParty.PPP.get(n).DeathTimerButton != null) {
        Player pl = panelParty.PPP.get(n).pl;
        panelParty.PPP.get(n).HoverEvent();
        panelParty.PPP.get(n).DeathTimerButton.hoverInfo.updateDescription("Dead",pl.Name+ " is dead! Tap to revive faster. "+ round(pl.CurrentDeathTimer)+ " seconds remaining.");
      }
    }  
    
    //disabled
    for(int n = 0; n < goldenCookie.size();n++) {
      goldenCookie.get(n).HoverEvent();
    }  
    
    //plays hover event for buffs
    for(int n = 0; n < aPlayer.size(); n++) {
      for(int i = 0; i < aPlayer.get(n).buffIcon.size();i++) {
        if (i < 11) {
          aPlayer.get(n).buffIcon.get(i).HoverEvent();
        }
      }
    }
  
  }
  
  //debugging
  
  //textAlign(TOP,TOP);
  //fill(200,25,25);
  //textSize(25);
  //text((int)(millis()/1000)+ "",0,0);
  //text((int)frameRate+ "",width-textWidth((int)frameRate+""),0);
  //text(mouseX + "             " + mouseY,0,50);
}


//mouseReleased event
void mouseReleased() {
  if(prestigePanel.show) {
    prestigePanel.mouseReleased();
  } else {
    
    
    goldSmithEdition.mouseReleased();
    
    
    
    currentAreaDungeon.mouseReleased();
    player123.UnitAsButton.mouseReleased();
    
    optionPanel.mouseReleased();
    characterPanel.mouseReleased();
    tavernPanel.mouseReleased();
    leftTabUI.mouseReleased();
    recruitPanel.mouseReleased(player123);
    inventoryPanel.mouseReleased();
    
    
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
  
}
//mousePressed event
void mousePressed() {
  if(prestigePanel.show) {
    prestigePanel.mousePressed();
  } else {

    goldSmithEdition.mousePressed();
    
    
    
    currentAreaDungeon.mousePressed();
    player123.UnitAsButton.mousePressed();
    characterPanel.mousePressed();
    tavernPanel.mousePressed();
    leftTabUI.mousePressed();
    recruitPanel.mousePressed(player123);
    optionPanel.mousePressed();
    areaTavern.mousePressed();
    inventoryPanel.mousePressed();
    
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
  
}
//keyTyped event
void keyTyped() {
  characterConfigurePanel.keyTyped();
}
//scrolling event
void mouseWheel(MouseEvent event) {
  if(prestigePanel.show) { 
    prestigePanel.mouseWheel(event);
  } else {
    inventoryPanel.mouseWheel(event);
    characterPanel.mouseWheel(event);
    tavernPanel.mouseWheel(event);
    recruitPanel.mouseWheel(event);
  }
}