import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

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

import com.google.gson.annotations.*; 
import com.google.gson.*; 
import com.google.gson.internal.*; 
import com.google.gson.internal.bind.*; 
import com.google.gson.internal.bind.util.*; 
import com.google.gson.reflect.*; 
import com.google.gson.stream.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class JackyClicker extends PApplet {

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
public void setup() {
  //loads all .png files to memory
  GetPath(dataPath(""),ListImages);
  //you can 
  
  //fullScreen(JAVA2D);
  
  
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
public void TimeEvent() {

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
public void ActionEvent() {
  
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
public void draw() {
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
public void mouseReleased() {
  
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
public void mousePressed() {
  
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
public void keyTyped() {
  characterConfigurePanel.keyTyped();
}
//plays mouse wheel for scroll bar
public void mouseWheel(MouseEvent event) {
  characterPanel.mouseWheel(event);
  tavernPanel.mouseWheel(event);
  recruitPanel.mouseWheel(event);
}
//Creates a generic area for the game
public class Area {
  boolean HaveEnemy;
  @Expose // @Expose is used for GsonBuilder so it will serialize/deserialize this variable
  String Name;
  @Expose
  String Description; 
  
  //creates a button for on the bottom,  middle - right of the screen
  Button AreaButton;
  
  int textColor;
  //position
  float x;
  float y;
  
  //triggering event
  boolean Active;
  
  
  //I use hashMap to allocate the image to memory, so its more important to keep string than image itself
  @Expose
  String backgroundImageName;
  
  PImage backgroundImage;
  
  //general stats of the area 
  @Expose
  float vit,str,end,agi,dex;
  //attack speed of the general area
  @Expose
  float as;
  //currency dropped for the general area 
  @Expose
  float exp,zen;
  //general prestige currency for the area 
  @Expose
  float pres;
  //general difficulty of the area
  @Expose
  float dif;
  //spawn interval of the area 
  @Expose
  float EnemySpawnTimer;
  
  //creates a panel when you clicked on the area button to show the statistics for the general area
  AreaButtonPanel areaButtonPanel;
  //condstructor
  public Area(String Name,String Description,int textColor) {
    this.Name = Name;
    this.Description = Description;
    this.textColor = textColor;
    textSize(20);
    x = width - 275 - textWidth(Name);
    y = height-85;
    
    textSize(20);
    //initialize the button
    AreaButton = new Button(Name,Description,x,y,textWidth(Name),30,3,color(100),textColor,16,color(60),3);
    //Area area,float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize
    textSize(20);
    //initallize the panel
    areaButtonPanel = new AreaButtonPanel(this,x + textWidth(Name) - 200,y - 220,200,210,color(25,25,200,150),10,3,color(255),1);
  }
  
  //empty?
  public void TimeEvent() {
    
  }
  
  //plays action event for the button
  public void ActionEvent() {
    if(Active) {
      if(AreaButton.wasClicked) {
        AreaButton.wasClicked = false;
        areaButtonPanel.show = ! areaButtonPanel.show;
      }
    }
  }
  
  //plays the hover event for the button
  public void HoverEvent() {
    if(Active) {
      AreaButton.hoverInfo.draw();
    }
  }
  
  //draws background image
  public void BackgoundImage() {
    if(Active) {
      if(backgroundImage != null) {
      image(backgroundImage,width/2 - backgroundImage.width/2,height/2 - backgroundImage.height/2);
      }
    }
  }
  
  //draws the button and the panel (the panel is only drawn when you clicke the button)
  public void draw() {
    if(Active) {
      AreaButton.draw();
      areaButtonPanel.draw();
    }
  }
  
  //plays this event
  public void mousePressed() {
    if(Active) {
      AreaButton.mousePressed();
    }
  }
  
  //plays that event
  public void mouseReleased() {
    if(Active) {
      AreaButton.mouseReleased();
    }
  }
  
}
//reform GeneralPanel to specific for AreaButtonPanel 
public class AreaButtonPanel extends GeneralPanel {
  Area area;
  public AreaButtonPanel(Area area,float x,float y,float sizeX,float sizeY,int background,float padding, float curve,int lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    this.area = area;
  }
  //draw
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
  //display stats of the general area
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
//reforms Area to a area that can spawn enemies 
public class AreaDungeon extends Area {
  
  ValueBar MileBar;
  
  Enemy en;
  
  //saves the MileMax because that represent the hard difficulty of the game 
  @Expose
  float MileMax;
  //represent the current difficulty
  @Expose
  float MileCurrent;
  
  //a teleport port for the player
  @Expose
  float[] MileStone = new float[8];
  
  //find length for each milestone
  @Expose
  boolean[] PassMileStone = new boolean[MileStone.length];
  
  
  
  @Expose
  boolean BossMileStone; //test if user is at a mile stone
  @Expose
  boolean ReachedBoss; //will spawn a boss model enemy 
  @Expose
  boolean BossSpawned; //to check if the boss exist 
  @Expose
  boolean DungeonLordSpawn; //realmlord* its the last boss of the realm
  //important
  @Expose
  boolean DungeonLordKilled; // check if the realm lord was killed
  
  @Expose
  float EnemySpawnTimerCurrent; // ..
  
  @Expose
  boolean GaveMilePoints; //..
  
  @Expose
  int barColor;
  
  //temp
  String name,des;
  PImage img;
  
  //constructor
  public AreaDungeon(String Name,String Description,int textColor,String backgroundImageName,float MileMax,float MileCurrent,int barColor,float vit,float str,float end,float agi,float dex,float as,float exp,float zen,float pres, float dif,float EnemySpawnTimer) {
    super(Name,Description,textColor);
    this.MileMax = MileMax;
    HaveEnemy = true;
    
    this.backgroundImageName = backgroundImageName;
    this.MileCurrent = MileCurrent;
    this.barColor = barColor;
    this.vit = vit;
    this.str = str;
    this.end = end;
    this.agi = agi;
    this.as = as;
    this.dex = dex;
    this.exp = exp;
    this.zen = zen;
    this.pres = pres;
    this.dif = dif;
    
    this.backgroundImage = loadImage(backgroundImageName);
    for(int n = 0; n < MileStone.length; n ++) {
      MileStone[n] = (MileMax/MileStone.length)*n;
    }
    
    PassMileStone[0] = true;
    
    this.EnemySpawnTimer = EnemySpawnTimer;
    
    MileBar = new ValueBar("Mile Bar","This shows your progress in this dungeon. Leaving the Dungeon will Reset your Miles!", 1000,275,height-45,width - 550,10,color(0),2,color(255),1,color(barColor));
    
    AreaButton.textColor = barColor;
    //creates an enemy
    createEnemy();
  }
  
  //this constructor is used for loading the realm
  public AreaDungeon(AreaDungeon ad) {
    this(ad. Name,ad. Description,ad. textColor,ad.backgroundImageName,ad. MileMax,ad. MileCurrent,ad. barColor,ad. vit,ad. str,ad. end,ad. agi,ad. dex,ad. as,ad. exp,ad. zen,ad. pres, ad. dif,ad. EnemySpawnTimer);
    for(int n = 0; n < ad.MileStone.length ; n++) {
      PassMileStone[n] = ad.PassMileStone[n];
    }
    DungeonLordKilled = ad.DungeonLordKilled;
  }
  
  
  //plays time events 
  public void TimeEvent(ArrayList<Player> pl,Player thisPlayer) {
    if(Active) {
      super.TimeEvent();
      

      en.TimeEvent();

      MileBarUpDate(pl,thisPlayer);

      
      if(en.Alive == false) {
        en.UnitPlaced = false;
      }
      
      enemyRespawn();
      
    }
  }
  
  //when player teleports to that mile
  public void setMile(float mile) {
    MileCurrent = mile;
    BossMileStone = false;
    ReachedBoss = false;
    BossMileStone = false;    
    DungeonLordSpawn = false;
    BossSpawned = false;
    createEnemy();
  }
  
  
  //plays action event
  public void ActionEvent(ArrayList<Player> pl,Player thisPlayer) {
    if(Active) {
      super.ActionEvent();
      en.ActionEvent(pl,thisPlayer);
      
      if(BossSpawned) {
        if(en.Alive == false && DungeonLordSpawn) {
          DungeonLordKilled = true;
          DungeonLordSpawn = false;
          BossSpawned = false;
        }
      }
      
      if(BossSpawned && en.Alive == false) {
        BossMileStone = false;
        ReachedBoss = false;
        BossSpawned = false;
        for(int n = 0; n < MileStone.length; n++) {
          if(MileCurrent > MileStone[n]) {
            PassMileStone[n] = true;
          }
        }
      }
      
    }
  }
  
  //recreates the enemy
  public void enemyRespawn() {

    
    if(en.Alive == false) {
      EnemySpawnTimerCurrent += 1/frameRate;
      
      
      if(GaveMilePoints == false) {
        if(MileCurrent < MileMax) {
          MileCurrent += 0.5f;
        }
        GaveMilePoints = true;
      }
    }
    
    
    if (EnemySpawnTimerCurrent > EnemySpawnTimer) {
      
      if(ReachedBoss) {
        BossMileStone = true;
      }
      createEnemy();
      en.UnitPlaced = true;
      en.Alive = true;
      GaveMilePoints = false;
      EnemySpawnTimerCurrent = 0;

    }
    
  }
  
  ///creates the enemy 
  public void createEnemy() {
    randomEnemyGraphics();
    
    double m = pow(dif,MileCurrent);
    if(DungeonLordSpawn) { 
      if(random(100) > 50) {
        en = new Enemy("Realm Lord","I am the guardian of this realm...",width/2 -100,height/2 - 200,(long)(10*m),(long)((543*vit)*m),(long)((21*str)*m),(long)((11*end)*m),(long)((1*agi)*m),(long)((1*dex)*m),(double)as,(long)((500*exp)*m),(long)((1000*zen)*m),(long)((10+pres)*m));
        en.UnitAsButton.background = color(random(255),random(255),random(255));
      } else {
        en = new Enemy("D Wizard","Another one.",width/2 -100,height/2 - 200,(long)(10*m),(long)((543*vit)*m),(long)((21*str)*m),(long)((11*end)*m),(long)((1*agi)*m),(long)((1*dex)*m),(double)as,(long)((500*exp)*m),(long)((1000*zen)*m),(long)((10+pres)*m),LoadAllImage.get("DarkMagician.png"),35,color(201,201,51));
      }
      BossSpawned = true;
      en.RealmLord = true;
    } else if(BossMileStone) {
      en = new Enemy("Boss","",width/2 -100,height/2 - 200,(long)(5*m),(long)((167*vit)*m),(long)((19*str)*m),(long)((11*end)*m),(long)((1*agi)*m),(long)((1*dex)*m),(double)as*3,(long)((50*exp)*m),(long)((100*zen)*m),(long)((1+pres)*m));
      en.UnitAsButton.background = color(51,0,102);
      en.UnitAsButton.textSize = 35;
      BossSpawned = true;
    } else {
      
      en = new Enemy(name,des,width/2 -100,height/2 - 200,(long)(1*m),(long)((12*vit)*m),(long)((11*str)*m),(long)((10*end)*m),(long)((1*agi)*m),(long)((1*dex)*m),(double)as,(long)((5*exp)*m),(long)((10*zen)*m),(long)(pres*m),img,25,color(255));
    }
    
    EasterEgg(m);
    
  }
  
  
  //just a list to spawn random graphics for enemy
  public void randomEnemyGraphics() {
    switch(round(random(5))) {
      case 0:
      name = "Prinny";
      des = "Dood.";
      img = LoadAllImage.get("Prinny.png");
      break;
      case 1:
      name = "Wrinkler";
      des = "";
      img = LoadAllImage.get("Wrinkler.png");
      break;
      case 2:
      name = "Cookie Clicker";
      des = "http:// orteil.dashnet.org/ cookieclicker/";
      img = LoadAllImage.get("Cookie.png");      
      break;
      case 3:
      name = "Prinny";
      des = "Dood.";
      img = LoadAllImage.get("Prinny.png");
      break;
      case 4:
      name = "Goblin";
      des = "Not even five people could kill me!";
      img = LoadAllImage.get("Goblin.png");      
      break;
      case 5:
      name = "Pikachu";
      des = "";
      img = LoadAllImage.get("Pikachu.png");         
      break;
      case 6: 
      break;
      case 7:
      break;
      case 8:
      break;
      case 9:
      break;
      case 10:
      break;
      case 11:
      break;
      case 12:
      break;
      case 13:
      break;
      case 14:
      break;
    }
  }
  
  //..
  public void EasterEgg(double m) {
    if(Name.equals("Cookie Realm")) {
      en = new Enemy("Cookie Clicker","http:// orteil.dashnet.org/ cookieclicker/",width/2 -100,height/2 - 200,(long)(1*m),012.5f,0,(long)((9*end)*m),0,0,0,(long)((5*exp)*m),(long)((10*zen)*m),0,LoadAllImage.get("Cookie.png"),25,color(255));
    } else if(Name.equals("GoldSmiths")) {
      en = new Enemy("Jeremy Corbyn","Everybody Loves me!",width/2 -100,height/2 - 200,(long)(1*m),12.5f,0,0,0,0,0,0,0,0,LoadAllImage.get("JeremyCorbyn.png"),25,color(255));
    }
  }
  
  
  //updates the mile bar
  public void MileBarUpDate(ArrayList<Player> pl, Player thisPlayer) {
    MileBar.updateBar(MileCurrent,MileMax);
    boolean leastOnePlayerAlive = false;
    
    for(int n = 0; n < pl.size();n++) {
      if(pl.get(n).Alive) {
        leastOnePlayerAlive = true;
        break;
      }
    }
    
    if(MileCurrent < MileMax && leastOnePlayerAlive) {
      if(BossSpawned == false) {
        MileCurrent += 1/( frameRate*5);
      }
    }
    
    for(int n = 0; n < MileStone.length ; n++) {
      if(MileCurrent > MileStone[n] && PassMileStone[n] == false) {
        //PassMileStone[n] = true;
        ReachedBoss = true;
      }
    }
    
    if( MileCurrent > MileMax ) {
      MileCurrent = MileMax;
      if(DungeonLordKilled == false) {
        DungeonLordSpawn = true;
      }
    }
    
  }
  
  //plays hover event
  @Override
  public void HoverEvent() {
    if(Active) {
      super.HoverEvent();
      MileBar.BarInfo.draw();
      en.HoverEvent();
      //en.UnitAsButton.hoverInfo.draw();
    }
  }
  
  //draws the enemy and mile bar
  @Override
  public void draw() {
    if(Active) {
      en.draw();
      super.draw();
      MileBar.draw();
    }
  }
  
  //plays this event
  @Override
  public void mousePressed() {
    if(Active) {
      super.mousePressed();
      en.UnitAsButton.mousePressed();
    }
  }
  
  //..
  @Override
  public void mouseReleased() {
    if(Active) {
      super.mouseReleased();
      en.UnitAsButton.mouseReleased();
    }
  }  
  
}
//slightly mold Area specific for the tavern
public class AreaTavern extends Area {
  public AreaTavern(String Name,String Description,int textColor,Player thisPlayer) {
    super(Name,Description,textColor);
    HaveEnemy = false;
    Active = true;
    backgroundImage = loadImage("BackgroundImage/Tavern.jpg");
  }
  
}
//A unique child class for this unit
public class Assassin extends GuildUnit {
  //..
  public Assassin(float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(uVit, uStr, uEnd, uAgi, uDex, exp);
    Name = "Assassin";
    Description = "deals 30% of the enemy's current health. Cost 25 Mood (must be above moody)";
    MoodCriticalPoint = 70;
    MoodSpeed = 0.04f;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
  }
  
  //used for loading back ur recruit 
  public Assassin(GuildUnit gu) {
    this(gu. uVit,gu. uStr,gu. uEnd,gu. uAgi,gu. uDex,gu. Exp);
    this.currentMood = gu.currentMood;  
  }
  
  //plays time event
  @Override
  public void TimeEvent(Player pl) {
    super.TimeEvent(pl);
  }
  
  //plays action event
  @Override
  public void ActionEvent(Enemy en,Player pl) {
    //a SUPA
    super.ActionEvent(en, pl);
    
    //triggers this recruites effect 
    if(UnitAsButton.wasClicked) {
      UnitAsButton.wasClicked = false;
      if(Moody == false && Strike == false) {
        if(currentMood >=  25) {
          if(en.UnitPlaced) {
            popText.add(new PopText((long)(en.CurrentHp*0.2f)+"", 1, 1, mouseX,mouseY,30,color(255)));
            en.CurrentHp = en.CurrentHp*0.7f;
            currentMood -= 25;
          } else {
            popText.add(new PopText("There's no one to cut...", 1, 1, mouseX,mouseY,16,color(200,25,25)));
          }
        } else {
          popText.add(new PopText("Go and die...", 1, 1, mouseX,mouseY,16,color(200,25,25)));
        }
      } else {
        popText.add(new PopText("I will cut you...", 1, 1, mouseX,mouseY,16,color(200,25,25)));
      }
    }
  }
  
  
  
  
  //draws it 
  public void draw() {
    super.draw();
  }
  
  //..
  public void mousePressed() {
    UnitAsButton.mousePressed();
  }
  //..
  public void mouseReleased() {
    UnitAsButton.mouseReleased();
  }
}
//how Buffs are created
public class BuffIcon {
  //nothing is saved here because buffs are temp for the game in general
  float x,y;
  float sizeX,sizeY;
  String title;
  float textSize;
  int background,textColor;
  HoverInfo BuffInfo;
  String infoDescription;
  int lineColor;
  float lineSize;
  float[] curve = new float[4];
  
  
  float duration;
  
  boolean Active;
  
  //possible values for this buff to be given to the player
  long BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex;
  long rawBonusRegHp, rawBonusDef, rawBonusDmg,rawBonusHp,rawBonusCrit, rawBonusCritDmg;
  long statBonusRegHp, statBonusDef, statBonusDmg,statBonusHp,statBonusCrit, statBonusCritDmg;
  float BonusExp;
  float BonusZeny;
  float BonusPrestige;
  
  boolean Gave;
  //..
  public BuffIcon(String title,String infoDescription,float duration,Unit un,float BonusExp,float BonusZeny,float BonusPrestige,long BonusVit,long BonusStr,long BonusEnd,long BonusAgi,long BonusDex,long rawBonusRegHp,long  rawBonusDef,long  rawBonusDmg,long rawBonusHp,long rawBonusCrit,long rawBonusCritDmg, float x,float y,float sizeX,float sizeY,float curve,int background,int textColor,int lineColor,float lineSize) {
    this.title = title;
    this.infoDescription = infoDescription;
    this.duration = duration;
    Active = true;
    //this.un = un;
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    for(int n = 0; n < 4; n++) {
      this.curve[n] = curve;
    }
    this.background = background;
    this.textColor = textColor;
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    
    this.BonusExp = BonusExp;
    this.BonusZeny = BonusZeny;
    this.BonusPrestige = BonusPrestige;
    
    this.BonusVit = BonusVit;
    this.BonusStr = BonusStr;
    this.BonusEnd = BonusEnd;
    this.BonusAgi = BonusAgi;
    this.BonusDex = BonusDex;
    
    this.rawBonusRegHp = rawBonusRegHp;
    this.rawBonusDef = rawBonusDef;
    this.rawBonusDmg = rawBonusDmg;
    this.rawBonusHp = rawBonusHp;
    this.rawBonusCrit = rawBonusCrit;
    this.rawBonusCritDmg = rawBonusCritDmg;    
    
    
    //initialise a hover info
    BuffInfo = new HoverInfo(title,infoDescription,14,color(255),225,7,color(25,25,200,150),x,y,sizeX,sizeY,5,1,color(255));
  }
  //draws hover event
  public void HoverEvent() {
    BuffInfo.draw();
  }
  //plays action
  public void ActionEvent(Unit un) {
    GiveValueToUnit(un);
    ActiveOffPlayerDead(un);
  }
  
  //plays time
  public void TimeEvent(Unit un) {
    BuffTimer(un);
    BuffInfo.updateDescription(title,infoDescription + " " + round(duration) + " seconds remaining.");
  }
  
  //a action event to che kthe buff timer
  public void BuffTimer(Unit un) {
    if(duration > 0) {
    duration -= 1/frameRate;
    } else {
      Active = false;
      GiveValueToUnit(un);
    }
  }
  
  //removes the buff if te player is dead
  public void ActiveOffPlayerDead(Unit un) {
    if(un.Alive == false) {
      Active = false;
      GiveValueToUnit(un);
    }
  }
  
  //updates the buff updatePosition
  public void updatePosition(float x,float y) {
    this.x = x;
    this.y = y;
    BuffInfo.updatePosition(x,y);
  }
  
  //gives the values to the player  
  public void GiveValueToUnit(Unit un) {
    if(Active && Gave == false) {
      
      un.BonusExp += BonusExp;
      un.BonusZeny += BonusZeny;
      un.BonusPrestige += BonusPrestige;
      
      un.BonusVit += BonusVit;
      un.BonusStr += BonusStr;
      un.BonusEnd += BonusEnd;
      un.BonusAgi += BonusAgi;
      un.BonusDex += BonusDex;
      
      un.rawBonusRegHp += rawBonusRegHp;
      un.rawBonusDef += rawBonusDef;
      un.rawBonusDmg += rawBonusDmg;
      un.rawBonusHp += rawBonusHp;
      un.rawBonusCrit += rawBonusCrit;
      un.rawBonusCritDmg += rawBonusCritDmg;
      Gave = true;
    } else if(Active == false && Gave == true) {
      Gave = false;
      
      un.BonusExp -= BonusExp;
      un.BonusZeny -= BonusZeny;
      un.BonusPrestige -= BonusPrestige;
      
      
      un.BonusVit -= BonusVit;
      un.BonusStr -= BonusStr;
      un.BonusEnd -= BonusEnd;
      un.BonusAgi -= BonusAgi;
      un.BonusDex -= BonusDex;
      
      un.rawBonusRegHp -= rawBonusRegHp;
      un.rawBonusDef -= rawBonusDef;
      un.rawBonusDmg -= rawBonusDmg;
      un.rawBonusHp -= rawBonusHp;
      un.rawBonusCrit -= rawBonusCrit;
      un.rawBonusCritDmg -= rawBonusCritDmg;
    }
    
    un.updateStat();
  }
  
  //draws the buff
  public void draw() {
    stroke(lineColor);
    strokeWeight(lineSize);
    
    fill(background);
    rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
    
    fill(255);
    textSize(11);
    textAlign(CENTER,CENTER);
    if(round(duration) < 100) {
      text(round(duration),x +sizeX/2,y +sizeY/2);
    } else {
      text("#",x +sizeX/2,y +sizeY/2);
    }
  }
  
  
}
//creates button
//trigger event 'wasClicked' boolean

//my engine for button
//very important to my work because it was literially based round it 
public class Button {
  float x,y;
  float sizeX,sizeY;
  String title;
  float textSize;
  int background,textColor;
  boolean mPress,mRel;
  
  //trigger event
  boolean wasClicked;
  
  
  HoverInfo hoverInfo;
  String infoDescription;
  int lineColor;
  float lineSize;
  float[] curve = new float[4];
  
  //constructor
  public Button(String title,String infoDescription,float x,float y,float sizeX,float sizeY,int background,int textColor,float textSize) {
    this.title = title;
    this.infoDescription = infoDescription;
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.background = background;
    this.textColor = textColor;
    this.textSize = textSize;
    lineColor = color(0);
    lineSize =1;

    hoverInfo = new HoverInfo(title,infoDescription,14,color(255),225,7,color(25,25,200,180),x,y,sizeX,sizeY,5,1,color(255));
  }
  
  //a more complex 1
  public Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve,int background,int textColor,float textSize,int lineColor,float lineSize) {
    this(text,infoDescription,x,y,sizeX,sizeY,background,textColor,textSize);
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    for(int n = 0 ;n < 4; n++) {
      this.curve[n] = curve;
    }
  }
  //pure custom button
  float textAngle;
  public Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve0,float curve1,float curve2,float curve3,int background,int textColor,float textSize,int lineColor,float lineSize,float textAngle) {
    this(text,infoDescription,x,y,sizeX,sizeY,background,textColor,textSize);
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    this.curve[0] = curve0;
    this.curve[1] = curve1;
    this.curve[2] = curve2;
    this.curve[3] = curve3;
    this.textAngle = textAngle;
    

  }
  PImage image;
  float textY;
  //this constructor ues  a image
  public Button(String title,String infoDescription,float x,float y,float sizeX,float sizeY,float textSize,int textColor,float textY,PImage image) {
    this.title = title;
    this.infoDescription = infoDescription;
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.textSize = textSize;
    this.textColor = textColor;
    this.image = image;
    this.textY = textY;
    hoverInfo = new HoverInfo(title,infoDescription,14,color(255),225,7,color(25,25,200,180),x,y,sizeX,sizeY,5,1,color(255));
  }
  
  //updates the position for the button
  public void UpdatePosition(float x,float y) {
    this.x = x;
    this.y = y;
    hoverInfo.updatePosition(x,y);
  }
  
  //draws 
  public void draw() {
    pushMatrix();
    if(mPress) {
      float tempS = 0.9f;
      scale(tempS,tempS);
      translate((x/tempS)+(((sizeX/2)*(1-tempS))/tempS),(y/tempS)+(((sizeY/2)*(1-tempS))/tempS));
    } else {
      translate(x,y);
    }
    if(image != null) {
      image(image,sizeX*(1-(image.width/sizeX))/2,sizeY*(1-(image.height/sizeY))/2);
    } else {
      stroke(lineColor);
      strokeWeight(lineSize);
      fill(background);
      rect(0,0,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
    }
    popMatrix();
    
    pushMatrix();
    translate(x+sizeX/2,y+sizeY/2);
    rotate(radians(textAngle));
    
    if(image != null) {
      translate(0,textY);
      textAlign(CENTER,CENTER);
    } else {
      textAlign(CENTER,CENTER);
    }
    
    fill(0);
    textSize(textSize);
    text(title,1,1);
    fill(textColor);
    textSize(textSize);
    text(title,0,0);
    
    
    popMatrix();
    
    if(mouseOn()) {
      //cursor(HAND);
    }
    //temp
    check();
  }
  
  //..
  public void mousePressed() {
    if(mouseOn()) {
      mPress = true;
    } else {
      mRel = false;
    }
  }
  //..
  public void mouseReleased() {
    if(mouseOn() && mPress) {
      mRel = true;
    } else {
      mPress = false;
    }
  }
  
  //check if the player done a FULL click
  public void check() {
    if(mPress && mRel) {
      mPress = false;
      mRel = false;
      wasClicked = true;
    }
  }
  
  //check if play's mouse is on the button 
  public boolean mouseOn() {
    if(mouseX > x && mouseX < x+sizeX &&
    mouseY > y && mouseY < y+sizeY) {
      return true;
    } else {
      return false;
    }
  }
  
}
//a panel to configure stats and name 
public class CharacterConfigurePanel extends GeneralPanel {
  
  String[] statName = new String[5];
  String[] statDes = new String[5];
  
  Button[] statButtonPos = new Button[5];
  Button[] statButtonNeg = new Button[5];
  
  
  int[] statRatio = new int[5];
  int statPointsLevel;
  
  Button Close;
  
  Button NameChange;
  Button AcceptNameChange;
  
  //pointer to player
  Player pl;
  
  public CharacterConfigurePanel(Player pl, float x,float y,float sizeX,float sizeY,int background,float padding, float curve,int lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    this.pl = pl;
    Close = new Button("X","",x+sizeX - padding - 25,y+padding,25,25,2,color(150),color(255),12,color(100),3);
    
    AcceptNameChange = new Button("Accept","",x+sizeX - padding - 70,y+padding + 50,70,25,2,color(150),color(255),12,color(100),3);
    

    NameChange = new Button(pl.Name,"Click here to change name. 8 Characters Max.",x+padding,y+padding + 50,200,25,2,color(0,150),color(255),12,color(255),1);
    
    for(int n = 0; n < statButtonPos.length; n++) {
      statButtonPos[n] = new Button("+","",x+sizeX - 20 - padding, sizeY+y -padding - 20 - 25*n,20,20,2,color(150),color(255),13,color(255),1);
      statButtonNeg[n] = new Button("-","",x+sizeX - 20 - padding -25, sizeY+y -padding - 20 - 25*n,20,20,2,color(150),color(255),13,color(255),1);
    }
    
    
    statName[0] = "Vitality";
    statDes[0] = "Each point gives 6 hp and each 40 points gives 1 hp regen."; 
    statName[1] = "Strength";
    statDes[1] = "Each point gives 2 damage."; 
    statName[2] = "Endurance";
    statDes[2] = "Each point gives 1 armor."; 
    statName[3] = "Agility";
    statDes[3] = "Each point gives 1 critial chance. don't upgrade, it does nothing."; 
    statName[4] = "Dexterity";
    statDes[4] = "Each point gives 1 critial damage. don't upgrade, it does nothing.";
  }

  //hover event
  public void HoverEvent() {
    if(show) {
      NameChange.hoverInfo.draw();
    }
  }
  
  //..
  public void ActionEvent() {
    if(show) {
      
      if(Close.wasClicked) {
        Close.wasClicked = false;
        show = false;
      }
      
      if(AcceptNameChange.wasClicked) {
        AcceptNameChange.wasClicked = false;
        NameChange.wasClicked = false;
      }
      
      if(NameChange.wasClicked) {
        NameChange.background = color(50,150);
      } else {
        NameChange.background = color(0,150);
        NameChange.hoverInfo.updateDescription(pl.Name,"Click here to change name. 8 Characters Max.");
      }
      
      
      for(int n = 0; n < statButtonPos.length ;n++){
        if(statButtonPos[n].wasClicked) {
          statButtonPos[n].wasClicked = false;
          
          if(statPointsLevel < 10 && statRatio[n] < 10) {
            statRatio[n] ++;
            statPointsLevel ++;
          }
        }
        if(statButtonNeg[n].wasClicked) {
          statButtonNeg[n].wasClicked = false;
          
          if(statPointsLevel > 0 && statRatio[n] > 0) {
            statRatio[n] --;
            statPointsLevel --;
          }
        }
      }
    }
  }
  
  //..
  public void ApplyStat(int n,int amount) {
    if(pl.StatPoints - amount >= 0) {
      switch(n) {
        case 0:
        pl.CharVit += amount;
        break;
        case 1:
        pl.CharStr += amount;
        break;
        case 2:
        pl.CharEnd += amount;
        break;
        case 3:
        pl.CharAgi += amount;
        break;
        case 4:
        pl.CharDex += amount;
        break;
      }
      pl.StatPoints -= amount;
      pl.updateStat();
    }    
  }
  
  //..
  public void NameChangeKey() {
    if(NameChange.wasClicked) {
      if((PApplet.parseInt(key) >= 65 && PApplet.parseInt(key) <= 90) || (PApplet.parseInt(key) >= 97 && PApplet.parseInt(key) <=122) || (PApplet.parseInt(key) >= 48 && PApplet.parseInt(key) <=57)) {
        if(pl.Name.length()  < 8) {
          pl.Name += Character.toString ((char) key);
        } else {
          popText.add(new PopText("8 Characters Max kokudorei...", 1, 1,NameChange.x + NameChange.sizeX/2,NameChange.y + NameChange.sizeY/2,14,color(200,25,25)));
        }
      } else if(key == BACKSPACE) {
        if(pl.Name.length() > 0) {
          pl.Name = pl.Name.substring(0, pl.Name.length()-1);
        }
      } else if(key == ENTER) {
        NameChange.wasClicked = false;
      }
    }
    
  }
  
  
  //..
  public void draw() {
    if(show) {
      super.draw();
      
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Configuration",x+padding,y+padding);
      
      textSize(14);
      text("Name:",x+padding, y+padding +30);
      NameChange.title = pl.Name;
      NameChange.draw();
      AcceptNameChange.draw();
      Close.draw();
      
      
      
      fill(255);
      textSize(15);
      textAlign(TOP,TOP);
      text("Auto Stat",x+padding,y+sizeY -padding - 170);        
      text("Points:",x+padding,y+sizeY -padding - 145);      
      text(statPointsLevel+" (Max.10)",x+sizeX -padding-textWidth(statPointsLevel+" (Max.10)"),y+sizeY -padding - 145);    
      
      
      fill(255);
      textSize(15);
      textAlign(TOP,TOP);
      
      for(int n = 0; n < statName.length; n++) {
        text(statName[n],x + padding, sizeY+y -padding - 20 - 25*n);
      }
      
      //stat buttons
      
      for(int n = 0;n < statButtonPos.length; n++) {
        statButtonPos[n].draw();
        statButtonNeg[n].draw();
        textSize(15);
        textAlign(TOP,TOP);
        text(statRatio[n]+"",x+sizeX -padding-textWidth(statRatio[n]+"") - 48,y+sizeY -padding  - 20 - 25*n);    
      }
    }
  }
  //..
  public void mousePressed() {
    if(show) {
      NameChange.mousePressed();
      AcceptNameChange.mousePressed();
      Close.mousePressed();
      for(int n = 0;n < statButtonPos.length; n++) {
        statButtonPos[n].mousePressed();
        statButtonNeg[n].mousePressed();
      }
    }    
  }
  //..
  public void mouseReleased() {
    
    if(show) {
      NameChange.mouseReleased();
      AcceptNameChange.mouseReleased();
      Close.mouseReleased();
      for(int n = 0;n < statButtonPos.length; n++) {
        statButtonPos[n].mouseReleased();
        statButtonNeg[n].mouseReleased();
      }
    }      
  }  
  
  //..
  public void keyTyped() {
    if(show) {
      NameChangeKey();
    }
  }
  
}
//..
public class CharacterPanel extends GeneralPanel{
  Button[] statButton = new Button[5];
  String[] statName = new String[5];
  String[] statDes = new String[5];
  
  Button statAuto;
  Button statAutoConfigure;
  
  float moveY = 40;
  float BodyLength = y+sizeY-padding-220;
  
  HoverInfo[] StatInfo = new HoverInfo[5];
  
  
  ScrollBar StatBody;
  
  CharacterConfigurePanel cCP;
  
  boolean AutoOn;
  
  long ChangeInLevel;
  //..
  public CharacterPanel(float x,float y,float sizeX,float sizeY,int background,float padding, float curve,int lineColor,float lineSize,CharacterConfigurePanel cCP,long Level) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    this.cCP = cCP;
    AutoOn = false;
    ChangeInLevel = Level;

    for(int n = 0; n < statButton.length; n++) {
     statButton[n] = new Button("","",x+sizeX - 20 - padding, sizeY+y -padding - 20 - 25*n,20,20,2,color(200),color(255),20,color(255),1);
    }

    statAuto = new Button("A","Automatically allocate your stats every time you level up.",x+sizeX - 20 - padding,sizeY+y -padding - 145,20,20,2,color(200),color(200,25,25),12,color(200,25,25),1);
    statAutoConfigure = new Button("C","Configure your Auto stats.",x+sizeX - 20 - padding - 25,sizeY+y -padding - 145,20,20,2,color(150),color(255),12,color(255),1);
    
    statAuto.hoverInfo.title = "[OFF] Auto";
    statAutoConfigure.hoverInfo.title = "Configure";
    
    statName[0] = "Vitality";
    statDes[0] = "Each point gives 8 hp and each 25 points gives 1 hp regen."; 
    statName[1] = "Strength";
    statDes[1] = "Each point gives 1 damage."; 
    statName[2] = "Endurance";
    statDes[2] = "Each 2 point gives 1 armor."; 
    statName[3] = "Agility";
    statDes[3] = "Each point gives 1 critial rating. (Critical chance is capped at 39.5% for crit rating)"; 
    statName[4] = "Dexterity";
    statDes[4] = "Each point gives 1 critial damage. (Critical Damage gives 15% Increased damage)";

    for(int n = 0; n < StatInfo.length; n++) {
      StatInfo[n] = new HoverInfo(statName[n],statDes[n],15,color(255),175,7,color(25,25,200,150),x + padding, sizeY+y -padding - 20 - 25*n,textWidth(statName[n]),20,5,1,color(255));
    }
    StatBody = new ScrollBar(540,BodyLength,x+sizeX,15,8,sizeY,color(0,150),0,color(255),1);
    
    
  }
  //..
  public void TimeEvent(Player pl) {
    if(show) {
      statButton[0].hoverInfo.updateDescription("Vitality","Base VIT: " + (long)pl.CharVit);
      statButton[1].hoverInfo.updateDescription("Strength","Base STR: " + (long)pl.CharStr);
      statButton[2].hoverInfo.updateDescription("Endurance","Base END: " + (long)pl.CharEnd);
      statButton[3].hoverInfo.updateDescription("Agility","Base AGI: " + (long)pl.CharAgi);
      statButton[4].hoverInfo.updateDescription("Dexterity","Base DEX: " + (long)pl.CharDex);
    }
  }
  
  //..
  public void ActionEvent(Player pl) {
    //auto applys the stat when player lvl up
    if(AutoOn) {
      if(ChangeInLevel < pl.Level) {
        for(int n = 0; n < cCP.statRatio.length; n++) {
          if(cCP.statRatio[n] != 0) {
            ApplyStat(n,pl, (int)(cCP.statRatio[n]*(pl.Level-ChangeInLevel)));
          }
        }
        ChangeInLevel = pl.Level;
      }
    }
    //..
    if(show) {
      
      cCP.ActionEvent();
      
      if(statAuto.wasClicked) {
        statAuto.wasClicked = false;
        AutoOn = !AutoOn;
        if(AutoOn) {
          statAuto.lineColor = color(25,200,25);
          statAuto.textColor = color(25,200,25);
          statAuto.hoverInfo.title = "[ON] Auto";
        } else {
          statAuto.lineColor = color(200,25,25);
          statAuto.textColor = color(200,25,25);
          statAuto.hoverInfo.title = "[OFF] Auto";
        }
      }
      
      
      if(statAutoConfigure.wasClicked) {
        statAutoConfigure.wasClicked = false;
        cCP.show = !cCP.show;
      }
      
      
      HoldStat(pl);
      for(int n = 0; n < statButton.length; n++) {
        if (statButton[n].wasClicked) {
          statButton[n].wasClicked = false;
          ApplyStat(n,pl,1);
        }
      }
    }
  }
  
  //record how long u press
  float HoldTime;
  public void HoldStat(Player pl) {
    for(int n = 0; n < statButton.length; n++) {
      if(statButton[n].mPress ) {
        HoldTime += 1/frameRate;
        if(HoldTime > 0.5f) {
          ApplyStat(n, pl,(int)pow(1+HoldTime,4));
        }
      }
    }
  }
  
  //..
  public void ApplyStat(int n,Player pl,int amount) {
    if(pl.StatPoints - amount >= 0) {
      switch(n) {
        case 0:
        pl.CharVit += amount;
        break;
        case 1:
        pl.CharStr += amount;
        break;
        case 2:
        pl.CharEnd += amount;
        break;
        case 3:
        pl.CharAgi += amount;
        break;
        case 4:
        pl.CharDex += amount;
        break;
      }
      pl.StatPoints -= amount;
      pl.updateStat();
    }    
  }
  
  //..
  public void draw(Player pl) {
    
    if(show) {
      super.draw();
      cCP.draw();
      
      
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Character",x+padding,y+padding);
      
      
      
      textSize(15);
      text(pl.Name,x+padding,y+padding + 20);
      text("Level "+pl.Level,x+sizeX -padding - textWidth("Level "+pl.Level),y+padding + 20);
      
      
      StatBody.draw();
      
      fill(0,150);
      stroke(255);
      strokeWeight(1);
      rect(x+padding -1,y+padding + moveY -1,sizeX-padding*2 + 2,BodyLength +2,3,3,3,3);
      
      
      clip(x+padding,y+padding + moveY,sizeX-padding*2,BodyLength);
      
      TotalContent(pl,0,0 +StatBody.contentMove() + moveY);
      BaseContent(pl,0,75 +StatBody.contentMove() + moveY);
      ItemContent(pl,0,130 +StatBody.contentMove() + moveY);
      BonusContent(pl,0,185 +StatBody.contentMove() + moveY);
      TotalContentAdv(pl,0,240 +StatBody.contentMove() + moveY);
      BaseContentAdv(pl,0,345 +StatBody.contentMove() + moveY);
      ItemContentAdv(pl,0,410 +StatBody.contentMove() + moveY);
      BonusContentAdv(pl,0,475 +StatBody.contentMove() + moveY);
      
      noClip();
      // y = 555
      // y length = 525
      
      fill(255);
      textSize(15);
      textAlign(TOP,TOP);
      text("Points:",x+padding,y+sizeY -padding - 145);      
      text(pl.StatPoints+"",x+sizeX -padding-textWidth(pl.StatPoints+"") - 48,y+sizeY -padding - 145);
      statAuto.draw();
      statAutoConfigure.draw();
      
      
      
      fill(255);
      textSize(15);
      textAlign(TOP,TOP);
      for(int n = 0; n < statName.length; n++) {
        text(statName[n],x + padding, sizeY+y -padding - 20 - 25*n);
      }
      
      //stat buttons
      for(int n = 0;n < statButton.length; n++) {
        statButton[n].draw();
      }
      
    }
  }
  
  //shows info of char
  public void TotalContent(Player pl,float cX,float cY) {
    fill(255);
    textSize(13);
    textAlign(TOP,TOP);
    text("Vitality",x+padding +cX ,y+padding +cY);
    text((long)pl.TotalVit+"",x+sizeX -padding - textWidth((long)pl.TotalVit+"")+cX ,y+padding +cY);
    
    text("Strength",x+padding +cX ,y+padding +cY +15);
    text((long)pl.TotalStr+"",x+sizeX -padding - textWidth((long)pl.TotalStr+"")+cX ,y+padding +cY +15);    
    
    text("Endurance",x+padding +cX ,y+padding +cY +30);
    text((long)pl.TotalEnd+"",x+sizeX -padding - textWidth((long)pl.TotalEnd+"")+cX ,y+padding +cY +30);    
    
    text("Agility",x+padding +cX ,y+padding +cY +45);
    text((long)pl.TotalAgi+"",x+sizeX -padding - textWidth((long)pl.TotalAgi+"")+cX ,y+padding +cY +45);    
    
    text("Dexterity",x+padding +cX ,y+padding +cY +60);
    text((long)pl.TotalDex+"",x+sizeX -padding - textWidth((long)pl.TotalDex+"")+cX ,y+padding +cY +60);    
  }
  
  
  //shows info of char
  public void TotalContentAdv(Player pl,float cX,float cY) {
    fill(255);
    textSize(13);
    textAlign(TOP,TOP);
    text("Health",x+padding +cX ,y+padding +cY);
    text((long)pl.TotalHp+"",x+sizeX -padding - textWidth((long)pl.TotalHp+"")+cX ,y+padding +cY);
    
    text("Damage",x+padding +cX ,y+padding +cY +15);
    text((long)pl.TotalDmg+"",x+sizeX -padding - textWidth((long)pl.TotalDmg+"")+cX ,y+padding +cY +15);    
    
    text("Defence",x+padding +cX ,y+padding +cY +30);
    text((long)pl.TotalDef+"",x+sizeX -padding - textWidth((long)pl.TotalDef+"")+cX ,y+padding +cY +30);    
    
    text("Health Regen",x+padding +cX ,y+padding +cY +45);
    text((long)pl.TotalRegHp+"",x+sizeX -padding - textWidth((long)pl.TotalRegHp+"")+cX ,y+padding +cY +45);    
    
    text("Critical Rating",x+padding +cX ,y+padding +cY +60);
    text((long)pl.TotalCrit+"",x+sizeX -padding - textWidth((long)pl.TotalCrit+"")+cX ,y+padding +cY +60);
    
    double critChance = (4/(double)pl.Level)*((1-(Math.pow(0.975f,4*(pl.TotalCrit + 1)/(double)pl.Level)))/(1-Math.pow(0.975f,4/(double)pl.Level)));
    
    text("Critical Chance",x+padding +cX ,y+padding +cY +75);
    text(String.format("%.1f", critChance + pl.TotalCritPercent)+"%",x+sizeX -padding - textWidth(String.format("%.1f", critChance + pl.TotalCritPercent)+"%")+cX ,y+padding +cY +75);
    
    text("Crit Damage",x+padding +cX ,y+padding +cY +90);
    text((long)pl.TotalCritDmg+"",x+sizeX -padding - textWidth((long)pl.TotalCritDmg+"")+cX ,y+padding +cY +90);       
  }  
  
  //shows info of char
  public void BaseContent(Player pl,float cX,float cY) {
    fill(180);
    textSize(10);
    textAlign(TOP,TOP);
    text("Base Vitality",x+padding +cX ,y+padding +cY);
    text((long)pl.CharVit+"",x+sizeX -padding - textWidth((long)pl.CharVit+"")+cX ,y+padding +cY);
    
    text("Base Strength",x+padding +cX ,y+padding +cY +10);
    text((long)pl.CharStr+"",x+sizeX -padding - textWidth((long)pl.CharStr+"")+cX ,y+padding +cY +10);    
    
    text("Base Endurance",x+padding +cX ,y+padding +cY +20);
    text((long)pl.CharEnd+"",x+sizeX -padding - textWidth((long)pl.CharEnd+"")+cX ,y+padding +cY +20);    
    
    text("Base Agility",x+padding +cX ,y+padding +cY +30);
    text((long)pl.CharAgi+"",x+sizeX -padding - textWidth((long)pl.CharAgi+"")+cX ,y+padding +cY +30);    
    
    text("Base Dexterity",x+padding +cX ,y+padding +cY +40);
    text((long)pl.CharDex+"",x+sizeX -padding - textWidth((long)pl.CharDex+"")+cX ,y+padding +cY +40);    
  }
  //shows info of char
  public void ItemContent(Player pl,float cX,float cY) {
    fill(180);
    textSize(10);
    textAlign(TOP,TOP);
    text("Item Vitality",x+padding +cX ,y+padding +cY);
    text((long)pl.ItemVit+"",x+sizeX -padding - textWidth((long)pl.ItemVit+"")+cX ,y+padding +cY);
    
    text("Item Strength",x+padding +cX ,y+padding +cY +10);
    text((long)pl.ItemStr+"",x+sizeX -padding - textWidth((long)pl.ItemStr+"")+cX ,y+padding +cY +10);    
    
    text("Item Endurance",x+padding +cX ,y+padding +cY +20);
    text((long)pl.ItemEnd+"",x+sizeX -padding - textWidth((long)pl.ItemEnd+"")+cX ,y+padding +cY +20);    
    
    text("Item Agility",x+padding +cX ,y+padding +cY +30);
    text((long)pl.ItemAgi+"",x+sizeX -padding - textWidth((long)pl.ItemAgi+"")+cX ,y+padding +cY +30);    
    
    text("Item Dexterity",x+padding +cX ,y+padding +cY +40);
    text((long)pl.ItemDex+"",x+sizeX -padding - textWidth((long)pl.ItemDex+"")+cX ,y+padding +cY +40);    
  } 
  //shows info of char
  public void BonusContent(Player pl,float cX,float cY) {
    fill(180);
    textSize(10);
    textAlign(TOP,TOP);
    text("Bonus Vitality",x+padding +cX ,y+padding +cY);
    text((long)pl.BonusVit+"",x+sizeX -padding - textWidth((long)pl.BonusVit+"")+cX ,y+padding +cY);
    
    text("Bonus Strength",x+padding +cX ,y+padding +cY +10);
    text((long)pl.BonusStr+"",x+sizeX -padding - textWidth((long)pl.BonusStr+"")+cX ,y+padding +cY +10);    
    
    text("Bonus Endurance",x+padding +cX ,y+padding +cY +20);
    text((long)pl.BonusEnd+"",x+sizeX -padding - textWidth((long)pl.BonusEnd+"")+cX ,y+padding +cY +20);    
    
    text("Bonus Agility",x+padding +cX ,y+padding +cY +30);
    text((long)pl.BonusAgi+"",x+sizeX -padding - textWidth((long)pl.BonusAgi+"")+cX ,y+padding +cY +30);    
    
    text("Bonus Dexterity",x+padding +cX ,y+padding +cY +40);
    text((long)pl.BonusDex+"",x+sizeX -padding - textWidth((long)pl.BonusDex+"")+cX ,y+padding +cY +40);    
  } 
  
  //shows info of char
  public void BaseContentAdv(Player pl,float cX,float cY) {
    fill(180);
    textSize(10);
    textAlign(TOP,TOP);
    text("Base Health",x+padding +cX ,y+padding +cY);
    text((long)pl.CharHp+"",x+sizeX -padding - textWidth((long)pl.CharHp+"")+cX ,y+padding +cY);
    
    text("Base Damage",x+padding +cX ,y+padding +cY +10);
    text((long)pl.CharDmg+"",x+sizeX -padding - textWidth((long)pl.CharDmg+"")+cX ,y+padding +cY +10);    
    
    text("Base Defence",x+padding +cX ,y+padding +cY +20);
    text((long)pl.CharDef+"",x+sizeX -padding - textWidth((long)pl.CharDef+"")+cX ,y+padding +cY +20);    
    
    text("Base Health Regen",x+padding +cX ,y+padding +cY +30);
    text((long)pl.CharRegHp+"",x+sizeX -padding - textWidth((long)pl.CharRegHp+"")+cX ,y+padding +cY +30);    
    
    text("Base Critical Rating",x+padding +cX ,y+padding +cY +40);
    text((long)pl.CharCrit+"",x+sizeX -padding - textWidth((long)pl.CharCrit+"")+cX ,y+padding +cY +40);
    
    text("Base Crit Damage",x+padding +cX ,y+padding +cY +50);
    text((long)pl.CharCritDmg+"",x+sizeX -padding - textWidth((long)pl.CharCritDmg+"")+cX ,y+padding +cY +50);    
  }    
  //shows info of char
  public void ItemContentAdv(Player pl,float cX,float cY) {
    fill(180);
    textSize(10);
    textAlign(TOP,TOP);
    text("Item Health",x+padding +cX ,y+padding +cY);
    text((long)pl.ItemHp+"",x+sizeX -padding - textWidth((long)pl.ItemHp+"")+cX ,y+padding +cY);
    
    text("Item Damage",x+padding +cX ,y+padding +cY +10);
    text((long)pl.ItemDmg+"",x+sizeX -padding - textWidth((long)pl.ItemDmg+"")+cX ,y+padding +cY +10);    
    
    text("Item Defence",x+padding +cX ,y+padding +cY +20);
    text((long)pl.ItemDef+"",x+sizeX -padding - textWidth((long)pl.ItemDef+"")+cX ,y+padding +cY +20);    
    
    text("Item Health Regen",x+padding +cX ,y+padding +cY +30);
    text((long)pl.ItemRegHp+"",x+sizeX -padding - textWidth((long)pl.ItemRegHp+"")+cX ,y+padding +cY +30);    
    
    text("Item Critical Rating",x+padding +cX ,y+padding +cY +40);
    text((long)pl.ItemCrit+"",x+sizeX -padding - textWidth((long)pl.ItemCrit+"")+cX ,y+padding +cY +40);
    
    text("Item Crit Damage",x+padding +cX ,y+padding +cY +50);
    text((long)pl.ItemCritDmg+"",x+sizeX -padding - textWidth((long)pl.ItemCritDmg+"")+cX ,y+padding +cY +50);    
  }     
  //shows info of char
  public void BonusContentAdv(Player pl,float cX,float cY) {
    fill(180);
    textSize(10);
    textAlign(TOP,TOP);
    text("Bonus Health",x+padding +cX ,y+padding +cY);
    text((long)pl.BonusHp+"",x+sizeX -padding - textWidth((long)pl.BonusHp+"")+cX ,y+padding +cY);
    
    text("Bonus Damage",x+padding +cX ,y+padding +cY +10);
    text((long)pl.BonusDmg+"",x+sizeX -padding - textWidth((long)pl.BonusDmg+"")+cX ,y+padding +cY +10);    
    
    text("Bonus Defence",x+padding +cX ,y+padding +cY +20);
    text((long)pl.BonusDef+"",x+sizeX -padding - textWidth((long)pl.BonusDef+"")+cX ,y+padding +cY +20);    
    
    text("Bonus Health Regen",x+padding +cX ,y+padding +cY +30);
    text((long)pl.BonusRegHp+"",x+sizeX -padding - textWidth((long)pl.BonusRegHp+"")+cX ,y+padding +cY +30);    
    
    text("Bonus Critical Rating",x+padding +cX ,y+padding +cY +40);
    text((long)pl.BonusCrit+"",x+sizeX -padding - textWidth((long)pl.BonusCrit+"")+cX ,y+padding +cY +40);
    
    text("Bonus Crit Damage",x+padding +cX ,y+padding +cY +50);
    text((long)pl.BonusCritDmg+"",x+sizeX -padding - textWidth((long)pl.BonusCritDmg+"")+cX ,y+padding +cY +50);    
  }    
  //..
  public void HoverEvent() {
    if(show) {
      cCP.HoverEvent();
      statAuto.hoverInfo.draw();
      statAutoConfigure.hoverInfo.draw();
      for(int n =0; n < statButton.length; n++) {
        statButton[n].hoverInfo.draw();
      }
      for(int n =0; n < StatInfo.length; n++) {
        StatInfo[n].draw();
      }      
    }
  }
  
  //..
  public void mousePressed() {
    if(show) {
      cCP.mousePressed();
      
      StatBody.mousePressed();
      statAuto.mousePressed();
      statAutoConfigure.mousePressed();
      for(int n = 0;n < statButton.length; n++) {
        statButton[n].mousePressed();
      }
    }    
  }
  //..
  public void mouseReleased() {
    
    if(show) {
      cCP.mouseReleased();
      StatBody.mouseReleased();
      statAuto.mouseReleased();
      statAutoConfigure.mouseReleased();
      HoldTime = 0;
      for(int n = 0;n < statButton.length; n++) {
        statButton[n].mouseReleased();
      }
    }      
  }
  //..
  public void mouseWheel(MouseEvent event) {
    if(show) {
      StatBody.mouseWheel(event,x,y,sizeX,sizeY);
    }
  }
  
}
//a temp class created in 16.1.0.8
class CreateMovingObject {
  float x,y;
  float duration;
  float speedX;
  float speedY;
  float angle;
  String ImageNameString;
  PImage Image;
  boolean Bounce;
  //..
  CreateMovingObject(String ImageNameString,float x,float y, float duration,float speed,float angle,boolean Bounce) {
    this.ImageNameString = ImageNameString;
    this.x = x;
    this.y = y;
    this.duration = duration;
    this.speedX = speed*sin(radians(angle));
    this.speedY = speed*cos(radians(angle));
    this.angle = angle;
    this.Bounce = Bounce;
    Image = LoadAllImage.get(ImageNameString);
  }
  //..
  public void TimeEvent() {
    if(duration > 0) {
      duration -= 1/frameRate;
    }
  }
  //moves the object per frame 
  public void MoveObject() {
    if(Bounce) {
      
    } else {
      x += speedX;
      y -= speedY;
    }
  }
  //..
  public void ActionEvent() {
    if(duration > 0) {
      MoveObject();
    }
  }
  //...
  public void draw() {
    if(duration > 0) {
      pushMatrix();
      translate(x,y);
      rotate(radians(angle));
      if(Image != null) {
        image(Image,-Image.width/2,-Image.height/2);
      } else {
        text("NO IMG",0,0);
      }
      popMatrix();
    }
  }
  
}
//..
public class DungeonPanel extends GeneralPanel {
  //pointer
  Player pl;
  
  float moveY = 50;
  float BodyLength = 250;
  
  ArrayList<AreaDungeon> ad;
  
  ArrayList<Button> AreaButton = new ArrayList<Button>();
  
  
  Button[] MileButton = new Button[8];
  long[] MilePrice = new long[MileButton.length];
  float[] MileStone = new float[MileButton.length];
  
  int areaButtonClicked;
  
  //..
  public DungeonPanel(Player pl,ArrayList<AreaDungeon> ad,float x,float y,float sizeX,float sizeY,int background,float padding, float curve,int lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    this.pl = pl;
    this.ad = ad;
    createAreaButton();
    createMileStoneButton();
    
    areaButtonClicked = -1;
  }
  
  //says what it does 
  public void createMileStoneButton() {
    for(int n = 0; n < MileButton.length ; n++ ) {
      MilePrice[n] = 250*n + (long)(n*pow(n,2)); 
      MileStone[n] = 1;
      MileButton[n] = new Button(200*n+"","Start at " + 1 + " Miles. Cost "+ MilePrice[n] + "z",correctMileButtonX(n) ,correctMileButtonY(n),40,40,3,color(150),color(200,25,25),15,color(100),3);
    }    
  }
  
  //repositon the  button X 
  public float correctMileButtonX(int n) {
   return x+padding + (45+2)*(n % 4);
  }
  //repositon the  button Y
  public float correctMileButtonY(int n) {
   return y+sizeY-padding - 120 + floor((45+2)*(n / 4));
  }   
  
  //..
  public void ActionEvent() {
    if(show) {
      clickedAreaButton();
      checkMileButton();
    }
  }
  //..
  public void TimeEvent() {
    if(show) {
      createAreaButton();
    }
  }
  //checks if the player can buy it then tp there on that mile 
  public void checkMileButton() {
    for(int n = 0; n < MileButton.length; n++) {
      if(MileButton[n].wasClicked) {
        MileButton[n].wasClicked = false;
        //areaButtonClicked
        if(areaButtonClicked != -1) {
          if(ad.get(areaButtonClicked).PassMileStone[n]) {
            if(checkMileButtonPrice(n,pl)) {
              popText.add(new PopText("-" +MilePrice[n] + "z", 1, 1, mouseX,mouseY,20,color(150)));
              pl.Zeny -= MilePrice[n];
              movePlayerToDungeon(n);
            } else { 
              popText.add(new PopText("You broke kokudorei...", 1, 1, mouseX,mouseY,20,color(200,25,25)));
            }
          } else {
            popText.add(new PopText("You Must Defeat the Mile Stone Boss!", 1, 1, mouseX,mouseY,20,color(200,25,25)));
          }
        } else {
          popText.add(new PopText("Click on a dungeon first!", 1, 1, mouseX,mouseY,20,color(200,25,25)));
        }
      }
    }
  }
  //moves player to dungeon 
  public void movePlayerToDungeon(int n) {
    ad.get(areaButtonClicked).setMile(MileStone[n]); 
    currentAreaDungeon = ad.get(areaButtonClicked);
    if(MileStone[n] > currentAreaDungeon.MileMax) {
      currentAreaDungeon.MileCurrent = currentAreaDungeon.MileMax;
    } else {
      currentAreaDungeon.MileCurrent = MileStone[n];
    }
    currentAreaDungeon.Active = true;
    areaTavern.Active = false;
    pl.InTavern = false;
  }
  
  
  public boolean checkMileButtonPrice(int ButtonIndex,Player pl) {
    if(pl.Zeny >= MilePrice[ButtonIndex]) {
      return true;
    } else {
      return false;
    }
  }  
  
  public void updateLineColorAreaButton(int i) {
    for(int n = 0; n <  AreaButton.size(); n++) {
      AreaButton.get(n).lineColor = color(100);
    }
    AreaButton.get(i).lineColor = color(25,200,25);
    for(int n = 0; n < MileButton.length; n++) {
      MileStone[n] = (long)((ad.get(i).MileMax/ad.get(i).MileStone.length)*n);
      MileButton[n].title = (long)((ad.get(i).MileMax/ad.get(i).MileStone.length)*n)+"";
      MilePrice[n] = 500*n + (long)(n*pow((ad.get(i).MileMax/1000)*16,pow(n,0.5f))); 
      MileButton[n].hoverInfo.updateDescription((long)((ad.get(i).MileMax/ad.get(i).MileStone.length)*n)+"","Start at " + (long)((ad.get(i).MileMax/ad.get(i).MileStone.length)*n) + " Miles. Cost " + MilePrice[n] + "z");
      if(ad.get(i).PassMileStone[n]) {
        MileButton[n].textColor = color(25,200,25);
      } else {
        MileButton[n].textColor = color(200,25,25);
      }
    }
  }

  
  public void clickedAreaButton() {
    for(int n = 0; n < AreaButton.size(); n++) {
      if(AreaButton.get(n).wasClicked) {
        AreaButton.get(n).wasClicked = false;
        areaButtonClicked = n;
        updateLineColorAreaButton(n);
      }
    }
  }
  
  //temp 
  public void createAreaButton() {
    for(int n = AreaButton.size(); n < ad.size(); n++) {
      AreaButton.add(new Button(ad.get(n).Name,ad.get(n).Description,x+padding,y+padding + moveY + 40*AreaButton.size(),sizeX - padding*2,35,3,color(150),color(ad.get(n).barColor),15,color(100),3));
    }
  }  
  
  
  public void HoverEvent() {
    
    if(show) {
      
      for(int n = 0; n < AreaButton.size();n++) {
        AreaButton.get(n).hoverInfo.draw();
      }
      for(int n = 0; n < MileButton.length ; n++) {
        MileButton[n].hoverInfo.draw();
      }
      
    }
  }
  
  
  
  public void draw(Player pl) {
    if(show) {
      super.draw();
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Dungeon",x+padding,y+padding);     
      
      
      for(int n = 0; n < AreaButton.size();n++) {
        AreaButton.get(n).draw();
      }
      
      for(int n = 0; n < MileButton.length ; n++) {
        MileButton[n].draw();
      }
      
      
      
      stroke(120);
      strokeWeight(2);
      fill(180);
      rect(x+sizeX -padding -13,y+sizeY-padding -15,13,13,0,20,0,20);
      fill(200);
      textSize(13);
      textAlign(TOP,BOTTOM);
      text("Zeny",x+padding,y+sizeY-padding);
      text(pl.Zeny+"",x+sizeX - padding - textWidth(pl.Zeny+"") - 15,y+sizeY - padding);
    }
  }
  
  public void mousePressed() {
    if (show) {
      
      for(int n = 0; n < AreaButton.size();n++) {
        AreaButton.get(n).mousePressed();
      }
      for(int n = 0; n < MileButton.length ; n++) {
        MileButton[n].mousePressed();
      }
      
    }
  }
  
  public void mouseReleased() {
    if (show) {
      
      for(int n = 0; n < AreaButton.size();n++) {
        AreaButton.get(n).mouseReleased();
      }
      for(int n = 0; n < MileButton.length ; n++) {
        MileButton[n].mouseReleased();
      }
      
    }
  }
  
}
//A generic enemy 
public class Enemy extends Unit {

  double AttackTimer;
  
  double CurrentAttackTimer;
  
  long ExpBounty;
  long GoldBounty;
  long PrestigeBounty;
  
  boolean GaveBounty;
  
  ValueBar AttackTimerBar;
  
  
  double TempDmg;
  
  boolean RealmLord;
  
  long Level;
  //constructor to intialize the enemy 
  public Enemy(String Name,String Description, float x ,float y,long Level,double CharVit,double CharStr,double CharEnd,double CharAgi,double CharDex,double AttackTimer,long ExpBounty,long GoldBounty,long PrestigeBounty) {
    super( Name, Description, x, y, CharVit, CharStr, CharEnd, CharAgi, CharDex);
    this.AttackTimer = AttackTimer;
    this.ExpBounty = ExpBounty;
    this.GoldBounty = GoldBounty;
    this.PrestigeBounty = PrestigeBounty;
    this.Level = Level;
    UnitAsButton = new Button(Name,Description,x,y,200,200,5,color(200,25,25),color(255),15,color(255),3);
    HpBar = new ValueBar(TotalHp,width/2 - 225,15,450,15,color(0),2,color(255),1,color(200,25,25));
    
    AttackTimerBar = new ValueBar("Attack Timer","This enemy will attack someone when this bar is full.", AttackTimer,width/2 - 225,35,175,10,color(0),2,color(255),1,color(200));
  }
  //intialize with image 
  public Enemy(String Name,String Description, float x ,float y,long Level,double CharVit,double CharStr,double CharEnd,double CharAgi,double CharDex,double AttackTimer,long ExpBounty,long GoldBounty,long PrestigeBounty, PImage image,float textSize,int textColor) {
    super( Name, Description, x, y, CharVit, CharStr, CharEnd, CharAgi, CharDex);
    this.AttackTimer = AttackTimer;
    this.ExpBounty = ExpBounty;
    this.GoldBounty = GoldBounty;
    this.PrestigeBounty = PrestigeBounty;
    this.Level = Level;

    UnitAsButton = new Button(Name,Description,x,y,200,200,textSize,textColor,-100,image);
    HpBar = new ValueBar(TotalHp,width/2 - 225,15,450,15,color(0),2,color(255),1,color(200,25,25));
    
    AttackTimerBar = new ValueBar("Attack Timer","This enemy will attack someone when this bar is full.", AttackTimer,width/2 - 225,35,175,10,color(0),2,color(255),1,color(200));
  }  
  
  //..
  @Override
  public void HoverEvent() {
    if(UnitPlaced) {
      super.HoverEvent();
      AttackTimerBar.BarInfo.draw();
    }
  }
  //..
  @Override
  public void draw() {
    if(UnitPlaced) {
      super.draw();
    }
    HpBar.draw();
    AttackTimerBar.draw();    
  }
  //plays regen (idk why its existing since it is on its parent)
  @Override
  public void RegenHp() {
    if(Alive) {
      CurrentHp += (TotalRegHp/frameRate);
      correctCurrentHp();
    }
  }
  
  //..
  @Override
  public void TimeEvent() {
    super.TimeEvent();
    AttackTime();
    HpBar.updateBar(CurrentHp,TotalHp);
    AttackTimerBar.updateBar(CurrentAttackTimer,AttackTimer);  
  }
  //...
  public void ActionEvent(ArrayList<Player> pl,Player ThisPlayer) {
    if(UnitPlaced) {
      super.ActionEvent();
      Attack(pl.get(round(random(pl.size()-1))));
      giveBounty(pl,ThisPlayer);
    }
  }
  
  
  //attack a random player when the attack timer is up
  public void Attack(Player pl) {
    //temp attack 
    double critChance = (4/(double)Level)*((1-(Math.pow(0.975f,4*(TotalCrit + 1)/(double)Level)))/(1-Math.pow(0.975f,4/(double)Level)));
    TempDmg = TotalDmg;
    boolean doneCrit = false;
    if(critChance+TotalCritPercent > random(100)) {
      TempDmg = TotalDmg*(1+(TotalCritDmg*0.15f));
      doneCrit = true;
    }    
    
    if(CurrentAttackTimer > AttackTimer && pl.Alive && Alive) {
      CurrentAttackTimer = 0;
      
      
      for(int n = 0; n < pl.guildUnit.size(); n++) {
        pl.guildUnit.get(n).TriggerWhileAttackedEvent(this);
      }
        
      if(TempDmg > pl.TotalDef) {
        pl.CurrentHp -= (TempDmg - pl.TotalDef);
        //(String text,float speedY,float LifeTime,float x,float y,float textSize,color textColor)
        //temp
        if(pl.ThisPlayer) {
          if(doneCrit) {
            popText.add(new PopText("-"+(long)(TempDmg-pl.TotalDef)+"",0.5f,0.9f,pl.x + pl.UnitAsButton.sizeX/2,pl.y,41,color(153,0,102)));
          } else {
            popText.add(new PopText("-"+(long)(TempDmg-pl.TotalDef)+"",1,0.5f,pl.x + pl.UnitAsButton.sizeX/2,pl.y,35,color(200,25,25)));
          }
        }
      }
    }
    
  }
  
  //temp only single player
  public void AttackTime() {
    if(AttackTimer < CurrentAttackTimer) {
      CurrentAttackTimer = AttackTimer;
    }    
    if(Alive) {
      CurrentAttackTimer += 1/frameRate;
    }
  }
  
  //?
  @Override
  public void Dead() {
    super.Dead();
  }
  
  
  //temp only for single player
  public void giveBounty(ArrayList<Player> pl,Player ThisPlayer) {
    if(UnitPlaced) {
      if(Alive == false && GaveBounty == false) {
        
        for(int n = 0; n < pl.size();n++) {
          Player pla = pl.get(n);
          
          long exp = (long)ceil(ExpBounty*(pla.CharExp + pla.ItemExp + pla.BonusExp)/(1+pla.guildUnit.size()));
          long gold = (long)(GoldBounty*(pla.CharZeny + pla.ItemZeny + pla.BonusZeny));
          long prestige = (long)(PrestigeBounty*(pla.CharPrestige + pla.ItemPrestige + pla.BonusPrestige));
          
          for(int i = 0; i < pla.guildUnit.size(); i++) {
            pla.guildUnit.get(i).GuildUnitLevelUp(exp);
            pla.guildUnit.get(i).TriggerOnEnemyDeadEvent(this);
            
          }
          
          pla.PlayerLevelUp(exp);
          pla.Zeny += gold;
          pla.Prestige += prestige;
          
          if(RealmLord) {
            pla.KilledRealmLord = true;
            println("fdsfdsfds");
          }
          
        }
        GaveBounty = true;
        
        
        
        if(GoldBounty != 0) {
          //PopText(String text,float speedY,float LifeTime,float x,float y,float textSize,color textColor)
          popText.add(new PopText("+"+(long)(GoldBounty*(ThisPlayer.CharZeny + ThisPlayer.ItemZeny + ThisPlayer.BonusZeny))+"z",1,random(1,1.5f),random(x+UnitAsButton.sizeX/4,x+UnitAsButton.sizeX*3/4),random(y+UnitAsButton.sizeY/4,y+UnitAsButton.sizeY*3/4),20,color(150)));
        }
        
        if(PrestigeBounty != 0) {
          popText.add(new PopText("+"+(long)(PrestigeBounty*(ThisPlayer.CharPrestige + ThisPlayer.ItemPrestige + ThisPlayer.BonusPrestige))+" favor",0.3f,random(4,5),random(x+UnitAsButton.sizeX/4,x+UnitAsButton.sizeX*3/4),random(y+UnitAsButton.sizeY/4,y+UnitAsButton.sizeY*3/4),30,color(204,102,0)));
        }
        
        if(ExpBounty != 0) {
          popText.add(new PopText("+" +(long)(ExpBounty*(ThisPlayer.CharExp + ThisPlayer.ItemExp + ThisPlayer.BonusExp)/(1+ThisPlayer.guildUnit.size()))+" exp",1,random(1,1.5f),random(x+UnitAsButton.sizeX/4,x+UnitAsButton.sizeX*3/4),random(y+UnitAsButton.sizeY/4,y+UnitAsButton.sizeY*3/4),20,color(255,255,51)));
        }
        
      }
    }
  }
  
}
//unique recruit from GuildUnit
public class Fighter extends GuildUnit {
  
  public Fighter(float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(uVit, uStr, uEnd, uAgi, uDex, exp);
    Name = "Fighter";
    Description = "Just a really strong recruit.";
    MoodCriticalPoint = 35;
    MoodSpeed = 0.15f;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
  }
  
  //used for loading
  public Fighter(GuildUnit gu) {
    this(gu. uVit,gu. uStr,gu. uEnd,gu. uAgi,gu. uDex,gu. Exp);
    this.currentMood = gu.currentMood;
  }
  
  //..
  @Override
  public void TimeEvent(Player pl) {
    super.TimeEvent(pl);
  }
  
  //..
  @Override
  public void ActionEvent(Enemy en,Player pl) {
    super.ActionEvent(en,pl);
  }
  
  //..
  public void draw() {
    super.draw();
  }
  
  //..
  public void mousePressed() {
    UnitAsButton.mousePressed();
  }
  //..
  public void mouseReleased() {
    UnitAsButton.mouseReleased();
  }
}
//A general panel which is used to for creating children classes 
public class GeneralPanel {
  float x,y;
  float sizeX,sizeY;
  int lineColor;
  float lineSize;
  int background;
  float[] curve = new float[4];
  float padding;
  
  //trigger event
  boolean show;
  //..
  public GeneralPanel(float x,float y,float sizeX,float sizeY,int background,float padding, float curve,int lineColor,float lineSize) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.background = background;
    this.padding = padding;
    
    show = false;
    
    for(int n = 0; n < 4; n++) {
      this.curve[n] = curve;
    }
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    
    
    
  }
  //..
  public void draw() {
    fill(background);
    stroke(lineColor);
    strokeWeight(lineSize);
    rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
  }
  
}
//a panel to configure stats and name 
public class GoldSmithEdition extends GeneralPanel {
  
  
  Button Close;
  
  
  public GoldSmithEdition(float x,float y,float sizeX,float sizeY,int background,float padding, float curve,int lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    Close = new Button("X","",x+sizeX - padding - 25,y+padding,25,25,2,color(150),color(255),12,color(100),3);
    show = true;
  }

  
  //..
  public void ActionEvent() {
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

  public void mousePressed() {
    if(show) {
      Close.mousePressed();
    }    
  }

  public void mouseReleased() {
    if(show) {
      Close.mouseReleased();
    }      
  }  

  
}
//this was removed since 16.1.0.4a
public class GoldenCookie extends Object {
  
  
  //programmed as a button
  Button GoldenCookieAsButton;
  
  //values that can give to the player 
  long BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex;
  long rawBonusRegHp, rawBonusDef, rawBonusDmg,rawBonusHp,rawBonusCrit, rawBonusCritDmg;
  long statBonusRegHp, statBonusDef, statBonusDmg,statBonusHp,statBonusCrit, statBonusCritDmg;
  
  //moar stuff
  long ExpBounty;
  long GoldBounty;
  
  //buff duration
  float duration;
  //check if the Buff is Alive ( not the player ) its to check if the buff should be removed from the game
  boolean Alive;
  //check if its a back cookie
  boolean BadCookie;
  
  
  //trigger
  boolean Placed;
  
  //..
  public GoldenCookie(String Name,String Description,boolean BadCookie) {
    super( Name, Description, 0, 0);
    duration = 10;
    Alive = true;
    Placed = true;
    
    this.BadCookie = BadCookie;
    
    //it will determine the color of the cookie if its a bad 1 or good 1
    if(BadCookie) {
      GoldenCookieAsButton = new Button(Name,Description,random(250,width-250),random(0,height-60),60,60,5,color(150,150,25),color(255),9,color(200,25,25),2);
    } else {
      GoldenCookieAsButton = new Button(Name,Description,random(250,width-250),random(0,height-60),60,60,5,color(150,150,25),color(255),9,color(25,200,25),2);
    }
    
    
  }  
  //..
  public void HoverEvent() {
    if(Placed) {
      GoldenCookieAsButton.hoverInfo.draw();
    }
  }
  //..
  public void draw() {
    if(Placed) {
      GoldenCookieAsButton.draw();
    }
  }
  
  
  //.. ?
  public void ActionEvent() {
    
  }
  
  //..
  public void TimeEvent() {
    CookieTimer();
  }
  
  //check if the cookie decayed on the screen
  public void CookieTimer() {
    if(duration > 0) {
    duration -= 1/frameRate;
    } else {
      Alive = false;
    }
  }
  
  //gives the to player
  public void GiveValue(Player pl) {
    if(Placed) {
      if(GoldenCookieAsButton.wasClicked) {
        GoldenCookieAsButton.wasClicked = false;
        if(pl.Alive) {
          //pl.PlayerLevelUp(ExpBounty);
          createCookieValue(pl);
          Alive = false;
        }
      }
    }
  }
  
  //temp
  //constructs the name and values for the cookie
  public void createCookieValue(Player pl) {
    int rolled = round(random(4));
    long statValue = (long)(pl.TotalStatPoints*0.35f) ;
    String buffKey = "";
    String buffTitle = "";
    String buffInfo = "";
    int lineColor = color(0);
    
    if(BadCookie) {
      lineColor = color (200,25,25);
      buffTitle = "Debuff";
      buffInfo = "Reduce";
      statValue = -statValue;
    } else {
      lineColor = color (25,200,25);
      buffTitle = "Buff";
      buffInfo = "Increase";     
    }
    
    switch(rolled) {
      case 0:
      buffKey = "Vitality";
      BonusVit = statValue;
      break;
      case 1:
      buffKey = "Strength";
      BonusStr = statValue;
      break;
      case 2:
      buffKey = "Endurance";
      BonusEnd = statValue;
      break;
      case 3:
      buffKey = "Agility";
      BonusAgi = statValue;
      break;
      case 4:
      buffKey = "Dexterity";
      BonusDex = statValue;
      break;
      
    }
    
    //creates a buff to the player
    pl.buffIcon.add(new BuffIcon(buffKey + " " + buffTitle,buffInfo+ " Player's "+ buffKey +" by " +statValue+".",20,pl,0,0,0,BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,0,0,0,0,0,panelParty.PPP.get(0).x,panelParty.PPP.get(0).y,15,15,2,color(150,150,25),color(255),lineColor,1));
  }
  
}
//a unit which is specific for the game   
public class GuildUnit extends Unit {
  
  //Player pl;
  
  //this is the mood of the recruit, there is a mechanic in the game that the recruits will get angry at you if u dont pay them
  float Mood;
  
  //saves current mood
  @Expose
  float currentMood;
  
  //creates mood bar
  ValueBar MoodBar;
  
  //triggers another event that ur recruits can get moody at you
  float MoodCriticalPoint;
  //how much mood is decreased per second
  float MoodSpeed;
  
  float BonusMoodSpeed;
  boolean OverTime;
  
  //?
  @Expose
  float WiseLeech;  
  @Expose
  long KillCount;
  
  //exp
  long TotalExp,LossExp;
  
  //exp/lvl
  @Expose
  long Exp, Level, MaxExp, OldMaxExp, ExpGain, CurrentExpGain, ExpDiff; 
  
  //the amount u must pay to the recruit to make  them happy 
  long PayPrice;
  
  //creates bar for their exp
  ValueBar ExpBar;
  
  //buttons 
  Button FireButton;
  Button PayButton;
  
  boolean Moody;
  boolean Strike;
  
  
  long OldLevel;
  
  @Expose
  float uVit,uStr,uEnd,uAgi,uDex;
  
  
  //second trigger
  boolean UnitRemove;
  
  //..
  public GuildUnit(float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp) {
    super( "", "", 0, 0, 0, 0, 0, 0, 0);
    this.uVit = uVit;
    this.uStr = uStr;
    this.uEnd = uEnd;
    this.uAgi = uAgi;
    this.uDex = uDex;
    //x = 0;
    //y = y;
    Mood = 100;
    //this.pl = pl;
    this.currentMood = Mood;
    CharExp = 1;
    CharZeny = 1;
    CharPrestige = 1;
    GuildUnitLevelUp(exp);
    
    //new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
    FireButton = new Button("Fire","Remove this recruit from your Group!",x,y,60,30,2,color(150),color(255),12,color(100),3);
    PayButton = new Button("Pay","Increase the Mood for this recruit!",x,y,60,30,2,color(150),color(255),12,color(100),3);
    //new ValueBar("Experience","This shows your current progress in the game.", ExpDiff,275,height-25,width - 550,10,color(0),2,color(255),1,color(255,255,102));
    //ValueBar(String title,String Description, double MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground) {
    MoodBar = new ValueBar("Mood","This shows your recruits Mood, if below a certian point, the recruit will become Moody, if at 0, your recruit will go on strike.",Mood,x,y,50,10,color(0),2,color(255),1,color(25,200,25));
    //public ValueBar(String title,String Description, double MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground)
    ExpBar = new ValueBar("Experience","Your Recruit's Experence.", ExpDiff,x,y,0,10,color(0),2,color(255),1,color(255,255,102));
    
  }
  
  
  
  //function to check if the player puts them on overtime
  public void updateMoodSpeed() {
    if(OverTime) {
      BonusMoodSpeed = MoodSpeed*4;
    } else {
      BonusMoodSpeed = 0;
    }
  }
  
  //check if the player is in tavern or in dungeon 
  public void RestInTavern(Player pl) {
    if(pl.InTavern) {
      if(currentMood < Mood) {
        currentMood += 0.4f/frameRate; 
      }
    } else {
      if(currentMood > 0) {
        currentMood -= (MoodSpeed+BonusMoodSpeed)/frameRate;
      }
    }
  }
  
  //used for special units 
  public void TriggerWhileAttackedEvent(Enemy en) {
    
  }
   //used for special units 
  public void TriggerOnAttackEvent(Enemy en) {
    
  }  
   //used for special units 
  public void TriggerOnEnemyDeadEvent(Enemy en) {
    
  } 
  //..
  public void TimeEvent(Player pl) {
    RestInTavern(pl);
    if(currentMood > 0) {
      updateMoodSpeed();
      MoodBar.innerBackground = color(200-MoodBarColor(),25+MoodBarColor(),25);
      PayButton.hoverInfo.updateDescription("Pay","Increase the Mood for this recruit! Cost " +PayPrice +"z");
      Strike = false;
    } else {
      Strike = true;
      UnitAsButton.background = color(200,25,25);
    }
    if(currentMood > MoodCriticalPoint) {
      UnitAsButton.background = color(25,200,25);
      Moody = false;
    } else {
      if(Strike == false) {
        UnitAsButton.background = color(255,140,0);
      }
      Moody = true;
    }
  }
  //..
  public float MoodBarColor() {
    return (currentMood/100)*175;
  }
  //used for special units 
  public void FireEvent(Player pl) {
    
  }
  
  //..
  public void ActionEvent(Enemy en,Player pl) {
    updateStat();
    Attack(en,pl);
    if (Strike) {
      BonusVit = -(CharVit+ItemVit);
      BonusStr = -(CharStr+ItemStr);
      BonusEnd = -(CharEnd+ItemEnd);
      BonusAgi = -(CharAgi+ItemAgi);
      BonusDex = -(CharDex+ItemDex);     
    } else if(Moody) {
      BonusVit = -(CharVit+ItemVit)*0.5f;
      BonusStr = -(CharStr+ItemStr)*0.5f;
      BonusEnd = -(CharEnd+ItemEnd)*0.5f;
      BonusAgi = -(CharAgi+ItemAgi)*0.5f;
      BonusDex = -(CharDex+ItemDex)*0.5f;
    } else if(OverTime) {
      BonusVit = (CharVit+ItemVit);
      BonusStr = (CharStr+ItemStr);
      BonusEnd = (CharEnd+ItemEnd);
      BonusAgi = (CharAgi+ItemAgi);
      BonusDex = (CharDex+ItemDex);    
    } else {
      BonusVit = 0;
      BonusStr = 0;
      BonusEnd = 0;
      BonusAgi = 0;
      BonusDex = 0;
    }
  }
  
  
  //deals dmg to the current enemy over time ( seconds )
  public void Attack(Enemy en,Player pl) {
    if(pl.Alive && en.UnitPlaced) {
      
      double critChance = (4/(double)Level)*((1-(Math.pow(0.975f,4*(TotalCrit + 1)/(double)Level)))/(1-Math.pow(0.975f,4/(double)Level)));
      double dmg = TotalDmg*(1+(TotalCritDmg*0.15f*(critChance+TotalCritPercent)*0.01f));

      if(dmg > en.TotalDef  && en.Alive) {
        en.CurrentHp -= (dmg-en.TotalDef)/frameRate;
        //temp
        
        //popText.add(new PopText((long)(TotalDmg-en.TotalDef)+"",1,0.5,mouseX,mouseY - 10,30,color(255)));
      }
    }
  }  
  //..
  public void draw() {
    super.draw();
  }
  
  public void UpgradeStat() {
    CharVit += floor((Level - OldLevel)*uVit);
    CharStr += floor((Level - OldLevel)*uStr);
    CharEnd += floor((Level - OldLevel)*uEnd);
    CharAgi += floor((Level - OldLevel)*uAgi);
    CharDex += floor((Level - OldLevel)*uDex);
    updateStat();
    OldLevel = Level;
  }
  
  //a lvl up function for guild units 
  public void GuildUnitLevelUp(long gain) {
    boolean lvlmore = false;
    //lvl cap 999999
    if (gain > 0) {
      Exp += gain;
      TotalExp += gain;
      //logs.add(new Log("You gained " + gain + " Exp",color(255,255,0)));
      CurrentExpGain += gain;
      }
      if (Exp >= MaxExp) {
        while (lvlmore == false) {
          if (Level == 999999) {
            ExpDiff = MaxExp - OldMaxExp;
            CurrentExpGain = MaxExp;
            Exp = MaxExp;
            lvlmore =true;
          } else {
          if (Exp >= MaxExp) {
            OldMaxExp = MaxExp;
            Level ++;
            MaxExp = Level*4 + 10 + OldMaxExp;
            
            
            //logs.add(new Log("You Leveled up to " + Level,color(255,255,255)));
            //logs.add(new Log("You gain " + (long)Math.floor(3 + (Level/7)) + " stat points",color(255,255,255)));
          } else {
            lvlmore =true;
            ExpDiff = MaxExp - OldMaxExp;
            if(Alive) {
              //CurrentHp += TotalHp*0.1;
            }
          }
        }
      }
     UpgradeStat();
     //if(UnitAsButton != null) {
     //  pl.LvlUp.add(new PopText("LVL UP!",1.5,1,UnitAsButton.x + UnitAsButton.sizeX/2,UnitAsButton.y,15,color(255)));
     //}
     PayPrice = (long)(128*Level + pow(1.00003f,Level));
     CurrentExpGain = Exp - OldMaxExp;  
    }
  }
   //..
  public void mousePressed() {
    UnitAsButton.mousePressed();
  }
  //..
  public void mouseReleased() {
    UnitAsButton.mouseReleased();
  }
}
//the hashmap
HashMap<String, PImage> LoadAllImage = new HashMap<String,PImage>();
ArrayList<File> ListImages;

//used to find all the files with .png in the data path and point it to memory
public void GetPath(String GetPath, ArrayList<File> GetFile) {
  File PathDir = new File(GetPath);
  File[]ListFiles = PathDir.listFiles();
  for(File file : ListFiles) {

    if(file.isFile()) {
      //GetFile.add(file);
      if(file.getName().matches(".*.png.*")) {

        LoadAllImage.put(file.getName(),loadImage(file.getPath()));
      }
    } else if(file.isDirectory()) {
      GetPath(file.getPath(), GetFile);
    }
  }
}
//display information about this thing when mouse hover
//hover infor
public class HoverInfo {
  float sizeX,sizeY;
  int background,textColor;
  String text;
  float textSize;
  
  String title;
  float padding;
  
  float objX,objY,objSizeX,objSizeY;
  
  int lineColor;
  float lineSize;
  float[] curve = new float[4];
  ///....
  public HoverInfo(String title, String text,float textSize,int textColor,float sizeX,float padding,int background,float objX, float objY,float objSizeX,float objSizeY) {
    this.sizeX = sizeX;
    this.background = background;
    this.textSize = textSize;
    this.textColor = textColor;
    
    this.objX = objX;
    this.objY = objY;
    this.objSizeX = objSizeX;
    this.objSizeY = objSizeY;
    
    
    this.title = title;
    this.text = wrapText(text,textSize,sizeX-padding*2);
    this.sizeY = (textSize*1.6f)*wrapNumber(text,textSize,sizeX-padding*2)+textSize*2;
    this.padding = padding;
    this.lineSize = 1;
    this.lineColor = color(0);
  }
  //....
  public HoverInfo(String title, String text,float textSize,int textColor,float sizeX,float padding,int background,float objX, float objY,float objSizeX,float objSizeY,float curve,float lineSize, int lineColor) {
    this(title,text,textSize,textColor,sizeX,padding, background, objX, objY, objSizeX, objSizeY);


    for(int n = 0 ;n < 4; n++) {
      this.curve[n] = curve;
    }    
    this.lineSize = lineSize;
    this.lineColor = lineColor;
    this.padding = padding;
  }
  
  //not in use
  public void updatePosition(float x,float y) {
    objX = x;
    objY = y;
  }
  //...
  public void updateDescription(String title, String text) {
    this.title = title;
    this.text = wrapText(text,textSize,sizeX-padding*2);
    this.sizeY = (textSize*1.6f)*wrapNumber(text,textSize,sizeX-padding*2)+textSize*2;    
  }
  
  
  //..
  public void draw() {
    if(mouseOn() && text.length() > 1) {
      pushMatrix();
      reposition();
      stroke(lineColor);
      strokeWeight(lineSize);
      fill(background);
      rect(0,0,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
      
      
      textAlign(TOP,TOP);
      textSize(textSize);
      fill(textColor,150);
      text(title,sizeX-textWidth(title)-padding,padding);
      fill(textColor);
      text(text,padding,textSize*2);
      popMatrix();
    }
  }
  //..
  public void reposition() {
    if(mouseX < width/2) {
      translate(mouseX,0);
    } else {
      translate(mouseX-sizeX,0);
    }
    if(mouseY < height/2) {
      translate(0,mouseY);
    } else {
      translate(0,mouseY-sizeY);
    }
  }
  //..
  public boolean mouseOn() {
    if(mouseX > objX && mouseX < objX+objSizeX &&
    mouseY > objY && mouseY < objY+objSizeY) {
      return true;
    } else {
      return false;
    }
  }
  
}
// dont very generic and not implimented in the game
public class InventoryPanel extends GeneralPanel {
  public InventoryPanel(float x,float y,float sizeX,float sizeY,int background,float padding, float curve,int lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
  }
  
  public void draw(Player pl) {
    if(show) {
      super.draw();
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Inventory",x+padding,y+padding);     
      
      
      
      stroke(120);
      strokeWeight(2);
      fill(180);
      rect(x+sizeX -padding -13,y+sizeY-padding -15,13,13,0,20,0,20);
      fill(200);
      textSize(13);
      textAlign(TOP,BOTTOM);
      text("Zeny",x+padding,y+sizeY-padding);
      text(pl.Zeny+"",x+sizeX - padding - textWidth(pl.Zeny+"") - 15,y+sizeY - padding);
      
    }
  }
  
}
//more unique recruits 
public class Leecher extends GuildUnit {
  
  int TapRequire;
  boolean GaveExp;
  
  public Leecher(float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(uVit, uStr, uEnd, uAgi, uDex, exp);
    this.WiseLeech = 1.5f;
    Name = "Leecher";
    Description = "Does nothing but leeches your exp, can be killed(Tapped) for 150% of the leeched exp.";
    MoodCriticalPoint = 0;
    MoodSpeed = 0;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
    
    
    TapRequire = 10;
    
  }
  public Leecher(GuildUnit gu) {
    this(gu. uVit,gu. uStr,gu. uEnd,gu. uAgi,gu. uDex,gu. Exp);
    this.currentMood = gu.currentMood;
    WiseLeech = gu.WiseLeech;
  }   
  
  @Override
  public void TimeEvent(Player pl) {
    super.TimeEvent(pl);
    if(WiseLeech < 10) {
      WiseLeech += 1/( frameRate*1000 );
    }
    UnitAsButton.hoverInfo.updateDescription(Name,"Does nothing but leeches your exp, can be killed(Tapped) for "+String.format("%.1f", WiseLeech*100)+"% of the leeched exp." + " Tap " + TapRequire + " more times to kill this recruit! You will gain " + (long)(Exp*WiseLeech) + " Exp.");
    
  }
  
  public float MoodBarColor() {
    return (currentMood/100)*175;
  }
  
  @Override
  public void ActionEvent(Enemy en,Player pl) {
    super.ActionEvent(en, pl);
    if(UnitAsButton.wasClicked) {
      if(TapRequire > 0) {
        TapRequire --;
        UnitAsButton.wasClicked = false;
      }
    }
    
    if(TapRequire == 0 && GaveExp == false) {
      pl.PlayerLevelUp((long)(Exp*WiseLeech));
      popText.add(new PopText("+" +(long)(Exp*WiseLeech)+" exp",1,random(1,1.5f),mouseX,mouseY,20,color(255,255,51)));
      GaveExp = true;
      UnitRemove = true;
    }
  }
 
 
 
  public void draw() {
    super.draw();
  }
  
  
   
  public void mousePressed() {
    UnitAsButton.mousePressed();
  }
  
  public void mouseReleased() {
    UnitAsButton.mouseReleased();
  }
}
//the left tabs ( it should have been a child for general panel
public class LeftTabUI {
  float x,y;
  float sizeX,sizeY;
  int lineColor;
  float lineSize;
  int background;
  float[] curve = new float[4];
  
  Button[] LeftTabs = new Button[6];
  String[] tabName = new String[6];
  
  float[] ButtonY = new float[6];
  
  public LeftTabUI(float x,float y,float sizeX,float sizeY,float Gap, int background,float curve0,float curve1,float curve2,float curve3,int textColor,float textSize,int lineColor,float lineSize,float textAngle) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.background = background;
    
    tabName[0] = "Character";
    tabName[1] = "Options";
    tabName[2] = "Dungeon";
    tabName[3] = "Quest";
    tabName[4] = "The tavern Inn";
    tabName[5] = "Inventory";
    
    textSize(textSize);
    for(int n = 0; n < ButtonY.length; n++) {
      for(int i = 0; i < n+1; i++) {
        ButtonY[n] += textWidth(tabName[i])+15;
      }
    }
    //public Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve0,float curve1,float curve2,float curve3,color background,color textColor,float textSize,color lineColor,float lineSize,float textAngle) {
    for(int n = 0; n < LeftTabs.length; n++) {
      LeftTabs[n] = new Button(tabName[n],"",x,y+sizeY-ButtonY[n] - Gap*n,sizeX,textWidth(tabName[n])+15,curve0,curve1,curve2,curve3,background,textColor,textSize,lineColor,lineSize,textAngle);
    }
    
  }
  
  public void ActionEvent(Player pl) {
    switch(whichClicked()) {
      case 0:
      characterPanel.show = true;
      break;
      case 1:
      optionPanel.show = true;
      break;
      case 2:
      
      //12345
      dungeonPanel.show = true;

      break;
      case 3:
      questPanel.show = true;
      break;
      case 4:
      
      tavernPanel.show = true;
      currentAreaDungeon.Active = false;
      areaTavern.Active = true;
      
      
      pl.InTavern = true;
      
      
      break;
      case 5:
      inventoryPanel.show = true;
      break;      
    }
  }
  
  public int whichClicked() {
    for(int n = 0; n < LeftTabs.length; n++) {
      if(LeftTabs[n].wasClicked) {
        UnShowPanel();
        LeftTabs[n].wasClicked = false;
        return n;
      }
    }
    return -1;
  }
  
  
  
  public void UnShowPanel() {
    characterPanel.show = false;
    optionPanel.show = false;
    inventoryPanel.show = false;
    tavernPanel.show = false;
    dungeonPanel.show = false;
    questPanel.show = false;
  }
  
  
  
  public void draw() {
    for(int n = 0; n < LeftTabs.length; n++) {
      LeftTabs[n].draw();
    }
  }
  
  public void mousePressed() {
    for(int n = 0; n < LeftTabs.length; n++) {
      LeftTabs[n].mousePressed();
    }        
  }
  
  public void mouseReleased() {
    for(int n = 0; n < LeftTabs.length; n++) {
      LeftTabs[n].mouseReleased();
    }    
  }
  
  
  
}
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
//moar panels 
public class OptionPanel extends GeneralPanel {
  Button SaveButton;
  public OptionPanel(float x,float y,float sizeX,float sizeY,int background,float padding, float curve,int lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    SaveButton = new Button("Save Game","Gave your current progress. (The game auto saves every 60 seconds)",x+padding,y+padding + 30,sizeX-padding*2,30,3,color(150),color(255),16,color(100),3);
  }
  
  public void ActionEvent(Player pl,ArrayList<AreaDungeon> ad) {
    if(SaveButton.wasClicked) {
      SaveButton.wasClicked = false;
      SaveTime = 61;
      saveGame(pl,ad);
    }
  }
  
  
  @Override
  public void draw() {
    if(show) {
      super.draw();
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Option",x+padding,y+padding);
      SaveButton.draw();
    }
  }
  
  public void HoverEvent() {
    if(show) {
      SaveButton.hoverInfo.draw();
    }
  }
  
  public void mouseReleased() {
    if(show) {
      SaveButton.mouseReleased();
    }
  }
  
  public void mousePressed() {
    if(show) {
      SaveButton.mousePressed();
    }
  }  
  
}
//MOAR PANELS 
public class PanelParty {
  float x,y;
  float sizeX,sizeY;
  int lineColor;
  float lineSize;
  int background;
  float[] curve = new float[4];
  
  float padding;
  ArrayList<PanelPartyPlayer> PPP = new ArrayList<PanelPartyPlayer>();
  public PanelParty(float x,float y,float sizeX,float sizeY,int background,float curve,float padding,int lineColor,float lineSize) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.padding = padding;
    this.background = background;
    for(int n = 0; n < 4; n++) {
      this.curve[n] = curve;
    }
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    
    if(aPlayer != null) {
      //public PanelPartyPlayer(String Name,float Hp,float x,float y,float sizeX,float sizeY,color background,float curve,float padding,color lineColor,float lineSize,color innerBackground) {
      for(int n = 0; n < aPlayer.size(); n++) {
        PPP.add(new PanelPartyPlayer(aPlayer.get(n),x+padding,y+padding + 55*PPP.size(),sizeX-padding*2,55,curve,5,lineColor,lineSize));
      }
    }
  }
  
  public void TimeEvent() {
    for(int n = 0; n < PPP.size();n++) {
      PPP.get(n).TimeEvent();
    }
  }
  
  public void ActionEvent() {
    for(int n = 0; n < PPP.size();n++) {
      PPP.get(n).ActionEvent();
    }
  }
  
  public void draw() {
    fill(background);
    stroke(lineColor);
    strokeWeight(lineSize);
    rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
    
    
  }
  
}
//its is used to enlist information for the party panel
public class PanelPartyPlayer {
  float x,y;
  float sizeX,sizeY;
  int lineColor;
  float lineSize;
  
  float[] curve = new float[4];
  
  float inX,inY;
  float inSizeX,inSizeY;
  
  float padding;
  
  ValueBar HpBar;
  
  Player pl;
  
  Button DeathTimerButton;
  
  boolean TriggerDeath;
  
  
  //ArrayList<BuffIcon> buffIcon = new ArrayList<BuffIcon>();
  public PanelPartyPlayer(Player pl,float x,float y,float sizeX,float sizeY,float curve,float padding,int lineColor,float lineSize) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    for(int n = 0; n < 4; n++) {
      this.curve[n] = curve;
    }
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    
    
    this.pl = pl;
    
    inX = x;
    inY = y;
    inSizeX = sizeX;
    inSizeY = sizeY;
    this.padding = padding;
    //public ValueBar(float MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground) {
    HpBar = new ValueBar(pl.TotalHp,x,y+20,sizeX,15,color(0),curve,lineColor,lineSize,color(25,200,25));
    
    //public Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,float textSize,color lineColor,float lineSize) {
    //DeathTimerButton = new Button("Dead",pl.Name +" is dead! Tap to revive faster.",x,y,sizeX,sizeY,curve,color(200,25,25,100),color(255),14,color(200,25,25,100),0);
  }
  
  public void draw() {
    HpBar.draw();
    fill(lineColor);
    textSize(14);
    textAlign(TOP,TOP);
    
    text(pl.Name,x+sizeX-textWidth(pl.Name),y);
    
    
    if(DeathTimerButton != null) {
      text(round(pl.CurrentDeathTimer) + " Secs",x+5,y+20);
    }
    
    for(int n = 0; n < pl.buffIcon.size(); n++) {
      pl.buffIcon.get(n).updatePosition(x+ 20*n, y + 40);
      if(n <11) {
        pl.buffIcon.get(n).draw();
      }
    }
    
  }
  
  public void TimeEvent() {
    HpBar.updateBar(pl.CurrentHp,pl.TotalHp);
    for(int i = 0; i < pl.buffIcon.size();i++) {
      pl.buffIcon.get(i).TimeEvent(pl);
    }
  }      
  
  
  
  public void HoverEvent() {
    DeathTimerButton.hoverInfo.draw();
  }
  
  public void ActionEvent() {
    createDeathButton();
    TapDeathButton();
  }
  
  public void createDeathButton() {
    if(pl.Alive == false && TriggerDeath == false) {
      DeathTimerButton = new Button("Dead",pl.Name +" is dead! Tap to revive faster.",x+3,y+3,sizeX-6,sizeY-6,curve[0],color(200,25,25,100),color(255),15,color(200,25,25,100),1);
      TriggerDeath = true;
    } else if(pl.Alive && TriggerDeath) {
      TriggerDeath = false;
      DeathTimerButton = null;
    }    
  }
  
  public void TapDeathButton(){
    if(DeathTimerButton != null) {
      if(DeathTimerButton.wasClicked) {
        pl.CurrentDeathTimer -= 1;
        DeathTimerButton.wasClicked = false;
      }
    }
  }
}
//the player class 
// thi is probably which could be the most commented on...
public class Player extends Unit {
  //death timer
  float DeathTimer;
  float CurrentDeathTimer;
  //@Expose used for Gson builder
  @Expose
  //?
  long StatPoints;
  //?
  long TotalStatPoints;
  //in use
  long TotalExp,LossExp;
  
  //exp
  @Expose
  //in use
  long Exp, Level, MaxExp, OldMaxExp, ExpGain, CurrentExpGain, ExpDiff; 
  //ur currency
  @Expose
  long Zeny;
  @Expose
  long Prestige;
  
  ValueBar ExpBar;
  //buffs 
  ArrayList<BuffIcon> buffIcon = new ArrayList<BuffIcon>();
  
  
  //temp - TRigger as single player/or refer to only this player
  boolean ThisPlayer;
  
  boolean InTavern;
  
  //enlist guild units under the player's existance
  @Expose
  ArrayList<GuildUnit> guildUnit = new ArrayList<GuildUnit>();
  
  //used for ascending ( not added in the game )
  @Expose
  boolean KilledRealmLord;
  
  
  //added in 16.1.0.8
  //temp
  float AttackImageDuration;
  //..
  public Player(String Name,String Description,float x,float y,double CharVit,double CharStr,double CharEnd,double CharAgi,double CharDex) {
    super( Name, Description, width/2 -40, height/2 +100, CharVit, CharStr, CharEnd, CharAgi, CharDex);
    //Button(String title,String infoDescription,float x,float y,float sizeX,float sizeY,float textSize,color textColor,PImage image)
    UnitAsButton = new Button(Name,Description,x,y,80,80,21,color(255),50,LoadAllImage.get("Hero.png"));
    DeathTimer = 50;
    CurrentDeathTimer = DeathTimer;
    PlayerLevelUp(0);
    this.x = width/2 -40;
    this.y = height/2 +100;
    CharExp = 1;
    CharZeny = 1;
    CharPrestige = 1;
    
    //ValueBar(float MaxValue,float x,float y,float sizeX,float sizeY,color background,float curve,color lineColor,float lineSize,color innerBackground)
    //HpBar = new ValueBar(TotalHp,width/2 - 225,15,450,15,color(0),2,color(255),1,color(200,25,25));
    ExpBar = new ValueBar("Experience","This shows your current progress in the game.", ExpDiff,275,height-25,width - 550,10,color(0),2,color(255),1,color(255,255,102));
    //guildUnit.add(new Leecher( "Leecher","Does nothing but leeches your exp, can be killed(Tapped) for 100% of the leeched exp and 50% more.",this,12, 12, 0, 0, 0,0,0,0));
    
  }
  //used for loading the player
  public Player(Player pl) {
    this(pl.Name,pl. Description,pl. x,pl. y,pl. CharVit,pl. CharStr,pl. CharEnd,pl. CharAgi,pl. CharDex,pl. Exp, pl. Zeny,pl. Prestige,pl. CharExp,pl. CharZeny,pl. CharPrestige, pl. StatPoints);
    KilledRealmLord = pl.KilledRealmLord;
    CharCritPercent = pl.CharCritPercent;
    ItemCritPercent = pl.ItemCritPercent;
  }
  
 
  
  
  
  //? ( this seems quite a useless constructor since i have it on the gson save )
  public Player(String Name,String Description,float x,float y,double CharVit,double CharStr,double CharEnd,double CharAgi,double CharDex,long exp, long zeny,long prestige,float CharExp,float CharZeny,float CharPrestige, long StatPoints) {
    this( Name, Description, width/2 -40, height/2 +100, CharVit, CharStr, CharEnd, CharAgi, CharDex);
    PlayerLevelUp(exp);
    Zeny = zeny;
    this.Prestige = prestige;
    this.CharExp = CharExp;
    this.CharZeny = CharZeny;
    this.CharPrestige = CharPrestige;
    this.StatPoints = StatPoints;
  }
  
  
  //..
  @Override
  public void HoverEvent() {
    if(UnitPlaced) {
      super.HoverEvent();
      ExpBar.BarInfo.draw();
    }
  }
  //..
  @Override
  public void draw() {
    if(UnitPlaced) {
      super.draw();
      ExpBar.draw();
    }
  }
  //..
  @Override
  public void TimeEvent() {
    super.TimeEvent();
    ReviveTime();
    ExpBar.updateBar(CurrentExpGain,ExpDiff);
    UnitAsButton.title = Name;
    UnitAsButton.hoverInfo.updateDescription(Name,Description);
    ExpBar.BarInfo.updateDescription(ExpBar.title,Description +" You are currently level "+ Level+". " + "You require "+(MaxExp-Exp)+" experience points to level up.");
  }
  
  
  //reason why i put 2 Alive , 1 for multipler( it auto falses the enemy button), if i clicked the enmy when im dead which will auto do dmg on it
  public void Attack(Enemy en) {
    if(Alive && ThisPlayer) {
      if (en.UnitAsButton.wasClicked) {
        
        double critChance = (4/(double)Level)*((1-(Math.pow(0.975f,4*(TotalCrit + 1)/(double)Level)))/(1-Math.pow(0.975f,4/(double)Level)));
        double dmg = TotalDmg;
        boolean doneCrit = false;
        if(critChance + TotalCritPercent > random(100)) {
          dmg = TotalDmg*(1+(TotalCritDmg*0.15f));
          doneCrit = true;
        }
        
        if(dmg > en.TotalDef  && en.Alive && Alive) {
          en.CurrentHp -= (dmg-en.TotalDef);
          
          //temp
          //easter egg
          if(currentAreaDungeon.Name.equals("GoldSmiths")) {
            if(random(100) > 50) {
              popText.add(new PopText("Vote for me!",1,0.5f,mouseX,mouseY - 10,25,color(255)));
            } else {
              popText.add(new PopText("Love me!",1,0.5f,mouseX,mouseY - 10,25,color(255)));
            }
          } else {
            if(doneCrit) {
              popText.add(new PopText((long)(dmg-en.TotalDef)+"",0.5f,0.8f,mouseX,mouseY - 10,32,color(255,255,0)));
              
            } else {
              //(String ImageNameString,float x,float y, float duration,float speed,float angle,boolean Bounce)
              popText.add(new PopText((long)(dmg-en.TotalDef)+"",1,0.5f,mouseX,mouseY - 10,28,color(255)));
            }
          }
          
        }
        en.UnitAsButton.wasClicked = false;
      }
    }
  }
  
  
  //..
  public void ActionEvent(Enemy en) {
    if(UnitPlaced) {
      super.ActionEvent();
      Revive();
      
      if(en.UnitAsButton.mPress) {
        UnitAsButton.image = LoadAllImage.get("HeroReady.png");
      } else if(AttackImageDuration > 0) { 
        AttackImageDuration -= 1/frameRate;
        UnitAsButton.image = LoadAllImage.get("HeroAttack.png");
      } else {
        UnitAsButton.image = LoadAllImage.get("Hero.png");
      }
      
      if(en.UnitAsButton.wasClicked && Alive) {
        AttackImageDuration = 0.1f;
        createMovingObject.add(new CreateMovingObject("Slash1.png",x+UnitAsButton.sizeX/2,y,0.1f,1,random(-5,5),false));
      }
      
      
      
      Attack(en);

    }
  }
  
  
  
  
  //check if the condiction is met, then revive the player back
  public void Revive() {
    if(CurrentDeathTimer < 0) {
      Alive = true;
      CurrentDeathTimer = DeathTimer;
      CurrentHp = TotalHp;
    }
  }
  
  //a revive counter
  public void ReviveTime() {
    if(Alive == false) {
      CurrentDeathTimer -= 1/frameRate;
      UnitAsButton.image = LoadAllImage.get("Hero.png");
    }
  }
  
  // a lvl up function for player
  public void PlayerLevelUp(long gain) {
    boolean lvlmore = false;
    
    //lvl cap 999999
    if (gain > 0) {
      Exp += gain;
      TotalExp += gain;
      //logs.add(new Log("You gained " + gain + " Exp",color(255,255,0)));
      CurrentExpGain += gain;
      }
      if (Exp >= MaxExp) {
        while (lvlmore == false) {
          if (Level == 999999) {
            ExpDiff = MaxExp - OldMaxExp;
            CurrentExpGain = MaxExp;
            Exp = MaxExp;
            lvlmore =true;
          } else {
          if (Exp >= MaxExp) {
            OldMaxExp = MaxExp;
            Level ++;
            StatPoints += 10;
            TotalStatPoints += 10;
            MaxExp = Level*4 + 10 + OldMaxExp;
            
            
            //PopText(String text,float speedY,float LifeTime,float x,float y,float textSize,color textColor,float Angle) {
            //logs.add(new Log("You Leveled up to " + Level,color(255,255,255)));
            //logs.add(new Log("You gain " + (long)Math.floor(3 + (Level/7)) + " stat points",color(255,255,255)));
          } else {
            lvlmore =true;
            ExpDiff = MaxExp - OldMaxExp;
            popText.add(new PopText("LVL UP!",1.5f,1,x+UnitAsButton.sizeX/2,y+UnitAsButton.sizeY/2,24,color(255),random(-20,20)));      
            if(Alive) {
              //CurrentHp += TotalHp*0.1;
            }
          }
        }
      }
         
   CurrentExpGain = Exp - OldMaxExp;  
   }
  }
  
}
//make text appear on screen for afew seconds
class PopText {
  float x,y;
  float textSize;
  int textColor;
  
  String text;
  
  boolean showBackground ;
  float sizeX,sizeY;
  int background;
  
  boolean Active;
  float LifeTime;
  
  float Fade;
  float alpha;
  
  
  float speedY;
  
  int lineColor;
  float lineSize;
  float[] curve = new float[4];
  //..
  PopText(String text,float speedY,float LifeTime,float x,float y,float textSize,int textColor) {
    this.text = text;
    this.x = random(x*0.975f,x*1.025f);
    this.y = y;
    this.textSize = textSize;
    this.textColor = textColor;
    showBackground = false;
    this.LifeTime = LifeTime;
    Active = true;
    this.speedY = speedY;
    
    
    
    correctInBox();
    
    Fade = 255/(frameRate*LifeTime*2);
    alpha = 255;
  }
  
  //this one just have angles in it 
  float speedX;
  float Angle;
  PopText(String text,float speedY,float LifeTime,float x,float y,float textSize,int textColor,float Angle) {
    this.text = text;
    this.Angle = Angle;
    
    this.x = x;
    this.y = y;
    this.textSize = textSize;
    this.textColor = textColor;
    showBackground = false;
    this.LifeTime = LifeTime;
    Active = true;
    correctInBox();
    
    speedX = speedY*sin(radians(Angle));
    this.speedY = speedY*cos(radians(Angle));
    
    
    Fade = 255/(frameRate*LifeTime*2);
    alpha = 255;
  }  
  
  //this one was never used 
  PopText(String text,float speedY, float LifeTime,float x,float y,float textSize,int textColor,float sizeX,float sizeY, int background,float curve, int lineColor, float lineSize) {
    this(text,speedY,LifeTime, x, y, textSize, textColor);
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.background = background;
    for(int n = 0; n < this.curve.length;n++) {
      this.curve[n] = curve;
    }
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    showBackground = true; 
  }
  
  //if the text is off the screen, it will repostion it inside the window
  public void correctInBox() {
    textSize(textSize);
    if(x - textWidth(text)/2 < 0) {
      x = textWidth(text)/2;
    } else if ( x + textWidth(text)/2 > width) {
      x = width - textWidth(text)/2;
    }
  }
  
  //..
  //decay
  //move
  public void TimeEvent() {
    if(LifeTime > 0) {
      LifeTime -= 1/frameRate;
      y = y - speedY;
      x = x + speedX;
      alpha -= Fade;
    } else {
      Active = false;
    }
  }
  
  //..
  public void draw() {
    if(showBackground) {
      fill(background);
      stroke(lineColor);
      strokeWeight(lineSize);
      rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
    }
    
    pushMatrix();
    translate(x,y);
    rotate(radians(Angle));
    textAlign(CENTER,CENTER);
    textSize(textSize);
    fill(0,alpha);
    text(text,1,1);
    fill(textColor,alpha);
    text(text,0,0);
    popMatrix();
  }
  
}
public class Priest extends GuildUnit {
  
  public Priest(float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(uVit, uStr, uEnd, uAgi, uDex, exp);
    Name = "Priest";
    Description = "''Come, Holy Sauce, Creator blest, and, in our pasta, give us thy rest...'' Ragu, the One True Heir.";
    MoodCriticalPoint = 30;
    MoodSpeed = 0.11f;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
  }
  
  public Priest(GuildUnit gu) {
    this(gu. uVit,gu. uStr,gu. uEnd,gu. uAgi,gu. uDex,gu. Exp);
    this.currentMood = gu.currentMood;
  }   
  
  @Override
  public void TimeEvent(Player pl) {
    super.TimeEvent(pl);
    UnitAsButton.hoverInfo.updateDescription(Name,"Grants a Buff which increases regen by " + ceil(Level*0.1f) + " and defence by " + ceil(Level*0.25f) +" for 5 mins. Cost 15 Mood. (Active) " + Description);
  }
  
  
  @Override
  public void ActionEvent(Enemy en,Player pl) {
    super.ActionEvent(en, pl);
    if(UnitAsButton.wasClicked) {
      UnitAsButton.wasClicked = false;
      if(pl.Alive) {
        if(currentMood >= 15) {
          GiveBuff(pl);
          currentMood -= 15;
        } else {
          popText.add(new PopText("Give me a Raise!", 1, 1, mouseX,mouseY,16,color(200,25,25)));
        }
      } else {
        popText.add(new PopText("I can't bless the dead!", 1, 1, mouseX,mouseY,16,color(200,25,25)));
      }
    }
  }
  
  
  public void GiveBuff(Player pl) {
    for(int n = 0; n < pl.buffIcon.size(); n++) {
      if("Holy Blessing" == pl.buffIcon.get(n).title) {
        pl.buffIcon.get(n).Active = false;
        pl.buffIcon.get(n).GiveValueToUnit(pl);
      }
    }
    pl.buffIcon.add(new BuffIcon("Holy Blessing","Increase regen by " + ceil(Level*0.1f) + " and Increase defence by " + ceil(Level*0.15f)+". ",300,pl,0,0,0, 0,0,0,0,0, ceil(Level*0.1f),ceil(Level*0.15f),0,0,0,0,1,1,15,15,2,color(255,153,204),color(255),color(25,200,25),1));        
  }
  
  
  
  public void draw() {
    super.draw();
  }
  
   
  public void mousePressed() {
    UnitAsButton.mousePressed();
  }
  
  public void mouseReleased() {
    UnitAsButton.mouseReleased();
  }
}
public class PrismIndigo extends GuildUnit {
  
  public PrismIndigo(float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(uVit, uStr, uEnd, uAgi, uDex, exp);
    Name = "Prism Indigo";
    Description = "Works Quadruple times harder when 'Over Time' is active. (Auto)";
    MoodCriticalPoint = 10;
    MoodSpeed = 0.17f;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
    UnitAsButton.title = wrapText("Prism Indigo",12,50);
  }
  public PrismIndigo(GuildUnit gu) {
    this(gu. uVit,gu. uStr,gu. uEnd,gu. uAgi,gu. uDex,gu. Exp);
    this.currentMood = gu.currentMood;
  }  
  
  
  @Override
  public void ActionEvent(Enemy en,Player pl) {
    updateStat();
    Attack(en, pl);
    if (Strike) {
      BonusVit = -(CharVit+ItemVit);
      BonusStr = -(CharStr+ItemStr);
      BonusEnd = -(CharEnd+ItemEnd);
      BonusAgi = -(CharAgi+ItemAgi);
      BonusDex = -(CharDex+ItemDex);     
    } else if(Moody) {
      BonusVit = -(CharVit+ItemVit)*0.5f;
      BonusStr = -(CharStr+ItemStr)*0.5f;
      BonusEnd = -(CharEnd+ItemEnd)*0.5f;
      BonusAgi = -(CharAgi+ItemAgi)*0.5f;
      BonusDex = -(CharDex+ItemDex)*0.5f;
    } else if(OverTime) {
      BonusVit = (CharVit+ItemVit)*3;
      BonusStr = (CharStr+ItemStr)*3;
      BonusEnd = (CharEnd+ItemEnd)*3;
      BonusAgi = (CharAgi+ItemAgi)*3;
      BonusDex = (CharDex+ItemDex)*3;    
    } else {
      BonusVit = 0;
      BonusStr = 0;
      BonusEnd = 0;
      BonusAgi = 0;
      BonusDex = 0;
    }
  }  
  
  @Override
  public void TimeEvent(Player pl) {
    super.TimeEvent(pl);
  }
  
  
  
  public void draw() {
    super.draw();
  }
  
   
  public void mousePressed() {
    UnitAsButton.mousePressed();
  }
  
  public void mouseReleased() {
    UnitAsButton.mouseReleased();
  }
}
public class Protector extends GuildUnit {
  
  public Protector(float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(uVit, uStr, uEnd, uAgi, uDex, exp);
    Name = "Protector";
    Description = "Blocks 45% enemy damage for you, Cost 3 Mood. (Must be above Moody, Auto)";
    MoodCriticalPoint = 20;
    MoodSpeed = 0.14f;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
  }

  public Protector(GuildUnit gu) {
    this(gu. uVit,gu. uStr,gu. uEnd,gu. uAgi,gu. uDex,gu. Exp);
    this.currentMood = gu.currentMood;
  }   
  
  @Override
  public void TimeEvent(Player pl) {
    super.TimeEvent(pl);
  }
  
  
  @Override
  public void ActionEvent(Enemy en,Player pl) {
    super.ActionEvent(en,pl);
  }
  
  @Override
  public void TriggerWhileAttackedEvent(Enemy en) {
    Defend(en);
  }
  
  public void Defend(Enemy en) {
    if(en.TempDmg > 0 && Moody == false && Strike == false && currentMood >= 3) {
      en.TempDmg -= en.TotalDmg*0.45f;
      currentMood -= 3;
    }
  }
  
  public void draw() {
    super.draw();
  }
  
   
  public void mousePressed() {
    UnitAsButton.mousePressed();
  }
  
  public void mouseReleased() {
    UnitAsButton.mouseReleased();
  }
}
public class QuestPanel extends GeneralPanel {
  public QuestPanel(float x,float y,float sizeX,float sizeY,int background,float padding, float curve,int lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
  }
  
  @Override
  public void draw() {
    if(show) {
      super.draw();
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Quest",x+padding,y+padding);
    }
  }
  
}
public class RecruitConfigurePanel extends GeneralPanel {
  
  ScrollBar RecruitBody;
  float moveY = 30;
  
  Button PayForAll;
  
  Button Close;
  
  Button OverWorkButton;
  
  boolean OverWorkOn;
  
  
  double TotalDps;
  
  public RecruitConfigurePanel(float x,float y,float sizeX,float sizeY,int background,float padding, float curve,int lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    
    Close = new Button("X","",x+sizeX - padding - 25,y+padding,25,25,2,color(150),color(255),12,color(100),3);
    RecruitBody = new ScrollBar(0,sizeY-padding*2-20,x+sizeX,y,8,sizeY,color(0,150),0,color(255),1);
    PayForAll = new Button("Pay All","Pay for all your recruits.",x+sizeX - padding - 100,y+padding,70,25,2,color(150),color(255),12,color(100),3);
    
    OverWorkButton = new Button("Over Time","Double your Recruits stats but x5 your recruits mood speed. The Stat increase will not affect recruits that are moody or on strike.",x+sizeX - padding - 175,y+padding,70,25,2,color(150),color(200,25,25),12,color(100),3);
    OverWorkButton.hoverInfo.title = "[OFF] Over Time";
  }
  
  public void ActionEvent(Player pl, RecruitPanel rP) {
    if(show) {
      
      if(OverWorkButton.wasClicked) {
        OverWorkButton.wasClicked = false;
        if(OverWorkOn == false) {
          OverWorkOn = true;
          OverWorkButton.textColor = color(25,200,25);
          OverWorkButton.hoverInfo.updateDescription("[ON] Over Time",OverWorkButton.infoDescription);
          rP.OverTimeButton.hoverInfo.updateDescription("[ON] Over Time",rP.OverTimeButton.infoDescription);
          rP.OverTimeButton.lineColor = color(25,200,25);
          rP.OverTimeButton.textColor = color(25,200,25);
        } else { 
          OverWorkOn = false;
          OverWorkButton.textColor = color(200,25,25);
          OverWorkButton.hoverInfo.updateDescription("[OFF] Over Time",OverWorkButton.infoDescription);
          rP.OverTimeButton.hoverInfo.updateDescription("[OFF] Over Time",rP.OverTimeButton.infoDescription);
          rP.OverTimeButton.lineColor = color(200,25,25);
          rP.OverTimeButton.textColor = color(200,25,25);
        }
        for(int n  = 0; n < pl.guildUnit.size(); n++) {
          pl.guildUnit.get(n).OverTime = OverWorkOn;
        }
      }
      
      if(PayForAll.wasClicked) {
        PayForAll.wasClicked = false;
        checkPayAllButton(pl);
      }
      
      if(Close.wasClicked) {
        Close.wasClicked = false;
        show = false;
      }
      for(int n = 0; n < pl.guildUnit.size();n++){
        if(pl.guildUnit.get(n).PayButton.wasClicked) {
          pl.guildUnit.get(n).PayButton.wasClicked = false;
          checkPayButton(pl.guildUnit.get(n),pl);
        } else if (pl.guildUnit.get(n).FireButton.wasClicked) {
          pl.guildUnit.get(n).FireButton.wasClicked = false;
          pl.guildUnit.get(n).FireEvent(pl);
          pl.guildUnit.remove(n);
        }
      }

    }    
  }
  
  public void checkPayAllButton(Player pl) {
    for(int n = 0; n < pl.guildUnit.size(); n++) {
      if(pl.guildUnit.get(n).currentMood < 98) {
        checkPayButton(pl.guildUnit.get(n),pl);
      }
    }
  }
  
  public void checkPayButton(GuildUnit gu,Player pl) {
    if(checkPayButtonPrice(gu,pl)) {
      pl.Zeny -= gu.PayPrice;
      popText.add(new PopText("-" +  gu.PayPrice + "z", 1, 1, mouseX,mouseY,20,color(150)));
      gu.currentMood = gu.Mood;
    } else {
      popText.add(new PopText("You broke kokudorei...", 1, 1, mouseX,mouseY,20,color(200,25,25)));
    }
  }
  
  public boolean checkPayButtonPrice(GuildUnit gu,Player pl) {
    if(pl.Zeny >= gu.PayPrice) {
      return true;
    } else {
      return false;
    }
  }  
  
  
  
  
  public void HoverEvent(Player pl) {
    if(show) {
      PayForAll.hoverInfo.draw();
      OverWorkButton.hoverInfo.draw();
      if(mouseX > x && mouseX < x+sizeX &&
      mouseY > moveY + y && mouseY <  y + sizeY) {      
        for(int n = 0; n < pl.guildUnit.size();n++){
          pl.guildUnit.get(n).ExpBar.BarInfo.draw();
          pl.guildUnit.get(n).PayButton.hoverInfo.draw();
          pl.guildUnit.get(n).FireButton.hoverInfo.draw();
        }
      }
    }
  }
  
  
  public void TimeEvent(Player pl) {
    if(show) {
      RecruitBody.contentLength = 305* pl.guildUnit.size();
      
      TotalDps = 0;
      
      for(int n = 0; n < pl.guildUnit.size();n++){
        TotalDps += pl.guildUnit.get(n).TotalDmg;
        pl.guildUnit.get(n).ExpBar.updateBar(pl.guildUnit.get(n).CurrentExpGain,pl.guildUnit.get(n).ExpDiff);
        pl.guildUnit.get(n).ExpBar.sizeX = sizeX -pl.guildUnit.get(n).PayButton.sizeX-pl.guildUnit.get(n).FireButton.sizeX -  padding*4;
        pl.guildUnit.get(n).ExpBar.BarInfo.objSizeX = sizeX -pl.guildUnit.get(n).PayButton.sizeX-pl.guildUnit.get(n).FireButton.sizeX -  padding*4;
        pl.guildUnit.get(n).ExpBar.BarInfo.updateDescription("Experience","Your Recruit's Experence. " + pl.guildUnit.get(n).Exp + " Total Exp, the recruit needs "+ (pl.guildUnit.get(n).MaxExp - pl.guildUnit.get(n).Exp) + " to level up.");
      }
    }
  }
  
  public void draw(Player pl) {
    if(show) {
      super.draw();
      
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Manage Recruits",x+padding,y+padding);    
      Close.draw();
      PayForAll.draw();
      OverWorkButton.draw();
      RecruitBody.draw();
      
      clip(x,y+padding + moveY, sizeX,sizeY-padding*2 - moveY);
      for(int n = 0; n < pl.guildUnit.size(); n++) {
        RecruitInfo(pl.guildUnit.get(n),0,moveY + 10 + 300*n + RecruitBody.contentMove());
      }
      
      noClip();
    }
  }
  
  public void RecruitInfo(GuildUnit Gu,float cX,float cY) {
    
    
    
    textAlign(TOP,TOP);
    textSize(14);
    fill(255);
    text(Gu.Name,x+padding + cX,y+padding + cY);
    text("Level "+Gu.Level,x+sizeX-padding-textWidth("Level "+Gu.Level),y+padding + cY);
    
    
      

    
    textSize(12);
    fill(180);
    text("Vitality",x+padding +cX ,y+padding +cY +20);
    text((long)Gu.TotalVit+"",x+sizeX -padding - textWidth((long)Gu.TotalVit+"")+cX ,y+padding +cY +20);
    
    text("Strength",x+padding +cX ,y+padding +cY +35);
    text((long)Gu.TotalStr+"",x+sizeX -padding - textWidth((long)Gu.TotalStr+"")+cX ,y+padding +cY +35);    
    
    text("Endurance",x+padding +cX ,y+padding +cY +50);
    text((long)Gu.TotalEnd+"",x+sizeX -padding - textWidth((long)Gu.TotalEnd+"")+cX ,y+padding +cY +50);    
    
    text("Agility",x+padding +cX ,y+padding +cY +65);
    text((long)Gu.TotalAgi+"",x+sizeX -padding - textWidth((long)Gu.TotalAgi+"")+cX ,y+padding +cY +65);    
    
    text("Dexterity",x+padding +cX ,y+padding +cY +80);
    text((long)Gu.TotalDex+"",x+sizeX -padding - textWidth((long)Gu.TotalDex+"")+cX ,y+padding +cY +80);
    
    
    text("Health",x+padding +cX ,y+padding +cY + 100);
    text((long)Gu.TotalHp+"",x+sizeX -padding - textWidth((long)Gu.TotalHp+"")+cX ,y+padding +cY + 100);
    
    
    //wtf? Gu.TotalDmg*100/0 = infinity?
    text("Damage",x+padding +cX ,y+padding +cY +115);
    text("(Total "+ round((float)(Gu.TotalDmg*100/TotalDps)) +"%) " + (long)Gu.TotalDmg+"",x+sizeX -padding - textWidth("(Total "+ round((float)(Gu.TotalDmg*100/TotalDps)) +"%) " + (long)Gu.TotalDmg+"")+cX ,y+padding +cY +115);    


    text("Defence",x+padding +cX ,y+padding +cY +130);
    text((long)Gu.TotalDef+"",x+sizeX -padding - textWidth((long)Gu.TotalDef+"")+cX ,y+padding +cY +130);    
    
    text("Health Regen",x+padding +cX ,y+padding +cY +145);
    text((long)Gu.TotalRegHp+"",x+sizeX -padding - textWidth((long)Gu.TotalRegHp+"")+cX ,y+padding +cY +145);    
    
    text("Critical Rating",x+padding +cX ,y+padding +cY +160);
    text((long)Gu.TotalCrit+"",x+sizeX -padding - textWidth((long)Gu.TotalCrit+"")+cX ,y+padding +cY +160);
    
    text("Crit Damage",x+padding +cX ,y+padding +cY +175);
    text((long)Gu.TotalCritDmg+"",x+sizeX -padding - textWidth((long)Gu.TotalCritDmg+"")+cX ,y+padding +cY +175);      
    
    fill(255);
    text("Current Mood",x+padding +cX ,y+padding +cY +195);
    text((int)Gu.currentMood+"",x+sizeX -padding - textWidth((int)Gu.currentMood+"")+cX ,y+padding +cY +195); 
    
    text("Critical Mood Point",x+padding +cX ,y+padding +cY +210);
    text((int)Gu.MoodCriticalPoint+"",x+sizeX -padding - textWidth((int)Gu.MoodCriticalPoint+"")+cX ,y+padding +cY +210); 
    
    text("Mood Speed",x+padding +cX ,y+padding +cY +225);
    text((Gu.MoodSpeed+Gu.BonusMoodSpeed) +"",x+sizeX -padding - textWidth((Gu.MoodSpeed+Gu.BonusMoodSpeed)+"")+cX ,y+padding +cY +225);    
    
    Gu.ExpBar.UpdatePosition(x+padding + (Gu.ExpBar.sizeX/4) ,y+padding +cY +270);
    
    Gu.FireButton.UpdatePosition(x+padding +cX,y+padding +cY +250);
    Gu.PayButton.UpdatePosition(x+sizeX-padding-Gu.PayButton.sizeX +cX,y+padding +cY +250);
    Gu.ExpBar.draw();
    Gu.PayButton.draw();
    Gu.FireButton.draw();
    
    //length total Y = 280
    
    //text("Description:",x+padding +cX ,y+padding +cY +225);
    //fill(180);
    //text(wrapText(Gu.Description,12,sizeX-padding*2),x+padding +cX ,y+padding +cY +240);

  }
  
  
  
  
  public void mouseReleased(Player pl) {
    if(show) {
      PayForAll.mouseReleased();
      OverWorkButton.mouseReleased();
      Close.mouseReleased();
      RecruitBody.mouseReleased();
      if(mouseX > x && mouseX < x+sizeX &&
      mouseY > moveY + y && mouseY <  y + sizeY) {   
        for(int n = 0; n < pl.guildUnit.size();n++){
          pl.guildUnit.get(n).PayButton.mouseReleased();
          pl.guildUnit.get(n).FireButton.mouseReleased();
        }
      }
    }
  }
  
  public void mousePressed(Player pl) {
    if(show) {
      PayForAll.mousePressed();
      OverWorkButton.mousePressed();
      Close.mousePressed();
      RecruitBody.mousePressed();
      if(mouseX > x && mouseX < x+sizeX &&
      mouseY > moveY + y && mouseY <  y + sizeY) {   
        for(int n = 0; n < pl.guildUnit.size();n++){
          pl.guildUnit.get(n).PayButton.mousePressed();
          pl.guildUnit.get(n).FireButton.mousePressed();
        }
      }
    }
  }
  
  public void mouseWheel(MouseEvent event) {
    if(show) {
      RecruitBody.mouseWheel(event,x,y,sizeX,sizeY);
    }
  }  
}
public class RecruitPanel extends GeneralPanel {
  
  Button RecruitConfigureButton;
  Button OverTimeButton;
  
  
  RecruitConfigurePanel RCP;
  
  
  
  HoverInfo RecruitInfo;
  
  
  
  public RecruitPanel(float x,float y,float sizeX,float sizeY,int background,float padding, float curve,int lineColor,float lineSize,RecruitConfigurePanel RCP) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    show = true;
    this.RCP = RCP;
    RecruitConfigureButton = new Button("M","Manage your recruits.",x+sizeX - 20 - padding,y +padding,20,20,2,color(150),color(255),13,color(255),1);
    RecruitConfigureButton.hoverInfo.title = "Manage";
    OverTimeButton = new Button("O","Puts your recruits on overtime.",x+sizeX - 20 - padding -25,y +padding,20,20,2,color(150),color(200,25,25),13,color(200,25,25),1);
    OverTimeButton.hoverInfo.title = "[OFF] Over Time";
    
    //(String title, String text,float textSize,color textColor,float sizeX,float padding,color background,float objX, float objY,float objSizeX,float objSizeY,float curve,float lineSize, color lineColor) 
    String des = "Recruiting units will increase your Dps. Moody(Orange) and Strike(Red) will heavily reduce their Stats and prevent some actions being preformed, you must Rest in the Tavern or Pay them to raise their mood! Also, exp will be shared amongst your recuits!";
    //hoverInfo = new HoverInfo(title,infoDescription,14,color(255),175,7,color(25,25,200,180),x,y,sizeX,sizeY,5,1,color(255));
    RecruitInfo = new HoverInfo("Recruiting",des,14,color(255),250,7,color(25,25,200,180),x+padding,y+padding,textWidth("Recruits"),20,5,1,color(255));
  }
  
  public void ActionEvent(Player pl,Enemy en) {
    if(show) {
      
      if(OverTimeButton.wasClicked) {
        OverTimeButton.wasClicked = false;
        if(RCP.OverWorkOn == false) {
          RCP.OverWorkOn = true;
          RCP.OverWorkButton.textColor = color(25,200,25);
          RCP.OverWorkButton.hoverInfo.updateDescription("[ON] Over Time",RCP.OverWorkButton.infoDescription);
          OverTimeButton.hoverInfo.updateDescription("[ON] Over Time",OverTimeButton.infoDescription);
          OverTimeButton.lineColor = color(25,200,25);
          OverTimeButton.textColor = color(25,200,25);
        } else { 
          RCP.OverWorkOn = false;
          RCP.OverWorkButton.textColor = color(200,25,25);
          RCP.OverWorkButton.hoverInfo.updateDescription("[OFF] Over Time",RCP.OverWorkButton.infoDescription);
          OverTimeButton.hoverInfo.updateDescription("[OFF] Over Time",OverTimeButton.infoDescription);
          OverTimeButton.lineColor = color(200,25,25);
          OverTimeButton.textColor = color(200,25,25);
        }
        for(int n  = 0; n < pl.guildUnit.size(); n++) {
          pl.guildUnit.get(n).OverTime = RCP.OverWorkOn;
        }
      }
      
      
      RCP.ActionEvent(pl,recruitPanel);
      for(int n = 0; n < pl.guildUnit.size();n++){
            
        pl.guildUnit.get(n).ActionEvent(en,pl);
      }
      if(RecruitConfigureButton.wasClicked) {
        RecruitConfigureButton.wasClicked = false;
        RCP.show = !RCP.show;
      }
    }
  }
  
  
  public void HoverEvent(Player pl) {
    if(show) {
      RCP.HoverEvent(pl);
      RecruitInfo.draw();
      RecruitConfigureButton.hoverInfo.draw();
      OverTimeButton.hoverInfo.draw();
      for(int n = 0; n < pl.guildUnit.size();n++){
        pl.guildUnit.get(n).UnitAsButton.hoverInfo.draw();
        pl.guildUnit.get(n).MoodBar.BarInfo.draw();
      }
    }
  }
  
  
  public void TimeEvent(Player pl) {
    RCP.TimeEvent(pl);
    for(int n = 0; n < pl.guildUnit.size();n++){
      pl.guildUnit.get(n).TimeEvent(pl);
    }
    
    if(show) {
      for(int n = 0; n < pl.guildUnit.size();n++){
        
        pl.guildUnit.get(n).UnitAsButton.UpdatePosition(x+padding + 55*n,y+sizeY - padding - 50);
        pl.guildUnit.get(n).MoodBar.UpdatePosition(x+padding + 55*n,y+sizeY - padding - 65);
        pl.guildUnit.get(n).MoodBar.updateBar(pl.guildUnit.get(n).currentMood,pl.guildUnit.get(n).Mood);
      }
    }
  }
  
  public void draw(Player pl) {
    if(show) {
      super.draw();
      
      RCP.draw(pl);
      
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Recruits",x+padding,y+padding);     
      RecruitConfigureButton.draw();
      OverTimeButton.draw();
      //temp
      double dps = 0;
      
      for(int n = 0; n < pl.guildUnit.size();n++){
        dps += pl.guildUnit.get(n).TotalDmg;
        pl.guildUnit.get(n).draw();
        pl.guildUnit.get(n).MoodBar.draw();
      }
      
      textSize(12);
      fill(180);
      textAlign(TOP,TOP);
      text((long)dps + " DPS",x+sizeX-padding -textWidth((long)dps + " DPS") - 50,y+padding + 4); 
      
    }
  }
  
  public void mouseReleased(Player pl) {
    if(show) {
      RCP.mouseReleased(pl);
      RecruitConfigureButton.mouseReleased();
      OverTimeButton.mouseReleased();
      for(int n = 0; n < pl.guildUnit.size();n++){
        pl.guildUnit.get(n).mouseReleased();
      }
    }
  }
  
  public void mousePressed(Player pl) {
    if(show) {
      RCP.mousePressed(pl);
      RecruitConfigureButton.mousePressed();
      OverTimeButton.mousePressed();
      for(int n = 0; n < pl.guildUnit.size();n++){
        pl.guildUnit.get(n).mousePressed();
      }  
    }
  }

  public void mouseWheel(MouseEvent event) {
    if(show) {
      RCP.mouseWheel(event);
    }
  } 
  
}
//Save
float SaveTime;
public void saveGame(Player pl,ArrayList<AreaDungeon> ad) {
  SaveTime += 1/frameRate;
  if(SaveTime > 60) {
    SaveTime = 0;
    Save(pl);
    SaveAreaDungeon(ad);
    //popText.add(new PopText((long)(TotalDmg-en.TotalDef)+"",1,0.5,mouseX,mouseY - 10,30,color(255)));
    popText.add(new PopText(wrapText("Your Game was Saved.",14,300),0.1f,3,100,height-100,14,(color(200,25,25))));
  }
}

public void SaveAreaDungeon(ArrayList<AreaDungeon> ad) {
  //JSONArray save = new JSONArray();
  
  Type listType = new TypeToken<List<AreaDungeon>>() {}.getType();
  List<AreaDungeon> target = new LinkedList<AreaDungeon>();
  
  for(int n = 0; n < ad.size(); n++) {
    target.add(ad.get(n));
  }
  
  Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
  String json = gson.toJson(target, listType);
  
  //saveJSONArray(, dataPath("Save\\SaveAreaDungeon.json"));
  PrintWriter save;
  save = createWriter(dataPath("Save\\SaveAreaDungeon.json"));
  save.println(json);
  save.flush();
  save.close();
}


public void Save(Player pl) {
  JSONObject save;
  Player target = pl;
  Gson gson = new  GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
  String json = gson.toJson(target);
  save = parseJSONObject(json);
  saveJSONObject(save, dataPath("Save\\Save.json"));
  
  //Player pla = gson.fromJson(json, Player.class);
}


public void Load() {
  if(new File(dataPath("Save\\Save.json")).exists()) {
    Gson gson = new  GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
    String json = "";
    String lines[] = loadStrings("Save\\Save.json");
    for(String a : lines) {
      json += a;
    }
    
    Player pl = gson.fromJson(json, Player.class);

    
    aPlayer.add(new Player(pl));
    
    
    for (int n = 0; n < pl.guildUnit.size(); n++) {
      GuildUnit g = pl.guildUnit.get(n);
      switch (pl.guildUnit.get(n).Name) {
        case "Assassin":
        aPlayer.get(0).guildUnit.add(new Assassin(g));
        break;
        case "Fighter":
        aPlayer.get(0).guildUnit.add(new Fighter(g));
        break;
        case "Priest":
        aPlayer.get(0).guildUnit.add(new Priest(g));
        break;
        case "Prism Indigo":
        aPlayer.get(0).guildUnit.add(new PrismIndigo(g));
        break;
        case "Protector":
        aPlayer.get(0).guildUnit.add(new Protector(g));
        break;
        case "Veteran":
        aPlayer.get(0).guildUnit.add(new Veteran(g));
        break;
        case "Leecher":
        aPlayer.get(0).guildUnit.add(new Leecher(g));
        break;
      }
    }
  } else { 
    aPlayer.add(new Player("Enter Name","This is the Player of the game",width/2 -40,height/2 +80,10,10,10,10,10));
  }
  
  if(new File(dataPath("Save\\SaveAreaDungeon.json")).exists()) {
    
    Gson gson = new  GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
    Type listType = new TypeToken<List<AreaDungeon>>() {}.getType();
    
    String json = "";
    String lines[] = loadStrings("Save\\SaveAreaDungeon.json");
    for(String a : lines) {
      json += a;
    }
    
    List<AreaDungeon> ad = gson.fromJson(json, listType);
    
    for(int n = 0; n < ad.size(); n++) {
      areaDungeon.add(new AreaDungeon(ad.get(n)));
    }
    
  } else {
    areaDungeon.add(new AreaDungeon("The Farm","Just about right.",color(200),"BackgroundImage/Farm.jpg",1000,0,color(204,255,255),1,1,1,1,1,3,1,1,0,1.02f,0.5f));
    areaDungeon.add(new AreaDungeon("The Forest","Beware of the deep hole...",color(200),"BackgroundImage/Forest.jpg",50,0,color(0,102,51),3,2,3,3,4,2.1f,1.8f,2.5f,0,1.05f,0.35f));
    areaDungeon.add(new AreaDungeon("Gold Mine's Idle","Too rich for your own good...",color(200),"BackgroundImage/Cave.jpg",100,0,color(204,204,0),23,14,3.5f,1,1,7.5f,0.15f,random(12,15),0,1.1f,0.2f));
    areaDungeon.add(new AreaDungeon("Cookie Realm","http:// orteil.dashnet.org/ cookieclicker/",color(200),"BackgroundImage/CookieClickerBG.jpg",50000,0,color(25,25,200),0,0,50,0,0,0,0.1f,0.1f,0,1.001f,0.00f));
    areaDungeon.add(new AreaDungeon("GoldSmiths","Easter egg",color(200),"BackgroundImage/GoldSmiths.jpg",10,0,color(204,204,0),100,0,0,0,0,7.5f,0,0,0,10,0));    
  }
}
//a literial scroll bar

public class ScrollBar {
  float sizeX,sizeY;
  float x,y;
  int background;
  int lineColor;
  float lineSize;
  float[] curve = new float[4];
  
  float contentLength;
  float boxSize;
  
  float inX,inY,inSizeX,inSizeY;

  
  boolean mPress,mRel;
  
  //ArrayList<Button> scrollButton = new ArrayList<Button>();
  public ScrollBar(float contentLength,float boxSize, float x,float y,float sizeX,float sizeY,int background,float curve,int lineColor,float lineSize) {
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.background = background;
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    this.curve[0] = curve;
    this.curve[1] = curve;
    this.curve[2] = curve;
    this.curve[3] = curve;  
    
    this.contentLength = contentLength;
    this.boxSize = boxSize;
    
    inX = x;
    inY = y;
    inSizeX = sizeX;
    inSizeY = sizeY;
  }
  
  //draw bar
  public void draw() {
    updateInnerBarSize();
    if(contentLength/boxSize > 1) {
      stroke(lineColor);
      strokeWeight(lineSize);
      fill(background);
      rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
      
      
      fill(lineColor);
      rect(inX,inY,inSizeX,inSizeY,curve[0],curve[1],curve[2],curve[3]);
      if(mPress) {
        innerBarMove();
      }
    } else {
      inY = 0;
    }
    
  }
  
  //gets content length
  
  //void updateConentLength(float cL) {
  //  contentLength = 15+bu.size()*50;
  //}
  
  //gets the size of the inner bar
  public void updateInnerBarSize() {
    inSizeY = (sizeY*boxSize)/contentLength;
    correctInnerBarPosition();
  }
  
  //moves the innner bar
  public void innerBarMove() {
    inY = mouseY - inSizeY/2;
    correctInnerBarPosition();
  }
  
  //reposition the inner bar if its out of boundaries
  public void correctInnerBarPosition() {
    if (inY < y) {
      inY = y;
    } else if (inY > sizeY-inSizeY + y) {
      inY = sizeY-inSizeY +y;
    }    
  }
  
  //move the content which the scroll bar controls
  //temp
  public float contentMove() {
    return  -((inY-y)/(sizeY-inSizeY))*(contentLength-boxSize);
  }
  
  
  public void mouseReleased() {
    mPress = false;
  }  
  
  public void mousePressed() {
    if(mouseOn()) {
      mPress = true;
    }
  }
  
public void mouseWheel(MouseEvent event,float cX,float cY,float cSX,float cSY) {
  if(mouseX > cX && mouseX < cX+cSX &&
    mouseY > cY && mouseY < cY+cSY) {
      inY += event.getCount()*25;
      correctInnerBarPosition();      
    }
  }

  
  
  
  public boolean mouseOn() {
    if(mouseX > inX && mouseX < inX+inSizeX &&
    mouseY > inY && mouseY < inY+inSizeY) {
      return true;
    } else {
      return false;
    }
  }
}
public class TavernPanel extends GeneralPanel {
  

  
  float moveY = 50;
  
  float BodyLength = 250;
  
  
  ScrollBar StatBody;
  
  
  ScrollBar HireBody;
  
  
  Button SleepButton;
  Button PrestigeButton;
  
  
  ArrayList<Button> HireButton = new ArrayList<Button>();
  ArrayList<Long> HireButtonPrice = new ArrayList<Long>();
  
  
  ArrayList<Button> BuffButton = new ArrayList<Button>();
  ArrayList<Long> BuffButtonPrice = new ArrayList<Long>();
  
  
  
  float hiretime;
  
  float mealtime;
  
  boolean showPrestigeButton;
  
  public TavernPanel(float x,float y,float sizeX,float sizeY,int background,float padding, float curve,int lineColor,float lineSize,Player thisPlayer) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    
    show = true;
    thisPlayer.InTavern = true;
    
    HireBody = new ScrollBar(0,BodyLength,x+sizeX,15,8,sizeY,color(0,150),0,color(255),1);
    //,correctBuffButtonX() ,correctBuffButtonY(),40,40,3,color(150),color(200,25,25),12,color(100),3));
    SleepButton = new Button("Refresh","stall time at the Inn, removing all recruits and meals from the Inn.",x+ padding, y + sizeY - padding - 60,sizeX-padding*2,35,3,color(150),color(255),15,color(100),3);
    PrestigeButton = new Button("Ascend","You have slain a realm lord. You can exile your soul to rebirth to a new dimension.",x+ padding, y + sizeY - padding - 100,sizeX-padding*2,35,3,color(139,0,139),color(255),15,color(75,0,130),3);
  }
  
  public float correctBuffButtonX() {
    return x+padding + (45+2)*(BuffButton.size() % 4);
  }
  public float correctBuffButtonY() {
    return y+padding+ moveY +BodyLength +20 + floor((45+2)*(BuffButton.size() / 4));
  }  
  
  //?
  public void TimeEvent() {
    hiretime += 1/frameRate;
    mealtime += 1/frameRate;
    
  }
  
  
  public void ActionEvent(ArrayList<Player> pl,Player ThisPlayer) {
    checkHireButton(ThisPlayer);
    CreateHireButton();
    //CreateBuffButton();
    checkBuffButton(pl,ThisPlayer);
    CreateBuffButton();
    RestUp();
    
    if(ThisPlayer.KilledRealmLord) {
      showPrestigeButton = true;
    }
    prestigeUp();
  }
  
  public void prestigeUp() {
    if(PrestigeButton.wasClicked) {
      PrestigeButton.wasClicked = false;
      if(showPrestigeButton) {
        //prestige
        
        
      }
    }
  }
  
  
  public void RestUp() {
    if(SleepButton.wasClicked) {
      SleepButton.wasClicked = false;
      BuffButton.clear();
      BuffButtonPrice.clear();
      HireButtonPrice.clear();
      HireButton.clear();
    }
  }
  
  
  
  public void CreateHireButton() {
    if(hiretime > 15) {
      hiretime = 0;
      if(HireButton.size() < 16) {
        randomRecruit();
      }
    }    
  }
  
  public void CreateBuffButton() {
    if(mealtime > 10) {
      mealtime = 0;
      if(BuffButton.size() < 8) {
        randomMeal();
      }
    }
  }
   
  
  
  public void randomMeal() {
    switch(round(random(5))) {
      case 0:
      BuffButtonPrice.add(1000l);
      BuffButton.add(new Button("REG+","Drink away your sorrows and enjoy! Gives your party a small regen boost for 180 secs. Cost "+ BuffButtonPrice.get(BuffButtonPrice.size()-1) + "z",correctBuffButtonX() ,correctBuffButtonY(),40,40,3,color(150),color(200,25,25),12,color(100),3));
      BuffButton.get(BuffButton.size()-1).hoverInfo.title = "Happy Hour";      
      break;
      case 1:
      BuffButtonPrice.add(9000l);
      BuffButton.add(new Button("EXP+","This legendary moonshine is over a century old, reason being cause nobody buys it. Gives your party a small exp boost for 180 secs. Cost "+ BuffButtonPrice.get(BuffButtonPrice.size()-1) + "z",correctBuffButtonX() ,correctBuffButtonY(),40,40,3,color(150),color(153,153,0),12,color(100),3));
      BuffButton.get(BuffButton.size()-1).hoverInfo.title = "Alex O' Moonshine";      
      break;
      case 2:
      BuffButtonPrice.add(1l);
      BuffButton.add(new Button("+1","Teedozo's Finger?! Why is this even on your menu meal?! Gives your party 1 bonus damage for 180 secs. Cost "+ BuffButtonPrice.get(BuffButtonPrice.size()-1) + "z",correctBuffButtonX(),correctBuffButtonY(),40,40,3,color(150),color(138,43,226),12,color(100),3));
      BuffButton.get(BuffButton.size()-1).hoverInfo.title = "Teedozo's Finger";      
      break;
      case 3:
      BuffButtonPrice.add(6969l);
      BuffButton.add(new Button("END+","If you can handle this, you can handle anything... Gives your party a small Endurance boost for 180 secs. Cost " +BuffButtonPrice.get(BuffButtonPrice.size()-1) + "z",correctBuffButtonX() ,correctBuffButtonY(),40,40,3,color(150),color(0,102,51),12,color(100),3));
      BuffButton.get(BuffButton.size()-1).hoverInfo.title = "Vomit Cake";      
      break;
      case 4:
      BuffButtonPrice.add(4352l);
      BuffButton.add(new Button("ZNY+","YOU GODDAM MONGORIAN! YOU MESSED UP MY CITI BEEF! Gives your party a small zeny boost for 180 secs. Cost " +BuffButtonPrice.get(BuffButtonPrice.size()-1) + "z",correctBuffButtonX() ,correctBuffButtonY(),40,40,3,color(150),color(120),12,color(100),3));
      BuffButton.get(BuffButton.size()-1).hoverInfo.title = "Mongorian Beef";          
      break;
      case 5:
      BuffButtonPrice.add(4096l);
      BuffButton.add(new Button("HP+","'This is Japanese lunch time rush'. Gives your party a small health boost for 180 secs. Cost " +BuffButtonPrice.get(BuffButtonPrice.size()-1) + "z",correctBuffButtonX() ,correctBuffButtonY(),40,40,3,color(150),color(175,25,25),12,color(100),3));
      BuffButton.get(BuffButton.size()-1).hoverInfo.title = "Japanese lunch time rush";
      break;
      case 6:
      
      break;
    }
  }
  
  public void randomRecruit() {
    switch(round(random(6))) {
      case 0:
      HireButtonPrice.add(10l);
      HireButton.add(new Button("Leecher","Hire me and I'll Leech exp off you! (literially)" + " Cost " + HireButtonPrice.get(HireButtonPrice.size()-1)+ "z",x+padding,y+padding + moveY + 40*HireButton.size(),sizeX - padding*2,35,3,color(150),color(255),15,color(100),3));
      HireBody.contentLength = 40*HireButton.size();     
      break;
      case 1:
      HireButtonPrice.add(1024l);
      HireButton.add(new Button("Priest","Bless you. (Weak stat growth, can buff you with regen and defence)" + " Cost " + HireButtonPrice.get(HireButtonPrice.size()-1)+ "z",x+padding,y+padding + moveY + 40*HireButton.size(),sizeX - padding*2,35,3,color(150),color(255),15,color(100),3));
      HireBody.contentLength = 40*HireButton.size();           
      break;
      case 2:
      HireButtonPrice.add(2048l);
      HireButton.add(new Button("Fighter","RAWRRRRR xD. (High stat growth)" + " Cost " + HireButtonPrice.get(HireButtonPrice.size()-1)+ "z",x+padding,y+padding + moveY + 40*HireButton.size(),sizeX - padding*2,35,3,color(150),color(255),15,color(100),3));
      HireBody.contentLength = 40*HireButton.size();
      break;
      case 3:
      HireButtonPrice.add(4096l);
      HireButton.add(new Button("Protector","The Heart is the Strongest Muscle. (low stat growth, blocks damage)" + " Cost " + HireButtonPrice.get(HireButtonPrice.size()-1)+ "z",x+padding,y+padding + moveY + 40*HireButton.size(),sizeX - padding*2,35,3,color(150),color(255),15,color(100),3));
      HireBody.contentLength = 40*HireButton.size();    
      break;
      case 4:
      HireButtonPrice.add(8192l);
      HireButton.add(new Button("Prism Indigo","Offer me with an amazing salary, with insurance, of course. (medium stat growth, Stronger at Over Time)" + " Cost " + HireButtonPrice.get(HireButtonPrice.size()-1)+ "z",x+padding,y+padding + moveY + 40*HireButton.size(),sizeX - padding*2,35,3,color(150),color(255),15,color(100),3));
      HireBody.contentLength = 40*HireButton.size();        
      break;
      case 5:
      HireButtonPrice.add(16384l);
      HireButton.add(new Button("Assassin","Disguised Toast. (low stat growth, can deal % dmg to enemy)" + " Cost " + HireButtonPrice.get(HireButtonPrice.size()-1)+ "z",x+padding,y+padding + moveY + 40*HireButton.size(),sizeX - padding*2,35,3,color(150),color(255),15,color(100),3));
      HireBody.contentLength = 40*HireButton.size();         
      break;
      case 6:
      HireButtonPrice.add(32768l);
      HireButton.add(new Button("Veteran","Too old. (low stat growth, becomes stronger per kill)" + " Cost " + HireButtonPrice.get(HireButtonPrice.size()-1)+ "z",x+padding,y+padding + moveY + 40*HireButton.size(),sizeX - padding*2,35,3,color(150),color(255),15,color(100),3));
      HireBody.contentLength = 40*HireButton.size();       
      break;
    }
  }  
  
  //guildUnit.add(new Priest(this,1, 0.8, 0.5, 0.1, 1,0));
  
  
  public void checkHireButton(Player ThisPlayer) {
    for(int n = 0; n < HireButton.size(); n++) {
      if(HireButton.get(n).wasClicked) {
        HireButton.get(n).wasClicked = false;
        if(ThisPlayer.guildUnit.size() < 4) {
          if(checkHireButtonPrice(n,ThisPlayer)) {
            ThisPlayer.Zeny -= HireButtonPrice.get(n);
            popText.add(new PopText("-" + HireButtonPrice.get(n) + "z", 1, 1, mouseX,mouseY,20,color(150)));
            createRecruit(ThisPlayer,HireButton.get(n));
            
            HireButton.remove(n);
            HireButtonPrice.remove(n);
            
          } else {
            popText.add(new PopText("You broke kokudorei...", 1, 1, mouseX,mouseY,20,color(200,25,25)));
          }
        } else {
          popText.add(new PopText("You already have 4 Recruits!", 1, 1, mouseX,mouseY,20,color(200,25,25)));
        }
      }
    }
  }
  
  public boolean checkHireButtonPrice(int ButtonIndex,Player pl) {
    if(pl.Zeny >= HireButtonPrice.get(ButtonIndex)) {
      return true;
    } else {
      return false;
    }
  }  
  
  //(Player pl,float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)
  public void createRecruit(Player pl,Button bu) {
    long exp = (long)(pl.Exp*0.4f);
    if(bu.title == "Leecher") {
      pl.guildUnit.add(new Leecher(0,0,0,0,0,0));
    } else if (bu.title == "Priest") {
      pl.guildUnit.add(new Priest(1, 4, 1, 2, 2,exp));
    } else if (bu.title == "Fighter") {
      pl.guildUnit.add(new Fighter(2, 7, 1, 0, 1,exp));
    } else if (bu.title == "Protector") {
      pl.guildUnit.add(new Protector(4, 4, 2, 0, 0,exp));
    } else if (bu.title == "Prism Indigo") {
      pl.guildUnit.add(new PrismIndigo(3, 5, 1, 1, 0,exp));
    } else if (bu.title == "Assassin") {
      pl.guildUnit.add(new Assassin(1, 6, 1, 1, 1,exp));
    } else if (bu.title == "Veteran") {
      pl.guildUnit.add(new Veteran(2, 3, 2, 2, 1,exp));
    }
  }
  
  
  
  public void checkBuffButton(ArrayList<Player> pl,Player ThisPlayer) {
    for(int n = 0; n < BuffButton.size(); n++) {
      if(BuffButton.get(n).wasClicked) {
        BuffButton.get(n).wasClicked = false;
        
        if(checkBuffButtonPrice(n,ThisPlayer)) {
          ThisPlayer.Zeny -= BuffButtonPrice.get(n);
          
          //(String text,float speedY,float LifeTime,float x,float y,float textSize,color textColor)
          popText.add(new PopText("-" + BuffButtonPrice.get(n) + "z", 1, 1, mouseX,mouseY,20,color(150)));
          createBuff(pl,BuffButton.get(n));
          
          BuffButton.remove(n);
          BuffButtonPrice.remove(n);
          
        } else {
          popText.add(new PopText("You broke kokudorei...", 1, 1, mouseX,mouseY,20,color(200,25,25)));
        }
        
      }
    }
  }
  
  
  
  
  public boolean checkBuffButtonPrice(int ButtonIndex,Player pl) {
    if(pl.Zeny >= BuffButtonPrice.get(ButtonIndex)) {
      return true;
    } else {
      return false;
    }
  }
  
  
  public void createBuff(ArrayList<Player> pl,Button BB) {
    if(BB.title == "REG+") {
      for(int n = 0; n < pl.size(); n++) {
        for(int i = 0; i < pl.get(n).buffIcon.size(); i++) {
          if("Happy Hour" == pl.get(n).buffIcon.get(i).title) {
            pl.get(n).buffIcon.get(i).Active = false;
            pl.get(n).buffIcon.get(i).GiveValueToUnit(pl.get(n));
          }
        }
        pl.get(n).buffIcon.add(new BuffIcon("Happy Hour","Gives " + ceil(pl.get(n).Level*0.025f) + " regen.",180,pl.get(n),0,0,0,0,0,0,0,0,ceil(pl.get(n).Level*0.025f),0,0,0,0,0,1,1,15,15,2,color(200,25,25),color(255),color(25,200,25),1));
      }
    } else if(BB.title == "EXP+") {
      for(int n = 0; n < pl.size(); n++) {
        for(int i = 0; i < pl.get(n).buffIcon.size(); i++) {
          if("Alex O' Moonshine" == pl.get(n).buffIcon.get(i).title) {
            pl.get(n).buffIcon.get(i).Active = false;
            pl.get(n).buffIcon.get(i).GiveValueToUnit(pl.get(n));
          }
        }
        pl.get(n).buffIcon.add(new BuffIcon("Alex O' Moonshine","Gives 20% bonus Exp.",180,pl.get(n),0.2f,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,15,15,2,color(153,153,0),color(255),color(25,200,25),1));
      }      
    } else if(BB.title == "+1") {
      for(int n = 0; n < pl.size(); n++) {
        for(int i = 0; i < pl.get(n).buffIcon.size(); i++) {
          if("Teedozo's Finger" == pl.get(n).buffIcon.get(i).title) {
            pl.get(n).buffIcon.get(i).Active = false;
            pl.get(n).buffIcon.get(i).GiveValueToUnit(pl.get(n));
          }
        }
        pl.get(n).buffIcon.add(new BuffIcon("Teedozo's Finger","Gives 1 bonus damage.",180,pl.get(n),0,0,0, 0,0,0,0,0, 0,0,1,0,0,0,1,1,15,15,2,color(138,43,226),color(255),color(25,200,25),1));
      }
    } else if(BB.title == "END+") {
      for(int n = 0; n < pl.size(); n++) {
        for(int i = 0; i < pl.get(n).buffIcon.size(); i++) {
          if("Vomit Cake" == pl.get(n).buffIcon.get(i).title) {
            pl.get(n).buffIcon.get(i).Active = false;
            pl.get(n).buffIcon.get(i).GiveValueToUnit(pl.get(n));
          }
        }
        pl.get(n).buffIcon.add(new BuffIcon("Vomit Cake","Gives "+(long)((pl.get(n).CharEnd+pl.get(n).ItemEnd)*0.1f)+" bonus Endurance.",180,pl.get(n),0,0,0, 0,0,(long)((pl.get(n).CharEnd+pl.get(n).ItemEnd)*0.1f),0,0, 0,0,0,0,0,0,1,1,15,15,2,color(0,102,51),color(255),color(25,200,25),1));
      }      
    } else if(BB.title == "ZNY+") {
      for(int n = 0; n < pl.size(); n++) {
        for(int i = 0; i < pl.get(n).buffIcon.size(); i++) {
          if("Mongorian Beef" == pl.get(n).buffIcon.get(i).title) {
            pl.get(n).buffIcon.get(i).Active = false;
            pl.get(n).buffIcon.get(i).GiveValueToUnit(pl.get(n));
          }
        }
        pl.get(n).buffIcon.add(new BuffIcon("Mongorian Beef","Gives 20% bonus Zeny.",180,pl.get(n),0,0.2f,0, 0,0,0,0,0, 0,0,0,0,0,0,1,1,15,15,2,color(120),color(255),color(25,200,25),1));
      }    
    } else if(BB.title == "HP+") { 
      for(int n = 0; n < pl.size(); n++) {
        for(int i = 0; i < pl.get(n).buffIcon.size(); i++) {
          if("Japanese lunch time rush" == pl.get(n).buffIcon.get(i).title) {
            pl.get(n).buffIcon.get(i).Active = false;
            pl.get(n).buffIcon.get(i).GiveValueToUnit(pl.get(n));
          }
        }
        pl.get(n).buffIcon.add(new BuffIcon("Japanese lunch time rush","Gives "+(long)(pl.get(n).Level*6)+" maximum health. ",180,pl.get(n),0,0.2f,0, 0,0,0,0,0, 0,0,0,(long)(pl.get(n).Level*6),0,0,1,1,15,15,2,color(175,25,25),color(255),color(25,200,25),1));
      }          
    }
  }
  
  
  
  public void HoverEvent() {
    if(show) {
      SleepButton.hoverInfo.draw();
      
      if(showPrestigeButton) {
        PrestigeButton.hoverInfo.draw();
      }
      
      if(mouseX > x+padding && mouseX < x+sizeX - padding &&
      mouseY > moveY + y+ padding && mouseY < moveY + y+ padding + BodyLength) {
        for(int n = 0; n < HireButton.size(); n++) {
          HireButton.get(n).hoverInfo.draw();
        }
      }
      for(int n = 0; n < BuffButton.size(); n++) {
        BuffButton.get(n).hoverInfo.draw();
      }
    }
  }
  
  public void draw(Player pl) {
    if(show) {
      super.draw();
      
      HireBody.draw();
      SleepButton.draw();
      
      if(showPrestigeButton) {
        PrestigeButton.draw();
        fill(255,0,255);
        textSize(13);
        textAlign(TOP,TOP);
        text("Prestige",x+padding,PrestigeButton.y-20);
        text(pl.Prestige+"",x+sizeX-padding-textWidth(pl.Prestige+""),PrestigeButton.y-20);
      }
      
      
      fill(255);
      textSize(16);
      textAlign(TOP,TOP);
      text("The Tavern Inn",x+padding,y+padding);
      
      fill(180);
      textSize(15);
      text("Recruit",x+padding,y+padding+ moveY-20);
      text(HireButton.size()+" (Max.16)",x+sizeX -padding - textWidth(HireButton.size()+" (Max.16)"),y+padding+ moveY-20);
      
      
      fill(0,150);
      stroke(255);
      strokeWeight(1);
      rect(x+padding-1,y+padding + moveY-1,sizeX-padding*2 +3 ,BodyLength +2,3,3,3,3);
      
      clip(x+padding,y+padding + moveY,x+sizeX-padding,BodyLength);

      
      for(int n = 0; n < HireButton.size(); n++) {
        HireButton.get(n).UpdatePosition(x+padding,(int)(y+padding + moveY + 40*n + +HireBody.contentMove()));
        
        HireButton.get(n).draw();
      }
      noClip();
      
      fill(180);
      textSize(15);      
      textAlign(TOP,TOP);
      text("Meals",x+padding,y+padding+ moveY +BodyLength);
      text(BuffButton.size()+" (Max.8)",x+sizeX - padding - textWidth(BuffButton.size()+" (Max.8)"),y+padding+ moveY +BodyLength);
      
      
      
      fill(0,150);
      stroke(255);
      strokeWeight(1);
      rect(x+padding -2,y+padding + moveY+ BodyLength + 20 -2,sizeX-padding*2 +5 ,87 +4,3,3,3,3);
      
      for(int n = 0; n < BuffButton.size(); n++) {
        BuffButton.get(n).UpdatePosition((x+padding + (45+2)*(n % 4)), y+padding+ moveY +BodyLength +20 + floor((45+2)*(n / 4)));
        BuffButton.get(n).draw();
      }
      
      
      
      stroke(120);
      strokeWeight(2);
      fill(180);
      rect(x+sizeX -padding -13,y+sizeY-padding -15,13,13,0,20,0,20);
      fill(200);
      textSize(13);
      textAlign(TOP,BOTTOM);
      text("Zeny",x+padding,y+sizeY-padding);
      text(pl.Zeny+"",x+sizeX - padding - textWidth(pl.Zeny+"") - 15,y+sizeY - padding);

    }
  }
  
  
  
  
  public void mousePressed() {
    if(show) {
      HireBody.mousePressed();
      SleepButton.mousePressed();
      
      if(showPrestigeButton) {
        PrestigeButton.mousePressed();
      }   
      
      for(int n = 0; n < BuffButton.size(); n++) {
        BuffButton.get(n).mousePressed();
      }
      
      
      if(mouseX > x+padding && mouseX < x+sizeX - padding &&
      mouseY > moveY + y+ padding && mouseY < moveY + y+ padding + BodyLength) {
        for(int n = 0;n < HireButton.size(); n++) {
          HireButton.get(n).mousePressed();
        }
      }
      
    }    
  }  
  
  public void mouseReleased() {
    
    if(show) {
      HireBody.mouseReleased();
      SleepButton.mouseReleased();
      if(showPrestigeButton) {
        PrestigeButton.mouseReleased();
      }      
      
      for(int n = 0; n < BuffButton.size(); n++) {
        BuffButton.get(n).mouseReleased();
      }
      
      for(int n = 0;n < HireButton.size(); n++) {
        HireButton.get(n).mouseReleased();
      }
      
      
    }      
  }
  
  public void mouseWheel(MouseEvent event) {
    if(show) {
      HireBody.mouseWheel(event,x,y,sizeX,sizeY);
    }
  }
    
}
public class Unit extends Object {
  
  //int counter;
  double TotalVit,TotalStr,TotalEnd,TotalAgi,TotalDex;
  double TotalHp,TotalDmg,TotalDef,TotalRegHp,TotalCrit,TotalCritDmg;
  
  //?
  //BigInteger BaseHp,BaseDmg,BaseDef,BaseRegHp,BaseCrit,BaseDodge,BaseHit,BaseCritDmg;
  @Expose
  double CharVit,CharStr,CharEnd,CharAgi,CharDex;
  @Expose
  double CharHp,CharDmg,CharDef,CharRegHp,CharCrit,CharCritDmg;
  
  @Expose
  double ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex;
  @Expose
  double ItemHp,ItemDmg,ItemDef,ItemRegHp,ItemCrit,ItemCritDmg;  
  
  
  
  double BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex;
  double BonusRegHp, BonusDef, BonusDmg,BonusHp,BonusCrit, BonusCritDmg;
  double rawBonusRegHp, rawBonusDef, rawBonusDmg,rawBonusHp,rawBonusCrit, rawBonusCritDmg;
  double statBonusRegHp, statBonusDef, statBonusDmg,statBonusHp,statBonusCrit, statBonusCritDmg;
  
  
  
  float TotalCritPercent;
  float BonusCritPercent;
  @Expose
  float ItemCritPercent;
  @Expose
  float CharCritPercent;
  
  float BonusExp;
  @Expose
  float ItemExp;
  @Expose
  float CharExp;
  
  float BonusZeny;
  @Expose
  float ItemZeny;
  @Expose
  float CharZeny;
  
  float BonusPrestige;
  @Expose
  float ItemPrestige;
  @Expose
  float CharPrestige;  
  
  //?
  float DropBonus;
  
  //?
  //long MaxHp, Hp, Dmg, Def,RegHp,Crit,Dodge,Hit,CritDmg;
  double CurrentHp;
  
  
  //?
  boolean Alive;
  
  
  //triggering event
  boolean UnitPlaced;
  
  
  Button UnitAsButton;
  
  ValueBar HpBar;
  
  
  public Unit(String Name,String Description,float x,float y,double CharVit,double CharStr,double CharEnd,double CharAgi,double CharDex) {
    super(Name,Description,x,y);
    this.CharVit = CharVit;
    this.CharStr = CharStr;
    this.CharEnd = CharEnd;
    this.CharAgi = CharAgi;
    this.CharDex = CharDex;
    Alive = true;
    updateStat();
    CurrentHp = TotalHp;
    UnitPlaced = true;
    //public Button(String text,String infoDescription,float x,float y,float sizeX,float sizeY,float curve,color background,color textColor,float textSize,color lineColor,float lineSize) {
  }
  
  public double ConvertStatToAdv(double v,double s,double e,double a,double d,float mV,float mS,float mE,float mA,float mD) {
    //CharHp = CharHp.multiply(new BigInteger("7"));
    double ReturnedValue = (double)(v*mV + s*mS + e*mE + a*mA + d*mD);
    return ReturnedValue;
  }
  
  public void draw() {
    if(UnitPlaced) {
      UnitAsButton.draw();
    }
  }
  
  
  
  public void updateStat() {
    statBonusStatToBonusAdv();
    TotalBonusAdv();
    CharStatToCharAdv();
    ItemStatToBonusAdv();
    TotalStat();
    AdvTotalStat();
    UniqueStats();
  }
  
  public void UniqueStats() {
    TotalCritPercent = CharCritPercent + ItemCritPercent + BonusCritPercent;
  }
  
  public void CharStatToCharAdv() {
    CharHp = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,8,0,0,0,0);
    CharDmg = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,0,1,0,0,0);
    CharDef = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,0,0,0.5f,0,0);
    CharRegHp = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,0.04f,0,0,0,0);
    CharCrit = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,0,0,0,1,0);
    CharCritDmg = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharAgi,CharDex,0,0,0,0,1);
  }
  
  //?
  public void statBonusStatToBonusAdv() {
    statBonusHp = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,8,0,0,0,0);
    statBonusDmg = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,1,0,0,0);
    statBonusDef = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,0,0.5f,0,0);
    statBonusRegHp = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0.04f,0,0,0,0);
    statBonusCrit = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,0,0,1,0);
    statBonusCritDmg = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex,0,0,0,0,1);
  }
  
  public void TotalBonusAdv() {
    BonusHp = statBonusHp + rawBonusHp;
    BonusDmg = statBonusDmg + rawBonusDmg;
    BonusDef = statBonusDef + rawBonusDef;
    BonusRegHp = statBonusRegHp + rawBonusRegHp;
    BonusCrit = statBonusCrit + rawBonusCrit;
    BonusCritDmg = statBonusCritDmg + rawBonusCritDmg;
  }  
  
  //?
  public void ItemStatToBonusAdv() {
    ItemHp = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,8,0,0,0,0);
    ItemDmg = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,0,1,0,0,0);
    ItemDef = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,0,0,0.5f,0,0);
    ItemRegHp = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,0.04f,0,0,0,0);
    ItemCrit = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,0,0,0,1,0);
    ItemCritDmg = ConvertStatToAdv(ItemVit,ItemStr,ItemEnd,ItemAgi,ItemDex,0,0,0,0,1);
  }   
  
  
  
  public void TotalStat() {
    TotalVit = CharVit+(BonusVit)+(ItemVit) ;
    TotalStr = CharStr+(BonusStr)+(ItemStr);
    TotalEnd = CharEnd+(BonusEnd)+(ItemEnd);
    TotalAgi = CharAgi+(BonusAgi)+(ItemAgi);
    TotalDex = CharDex+(BonusDex)+(ItemDex);
  }
  
  public void AdvTotalStat() {
    TotalHp = CharHp+(BonusHp)+(ItemHp);
    TotalDmg = CharDmg+(BonusDmg)+(ItemDmg);
    TotalDef = CharDef+(BonusDef)+(ItemDef);
    TotalRegHp = CharRegHp+(BonusRegHp)+(ItemRegHp);
    TotalCrit = CharCrit+(BonusCrit)+(ItemCrit);
    TotalCritDmg = CharCritDmg+(BonusCritDmg)+(ItemCritDmg);
    
    correctCurrentHp();
  }  
  
  
   public void Dead() {
    if (CurrentHp <= 0 && Alive && UnitPlaced) {
     CurrentHp = 0;
     Alive = false;
    }  
  }
  
  
  
  public void correctCurrentHp() {
    if (TotalHp <1) {
      CurrentHp = 1;
      TotalHp = CurrentHp;
    }
    if(TotalHp < CurrentHp) {
      CurrentHp = TotalHp;
    }    
  }
  
  
  public void TimeEvent() {
    RegenHp();
    //updateStat();
  }
  
  //problems with long/double
  public void RegenHp() {
    if(Alive) {
      CurrentHp += (TotalRegHp/frameRate);
      correctCurrentHp();
    }
  }
  
  public void HoverEvent() {
    if(UnitPlaced) {
      UnitAsButton.hoverInfo.draw();
    }
  }
  
  public void ActionEvent() {
    if(UnitPlaced) {
      Dead();
    }
  }
  
}

//public class Unit extends Object {
  
//  //int counter;
  
//  BigInteger TotalVit,TotalStr,TotalEnd,TotalAgi,TotalDex;
//  BigInteger TotalHp,TotalDmg,TotalDef,TotalRegHp,TotalCrit,TotalCritDmg;
  
//  //?
//  //BigInteger BaseHp,BaseDmg,BaseDef,BaseRegHp,BaseCrit,BaseDodge,BaseHit,BaseCritDmg;
  
//  BigInteger CharVit,CharStr,CharEnd,CharAgi,CharDex;
//  BigInteger CharHp,CharDmg,CharDef,CharRegHp,CharCrit,CharCritDmg;

//  BigInteger BonusVit,BonusStr,BonusEnd,BonusAgi,BonusDex;
//  BigInteger BonusRegHp, BonusDef, BonusDmg,BonusHp,BonusCrit, BonusCritDmg;
  
//  float DropBonus;
  
//  //?
//  BigInteger MaxHp, Hp, Dmg, Def,RegHp,Crit,Dodge,Hit,CritDmg;
  
//  //?
//  String UnitType;
  
//  //?
//  boolean Alive,UnitPlaced;
  
//  public Unit(String Name,String Description,float x,float y,BigInteger CharVit,BigInteger CharStr,BigInteger CharEnd,BigInteger CharAgi,BigInteger CharDex) {
//    super(Name,Description,x,y);
//    this.CharVit = CharVit;
//    this.CharStr = CharStr;
//    this.CharEnd = CharEnd;
//    this.CharAgi = CharAgi;
//    this.CharDex = CharDex;
    
//    BonusStatToBonusAdv();
//    CharStatToCharAdv();
//    TotalStat();
//    AdvTotalStat();
//  }
  
//  BigInteger ConvertStatToAdv(BigInteger v,BigInteger s,BigInteger e,BigInteger a,BigInteger d,int mV,int mS,int mE,int mA,int mD) {
//    //CharHp = CharHp.multiply(new BigInteger("7"));
//    BigInteger ReturnedValue = v.multiply(new BigInteger(mV+"")).add(s.multiply(new BigInteger(mS+""))).add(e.multiply(new BigInteger(mE+""))).add(a.multiply(new BigInteger(mA+""))).add(d.multiply(new BigInteger(mD+"")));
//    return ReturnedValue;
//  }
  
//  void CharStatToCharAdv() {
//    CharHp = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharEnd,CharDex,7,0,0,0,0);
//    CharDmg = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharEnd,CharDex,0,2,0,0,0);
//    CharDef = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharEnd,CharDex,0,0,1,0,0);
//    CharRegHp = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharEnd,CharDex,1,0,0,0,0);
//    CharCrit = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharEnd,CharDex,0,0,0,1,0);
//    CharCritDmg = ConvertStatToAdv(CharVit,CharStr,CharEnd,CharEnd,CharDex,0,0,0,0,1);
//  }
  
//  //?
//  void BonusStatToBonusAdv() {
//    BonusHp = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusEnd,BonusDex,7,0,0,0,0);
//    BonusDmg = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusEnd,BonusDex,0,2,0,0,0);
//    BonusDef = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusEnd,BonusDex,0,0,1,0,0);
//    BonusRegHp = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusEnd,BonusDex,1,0,0,0,0);
//    BonusCrit = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusEnd,BonusDex,0,0,0,1,0);
//    BonusCritDmg = ConvertStatToAdv(BonusVit,BonusStr,BonusEnd,BonusEnd,BonusDex,0,0,0,0,1);
//  }  
  
//  void TotalStat() {
//    TotalVit = CharVit.add(BonusVit);
//    TotalStr = CharStr.add(BonusStr);
//    TotalEnd = CharEnd.add(BonusEnd);
//    TotalAgi = CharAgi.add(BonusAgi);
//    TotalDex = CharDex.add(BonusDex);
//  }
  
//  void AdvTotalStat() {
//    TotalHp = CharHp.add(BonusHp);
//    TotalDmg = CharDmg.add(BonusDmg);
//    TotalDef = CharDef.add(BonusDef);
//    TotalRegHp = CharRegHp.add(BonusRegHp);
//    TotalCrit = CharCrit.add(BonusCrit);
//    TotalCritDmg = CharCritDmg.add(BonusCritDmg);
    
//    if (MaxHp <1) {
//      Hp = 1;
//      MaxHp = Hp;
//    }
//    if(MaxHp < Hp) {
//      Hp = MaxHp;
//    }
//  }
//}
//temp
public class ValueBar {
  double MaxValue;
  double CurrentValue;
  float x,y;
  float sizeX,sizeY;
  int background;
  
  int lineColor;
  float lineSize;
  float[] curve = new float[4];
  
  float inX,inY;
  float inSizeX,inSizeY;
  
  int innerBackground;
  
  
  HoverInfo BarInfo;
  String title;
  String Description;
  
  public ValueBar(double MaxValue,float x,float y,float sizeX,float sizeY,int background,float curve,int lineColor,float lineSize,int innerBackground) {
    this.MaxValue = MaxValue;
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.background = background;
    for(int n = 0;n < 4;n++) {
      this.curve[n] = curve;
    }
    this.lineColor = lineColor;
    this.lineSize = lineSize;
    this.innerBackground = innerBackground;
    
    inX = x;
    inY = y;
    inSizeX = sizeX;
    inSizeY = sizeY;
    title = "";
    Description = "";
  }
  
  public ValueBar(String title,String Description, double MaxValue,float x,float y,float sizeX,float sizeY,int background,float curve,int lineColor,float lineSize,int innerBackground) {
    this( MaxValue, x, y, sizeX, sizeY, background, curve, lineColor, lineSize, innerBackground);
    this.title = title;
    this.Description = Description;
    //HoverInfo(title,infoDescription,14,color(255),175,7,color(25,25,200,150),x,y,sizeX,sizeY,5,1,color(255));
    BarInfo = new HoverInfo(title,Description,14,color(255),175,7,color(25,25,200,150),x,y,sizeX,sizeY,5,1,color(255));
  }  
  
  public void UpdatePosition(float x,float y){
    this.x = x;
    this.y = y;
    inX = x;
    inY = y;
    BarInfo.updatePosition(x,y);
  }
  
  public void draw() {
    
    fill(background);
    stroke(lineColor);
    strokeWeight(lineSize);
    
    //outer 
    rect(x,y,sizeX,sizeY,curve[0],curve[1],curve[2],curve[3]);
    
    //inner
    fill(innerBackground);
    rect(inX,inY,inSizeX,inSizeY,curve[0],curve[1],curve[2],curve[3]);
    
    textSize(sizeY-1);
    textAlign(TOP,CENTER);
    fill(255);
    if(MaxValue > 10) {
      text((long)(CurrentValue)+"/"+(long)(MaxValue),x+sizeX - textWidth((long)(CurrentValue)+"/"+(long)(MaxValue))-5,y +sizeY/2 -1);
    } else {
      text( String.format("%.2f", CurrentValue) +"/"+String.format("%.2f", MaxValue),x+sizeX - textWidth(String.format("%.2f", CurrentValue) +"/"+String.format("%.2f", MaxValue))-5,y +sizeY/2 -1);
    }
  }
  
  public double getRatio(double CurrentValue) {
    if(CurrentValue/MaxValue > 1) {
      return 1;
    } else if(CurrentValue/MaxValue < 0) {
      return 0;
    } else {
      return CurrentValue/MaxValue;
    }
  }
  
  public void updateBar(double CurrentValue,double MaxValue) {
    inSizeX = sizeX * (float)getRatio(CurrentValue);
    this.MaxValue = MaxValue;
    this.CurrentValue = CurrentValue;
    
  }
}
public class Veteran extends GuildUnit {
  
  public Veteran(float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)  {
    super(uVit, uStr, uEnd, uAgi, uDex, exp);
    Name = "Veteran";
    Description = "Gains 1 Strength per 10 kills. ";
    MoodCriticalPoint = 35;
    MoodSpeed = 0.1f;
    UnitAsButton = new Button(Name,Description,x,y,50,50,3,color(25,200,25),color(255),12,color(255),1);
    
    
    //temp
    CharStr += KillCount*0.1f;
  }
  
  public Veteran(GuildUnit gu) {
    this(gu. uVit,gu. uStr,gu. uEnd,gu. uAgi,gu. uDex,gu. Exp);
    this.currentMood = gu.currentMood;
    KillCount = gu.KillCount;
    CharStr += KillCount*0.1f;
  }
    
  
  
  
  @Override
  public void TimeEvent(Player pl) {
    super.TimeEvent(pl);
    UnitAsButton.hoverInfo.updateDescription(Name,Description + "Have currently slain " + KillCount +". Strength gain + " + (long)(KillCount*0.1f));
  }
  
  
  @Override
  public void ActionEvent(Enemy en,Player pl) {
    super.ActionEvent(en,pl);
  }
  
  @Override
  public void TriggerOnEnemyDeadEvent(Enemy en) {
    super.TriggerOnEnemyDeadEvent(en);
    StrengthGain();
  }
  
  public void StrengthGain() {
    KillCount++;
    CharStr += 0.1f;
  }
  
  
  public void draw() {
    super.draw();
  }
  
   
  public void mousePressed() {
    UnitAsButton.mousePressed();
  }
  
  public void mouseReleased() {
    UnitAsButton.mouseReleased();
  }
}
//Wrap text
//note:
//this doesnt return how many times it had wrapped
//best used in textAlign(TOP,TOP);

//gets wrapped version
public String wrapText(String text,float textSize,float contentWidth) {
  String textConstructor = "";
  String[] word = text.split("\\s+");
  String tempText = "";
  textSize(textSize);
  
  for(int n = 0;n < word.length;n++) {
    if(textWidth(tempText+word[n]) > contentWidth) {
      textConstructor += "\n";
      tempText = "";
    }
    tempText += word[n] + " ";
    textConstructor += word[n] + " ";
  }
  
  return textConstructor;
}

//gets the number of wrap// \n in the text
public int wrapNumber(String text,float textSize,float contentWidth) {
  int line = 1;
  String[] word = text.split("\\s+");
  String tempText = "";
  textSize(textSize);
 
  for(int n = 0;n < word.length;n++) {
    if(textWidth(tempText+word[n]) > contentWidth) {
      tempText = "";
      line++;
    }
    tempText += word[n] + " ";
  }
  
  return line;
}
  public void settings() {  size(1150,600,JAVA2D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "JackyClicker" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
