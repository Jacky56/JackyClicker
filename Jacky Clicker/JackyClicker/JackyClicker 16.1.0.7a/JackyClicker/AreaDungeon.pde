public class AreaDungeon extends Area {

  ValueBar MileBar;
  
  Enemy en;
  float MileMax;
  float MileCurrent;
  
  
  float[] MileStone = new float[8];
  boolean[] PassMileStone = new boolean[MileStone.length];
  
  
  
  //boolean[] BossMileStone = new boolean[MileStone.length];
  //boolean[] ReachedBoss = new boolean[MileStone.length];
  boolean BossMileStone;
  boolean ReachedBoss;
  boolean BossSpawned;
  
  boolean DungeonLordSpawn;
  boolean DungeonLordKilled;
  
  float EnemySpawnTimerCurrent;
  
  
  boolean GaveMilePoints;
  
  
  
  
  //float MilePoints;
  //float MilePerSec;
  
  color barColor;
  
  
  String name,des;
  PImage img;
  
  public AreaDungeon(String Name,String Description,color textColor,ArrayList<Player> pl,Player thisPlayer,PImage backgroundImage,float MileMax,float MileCurrent,color barColor,float vit,float str,float end,float agi,float dex,float as,float exp,float zen,float pres, float dif,float EnemySpawnTimer) {
    super(Name,Description,textColor,pl,thisPlayer);
    this.MileMax = MileMax;
    HaveEnemy = true;
    this.backgroundImage = backgroundImage;
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
    
    for(int n = 0; n < MileStone.length; n ++) {
      MileStone[n] = (MileMax/MileStone.length)*n;
      PassMileStone[n] = false;
    }
    PassMileStone[0] = true;
    
    this.EnemySpawnTimer = EnemySpawnTimer;
    
    MileBar = new ValueBar("Mile Bar","This shows your progress in this dungeon. Leaving the Dungeon will Reset your Miles!", 1000,275,height-45,width - 550,10,color(0),2,color(255),1,color(barColor));
    
    AreaButton.textColor = barColor;
    //Enemy(String Name,String Description,float x,float y,long CharVit,long CharStr,long CharEnd,long CharAgi,long CharDex,double AttackTimer,long ExpBounty,long GoldBounty,long PrestigeBounty) {
    createEnemy();
  }
  
  @Override
  public void TimeEvent() {
    if(Active) {
      super.TimeEvent();
      

      en.TimeEvent();

      MileBarUpDate();

      
      if(en.Alive == false) {
        en.UnitPlaced = false;
      }
      
      enemyRespawn();
      
    }
  }
  
  public void setMile(float mile) {
    MileCurrent = mile;
    BossMileStone = false;
    ReachedBoss = false;
    BossMileStone = false;    
    DungeonLordSpawn = false;
    BossSpawned = false;
    createEnemy();
  }
  
  
  @Override
  public void ActionEvent() {
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
  
  public void enemyRespawn() {

    
    if(en.Alive == false) {
      EnemySpawnTimerCurrent += 1/frameRate;
      
      
      if(GaveMilePoints == false) {
        if(MileCurrent < MileMax) {
          MileCurrent += 0.5;
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

  public void createEnemy() {
    randomEnemyGraphics();
    
    double m = pow(dif,MileCurrent);
    if(DungeonLordSpawn) { 
      if(random(100) > 50) {
        en = new Enemy("Realm Lord","I am the guardian of this realm...",width/2 -100,height/2 - 200,(long)((543*vit)*m),(long)((21*str)*m),(long)((11*end)*m),(long)((1*agi)*m),(long)((1*dex)*m),(double)as,(long)((500*exp)*m),(long)((1000*zen)*m),(long)((10+pres)*m));
        en.UnitAsButton.background = color(random(255),random(255),random(255));
      } else {
        en = new Enemy("D Wizard","Another one.",width/2 -100,height/2 - 200,(long)((543*vit)*m),(long)((21*str)*m),(long)((11*end)*m),(long)((1*agi)*m),(long)((1*dex)*m),(double)as,(long)((500*exp)*m),(long)((1000*zen)*m),(long)((10+pres)*m),LoadAllImage.get("DarkMagician.png"),35,color(201,201,51));

      }
      BossSpawned = true;
    } else if(BossMileStone) {
      en = new Enemy("Boss","",width/2 -100,height/2 - 200,(long)((167*vit)*m),(long)((19*str)*m),(long)((11*end)*m),(long)((1*agi)*m),(long)((1*dex)*m),(double)as*3,(long)((50*exp)*m),(long)((100*zen)*m),(long)((1+pres)*m));
      en.UnitAsButton.background = color(51,0,102);
      en.UnitAsButton.textSize = 35;
      BossSpawned = true;
    } else {
      
      en = new Enemy(name,des,width/2 -100,height/2 - 200,(long)((12*vit)*m),(long)((11*str)*m),(long)((10*end)*m),(long)((1*agi)*m),(long)((1*dex)*m),(double)as,(long)((5*exp)*m),(long)((10*zen)*m),(long)(pres*m),img,25,color(255));
    }
    
    EasterEgg(m);
    
  }
  
  
  
  void randomEnemyGraphics() {
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
  
  
  void EasterEgg(double m) {
    if(Name.equals("Cookie Realm")) {
      en = new Enemy("Cookie Clicker","http:// orteil.dashnet.org/ cookieclicker/",width/2 -100,height/2 - 200,012.5,0,(long)((9*end)*m),0,0,0,(long)((5*exp)*m),(long)((10*zen)*m),0,LoadAllImage.get("Cookie.png"),25,color(255));
    } else if(Name.equals("GoldSmiths")) {
      en = new Enemy("Jeremy Corbyn","Everybody Loves me!",width/2 -100,height/2 - 200,12.5,0,0,0,0,0,0,0,0,LoadAllImage.get("JeremyCorbyn.png"),25,color(255));
    }
    if(random(100) > 99) {
      name = "Theo";
      des = "Powered by Tony Do.";
      img = LoadAllImage.get("Theo.png");
    }
  }
  
  
  
  public void MileBarUpDate() {
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
  
  
  @Override
  public void HoverEvent() {
    if(Active) {
      super.HoverEvent();
      MileBar.BarInfo.draw();
      en.HoverEvent();
      //en.UnitAsButton.hoverInfo.draw();
    }
  }
  
  @Override
  public void draw() {
    if(Active) {
      en.draw();
      super.draw();
      MileBar.draw();
    }
  }
  
  @Override
  public void mousePressed() {
    if(Active) {
      super.mousePressed();
      en.UnitAsButton.mousePressed();
    }
  }
  
  @Override
  public void mouseReleased() {
    if(Active) {
      super.mouseReleased();
      en.UnitAsButton.mouseReleased();
    }
  }  
  
}