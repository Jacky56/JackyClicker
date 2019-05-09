//the equipment
protected class Equipment extends Item{
  @Expose
  private boolean Equipped; // a useless varible 
  @Expose
  private float Rarity; //rarity, inreases general stats and rolls of the item
  @Expose
  private String SlotType;  //there are 7 different slots in the game 
  
  private float ChanceRoll; //base roll chance
  private float AdditionalChance[] = new float[11]; // added roll chance depending on the slot type
  
  
  float LwStat; //lower bound of the stat roll
  float UpStat; // upper bound of the stat roll

  float CurrentMile; // ?
  float Dif; // ?
  
  //a constructor that can create specfic name and description
  protected Equipment(String Name,String Description, String ItemImage,color NameColor,String SlotType,float Rarity,float CurrentMile,float Dif, float x,float y,float sizeX,float sizeY) {
    super(Name,Description,ItemImage,NameColor,x,y,sizeX,sizeY);
    this.Rarity = Rarity;
    this.SlotType = SlotType;
    ChanceRoll = 20 + (Rarity-25)*0.35;
    this.CurrentMile = CurrentMile/2;
    this.Dif = Dif;
    Equipped = false;
    
    LwStat = 1 + 1*pow(1.025,Rarity-25);
    UpStat = 1.7 + 1*pow(1.025,Rarity-25);
    
    EquipmentType();
    
    GenerateStat();
    ItemAsButton.hoverInfo.updateDescription(Name,this.Description);
  }
  
  // a constructor that generate completely  random name and description
  protected Equipment(float Rarity,float CurrentMile,float Dif, float x,float y,float sizeX,float sizeY) {
    super();
    Name = "";
    Description ="";
    
    switch(round(random(6))) {
      case 0:
      SlotType = "head";
      ItemImage = "head"+round(random(3))+".png";
      SlotName("head");
      SlotDescription("head");
      break;
      case 1:
      SlotType = "body";
      ItemImage = "body"+round(random(3))+".png";
      SlotName("body");
      SlotDescription("body");
      break;
      case 2:
      SlotType = "boot";
      ItemImage = "boot"+round(random(3))+".png";
      SlotName("boot");
      SlotDescription("boot");
      break;
      case 3:
      SlotType = "weapon";
      ItemImage = "weapon"+round(random(7))+".png";
      SlotName("weapon");
      SlotDescription("weapon");
      break;
      case 4:
      SlotType = "glove";
      ItemImage = "glove"+round(random(3))+".png";
      SlotName("glove");
      SlotDescription("glove");
      break;
      case 5:
      SlotType = "neck";
      ItemImage = "neck"+round(random(3))+".png";
      SlotName("neck");
      SlotDescription("neck");
      break;
      case 6:
      SlotType = "ring";
      ItemImage = "ring"+round(random(3))+".png";
      SlotName("ring");
      SlotDescription("ring");
      break;
    }
    
    if(0 <= Rarity && Rarity < 25) {
      NameColor = color(150,0,0);
    } else if(25 <= Rarity && Rarity < 40) {
      NameColor = color(200);
    } else if(40 <= Rarity && Rarity < 50) {
      NameColor = color(140,140,25);
    } else if(50 <= Rarity && Rarity < 65) {
      NameColor = color(0,120,200);
    } else if(65 <= Rarity && Rarity < 75) {
      NameColor = color(0,120,200);
    } else if(75 <= Rarity && Rarity < 90) {
      NameColor = color(0,100,0);
    } else if(90 <= Rarity) {
      NameColor = color(210,105,30);
    }
    
    this.Rarity = Rarity;
    ChanceRoll = 20 + (Rarity-25)*0.35;
    this.CurrentMile = CurrentMile/2;
    this.Dif = Dif;
    Equipped = false;
    
    LwStat = 1 + 1*pow(1.025,Rarity-25);
    UpStat = 1.7 + 1*pow(1.025,Rarity-25);

    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    
    EquipmentType();
    GenerateStat();      
    ItemAsButton = new Button(Name,Description,x, y,sizeX,sizeY,10,NameColor,sizeY/2,LoadAllImage.get(ItemImage));
  }

  //reads a .txt file for the first word of the name (adjective?)  
  private void StartName() {
    String lines[] = loadStrings("ItemName/StartName.txt");
    Name += lines[int(random(lines.length))];
  }
  
  //reads a.txt file for the end word of the name (verb? or noun)
  private void EndName() {
    String lines[] = loadStrings("ItemName/EndName.txt");
    Name += lines[int(random(lines.length))];
  
  }
  
  //rolls specfic names depending on the slot type
  private void SlotDescription(String Slot) {
    if(Slot.equals("head")) {
      String lines[] = loadStrings("ItemName/HeadDes.txt");
      Description += lines[int(random(lines.length))];
    }
    if(Slot.equals("body")) {
      String lines[] = loadStrings("ItemName/BodyDes.txt");
      Description += lines[int(random(lines.length))];
    }
    if(Slot.equals("boot")) {
      String lines[] = loadStrings("ItemName/BootDes.txt");
      Description += lines[int(random(lines.length))];
     
    }
    if(Slot.equals("weapon")) {
      String lines[] = loadStrings("ItemName/WeaponDes.txt");
      Description += lines[int(random(lines.length))];
    }
    if(Slot.equals("glove")) {
      String lines[] = loadStrings("ItemName/GloveDes.txt");
      Description += lines[int(random(lines.length))];
    }
    if(Slot.equals("ring")) {
      String lines[] = loadStrings("ItemName/RingDes.txt");
      Description += lines[int(random(lines.length))];
    }
    if(Slot.equals("neck")) {
      String lines[] = loadStrings("ItemName/NeckDes.txt");
      Description += lines[int(random(lines.length))];
    }        
  }

  //the function that creates the name
  private void SlotName(String Slot) {
    if(Slot.equals("head")) {
      StartName();
      String lines[] = loadStrings("ItemName/Head.txt");
      Name += lines[int(random(lines.length))];
      if(random(100) < 15) {
        EndName();
      }
    }
    if(Slot.equals("body")) {
      StartName();
      String lines[] = loadStrings("ItemName/Body.txt");
      Name += lines[int(random(lines.length))];
      if(random(100) < 15) {
        EndName();
      }
    }
    if(Slot.equals("boot")) {
      
      StartName();
      String lines[] = loadStrings("ItemName/Boot.txt");
      Name += lines[int(random(lines.length))];
      if(random(100) < 15) {
        EndName();
      }
     
    }
    if(Slot.equals("weapon")) {
      String lines[] = loadStrings("ItemName/Weapon.txt");
      Name += lines[int(random(lines.length))];
     if(random(100) < 15) {
        EndName();
     }
    }
    if(Slot.equals("glove")) {
      StartName();
      String lines[] = loadStrings("ItemName/Glove.txt");
      Name += lines[int(random(lines.length))];
      if(random(100) < 15) {
        EndName();
      }
    }
    if(Slot.equals("ring")) {
      StartName();
      String lines[] = loadStrings("ItemName/Ring.txt");
      Name += lines[int(random(lines.length))];
      if(random(100) < 15) {
        EndName();
      }
    }
    if(Slot.equals("neck")) {
      StartName();
      String lines[] = loadStrings("ItemName/Neck.txt");
      Name += lines[int(random(lines.length))];
      if(random(100) < 15) {
        EndName();
      }
    }        
  }
  
  
  
  
  //balance the additional roll chance for specific slto type
  private void EquipmentType() {
    if(SlotType.equalsIgnoreCase("boot")) {
      AdditionalChance[6] = 25;
      AdditionalChance[2] = 15;
      AdditionalChance[1] = -15;
      AdditionalChance[7] = -10;
    }
    
    if(SlotType.equalsIgnoreCase("glove")) {
      AdditionalChance[3] = 15;
      AdditionalChance[4] = 15;
      AdditionalChance[10] = 15;
      AdditionalChance[9] = 10;
      AdditionalChance[7] = -30;
      AdditionalChance[8] = -20;
    }
    
    if(SlotType.equalsIgnoreCase("weapon")) {
      for(int n = 0; n < AdditionalChance.length; n ++) {
        AdditionalChance[n] = -10;
      }
      AdditionalChance[7] = 70;
    }
    
    if(SlotType.equalsIgnoreCase("body")) {
      for(int n = 0; n < AdditionalChance.length; n ++) {
        AdditionalChance[n] = -5;
      }
      AdditionalChance[6] = 65;
      AdditionalChance[2] = 5;
    }
    
    if(SlotType.equalsIgnoreCase("ring")) {
      for(int n = 0; n < AdditionalChance.length; n ++) {
        AdditionalChance[n] = 5;
      }
    }
    
   if(SlotType.equalsIgnoreCase("neck")) {
      for(int n = 0; n < AdditionalChance.length; n ++) {
        AdditionalChance[n] = 10;
      }
    }
    
   if(SlotType.equalsIgnoreCase("")) {
      for(int n = 0; n < AdditionalChance.length; n ++) {
        AdditionalChance[n] = 5;
      }
    }    
    
    
  }
  
  
  
  
  
  //rolls the stats for the item and adds it to the description
  private void GenerateStat() {
    if(random(100) < ChanceRoll + AdditionalChance[0]) {
      ItemVit = (long)( random(LwStat,UpStat)* pow(Dif,CurrentMile) * 0.7);
      if(ItemVit != 0) {
        Description += " | Vit: " + ItemVit;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[1]) {
      ItemStr = (long)( random(LwStat,UpStat)* pow(Dif,CurrentMile));
      if(ItemStr != 0) {
        Description += " | Str: " + ItemStr;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[2]) {
      ItemEnd = (long)( random(LwStat,UpStat)* pow(Dif,CurrentMile));
      if(ItemEnd != 0) {
        Description += " | End: " + ItemEnd;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[3]) {
      ItemAgi = (long)( random(LwStat,UpStat)* pow(Dif,CurrentMile));
      if(ItemAgi != 0) {
        Description += " | Agi: " + ItemAgi;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[4]) {
      ItemDex = (long)( random(LwStat,UpStat)* pow(Dif,CurrentMile));
      if(ItemDex != 0) {
        Description += " | Dex: " + ItemDex;
      }
    }
    
    
    if(random(100) < ChanceRoll + AdditionalChance[5]) {
      ItemRegHp = (long)( random(LwStat,UpStat)* pow(Dif,CurrentMile) * 0.025);
      if(ItemRegHp != 0) { 
        Description += " | Regen: " + ItemRegHp;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[6]) {
      ItemDef = (long)( random(LwStat,UpStat)* pow(Dif,CurrentMile) * 0.6);
      if(ItemDef != 0) { 
        Description += " | Def: " + ItemDef;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[7]) {
      ItemDmg = (long)( random(LwStat,UpStat)* pow(Dif,CurrentMile) * 0.8);
      if(ItemDmg != 0) { 
        Description += " | Dmg: " + ItemDmg;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[8]) {
      ItemHp = (long)( random(LwStat,UpStat)* pow(Dif,CurrentMile) * 1.3);
      if(ItemHp != 0) { 
        Description += " | Health: " + ItemHp;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[9]) {
      ItemCrit = (long)( random(LwStat,UpStat)* pow(Dif,CurrentMile) * 0.45);
      if(ItemCrit != 0) {
        Description += " | Crit Rating: " + ItemCrit;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[10]) {
      ItemCritDmg = (long)( random(LwStat,UpStat)* pow(Dif,CurrentMile) * 0.05);
      if(ItemCritDmg != 0) {
        Description += " | Crit Dmg: " + ItemCritDmg +"%";
      }
    }
    
    Description += " | Rarity: " + round(Rarity);
    
  }
  
  //load the saved item
  public Equipment(Equipment eq) {
    super(eq.Name,eq.Description,eq.ItemImage,eq.NameColor,eq.x,eq.y,eq.sizeX,eq.sizeY);
    
    this.ItemVit = eq.ItemVit;
    this.ItemStr = eq.ItemStr;
    this.ItemEnd = eq.ItemEnd;
    this.ItemAgi = eq.ItemAgi;
    this.ItemDex = eq.ItemDex;
    
    this.ItemRegHp = eq.ItemRegHp;
    this.ItemDef =  eq.ItemDef;
    this.ItemDmg =  eq.ItemDmg;
    this.ItemHp =  eq.ItemHp;
    this.ItemCrit =  eq.ItemCrit;
    this.ItemCritDmg =  eq.ItemCritDmg;
    
    this.Equipped = eq.Equipped;
    this.Rarity = eq.Rarity;
    
    this.SlotType = eq.SlotType;
    
  }
 
}