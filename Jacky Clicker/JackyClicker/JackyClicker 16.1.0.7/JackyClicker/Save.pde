//Save
float SaveTime;
void saveGame(Player pl) {
  SaveTime += 1/frameRate;
  if(SaveTime > 50) {
    SaveTime = 0;
    Save(pl);
    //popText.add(new PopText((long)(TotalDmg-en.TotalDef)+"",1,0.5,mouseX,mouseY - 10,30,color(255)));
    popText.add(new PopText(wrapText("Your Game was Saved.(Beware I have not coded the load for your guild units! it exist in the save)",14,300),0.1,7,100,height-100,14,(color(200,25,25))));
  }
}


void Save(Player pl) {
  JSONObject save;
  Player target = pl;
  Gson gson = new Gson();
  String json = gson.toJson(target);

  save = parseJSONObject(json);
  saveJSONObject(save, dataPath("Save\\Save.json"));
  
  Player pla = gson.fromJson(json, Player.class);
}


void Load() {
  if(new File(dataPath("Save\\Save.json")).exists()) {
    Gson gson = new Gson();
    String json = "";
    String lines[] = loadStrings("Save\\Save.json");
    for(String a : lines) {
      json += a;
    }
    
    //s = new JsonReader("Save\\Save.json");
    //public Player(String Name,String Description,float x,float y,double CharVit,double CharStr,double CharEnd,double CharAgi,double CharDex,long exp, long zeny,long prestige,float CharExp,float CharZeny,float CharPrestige, long StatPoints) {
    //aPlayer.add(new Player("Nanashi","This is the Player of the game",width/2 -40,height/2 +80,10+aPlayer.size(),10,10,10,10));
    
    //String Name = s.getString("Name");
    //String Description = s.getString("Description");
    //float x = s.getFloat("x");
    //float y = s.getFloat("y");
    
    //double vit = s.getDouble("CharVit");
    //double str = s.getDouble("CharStr");
    //double end = s.getDouble("CharEnd");
    //double agi = s.getDouble("CharAgi");
    //double dex = s.getDouble("CharDex");
    
    //long Exp = s.getLong("Exp");
    //long Zeny = s.getLong("Zeny");
    //long Prestige = s.getLong("Prestige");
    
    //float CharExp = s.getFloat("CharExp");
    //float CharZeny = s.getFloat("CharZeny");
    //float CharPrestige = s.getFloat("CharPrestige");
    
    //long StatPoints = s.getLong("StatPoints");
    Player pl = gson.fromJson(json, Player.class);
    println(pl.guildUnit.size());
    
    Player pla = new Player("Nanashi","This is the Player of the game",width/2 -40,height/2 +80,10,10,10,10,10);
    
    aPlayer.add(pl);
    //aPlayer.get(0).updateStat();

    
    for (int n = 0; n < pl.guildUnit.size(); n++) {
     println(pl.guildUnit.get(n).Name);
     //aPlayer.get(0).guildUnit.add(pl.guildUnit.get(n));
    }
    
    //aPlayer.add(new Player(Name,Description,x,y,vit,str,end,agi,dex,Exp,Zeny,Prestige,CharExp,CharZeny,CharPrestige,StatPoints));
    //aPlayer.add(new Player("Nanashi","This is the Player of the game",width/2 -40,height/2 +80,10,10,10,10,10));
  } else { 
    aPlayer.add(new Player("Nanashi","This is the Player of the game",width/2 -40,height/2 +80,10,10,10,10,10));
  }
}