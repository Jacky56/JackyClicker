protected class Equipment extends Item{
  @Expose
  private boolean Equipped;
  @Expose
  private float Rarity;
  @Expose
  private String SlotType;
  
  private float ChanceRoll;
  private float AdditionalChance[] = new float[11];
  
  
  float LwStat;
  float UpStat;

  float CurrentMile;
  float Dif;
  
  float MileReduction;
  
  
  protected Equipment(String Name,String Description, String ItemImage,color NameColor,String SlotType,float Rarity,float CurrentMile,float Dif, float x,float y,float sizeX,float sizeY) {
    super(Name,Description,ItemImage,NameColor,x,y,sizeX,sizeY);
    this.Rarity = Rarity;
    this.SlotType = SlotType;
    ChanceRoll = 20 + (Rarity-25)*0.35;
    
    
    MileReduction = 2.35;
    this.CurrentMile = CurrentMile/MileReduction;
    this.Dif = Dif;
    Equipped = false;
    
    LwStat = 0.5 + 1.1*pow(1.023,Rarity-25);
    UpStat = 1.7 + 1.1*pow(1.023,Rarity-25);
    
    EquipmentType();
    
    GenerateStat();
    ItemAsButton.hoverInfo.updateDescription(Name,this.Description);
  }
  
  protected Equipment(float Rarity,float CurrentMile,float Dif, float x,float y,float sizeX,float sizeY) {
    super();
    Name = "";
    Description ="";
    this.Rarity = Rarity;
    ChanceRoll = 20 + (Rarity-25)*0.35;
    
    GenerateItemType();
    
    
    
    MileReduction = 2.35;
    this.CurrentMile = CurrentMile/MileReduction;
    
    this.Dif = Dif;
    Equipped = false;
    
    LwStat = 0.5 + 1.1*pow(1.023,Rarity-25);
    UpStat = 1.7 + 1.1*pow(1.023,Rarity-25);

    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    
    EquipmentType();
    GenerateStat();      
    ItemAsButton = new Button(Name,Description,x, y,sizeX,sizeY,10,NameColor,sizeY/2,LoadAllImage.get(ItemImage));
  }
  
  
  private void GenerateItemType() {
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
      NameColor = color(190,0,190);
    } else if(75 <= Rarity && Rarity < 90) {
      NameColor = color(0,100,0);
    } else if(90 <= Rarity) {
      NameColor = color(210,105,30);
    } 
    
  }
  
  
  
  private void StartName() {
    String lines[] = loadStrings("ItemName/StartName.txt");
    Name += lines[int(random(lines.length))];
  }
  
  private void EndName() {
    
    String lines[] = loadStrings("ItemName/EndName.txt");
    Name += lines[int(random(lines.length))];
  
  }
  
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
  
  
  
  
  
  private void EquipmentType() {
    if(SlotType.equalsIgnoreCase("boot")) {
      AdditionalChance[6] = 25;
      AdditionalChance[2] = 15;
      AdditionalChance[1] = -15;
      AdditionalChance[7] = -25;
    }
    
    if(SlotType.equalsIgnoreCase("glove")) {
      AdditionalChance[3] = 15;
      AdditionalChance[4] = 15;
      AdditionalChance[10] = 15;
      AdditionalChance[9] = 10;
      AdditionalChance[7] = -25;
      AdditionalChance[8] = -20;
    }
    
    if(SlotType.equalsIgnoreCase("weapon")) {
      for(int n = 0; n < AdditionalChance.length; n ++) {
        AdditionalChance[n] = -12;
      }
      AdditionalChance[7] = 70;
      AdditionalChance[1] = 5;
    }
    
    if(SlotType.equalsIgnoreCase("body")) {
      for(int n = 0; n < AdditionalChance.length; n ++) {
        AdditionalChance[n] = -10;
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
        AdditionalChance[n] = 5;
      }
      AdditionalChance[5] = 15;
    }
    
   if(SlotType.equalsIgnoreCase("head")) {
      for(int n = 0; n < AdditionalChance.length; n ++) {
        if(n < 5) {
          AdditionalChance[n] = 10;
        } else {
          AdditionalChance[n] = -10;
        }
        
      }
    }    
    
    
  }
  
  
  
  
  
  
  private void GenerateStat() {
    if(random(100) < ChanceRoll + AdditionalChance[0]) {
      ItemVit = (long)((CurrentMile*MileReduction/50 + random(LwStat,UpStat)* pow(Dif,CurrentMile)) * 0.95);
      if(ItemVit != 0) {
        Description += " | Vit: " + ItemVit;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[1]) {
      ItemStr = (long)((CurrentMile*MileReduction/50 + random(LwStat,UpStat)* pow(Dif,CurrentMile))*0.8);
      if(ItemStr != 0) {
        Description += " | Str: " + ItemStr;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[2]) {
      ItemEnd = (long)((CurrentMile*MileReduction/50 + random(LwStat,UpStat)* pow(Dif,CurrentMile)) * 0.7);
      if(ItemEnd != 0) {
        Description += " | End: " + ItemEnd;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[3]) {
      ItemAgi = (long)((CurrentMile*MileReduction/50 + random(LwStat,UpStat)* pow(Dif,CurrentMile)) * 0.5);
      if(ItemAgi != 0) {
        Description += " | Agi: " + ItemAgi;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[4]) {
      ItemDex = (long)((CurrentMile*MileReduction/50 + random(LwStat,UpStat)* pow(Dif,CurrentMile)) * 0.65);
      if(ItemDex != 0) {
        Description += " | Dex: " + ItemDex;
      }
    }
    
    
    if(random(100) < ChanceRoll + AdditionalChance[5]) {
      ItemRegHp = (long)((CurrentMile*MileReduction/50 + random(LwStat,UpStat)* pow(Dif,CurrentMile)) * 0.1);
      if(ItemRegHp != 0) { 
        Description += " | Regen: " + ItemRegHp;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[6]) {
      ItemDef = (long)((CurrentMile*MileReduction/50 + random(LwStat,UpStat)* pow(Dif,CurrentMile)) * 0.4);
      if(ItemDef != 0) { 
        Description += " | Def: " + ItemDef;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[7]) {
      ItemDmg = (long)((CurrentMile*MileReduction/50 + random(LwStat,UpStat)* pow(Dif,CurrentMile)) * 0.85);
      if(ItemDmg != 0) { 
        Description += " | Dmg: " + ItemDmg;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[8]) {
      ItemHp = (long)((CurrentMile*MileReduction/50 + random(LwStat,UpStat)* pow(Dif,CurrentMile)) * 3.6);
      if(ItemHp != 0) { 
        Description += " | Health: " + ItemHp;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[9]) {
      ItemCrit = (long)((CurrentMile*MileReduction/50 + random(LwStat,UpStat)* pow(Dif,CurrentMile)) * 0.65);
      if(ItemCrit != 0) {
        Description += " | Crit Rating: " + ItemCrit;
      }
    }
    if(random(100) < ChanceRoll + AdditionalChance[10]) {
      ItemCritDmg = (long)((CurrentMile*MileReduction/50 + random(LwStat,UpStat)* pow(Dif,CurrentMile)) * 0.4);
      if(ItemCritDmg != 0) {
        Description += " | Crit Dmg: " + ItemCritDmg;
      }
    }
    
    Description += " | Rarity: " + round(Rarity);
    
  }
  
  //saved item
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