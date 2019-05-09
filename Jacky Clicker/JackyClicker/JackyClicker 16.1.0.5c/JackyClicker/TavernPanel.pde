public class TavernPanel extends GeneralPanel {
  

  
  float moveY = 50;
  
  float BodyLength = 250;
  
  
  ScrollBar StatBody;
  
  
  ScrollBar HireBody;
  
  
  ArrayList<Button> HireButton = new ArrayList<Button>();
  ArrayList<Long> HireButtonPrice = new ArrayList<Long>();
  
  
  ArrayList<Button> BuffButton = new ArrayList<Button>();
  ArrayList<Long> BuffButtonPrice = new ArrayList<Long>();
  
  
  
  float hiretime;
  
  float mealtime;
  
  public TavernPanel(float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    
    
    HireBody = new ScrollBar(0,BodyLength,x+sizeX,15,8,sizeY,color(0,150),0,color(255),1);
    
    
    
    //BuffButtonPrice.add(1000l);
    //BuffButton.add(new Button("REG+","Drink away your sorrows and enjoy! Gives your party a small regen boost for 90 secs. Cost "+ BuffButtonPrice.get(BuffButtonPrice.size()-1) + "z",correctBuffButtonX() ,correctBuffButtonY(),40,40,3,color(150),color(200,25,25),12,color(100),3));
    //BuffButton.get(BuffButton.size()-1).hoverInfo.title = "Happy Hour";
    
    //BuffButtonPrice.add(9000l);
    //BuffButton.add(new Button("EXP+","This legendary moonshine is over a century old, reason being cause nobody buys it. Gives your party a small exp boost for 90 secs. Cost "+ BuffButtonPrice.get(BuffButtonPrice.size()-1) + "z",correctBuffButtonX() ,correctBuffButtonY(),40,40,3,color(150),color(153,153,0),12,color(100),3));
    //BuffButton.get(BuffButton.size()-1).hoverInfo.title = "Alex O' Moonshine";
    
    
    //BuffButtonPrice.add(1l);
    //BuffButton.add(new Button("+1","Teedozo's Finger?! Why is this even on your menu meal?! Gives your party 1 bonus damage for 90 secs. Cost "+ BuffButtonPrice.get(BuffButtonPrice.size()-1) + "z",correctBuffButtonX(),correctBuffButtonY(),40,40,3,color(150),color(138,43,226),12,color(100),3));
    //BuffButton.get(BuffButton.size()-1).hoverInfo.title = "Teedozo's Finger";
    
    //BuffButtonPrice.add(6969l);
    //BuffButton.add(new Button("END+","If you can handle this, you can handle anything... Gives your party a small Endurance boost for 90 secs. Cost " +BuffButtonPrice.get(BuffButtonPrice.size()-1) + "z",correctBuffButtonX() ,correctBuffButtonY(),40,40,3,color(150),color(0,102,51),12,color(100),3));
    //BuffButton.get(BuffButton.size()-1).hoverInfo.title = "Vomit Cake";
       
    
    //BuffButtonPrice.add(4352l);
    //BuffButton.add(new Button("ZNY+","YOU GODDAM MONGORIAN! YOU MESSED UP MY CITI BEEF! Gives your party a small zeny boost for 90 secs. Cost " +BuffButtonPrice.get(BuffButtonPrice.size()-1) + "z",correctBuffButtonX() ,correctBuffButtonY(),40,40,3,color(150),color(120),12,color(100),3));
    //BuffButton.get(BuffButton.size()-1).hoverInfo.title = "Mongorian Beef";    
    
    
    //BuffButtonPrice.add(999999999999999999l);
    //BuffButton.add(new Button("McN","You knew this was gonna be in the game... Cost £4.19 for Box of 20 pc.",correctBuffButtonX() ,correctBuffButtonY(),40,40,3,color(150),color(138,43,226),12,color(100),3));
    //BuffButton.get(BuffButton.size()-1).hoverInfo.title = "McNugget";
    

  }
  
  float correctBuffButtonX() {
    return x+padding + (45+2)*(BuffButton.size() % 4);
  }
  float correctBuffButtonY() {
    return y+padding+ moveY +BodyLength +20 + floor((45+2)*(BuffButton.size() / 4));
  }  
  
  //?
  void TimeEvent() {
    hiretime += 1/frameRate;
    mealtime += 1/frameRate;
  }
  
  
  void ActionEvent(ArrayList<Player> pl,Player ThisPlayer) {
    checkHireButton(ThisPlayer);
    CreateHireButton();
    //CreateBuffButton();
    checkBuffButton(pl,ThisPlayer);
    CreateBuffButton();
  }
  
  
  
  
  void CreateHireButton() {
    if(hiretime > 1) {
      hiretime = 0;
      if(HireButton.size() < 16) {
        randomRecruit();
      }
    }    
  }
  
  void CreateBuffButton() {
    if(mealtime > 1) {
      mealtime = 0;
      if(BuffButton.size() < 8) {
        randomMeal();
      }
    }
  }
   
  
  
  void randomMeal() {
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
  
  void randomRecruit() {
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
      HireButtonPrice.add(1048576l);
      HireButton.add(new Button("Assassin","Disguised Toast. (low stat growth, can deal % dmg to enemy)" + " Cost " + HireButtonPrice.get(HireButtonPrice.size()-1)+ "z",x+padding,y+padding + moveY + 40*HireButton.size(),sizeX - padding*2,35,3,color(150),color(255),15,color(100),3));
      HireBody.contentLength = 40*HireButton.size();         
      break;
      case 6:
      HireButtonPrice.add(2097152l);
      HireButton.add(new Button("Veteran","Too old. (low stat growth, becomes stronger per kill)" + " Cost " + HireButtonPrice.get(HireButtonPrice.size()-1)+ "z",x+padding,y+padding + moveY + 40*HireButton.size(),sizeX - padding*2,35,3,color(150),color(255),15,color(100),3));
      HireBody.contentLength = 40*HireButton.size();       
      break;
    }
  }  
  
  //guildUnit.add(new Priest(this,1, 0.8, 0.5, 0.1, 1,0));
  
  
  void checkHireButton(Player ThisPlayer) {
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
  
  boolean checkHireButtonPrice(int ButtonIndex,Player pl) {
    if(pl.Zeny >= HireButtonPrice.get(ButtonIndex)) {
      return true;
    } else {
      return false;
    }
  }  
  
  //(Player pl,float uVit,float uStr,float uEnd,float uAgi,float uDex,long exp)
  void createRecruit(Player pl,Button bu) {
    long exp = (long)(pl.Exp*0.4);
    if(bu.title == "Leecher") {
      pl.guildUnit.add(new Leecher(pl,0,0,0,0,0,0));
    } else if (bu.title == "Priest") {
      pl.guildUnit.add(new Priest(pl,1, 0.6, 0.5, 0.1, 1,exp));
    } else if (bu.title == "Fighter") {
      pl.guildUnit.add(new Fighter(pl,1, 1.6, 1.1, 0.1, 0.8,exp));
    } else if (bu.title == "Protector") {
      pl.guildUnit.add(new Protector(pl,2, 0.55, 0.15, 0.4, 0.2,exp));
    } else if (bu.title == "Prism Indigo") {
      pl.guildUnit.add(new PrismIndigo(pl,1, 0.85, 0.6, 0.7, 0.3,exp));
    } else if (bu.title == "Assassin") {
      pl.guildUnit.add(new Assassin(pl,0.7, 0.45, 0.35, 0.55, 0.3,exp));
    } else if (bu.title == "Veteran") {
      pl.guildUnit.add(new Veteran(pl,0.2, 0.3, 0.55, 0.25, 0.3,exp,14365));
    }
  }
  
  
  
  void checkBuffButton(ArrayList<Player> pl,Player ThisPlayer) {
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
  
  
  
  
  boolean checkBuffButtonPrice(int ButtonIndex,Player pl) {
    if(pl.Zeny >= BuffButtonPrice.get(ButtonIndex)) {
      return true;
    } else {
      return false;
    }
  }
  
  
  void createBuff(ArrayList<Player> pl,Button BB) {
    if(BB.title == "REG+") {
      for(int n = 0; n < pl.size(); n++) {
        for(int i = 0; i < pl.get(n).buffIcon.size(); i++) {
          if("Happy Hour" == pl.get(n).buffIcon.get(i).title) {
            pl.get(n).buffIcon.get(i).Active = false;
            pl.get(n).buffIcon.get(i).GiveValueToUnit();
          }
        }
        pl.get(n).buffIcon.add(new BuffIcon("Happy Hour","Gives " + ceil(pl.get(n).Level*0.025) + " regen.",180,pl.get(n),0,0,0,0,0,0,0,0,ceil(pl.get(n).Level*0.025),0,0,0,0,0,1,1,15,15,2,color(200,25,25),color(255),color(25,200,25),1));
      }
    } else if(BB.title == "EXP+") {
      for(int n = 0; n < pl.size(); n++) {
        for(int i = 0; i < pl.get(n).buffIcon.size(); i++) {
          if("Alex O' Moonshine" == pl.get(n).buffIcon.get(i).title) {
            pl.get(n).buffIcon.get(i).Active = false;
            pl.get(n).buffIcon.get(i).GiveValueToUnit();
          }
        }
        pl.get(n).buffIcon.add(new BuffIcon("Alex O' Moonshine","Gives 20% bonus Exp.",180,pl.get(n),0.2,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,15,15,2,color(153,153,0),color(255),color(25,200,25),1));
      }      
    } else if(BB.title == "+1") {
      for(int n = 0; n < pl.size(); n++) {
        for(int i = 0; i < pl.get(n).buffIcon.size(); i++) {
          if("Teedozo's Finger" == pl.get(n).buffIcon.get(i).title) {
            pl.get(n).buffIcon.get(i).Active = false;
            pl.get(n).buffIcon.get(i).GiveValueToUnit();
          }
        }
        pl.get(n).buffIcon.add(new BuffIcon("Teedozo's Finger","Gives 1 bonus damage.",180,pl.get(n),0,0,0, 0,0,0,0,0, 0,0,1,0,0,0,1,1,15,15,2,color(138,43,226),color(255),color(25,200,25),1));
      }
    } else if(BB.title == "END+") {
      for(int n = 0; n < pl.size(); n++) {
        for(int i = 0; i < pl.get(n).buffIcon.size(); i++) {
          if("Vomit Cake" == pl.get(n).buffIcon.get(i).title) {
            pl.get(n).buffIcon.get(i).Active = false;
            pl.get(n).buffIcon.get(i).GiveValueToUnit();
          }
        }
        pl.get(n).buffIcon.add(new BuffIcon("Vomit Cake","Gives "+(long)((pl.get(n).CharEnd+pl.get(n).ItemEnd)*0.1)+" bonus Endurance.",180,pl.get(n),0,0,0, 0,0,(long)((pl.get(n).CharEnd+pl.get(n).ItemEnd)*0.1),0,0, 0,0,0,0,0,0,1,1,15,15,2,color(0,102,51),color(255),color(25,200,25),1));
      }      
    } else if(BB.title == "ZNY+") {
      for(int n = 0; n < pl.size(); n++) {
        for(int i = 0; i < pl.get(n).buffIcon.size(); i++) {
          if("Mongorian Beef" == pl.get(n).buffIcon.get(i).title) {
            pl.get(n).buffIcon.get(i).Active = false;
            pl.get(n).buffIcon.get(i).GiveValueToUnit();
          }
        }
        pl.get(n).buffIcon.add(new BuffIcon("Mongorian Beef","Gives 20% bonus Zeny.",180,pl.get(n),0,0.2,0, 0,0,0,0,0, 0,0,0,0,0,0,1,1,15,15,2,color(120),color(255),color(25,200,25),1));
      }    
    } else if(BB.title == "HP+") { 
      for(int n = 0; n < pl.size(); n++) {
        for(int i = 0; i < pl.get(n).buffIcon.size(); i++) {
          if("Japanese lunch time rush" == pl.get(n).buffIcon.get(i).title) {
            pl.get(n).buffIcon.get(i).Active = false;
            pl.get(n).buffIcon.get(i).GiveValueToUnit();
          }
        }
        pl.get(n).buffIcon.add(new BuffIcon("Japanese lunch time rush","Gives "+(long)(pl.get(n).Level*6)+" maximum health. ",180,pl.get(n),0,0.2,0, 0,0,0,0,0, 0,0,0,(long)(pl.get(n).Level*6),0,0,1,1,15,15,2,color(175,25,25),color(255),color(25,200,25),1));
      }          
    }
  }
  
  
  
  public void HoverEvent() {
    if(show) {
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
  
  
  
  
  void mousePressed() {
    if(show) {
      HireBody.mousePressed();
      
      
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
  
  void mouseReleased() {
    
    if(show) {
      HireBody.mouseReleased();
      
      for(int n = 0; n < BuffButton.size(); n++) {
        BuffButton.get(n).mouseReleased();
      }
      
      for(int n = 0;n < HireButton.size(); n++) {
        HireButton.get(n).mouseReleased();
      }
      
      
    }      
  }
  
  void mouseWheel(MouseEvent event) {
    if(show) {
      HireBody.mouseWheel(event,x,y,sizeX,sizeY);
    }
  }
    
}