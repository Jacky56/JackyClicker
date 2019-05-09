//Save
float SaveTime;
void saveGame(Player pl,ArrayList<AreaDungeon> ad) {
  SaveTime += 1/frameRate;
  if(SaveTime > 60) {
    SaveTime = 0;
    Save(pl);
    SaveAreaDungeon(ad);
    //popText.add(new PopText((long)(TotalDmg-en.TotalDef)+"",1,0.5,mouseX,mouseY - 10,30,color(255)));
    popText.add(new PopText(wrapText("Your Game was Saved.",14,300),0.1,3,100,height-100,14,(color(200,25,25))));
  }
}

void SaveAreaDungeon(ArrayList<AreaDungeon> ad) {
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
  save = createWriter(dataPath("Save/SaveAreaDungeon.json"));
  save.println(json);
  save.flush();
  save.close();
}


void Save(Player pl) {
  JSONObject save;
  Player target = pl;
  Gson gson = new  GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
  String json = gson.toJson(target);
  save = parseJSONObject(json);
  saveJSONObject(save, dataPath("Save/Save.json"));
  
  //Player pla = gson.fromJson(json, Player.class);
}


void Load() {
  if(new File(dataPath("Save/Save.json")).exists()) {
    Gson gson = new  GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
    String json = "";
    String lines[] = loadStrings("Save/Save.json");
    for(String a : lines) {
      json += a;
    }
    
    Player pl = gson.fromJson(json, Player.class);
    
    if(aPlayer !=null) {
      aPlayer.clear();
    }
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
        case "Bard":
        aPlayer.get(0).guildUnit.add(new Bard(g));
        break;        
      }
    }
  } else { 
    aPlayer.add(new Player("Enter Name","This is the Player of the game.",width/2 -40,height/2 +80,10,10,10,10,10));
  }
  
  player123 = aPlayer.get(0);
  player123.ThisPlayer = true;
  
  
  if(new File(dataPath("Save/SaveAreaDungeon.json")).exists()) {
    
    Gson gson = new  GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
    Type listType = new TypeToken<List<AreaDungeon>>() {}.getType();
    
    String json = "";
    String lines[] = loadStrings("Save/SaveAreaDungeon.json");
    for(String a : lines) {
      json += a;
    }
    
    List<AreaDungeon> ad = gson.fromJson(json, listType);
    
    for(int n = 0; n < ad.size(); n++) {
      areaDungeon.add(new AreaDungeon(ad.get(n)));
    }
    
  } else {
    areaDungeon.add(new AreaDungeon("The Forest","Most stable environment.",color(200),"BackgroundImage/Forest.jpg",600,0,color(0,102,51),1,1,1,1,1,3,1,1,0,1.01,0.5));
    for(int n = 0; n < 3; n++) {
      switch(round(random(5))) {
        case 0:
        areaDungeon.add(new AreaDungeon("OutLaw","Beware of the deep hole...",color(200),"BackgroundImage/BarrenLand.jpg",100,0,color(0,102,51),random(3,4),random(2.1,3.2),random(2.1,2.9),random(1.4,2.3),random(1.5,2.5), random(1.5,5),random(2.5,4),random(2.5,4),0,random(1.03,1.06),random(0.35,2)));
        break;
        case 1:
        if(random(100) > 90) {
          areaDungeon.add(new AreaDungeon("Cookie Realm","http:// orteil.dashnet.org/ cookieclicker/",color(200),"BackgroundImage/CookieClickerBG.jpg",50000,0,color(25,25,200),0,0,50,0,0,0,0.1,0.1,0,1.001,0.00));
        } else {
          n --;
        }
        break;
        case 2:
        areaDungeon.add(new AreaDungeon("Gold Mine's Idle","Too rich for your own good...(no edit)",color(200),"BackgroundImage/Cave.jpg",100,0,color(204,204,0),23,14,3.5,1,1,7.5,0.15,random(12,15),0,1.1,0.2));
        break;
        case 3:
        areaDungeon.add(new AreaDungeon("Elder Pact","'Squirm crawl slither writhe today we rise.'(no edit)",color(200),"BackgroundImage/Grandma.jpg",10000,0,color(200,25,25),0.7,0.6,0.4,1,1,0.5,0.5,0.45,0,1.002,0.02));
        break;
        case 4:
        areaDungeon.add(new AreaDungeon("Chin Chin's Den","Run for your life...",color(200),"BackgroundImage/ChinChin.jpg",16,0,color(0),43264,6456,4353,3215,213,15,1000,1000,9,2.1,0.5));
        break;
        case 5:
        areaDungeon.add(new AreaDungeon("Void","",color(200),null,2000,0,color(0),1,1,1,1,1,3,random(0.8,1.2),random(0.8,1.2),0,random(1.01,1.03),random(0.2,0.5)));
        break;
      }
    }
  }
}