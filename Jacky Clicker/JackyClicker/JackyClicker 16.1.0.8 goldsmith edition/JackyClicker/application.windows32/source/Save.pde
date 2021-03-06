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
  save = createWriter(dataPath("Save\\SaveAreaDungeon.json"));
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
  saveJSONObject(save, dataPath("Save\\Save.json"));
  
  //Player pla = gson.fromJson(json, Player.class);
}


void Load() {
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
    areaDungeon.add(new AreaDungeon("The Farm","Just about right.",color(200),"BackgroundImage/Farm.jpg",1000,0,color(204,255,255),1,1,1,1,1,3,1,1,0,1.02,0.5));
    areaDungeon.add(new AreaDungeon("The Forest","Beware of the deep hole...",color(200),"BackgroundImage/Forest.jpg",50,0,color(0,102,51),3,2,3,3,4,2.1,1.8,2.5,0,1.05,0.35));
    areaDungeon.add(new AreaDungeon("Gold Mine's Idle","Too rich for your own good...",color(200),"BackgroundImage/Cave.jpg",100,0,color(204,204,0),23,14,3.5,1,1,7.5,0.15,random(12,15),0,1.1,0.2));
    areaDungeon.add(new AreaDungeon("Cookie Realm","http:// orteil.dashnet.org/ cookieclicker/",color(200),"BackgroundImage/CookieClickerBG.jpg",50000,0,color(25,25,200),0,0,50,0,0,0,0.1,0.1,0,1.001,0.00));
    areaDungeon.add(new AreaDungeon("GoldSmiths","Easter egg",color(200),"BackgroundImage/GoldSmiths.jpg",10,0,color(204,204,0),100,0,0,0,0,7.5,0,0,0,10,0));    
  }
}