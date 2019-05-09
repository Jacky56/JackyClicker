//Save
// this saves your game
//I used Gson library to serialize the player object into Json
float SaveTime;

//a function that auto saves the game every 60 seconds
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

//saves the area of the game 
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

//parse the object data as json and stored in dataPath("Save/Save.json")
void Save(Player pl) {
  JSONObject save;
  Player target = pl;
  Gson gson = new  GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
  String json = gson.toJson(target);
  save = parseJSONObject(json);
  saveJSONObject(save, dataPath("Save/Save.json"));
  
  //Player pla = gson.fromJson(json, Player.class);
}


//loads the Json file and deserializes into java object
void Load() {
  //check if the file exist
  if(new File(dataPath("Save/Save.json")).exists()) {
    //Gson uses @expose to select specifc varibles to serialize or deserialize
    Gson gson = new  GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
    String json = "";
    //parse the json file as a string
    //I had problems using the Gson library for deserializing 
    String lines[] = loadStrings("Save/Save.json");
    for(String a : lines) {
      json += a;
    }
    
    //use pl as a reference
    Player pl = gson.fromJson(json, Player.class);
    
    //deletes all the existance of aPlayer (it was meant to be temp)
    if(aPlayer !=null) {
      aPlayer.clear();
    }
    
    //add the reference Player into the array
    aPlayer.add(new Player(pl));
    
    //is to check how many guild Units was under the reference data
    for (int n = 0; n < pl.guildUnit.size(); n++) {
      //g is used as a reference of the pl
      GuildUnit g = pl.guildUnit.get(n);
      //check which Name it follows
      //then loads the object from its reference
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
    //if the Save.json doesnt exist it will just load a fresh data
    aPlayer.add(new Player("Enter Name","This is the Player of the game.",width/2 -40,height/2 +80,10,10,10,10,10));
  }
  
  //temp
  //sign the aPlayer 0 as the player of the game 
  player123 = aPlayer.get(0);
  //temp
  player123.ThisPlayer = true;
  
  //loads the area dungeon into the game
  //check if the save file even exist
  if(new File(dataPath("Save/SaveAreaDungeon.json")).exists()) {
    //stuff
    Gson gson = new  GsonBuilder().excludeFieldsWithoutExposeAnnotation().create();
    Type listType = new TypeToken<List<AreaDungeon>>() {}.getType();
    
    String json = "";
    String lines[] = loadStrings("Save/SaveAreaDungeon.json");
    for(String a : lines) {
      json += a;
    }
    
    List<AreaDungeon> ad = gson.fromJson(json, listType);
    //load the reference data into areaDungeon
    for(int n = 0; n < ad.size(); n++) {
      areaDungeon.add(new AreaDungeon(ad.get(n)));
    }
    
  } else {
    //RNG the area dungeon if the save file doesnt exist
    areaDungeon.add(new AreaDungeon("The Forest","Most stable environment.",color(200),"BackgroundImage/Forest.jpg",600,0,color(0,102,51),1,1,1,1,1,3,1,1,0,1.01,0.5));
    areaDungeon.add(new AreaDungeon("The Space Galaxy","Where Aliens Exist...",color(200),"BackgroundImage/AlienBG.jpg",2,0,color(102,0,51),1,1,1,1,1,69,1,1,0,1.01,0.2));
    areaDungeon.add(new AreaDungeon("Cookie Realm","http:// orteil.dashnet.org/ cookieclicker/",color(200),"BackgroundImage/CookieClickerBG.jpg",50000,0,color(25,25,200),0,0,50,0,0,0,0.1,0.1,0,1.001,0.00));
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