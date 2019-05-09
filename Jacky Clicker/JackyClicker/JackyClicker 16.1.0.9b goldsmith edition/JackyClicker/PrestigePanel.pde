protected class PrestigePanel extends GeneralPanel {

  private ScrollBar ButtonBody;
  
  private Button PrestigeButton;
  
  
  private ArrayList<Button> UpgradeButton = new ArrayList<Button>();
  private ArrayList<Long> UpgradeButtonPrice = new ArrayList<Long>();
  
  private Player pl;
  
  
  private ValueBar PrestigeBar;
  
  
  private Button PrestigeLevelShow;
  
  protected PrestigePanel(Player pl,float x,float y,float sizeX,float sizeY,color background,float padding, float curve,color lineColor,float lineSize) {
    super( x, y, sizeX, sizeY, background, padding, curve, lineColor, lineSize);
    this.pl = pl;
    PrestigeButton = new Button("Rebirth","Enter to a new dimension...",x+sizeX-padding - 100, y + sizeY - padding - 35,100,35,3,color(139,0,139),color(255),15,color(75,0,130),3);
    PrestigeBar = new ValueBar("Prestige Level","", pl.PrestigeDiff,208 + padding + 20,y+sizeY-padding -10, sizeX-padding*2 - 90 -(208 + padding + 20),10,color(0),2,color(255),1,color(255,0,255));
    
    textSize(20);
    PrestigeLevelShow = new Button("Prestige Level: "+pl.PrestigeLevel,"each level will grant you 5% increased zeny and exp",PrestigeBar.x, PrestigeBar.y-35,textWidth("Prestige Level: "+pl.PrestigeLevel),25,3,color(100),color(255),15,color(50),3);
    
    ButtonBody = new ScrollBar(0, sizeY,208 + padding,15,8,sizeY,color(0,150),0,color(255),1);
    for (int n = 0; n < 100; n ++) {
      UpgradeButton.add(new Button(n+"","This is button "+ n,correctUpgradeButtonX() ,correctUpgradeButtonY(),40,40,3,color(150),color(139,0,139),18,color(100),3));
    }
  }
  
  
  public float correctUpgradeButtonX() {
    return x+padding + (45+2)*(UpgradeButton.size() % 4);
  }
  public float correctUpgradeButtonY() {
    return y+padding+ floor((45+2)*(UpgradeButton.size() / 4));
  }  
  
  
  protected void TimeEvent() {
    if(show) {
      PrestigeBar.BarInfo.updateDescription("Prestige Level","Your Prestige Level is " + pl.PrestigeLevel +". You require " + (pl.MaxPrestige-pl.TotalPrestige) + " Prestige Points to level up");
      PrestigeBar.updateBar(pl.TotalPrestige-pl.OldMaxPrestige,pl.MaxPrestige-pl.OldMaxPrestige);
      correctUpgradeButtonY();
      correctUpgradeButtonX();
      ButtonBody.contentLength = correctUpgradeButtonY();
      PrestigeLevelShow.title = "Prestige Level: "+pl.PrestigeLevel;
      PrestigeLevelShow.hoverInfo.updateDescription("Level "+pl.PrestigeLevel,"each level will grant you 5% increased zeny and exp");
    }
  }
  
  private void resetGame() {
    pl.Zeny = 0;
    pl.Level = 0;
    pl.Exp = 0;
    pl.OldMaxExp = 0;
    pl.StatPoints = 0;
    pl.MaxExp = 0;
    pl.PlayerLevelUp(0);
    pl.CurrentPrestige = 0;
    pl.KilledRealmLord = false;
    pl.Death = 0;
    pl.CharVit = 10;
    pl.CharStr = 10;
    pl.CharEnd = 10;
    pl.CharAgi = 10;
    pl.CharDex = 10;
    pl.updateStat();
    pl.guildUnit.clear();
    areaDungeon.clear();
    tavernPanel = new TavernPanel(prestigeTavernPanel,15,15,200,height-30,color(25,25,200,150),10,2,color(255),1,player123);
    questPanel = new QuestPanel(15,15,200,height-30,color(25,25,200,150),10,2,color(255),1);
    Save(pl);
    
    if(new File(dataPath("Save\\SaveAreaDungeon.json")).exists()) {
      new File(dataPath("Save\\SaveAreaDungeon.json")).delete();
    }
    Load();
    currentAreaDungeon = areaDungeon.get(0);
  }
  
  
  protected void ActionEvent() {
    if(show) {
      if(PrestigeButton.wasClicked) {
        resetGame();
        show = !show;
      }
      for(int n = 0; n < UpgradeButton.size(); n++) {
        if(UpgradeButton.get(n).wasClicked) {
          UpgradeButton.get(n).wasClicked = false;
        }
      }
    }
  }


  
  public boolean checkUpgradeButtonPrice(int ButtonIndex) {
    if(pl.Prestige >= UpgradeButtonPrice.get(ButtonIndex)) {
      return true;
    } else {
      return false;
    }
  }
  
  
  public void HoverEvent() {
    if(show) {
      PrestigeBar.BarInfo.draw();
      PrestigeButton.hoverInfo.draw();
      PrestigeLevelShow.hoverInfo.draw();
      for(int n = 0; n < UpgradeButton.size();n ++ ) {
        UpgradeButton.get(n).hoverInfo.draw();
      }
    }
  }
  
  @Override
  public void draw() {
    if(show) {
      super.draw();
      fill(255,0,255);
      textSize(16);
      textAlign(TOP,TOP);
      text("Prestige Points Left: "+pl.Prestige,x+sizeX-padding-textWidth("Prestige Points Left : "+pl.Prestige),y+padding);
      PrestigeBar.draw();
      
      PrestigeLevelShow.draw();
      
      ButtonBody.draw();
      PrestigeButton.draw();
      clip(x+padding,y+padding,208 + padding, sizeY - padding*2);
      for(int n = 0; n < UpgradeButton.size(); n++) {
        UpgradeButton.get(n).UpdatePosition( x+padding + (45+2)*(n % 4),y+padding+ floor((45+2)*(n / 4))+ButtonBody.contentMove());
        UpgradeButton.get(n).draw();
      }
      noClip();
    }
  }
  
  
  
  
  public void mousePressed() {
    if(show) {
      PrestigeButton.mousePressed();
      ButtonBody.mousePressed();
      for(int n = 0; n < UpgradeButton.size(); n++) {
        UpgradeButton.get(n).mousePressed();
      }
    }    
  }  
  
  public void mouseReleased() {
    if(show) {
      PrestigeButton.mouseReleased();
      ButtonBody.mouseReleased();
      for(int n = 0; n < UpgradeButton.size(); n++) {
        UpgradeButton.get(n).mouseReleased();
      }
    }      
  }
  
  public void mouseWheel(MouseEvent event) {
    if(show) {
      ButtonBody.mouseWheel(event,x,y,235+padding,sizeY);
    }
  }  
}